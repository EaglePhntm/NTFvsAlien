/datum/job/xenomorph
	job_category = JOB_CAT_XENO
	title = ROLE_XENOMORPH
	supervisors = "the hive ruler"
	selection_color = "#B2A3CC"
	display_order = JOB_DISPLAY_ORDER_XENOMORPH
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_NOHEADSET|JOB_FLAG_OVERRIDELATEJOINSPAWN|JOB_FLAG_SHOW_OPEN_POSITIONS
	jobworth = list(/datum/job/survivor/rambo = SURVIVOR_POINTS_REGULAR)
	job_points_needed = 10 //Redefined via config.
	faction = FACTION_XENO
	exp_type = EXP_TYPE_SPECIAL
	html_description = {"
		<b>Difficulty</b>: Variable<br /><br />
		<b>You answer to the</b> acting Hive leader<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Crash, Nuclear War<br /><br /><br />
		<b>Duty</b>: Spread the hive, obey the will of your Hive Leader and the Queen Mother. Kill or capture those who get into your way. Protect the hive whenever possible. Amass your numbers.
	"}
	/**
	 * This is the amount of "free" xeno jobs opened at the start, even before marines job contributes to the total.
	 * This is a counter to prevent adding more jobs that necessary
	 */
	var/free_xeno_at_start = FREE_XENO_AT_START

/datum/job/xenomorph/return_spawn_type(datum/preferences/prefs)
	return /mob/living/carbon/xenomorph/larva

/datum/job/xenomorph/return_spawn_turf()
	if(length(GLOB.xeno_resin_silos_by_hive[XENO_HIVE_NORMAL]))
		return pick(GLOB.xeno_resin_silos_by_hive[XENO_HIVE_NORMAL])
	return pick(GLOB.spawns_by_job[/datum/job/xenomorph])

/datum/job/xenomorph/get_spawn_message_information(mob/M)
	. = ..()
	. += separator_hr("[span_role_header("<b>Xenomorph Information</b>")]")
	. += {"<b>Your job is to spread the hive and protect the Hive Leader. If there's no Hive Leader, you can become the Shrike or Queen yourself by evolving into a drone.</b><br>
Talk in Hivemind using <strong>;</strong>, <strong>.a</strong>, or <strong>,a</strong> (e.g. ';My life for the queen!')"}

/datum/job/xenomorph/handle_special_preview(client/parent)
	parent.show_character_previews(image('icons/Xeno/castes/larva.dmi', icon_state = "Bloody Larva", dir = SOUTH))
	return TRUE

/datum/job/xenomorph/add_job_positions(amount)
	if(!(SSticker.mode.round_type_flags & MODE_XENO_SPAWN_PROTECT))
		if(free_xeno_at_start > 0)
			free_xeno_at_start--
			return
	. = ..()
	if(!.)
		return
	var/datum/hive_status/normal/HS = GLOB.hive_datums[XENO_HIVE_NORMAL]
	HS.give_larva_to_next_in_queue()

/datum/job/xenomorph/after_spawn(mob/living/carbon/xenomorph/xeno, mob/M, latejoin)
	. = ..()
	if(xeno.hivenumber == XENO_HIVE_NORMAL || xeno.hivenumber != XENO_HIVE_CORRUPTED)
		SSminimaps.add_marker(xeno, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, xeno.xeno_caste.minimap_icon, MINIMAP_BLIPS_LAYER))

/datum/job/xenomorph/queen
	title = ROLE_XENO_QUEEN
	req_admin_notify = TRUE
	supervisors = "Queen mother"
	selection_color = "#8972AA"
	display_order = JOB_DISPLAY_ORDER_XENO_QUEEN
	exp_requirements = XP_REQ_EXPERIENCED
	job_flags = JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_NOHEADSET|JOB_FLAG_OVERRIDELATEJOINSPAWN|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_HIDE_CURRENT_POSITIONS|JOB_FLAG_LOUDER_TTS
	jobworth = list(/datum/job/survivor/rambo = SURVIVOR_POINTS_REGULAR)
	html_description = {"
		<b>Difficulty</b>: Soul crushing<br /><br />
		<b>You answer to the</b> Queen Mother<br /><br />
		<b>Unlock Requirement</b>: 10 hours playtime (any role)<br /><br />
		<b>Gamemode Availability</b>: Crash, Nuclear War<br /><br /><br />
		<b>Duty</b>: Lead the hive and ensure success isn’t snatched away by your enemies. Manage the supply of psypoints
	"}

/datum/job/xenomorph/queen/return_spawn_type(datum/preferences/prefs)
	return /mob/living/carbon/xenomorph/queen

/datum/job/xenomorph/queen/return_spawn_turf()
	return pick(GLOB.spawns_by_job[/datum/job/xenomorph])

/datum/job/xenomorph/queen/get_spawn_message_information(mob/M)
	. = ..()
	. += separator_hr("[span_role_header("<b>Xeno Queen Information</b>")]")
	. += {"<b>You are now the alien ruler!<br>
Your job is to spread the hive.</b><br>
Talk in Hivemind using <strong>;</strong>, <strong>.a</strong>, or <strong>:a</strong> (e.g. ';My life for the hive!')"}

/datum/job/xenomorph/queen/handle_special_preview(client/parent)
	parent.show_character_previews(image('icons/Xeno/castes/larva.dmi', icon_state = "Larva", dir = SOUTH))
	return TRUE

/datum/job/xenomorph/green
	title = "Corrupted Xenomorph"
	minimal_access = ALL_MARINE_ACCESS
	access = ALL_MARINE_ACCESS

/datum/job/xenomorph/green/return_spawn_type(datum/preferences/prefs)
	return /mob/living/carbon/xenomorph/larva/Corrupted

/datum/job/xenomorph/green/return_spawn_turf()
	if(length(GLOB.xeno_resin_silos_by_hive[XENO_HIVE_CORRUPTED]))
		return pick(GLOB.xeno_resin_silos_by_hive[XENO_HIVE_CORRUPTED])
	return pick(GLOB.spawns_by_job[/datum/job/xenomorph/green])

/datum/job/xenomorph/green/after_spawn(mob/living/carbon/xenomorph/xeno, mob/M, latejoin)
	. = ..()
	if(xeno.hivenumber == XENO_HIVE_CORRUPTED)
		SSminimaps.add_marker(xeno, MINIMAP_FLAG_MARINE, image('icons/UI_icons/map_blips.dmi', null, xeno.xeno_caste.minimap_icon, MINIMAP_BLIPS_LAYER))