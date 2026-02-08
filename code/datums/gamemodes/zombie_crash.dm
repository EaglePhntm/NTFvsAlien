/datum/game_mode/infestation/crash/zombie
	name = "Zombie Crash"
	config_tag = "Zombie Crash"
	round_type_flags = MODE_ALLOW_MARINE_QUICKBUILD|MODE_XENO_GRAB_DEAD_ALLOWED|MODE_CHILL_RULES|MODE_INFESTATION|MODE_PSY_POINTS|MODE_SILO_RESPAWN|MODE_MUTATIONS_OBTAINABLE
	xeno_abilities_flags = ABILITY_ALL_GAMEMODE //Non pvp
	required_players = 1
	valid_job_types = list(
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/engineer = 3,
		/datum/job/terragov/squad/corpsman = 1,
		/datum/job/terragov/squad/smartgunner = 1,
		/datum/job/terragov/squad/specialist = 1,
		/datum/job/terragov/squad/leader = 1,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/silicon/synthetic = 1,
		/datum/job/terragov/command/fieldcommander = 1,
		/datum/job/xenomorph = 2,
		/datum/job/xenomorph/queen = 1,
	)
	job_points_needed_by_job_type = list(
		/datum/job/terragov/squad/smartgunner = 20,
		/datum/job/terragov/squad/specialist = 20,
		/datum/job/terragov/squad/corpsman = 5,
		/datum/job/terragov/squad/engineer = 5,
		/datum/job/xenomorph = CRASH_LARVA_POINTS_NEEDED,
	)
	whitelist_ship_maps = null
	blacklist_ground_maps = list(MAP_COLONY1, MAP_BIG_RED, MAP_DELTA_STATION, MAP_LV_624, MAP_LV_624BASES, MAP_WHISKEY_OUTPOST, MAP_OSCAR_OUTPOST, MAP_FORT_PHOBOS, MAP_CHIGUSA, MAP_LAVA_OUTPOST, MAP_CORSAT, MAP_KUTJEVO_REFINERY, MAP_BLUESUMMERS)
	time_between_round = 1 HOURS
	xenorespawn_time = 3 MINUTES

/datum/game_mode/infestation/crash/zombie/can_start(bypass_checks = FALSE)
	if((!(config_tag in SSmapping.configs[GROUND_MAP].gamemodes) || (SSmapping.configs[GROUND_MAP].map_name in blacklist_ground_maps)) && !bypass_checks)
		log_world("attempted to start [name] on "+SSmapping.configs[GROUND_MAP].map_name+" which doesn't support it.")
		to_chat(world, "<b>Unable to start [name].</b> [SSmapping.configs[GROUND_MAP].map_name] isn't supported on [name].")
		// start a gamemode vote, in theory this should never happen.
		addtimer(CALLBACK(SSvote, TYPE_PROC_REF(/datum/controller/subsystem/vote, initiate_vote), "gamemode", "SERVER"), 10 SECONDS)
		return FALSE
	if(length(GLOB.ready_players) < required_players && !bypass_checks)
		to_chat(world, "<b>Unable to start [name].</b> Not enough players, [required_players] players needed.")
		return FALSE
	if(!set_valid_job_types() && !bypass_checks)
		return FALSE
	if(!set_valid_squads() && !bypass_checks)
		return FALSE
	return TRUE

/datum/game_mode/infestation/crash/zombie/post_setup()
	. = ..()
	for(var/obj/effect/landmark/corpsespawner/corpse AS in GLOB.corpse_landmarks_list)
		corpse.create_zombie()

	for(var/i in GLOB.zombie_spawner_turfs)
		new /obj/effect/ai_node/spawner/zombie(i)

	for(var/i in GLOB.xeno_resin_silo_turfs)
		new /obj/effect/ai_node/spawner/zombie(i)
	addtimer(CALLBACK(src, PROC_REF(balance_scales)), 1 SECONDS)
	RegisterSignal(SSdcs, COMSIG_GLOB_ZOMBIE_TUNNEL_DESTROYED, PROC_REF(check_finished))
	RegisterSignal(SSdcs, COMSIG_GLOB_DISK_GENERATED, PROC_REF(disk_printed))

/datum/game_mode/infestation/crash/zombie/on_nuke_started(datum/source, obj/machinery/nuclearbomb/nuke)
	var/datum/hive_status/normal/HS = GLOB.hive_datums[XENO_HIVE_NORMAL]
	var/area_name = get_area_name(nuke)
	HS.xeno_message("An overwhelming wave of acknowledgement ripples throughout the hive... A antimatter bomb been activated[area_name ? " in [area_name]":""]!")
	HS.set_all_xeno_trackers(nuke)

