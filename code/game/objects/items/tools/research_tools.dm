// Tools used for research
/obj/item/tool/research
	///Skill type needed to use the tool
	var/skill_type = SKILL_MEDICAL
	///Skill level needed to use the tool
	var/skill_threshold = SKILL_MEDICAL_EXPERT

/obj/item/tool/research/xeno_analyzer
	name = "xenolinguistic translator"
	desc = "A tool translating communications with some alien species when held. Can be used to befriend Newt."
	icon = 'icons/obj/items/radio.dmi'
	icon_state = "beacon"
	var/on = FALSE
	var/knowsxenolang = FALSE
	var/mob/current_user

/obj/item/tool/research/xeno_analyzer/proc/remove_current_user()
	if(!current_user)
		return
	if(!knowsxenolang)
		current_user.remove_language(/datum/language/xenocommon)
	current_user = null
	knowsxenolang = FALSE

/obj/item/tool/research/xeno_analyzer/proc/try_set_user(mob/user)
	if(user == current_user)
		return
	remove_current_user()
	if(!istype(user))
		INVOKE_NEXT_TICK_UNIQUE(src,PROC_REF(turn_off_if_no_user))
		return
	current_user = user
	if(user.has_language(/datum/language/xenocommon))
		knowsxenolang = TRUE
	else
		knowsxenolang = FALSE
		if(on)
			user.grant_language(/datum/language/xenocommon)

/obj/item/tool/research/xeno_analyzer/proc/turn_off_if_no_user()
	if(istype(current_user))
		return
	remove_filter("translator_on")
	if(on)
		on = FALSE
		balloon_alert_to_viewers("turns off")

/obj/item/tool/research/xeno_analyzer/attack_self(mob/user)
	. = ..()
	if(on)
		on = FALSE
		if(current_user && !knowsxenolang)
			current_user.remove_language(/datum/language/xenocommon)
		remove_filter("translator_on")
		balloon_alert(user, "turns off")
		to_chat(user, span_notice("I turn off the translator."))
		return
	on = TRUE
	add_filter("translator_on", 4, outline_filter(1, COLOR_CYAN))
	to_chat(user, span_notice("I turn on the translator, translating xeno language straight to my neural implant."))
	balloon_alert(user, "turns on")
	if(user.has_language(/datum/language/xenocommon))
		knowsxenolang = TRUE
	else
		knowsxenolang = FALSE
		user.grant_language(/datum/language/xenocommon)

/obj/item/tool/research/xeno_analyzer/Moved(atom/old_loc, movement_dir, forced, list/old_locs)
	. = ..()
	var/atom/movable/usercandidate = loc
	while(ismovable(usercandidate))
		if(ismob(usercandidate))
			try_set_user(usercandidate)
			return
		usercandidate = usercandidate.loc
	try_set_user(null)

/obj/item/tool/research/xeno_analyzer/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode)
	. = ..()
	if(message_language != /datum/language/common && on) //translates all languages to common.
		say(message, language = /datum/language/common)

/obj/item/tool/research/excavation_tool
	name = "subterrain scanner and excavator"
	desc = "A tool for locating and uncovering underground resources. Use \"unique action\" when near an excavation site."
	icon = 'icons/obj/items/surgery_tools.dmi'
	icon_state = "alien_drill"

/obj/item/tool/research/excavation_tool/unique_action(mob/user)
	. = ..()
	if(user.skills.getRating(skill_type) < skill_threshold)
		balloon_alert(user, "not skilled enough!")
		return

	if(!do_after(user, 10 SECONDS, NONE, user.loc, BUSY_ICON_FRIENDLY, null, PROGRESS_BRASS))
		return

	var/spawner_located = FALSE
	for(var/obj/effect/landmark/excavation_site_spawner/spawner_to_check AS in SSexcavation.active_spawners)
		if(get_dist(user, spawner_to_check) < 3)
			say(span_notice("<b>Excavation site found, escavating...</b>"))
			SSexcavation.excavate_site(spawner_to_check)
			spawner_located = TRUE

	if (!spawner_located)
		say(span_notice("<b>No excavation site found at location. Try moving closer to the nearest one on your map.</b>"))
