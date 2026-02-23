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
