SUBSYSTEM_DEF(strings)
	name = "Strings"
	flags = SS_NO_FIRE|SS_NO_INIT

	var/list/list/externally_loaded_lists = list()
	var/list/externally_loaded_strings = list()

/datum/controller/subsystem/strings/Recover()
	externally_loaded_lists = SSstrings.externally_loaded_lists
	externally_loaded_strings = SSstrings.externally_loaded_strings

/datum/controller/subsystem/strings/proc/get_list_from_file(file)
	if(!isnull(externally_loaded_lists[file]))
		return externally_loaded_lists[file]
	return externally_loaded_lists[file] = file2list("strings/[file].txt")

/datum/controller/subsystem/strings/proc/get_string_from_file(file)
	if(!isnull(externally_loaded_strings[file]))
		return externally_loaded_strings[file]
	return externally_loaded_strings[file] = file2text("strings/[file].txt")

