#define PINGID_SERVER_UPDATE_NOTIFICATIONS "1476636729757663365"
#define PINGID_NEW_ROUND_PING "1177233820639035432"

#define MAXIMUM_DISCORD_MESSAGE_LENGTH 1800 // actually 2000 but let's leave 10% safety buffer

/proc/status_update_server_start()
	var/datum/getrev/revdata = GLOB?.revdata
	var/compile_date = "[revdata.date]"
	var/commit = "[revdata.commit]"
	var/rev_data_file = file("data/revision.json")
	var/round_id = replacetext(GLOB.log_directory, "data/logs/", "")
	var/msg = "Server starting...\nRound ID : [round_id]\n**Server revision compiled on:** [compile_date]\nLocal commit: [commit]\n"
	var/pingid = null
	var/json = ""
	var/list/file_data = list()
	if(fexists(rev_data_file))
		json = file2text(rev_data_file)
		file_data = json_decode(json)
		log_game("loaded revision data : [json]")
		if(file_data["date"] != compile_date)
			msg += "Compile date has changed.  Server has updated.\n"
			pingid = PINGID_SERVER_UPDATE_NOTIFICATIONS
			log_world(msg)
		else if(file_data["commit"] != commit)
			msg += "Commit has changed but compile date has not. This suggests a partially completed update. This may cause bugs.\n"
			log_runtime(msg)
			SEND_TEXT(world.log, "<font color='red'>[msg]</font>")
		else
			msg += "Server does not appear to have updated since last round.\n"
			log_world(msg)
		fdel(rev_data_file)
	else
		msg += "Could not load last revision.\n"
		log_world(msg)
	file_data["date"] = compile_date
	file_data["commit"] = commit
	json = json_encode(file_data)
	WRITE_FILE(rev_data_file, json)
	log_game("Saved revision data : [json]")

	amia_arbitrary_status_update(msg, pingid)

/proc/status_update_maps_loaded()
	GLOB.maps_loaded_data += "Mode: [GLOB.master_mode]\n"
	amia_arbitrary_status_update(GLOB.maps_loaded_data)

GLOBAL_VAR_INIT(round_end_ping_done, FALSE)

/proc/status_update_round_end(list/stats)
	var/pingid = null
	var/msg = ""
	if(!GLOB.round_end_ping_done)
		pingid = PINGID_NEW_ROUND_PING
		GLOB.round_end_ping_done = TRUE
		msg += "Round [replacetext(GLOB.log_directory, "data/logs/", "")] has ended!\nMode:[SSticker.mode.name]\nResult:[SSticker.mode.round_finished]\n"
	msg += replacetext(stats.Join("\n"),"<br>","\n")
	msg = splittext(msg, "\n")
	send_long_status_update(msg, pingid)

/proc/status_update_vote_started(initiator)
	var/lines = list()
	lines += "[capitalize(SSvote.mode)] vote started by [initiator]."
	if(SSvote.mode == "custom")
		lines += "--*[SSvote.question]*"
	for(var/choice in SSvote.choices)
		lines += "- [choice]"
	send_long_status_update(lines)

/proc/status_update_vote_ended(result_text)
	send_long_status_update(splittext(result_text, "\n"))

/proc/send_long_status_update(list/lines, ping_id)
	var/msg = ""
	while(length(lines))
		if(length(msg) + length(lines[1]) > MAXIMUM_DISCORD_MESSAGE_LENGTH)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(send_long_status_update), lines), 1.5 SECONDS)// we do not include ping_id here to avoid duplicate pings
			break
		msg += "[lines[1]]\n"
		lines.Cut(1,1)
	amia_arbitrary_status_update(msg, ping_id)
