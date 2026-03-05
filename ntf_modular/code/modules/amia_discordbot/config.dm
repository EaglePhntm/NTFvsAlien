/datum/config_entry/string/amia_address
	config_entry_value = "127.0.0.1"
	protection = CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/amia_port
	config_entry_value = "3001"
	protection = CONFIG_ENTRY_HIDDEN

/datum/config_entry/flag/amia_enabled
	protection = CONFIG_ENTRY_HIDDEN

/proc/amia_constring()
	return "http://" + CONFIG_GET(string/amia_address) + ":" + CONFIG_GET(string/amia_port) + "/"

GLOBAL_VAR_INIT(amia_request_number, 0)
GLOBAL_LIST_EMPTY(amia_requests_outstanding)

/// caution, may be slow!
/proc/do_amia_export(constring, logdesc)
	var/this_request_number = GLOB.amia_request_number++
	GLOB.amia_requests_outstanding += "[this_request_number]"
	GLOB.amia_requests_outstanding["[this_request_number]"] = logdesc
	log_game("Beginning amia request #[this_request_number] :- [logdesc]")
	. = world.Export("[amia_constring()][constring]")
	if(islist(.))
		log_game("Successfully completed amia request #[this_request_number] :- [logdesc]")
	else
		log_world("Failed amia request #[this_request_number] :- [logdesc]")
	GLOB.amia_requests_outstanding -= "[this_request_number]"