///Counts humans and zombies not in valhalla
/datum/game_mode/infestation/crash/zombie/proc/count_humans_and_zombies(list/z_levels = SSmapping.levels_by_any_trait(list(ZTRAIT_MARINE_MAIN_SHIP, ZTRAIT_GROUND, ZTRAIT_RESERVED)), count_flags)
	var/num_humans = 0
	var/num_zombies = 0
	var/num_xenos = 0

	for(var/z in z_levels)
		for(var/mob/living/carbon/xenomorph/beno in GLOB.alive_xeno_list)
			if(!istype(beno))
				continue
			if(count_flags & COUNT_IGNORE_XENO_SSD && !beno.client && beno.afk_status == MOB_DISCONNECTED)
				continue
			if(isspaceturf(beno.loc))
				continue
			num_xenos++
		for(var/mob/living/carbon/human/H  in GLOB.humans_by_zlevel["[z]"])
			if(!istype(H)) // Small fix?
				continue
			if(H.faction == FACTION_ZOMBIE)
				num_zombies++
				continue
			if(count_flags & COUNT_IGNORE_HUMAN_SSD && !H.client && H.afk_status == MOB_DISCONNECTED)
				continue
			if(isspaceturf(H.loc))
				continue
			num_humans++
	return list(num_humans, num_zombies, num_xenos)

/datum/game_mode/infestation/crash/zombie/balance_scales()
	if(GLOB.zombie_spawners == 0)
		return

	var/list/living_player_list = count_humans_and_zombies(count_flags = COUNT_IGNORE_HUMAN_SSD)
	var/num_humans = living_player_list[1]
	var/num_zombies = living_player_list[2]
	if(num_zombies * 0.125 >= num_humans) // if there's too much zombies, don't spawn even more
		for(var/obj/effect/ai_node/spawner/zombie/spawner AS in GLOB.zombie_spawners)
			if(!spawner.threat_warning)
				SSspawning.spawnerdata[spawner].max_allowed_mobs = 0
				spawner.maxamount = 0
		return
	for(var/obj/effect/ai_node/spawner/zombie/spawner AS in GLOB.zombie_spawners)
		if(!spawner.threat_warning)
			var/new_spawn_cap = round(num_humans * 8 / length(GLOB.zombie_spawners))
			SSspawning.spawnerdata[spawner].max_allowed_mobs = new_spawn_cap
			spawner.maxamount = new_spawn_cap

/datum/game_mode/infestation/crash/zombie/get_adjusted_jobworth_list(list/jobworth_list)
	return jobworth_list

/datum/game_mode/infestation/crash/zombie/check_finished(force_end)
	if(round_finished)
		return TRUE

	if(!shuttle_landed && !force_end)
		return FALSE

	if(!length(GLOB.zombie_spawners))
		message_admins("Round finished: [MODE_INFESTATION_M_MAJOR]") //marines destroyed all zombie spawners
		round_finished = MODE_INFESTATION_M_MAJOR
		return TRUE

	var/list/living_player_list = count_humans_and_xenos(count_flags = COUNT_IGNORE_HUMAN_SSD| COUNT_GREENOS_TOWARDS_MARINES )
	var/num_humans = living_player_list[1]
	var/num_xenos = living_player_list[3]
	if(num_humans && planet_nuked == INFESTATION_NUKE_NONE && marines_evac == CRASH_EVAC_NONE && !force_end)
		return FALSE

	switch(planet_nuked)
		if(INFESTATION_NUKE_NONE)
			if(!num_humans && !num_xenos)
				message_admins("Round finished: [MODE_ZOMBIE_Z_MAJOR]") //zombies wiped out ALL the marines
				round_finished = MODE_ZOMBIE_Z_MAJOR
				return TRUE
			if(marines_evac == CRASH_EVAC_COMPLETED || (!length(GLOB.active_nuke_list) && marines_evac != CRASH_EVAC_NONE))
				message_admins("Round finished: [MODE_ZOMBIE_Z_MINOR]") //marines evaced without a nuke
				round_finished = MODE_ZOMBIE_Z_MINOR
				return TRUE

		if(INFESTATION_NUKE_COMPLETED)
			if(marines_evac == CRASH_EVAC_NONE)
				message_admins("Round finished: [MODE_INFESTATION_M_MINOR]") //marines nuked the planet but didn't evac
				round_finished = MODE_INFESTATION_M_MINOR
				return TRUE
			message_admins("Round finished: [MODE_INFESTATION_M_MAJOR]") //marines nuked the planet and managed to evac
			round_finished = MODE_INFESTATION_M_MAJOR
			return TRUE

		if(INFESTATION_NUKE_COMPLETED_SHIPSIDE, INFESTATION_NUKE_COMPLETED_OTHER)
			message_admins("Round finished: [MODE_GENERIC_DRAW_NUKE]") //marines nuked themselves somehow
			round_finished = MODE_GENERIC_DRAW_NUKE
			return TRUE
	return FALSE

