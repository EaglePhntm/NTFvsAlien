#define PINGID_SERVER_UPDATE_NOTIFICATIONS 1476636729757663365
#define PINGID_NEW_ROUND_PING 1177233820639035432

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
	stats = replacetext(stats.Join("\n"),"<br>","\n")
	stats = splittext(stats,"\n")
	while(length(stats))
		if(length(msg) + length(stats[1]) > MAXIMUM_DISCORD_MESSAGE_LENGTH)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(status_update_round_end), stats), 1.5 SECONDS)
			break
		msg += "[stats[1]]\n"
		stats.Cut(1,1)
	amia_arbitrary_status_update(msg, pingid)


