/datum/escalation
	var/name = "bugged escalation"
	var/datum/opportunity/op
	var/faction = FACTION_TERRAGOV
	var/mob/initiator = null
	var/started = FALSE
	var/concluded = FALSE

/datum/escalation/New(datum/opportunity/op, mob/m, forcedfaction)
	. = ..()
	initiator = m
	src.op = new op(src)
	if(forcedfaction)
		src.op.faction = forcedfaction
	else
		src.op.faction = initiator.faction
	SetName()

/datum/escalation/proc/SetName()
	name = GLOB.operation_namepool[/datum/operation_namepool].get_random_name() + " - [faction] [op.name]"

/datum/escalation/proc/start(forced)
	var/success = op.tryactivate(initiator,forced)
	if(success)
		started = TRUE
		announceselffac()
		addtimer(CALLBACK(src, PROC_REF(announceenemyfacs)),op.firstmovers)

/datum/escalation/proc/announceselffac()
	minor_announce(op.announcefac,"[faction] ICAP - [name]", GLOB.alive_human_list_faction[faction] + GLOB.observer_list)
	var/firstmoversseconds = (op.firstmovers / 10)
	for(var/mob/living/carbon/human/human AS in GLOB.alive_human_list_faction[faction])
		if(human.job)
			human.play_screen_text(HUD_ANNOUNCEMENT_FORMATTING(name, "[GAME_YEAR]-[time2text(world.realtime, "MM-DD")] [stationTimestamp("hh:mm")] Est time until contact: [firstmoversseconds] SECONDS<br>[human.job.title], [human], [human.faction]" , LEFT_ALIGN_TEXT), new /atom/movable/screen/text/screen_text/picture/potrait/custom_mugshot(null, null, human))

/datum/escalation/proc/announceenemyfacs()
	if(op.announcehumanoid)
		minor_announce(op.announcehumanoid,"Reactive Intelligence Network - [faction] Subdivision", GLOB.alive_human_list + GLOB.observer_list)
		for(var/mob/living/carbon/human/human AS in GLOB.alive_human_list)
			if(human.job)
				human.play_screen_text(HUD_ANNOUNCEMENT_FORMATTING(name, "[GAME_YEAR]-[time2text(world.realtime, "MM-DD")] [stationTimestamp("hh:mm")] !CONTACT IMMINENT!<br>[human.job.title], [human], [human.faction]" , LEFT_ALIGN_TEXT), new /atom/movable/screen/text/screen_text/picture/potrait/custom_mugshot(null, null, human))
	if(op.announcexenos)
		for(var/hivenumber in GLOB.hive_datums)
			GLOB.hive_datums[hivenumber].xeno_message(op.announcexenos, size = 3)

/datum/escalation/proc/end()
	minor_announce("Thus concludes the story of these brave people and their struggle on [SSmapping.configs[GROUND_MAP].map_name] as part of The [name] Incident.", "[name] concluded")
	for(var/hivenumber in GLOB.hive_datums)
		GLOB.hive_datums[hivenumber].xeno_message("A wave of newfound calmness and tranquality washes through the hive. The talls' greed and ambitions abate for now, as the incident they refer to as [name] reaches it's conclusion.", size = 3)
	concluded = TRUE
