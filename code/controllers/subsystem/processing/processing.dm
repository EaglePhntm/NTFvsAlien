//Used to process objects. Fires once every second.

SUBSYSTEM_DEF(processing)
	name = "Processing"
	priority = FIRE_PRIORITY_PROCESS
	flags = SS_BACKGROUND|SS_POST_FIRE_TIMING|SS_NO_INIT
	wait = 10

	var/stat_tag = "P" //Used for logging
	var/list/processing = list()
	var/list/currentrun = list()
	var/datum/currently_processing
	var/currently_processing_details = "*NULL*"

/datum/controller/subsystem/processing/stat_entry(msg)
	msg = "[stat_tag]:[length(processing)]"
	return ..()

/datum/controller/subsystem/processing/fire(resumed = 0)
	if (!resumed)
		currentrun = processing.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/current_run = currentrun

	while(length(current_run))
		currently_processing = current_run[length(current_run)]
		var/datum/thing = currently_processing
		currently_processing_details = "[logdetails(thing)][isdatum(thing) ? "([thing.ref_search_details()])" : ""]"
		current_run.len--
		if(QDELETED(thing))
			processing -= thing
		else if(thing.process(wait*0.1) == PROCESS_KILL)
			// fully stop so that a future START_PROCESSING will work
			STOP_PROCESSING(src, thing)
		currently_processing = null
		currently_processing_details = "*NULL*"
		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/processing/ref_search_details()
	. = "[..()](currently_processing:[currently_processing_details])"

/datum/proc/process()
	set waitfor = 0
	return PROCESS_KILL
