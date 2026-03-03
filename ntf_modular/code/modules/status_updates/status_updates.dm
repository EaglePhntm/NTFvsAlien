#define PINGID_SERVER_UPDATE_NOTIFICATIONS "1476636729757663365"
#define PINGID_NEW_ROUND_PING "1177233820639035432"

#define PINGID_CRASH_ROUND_PING "1469068799469818049"
#define PINGID_ZOMBIE_CRASH_ROUND_PING "1476701184785125499"
#define PINGID_NUCLEAR_WAR_VARIANT_PING "1476701614025871382"
#define PINGID_SURVIVAL_PING "1476701856175755364"
#define PINGID_SURVIVOR_HEAVY_PING "1476702539440324720"
#define PINGID_CLASSIC_MODE_PING "1476702696697237567"
#define PINGID_SOL_MODE_PING "1476703075640283408"

GLOBAL_LIST_INIT(mode_to_pingid, list(
	"Crash" = PINGID_CRASH_ROUND_PING,
	"Zombie Crash" = PINGID_ZOMBIE_CRASH_ROUND_PING,
	"Nuclear War" = PINGID_NUCLEAR_WAR_VARIANT_PING,
	"Nuclear War Plus" = PINGID_NUCLEAR_WAR_VARIANT_PING,
	"Sovl War" = PINGID_NUCLEAR_WAR_VARIANT_PING,
	"Sovl War Plus" = PINGID_NUCLEAR_WAR_VARIANT_PING,
	"Survival" = PINGID_SURVIVAL_PING,
	"Extended - Survivor-Heavy" = PINGID_SURVIVOR_HEAVY_PING,
	"Secret of Life - Classic" = PINGID_CLASSIC_MODE_PING,
	"Secret of Life - Main" = PINGID_SOL_MODE_PING,
	"Secret of Life - No Subfactions" = PINGID_SOL_MODE_PING,
	"Secret of Life - NTF vs Alien only" = PINGID_SOL_MODE_PING,
	"Secret of Life - NTF vs CLF" = PINGID_SOL_MODE_PING,
))

#define MAXIMUM_DISCORD_MESSAGE_LENGTH 1800 // actually 2000 but let's leave 10% safety buffer

/proc/status_update_server_start()
	var/datum/getrev/revdata = GLOB?.revdata
	var/compile_date = "[revdata?.date]"
	var/commit = "[revdata?.commit]"
	var/rev_data_file = file("data/revision.json")
	var/round_id = replacetext(GLOB.log_directory, "data/logs/", "")
	var/msg = "Server starting...\nRound ID : [round_id]\nPlayers online: [length(GLOB.whitelisted_clients)]\n**Server revision compiled on:** [compile_date]\nLocal commit: [commit]\n"
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
	GLOB.maps_loaded_data += "Players online: [length(GLOB.whitelisted_clients)]\n"
	amia_arbitrary_status_update(GLOB.maps_loaded_data)

/proc/status_update_round_end(list/stats)
	var/msg = "Round [replacetext(GLOB.log_directory, "data/logs/", "")] has ended!\nMode:[SSticker.mode.name]\nResult:[SSticker.mode.round_finished]\nPlayers online: [length(GLOB.whitelisted_clients)]\n"
	msg += stats.Join("\n")
	msg = replacetext(msg, "<br>", "\n")
	msg = replacetext(msg, "<span class='span_round_body'>", "")
	msg = replacetext(msg, "</span>", "")
	msg = splittext(msg, "\n")
	send_long_status_update(msg, PINGID_NEW_ROUND_PING)

/proc/status_update_vote_started(initiator)
	var/lines = list()
	lines += "[capitalize(SSvote.mode)] vote started by [initiator]."
	if(SSvote.mode == "custom")
		lines += "--*[SSvote.question]*"
	for(var/choice in SSvote.choices)
		lines += "- [choice]"
	lines += "Players online: [length(GLOB.whitelisted_clients)]"
	send_long_status_update(lines)

/proc/status_update_vote_ended(result_text)
	send_long_status_update(splittext(result_text, "\n"))

GLOBAL_VAR(next_gamemode_pinged)
GLOBAL_VAR(next_gamemode)

/proc/status_update_next_gamemode(mode, restarting = FALSE, starting = FALSE)
	var/msg = ""
	var/pingid = null
	if(restarting || starting)
		if(restarting)
			msg += "Server restarting.\n"
		else
			msg += "Round starting.\n"
	else
		if(GLOB.next_gamemode_pinged == mode)
			return
	if(GLOB.next_gamemode_pinged != mode)
		pingid = GLOB.mode_to_pingid[mode]
	if(starting)
		msg += "Current gamemode: [mode]\n"
		GLOB.next_gamemode_pinged = null
	else
		msg += "Next gamemode: [mode]\n"
		GLOB.next_gamemode_pinged = mode
	msg += "Players online: [length(GLOB.whitelisted_clients)]"
	amia_arbitrary_status_update(msg, pingid)

/proc/send_long_status_update(list/lines, ping_id)
	var/msg = ""
	while(length(lines))
		if(length(msg) + length(lines[1]) > MAXIMUM_DISCORD_MESSAGE_LENGTH)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(send_long_status_update), lines), 1.5 SECONDS)// we do not include ping_id here to avoid duplicate pings
			break
		msg += "[lines[1]]\n"
		lines.Cut(1,2)
	amia_arbitrary_status_update(msg, ping_id)