/datum/game_mode/infestation/crash/zombie/announce()
	to_chat(world, span_round_header("The current map is - [SSmapping.configs[GROUND_MAP].map_name]!"))
	priority_announce("Scheduled for landing in T-10 Minutes. Prepare for landing. Phrenetic reports about an unidentified disease rapidly spreading throughout the site were received before it went silent. Your mission is to contain and destroy the source of the contagion by any means necessary, including use of the on-site antimatter device. Bio-warfare protocols active. Detonation Protocol Active.<br><br> Additionally, Xenomorphic lifeforms may be present in the AO, likely willing to cooperate due to the dire situation. But be prepared to eliminate them aswell if not.",
	title = "Mission classification: TOP SECRET",
	type = ANNOUNCEMENT_PRIORITY,
	color_override = "red")
	var/sound/sound = sound(get_sfx(SFX_QUEEN), channel = CHANNEL_ANNOUNCEMENTS, volume = 50)
	for(var/mob/hearer in GLOB.alive_xeno_list_hive[XENO_HIVE_NORMAL])
		SEND_SOUND(hearer, sound)
		to_chat(hearer, assemble_alert(
			title = "Queen Mother Report",
			subtitle = "The Queen Mother reaches into your mind...",

			message = "To my children and their Queen,<br> The situation regarding this location has became dire and we can not contain the diseased tall outbreak. \
			I sense a metal bird is approaching in approximately ten minutes. Cooperate with the metal hive and eliminate the common enemy. Even if it means destroying the area.",

			color_override = "purple"
		))
	playsound(shuttle, 'sound/machines/warning-buzzer.ogg', 75, 0, 30)
	for(var/mob/living/person in GLOB.alive_living_list)
		if(!person.client)
			continue
		SEND_SOUND(person, pick('ntf_modular/sound/music/war_mode/adminmusic/zombies/Damned.ogg', 'ntf_modular/sound/music/war_mode/adminmusic/zombies/Lovesong_for_a_Deadman.ogg'))
	balance_scales()

/datum/game_mode/infestation/crash/zombie/crash_shuttle(obj/docking_port/stationary/target)
	. = ..()
	for(var/mob/living/person in GLOB.alive_living_list)
		if(!person.client)
			continue
		SEND_SOUND(person, 'ntf_modular/sound/music/war_mode/adminmusic/zombies/cod_zombies_round.ogg')

/datum/game_mode/infestation/crash/zombie/end_round_fluff()
	. = ..()
	var/sound/endround_music
	switch(round_finished)
		if(MODE_ZOMBIE_Z_MAJOR)
			endround_music = sound('ntf_modular/sound/music/war_mode/adminmusic/zombies/nacht.ogg')
		if(MODE_ZOMBIE_Z_MINOR)
			endround_music = sound('ntf_modular/sound/music/war_mode/adminmusic/zombies/tranzit.ogg')
		if(MODE_INFESTATION_M_MAJOR)
			endround_music = sound('ntf_modular/sound/music/war_mode/adminmusic/zombies/buried.ogg')
		if(MODE_INFESTATION_M_MINOR)
			endround_music = sound('ntf_modular/sound/music/war_mode/adminmusic/zombies/der_riese.ogg')
		if(MODE_GENERIC_DRAW_NUKE)
			endround_music = sound('ntf_modular/sound/music/war_mode/adminmusic/zombies/nacht.ogg')

	endround_music.channel = CHANNEL_CINEMATIC

	for(var/mob/hearer AS in GLOB.player_list)
		if(hearer.client?.prefs?.toggles_sound & SOUND_NOENDOFROUND)
			continue
		SEND_SOUND(hearer, endround_music)

/datum/game_mode/infestation/crash/zombie/proc/disk_printed()
	SIGNAL_HANDLER
	for(var/mob/hearer AS in GLOB.player_list)
		if(hearer.client?.prefs?.toggles_sound & SOUND_NOENDOFROUND)
			continue
		SEND_SOUND(hearer, 'ntf_modular/sound/music/war_mode/adminmusic/zombies/round_switch.ogg')
