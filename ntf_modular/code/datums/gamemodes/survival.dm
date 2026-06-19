/datum/game_mode/infestation/colony_fall
	name = "Colony Fall"
	config_tag = "Colony Fall"
	round_type_flags = MODE_INFESTATION|MODE_DISALLOW_RAILGUN|MODE_PSY_POINTS|MODE_XENO_GRAB_DEAD_ALLOWED|MODE_MUTATIONS_OBTAINABLE
	round_type_flags2 = MODE_2_NO_GHOSTS|MODE_2_SURVIVAL
	xeno_abilities_flags = ABILITY_ALL_GAMEMODE
	factions = list(FACTION_XENO, FACTION_CLF)
	human_factions = list(FACTION_CLF)
	valid_job_types = list(
		/datum/job/survivor/assistant = 2,
		/datum/job/survivor/scientist = 1,
		/datum/job/survivor/doctor = 2,
		/datum/job/survivor/liaison = 1,
		/datum/job/survivor/security = 4,
		/datum/job/survivor/civilian = 6,
		/datum/job/survivor/chef = 1,
		/datum/job/survivor/botanist = 1,
		/datum/job/survivor/atmos = 2,
		/datum/job/survivor/chaplain = 1,
		/datum/job/survivor/miner = 2,
		/datum/job/survivor/salesman = 1,
		/datum/job/survivor/marshal = 1,
		/datum/job/survivor/non_deployed_operative = 2,
		/datum/job/survivor/prisoner = 6,
		/datum/job/survivor/stripper = 4,
		/datum/job/survivor/maid = 4,
		/datum/job/survivor/synth = 1,
		/datum/job/clf/standard = 1,
		/datum/job/clf/medic = 1,
		/datum/job/clf/leader = 1,
		/datum/job/xenomorph = 2,//two so they dont wipe by a mistake or maybe duo.
	)
	evo_requirements = list(
		/datum/xeno_caste/queen = 8,
		/datum/xeno_caste/king = 12,
		/datum/xeno_caste/dragon = 12,
		/datum/xeno_caste/gorger = 6,
		/datum/xeno_caste/widow = 6,
		/datum/xeno_caste/ravager = 6,
		/datum/xeno_caste/praetorian = 6,
		/datum/xeno_caste/boiler = 6,
		/datum/xeno_caste/defiler = 6,
		/datum/xeno_caste/crusher = 6,
		/datum/xeno_caste/shrike = 6,
		/datum/xeno_caste/behemoth = 6,
		/datum/xeno_caste/warlock = 6,
		/datum/xeno_caste/chimera = 6,
	)

	shutters_drop_time = 5 SECONDS
	deploy_time_lock = 5 SECONDS
	xenorespawn_time = 2 MINUTES
	whitelist_ground_maps = list(MAP_COLONY1)
	blacklist_ground_maps = null
	whitelist_ship_maps = list(MAP_EAGLE) //since it dont have survivor spawns, they should spawn at colony itself. And can be used to spawn marines later. Eagle is a fast dropship for emergency response.
	whitelist_antag_maps = list(MAP_ANTAGMAP_NOSPAWN)
	bioscan_interval = 0
	spawn_xeno_shit = FALSE

/datum/game_mode/infestation/colony_fall/post_setup()
	. = ..()

	if(!(round_type_flags & MODE_INFESTATION))
		return

	for(var/i in GLOB.xeno_resin_silo_turfs)
		new /obj/structure/xeno/silo(i)
		new /obj/structure/xeno/pherotower(i)

	for(var/i in GLOB.alive_xeno_list_hive[XENO_HIVE_NORMAL])
		if(isxenolarva(i)) // Larva
			var/mob/living/carbon/xenomorph/larva/X = i
			X.evolution_stored = X.xeno_caste.evolution_threshold //Immediate roundstart evo for larva.
		else // Handles Shrike etc
			var/mob/living/carbon/xenomorph/X = i
			X.upgrade_stored = X.xeno_caste.upgrade_threshold


/datum/game_mode/infestation/colony_fall/announce()
	to_chat("all", span_round_header("The current map is - [SSmapping.configs[GROUND_MAP].map_name]!"))
	to_chat("all", span_information("The brave colonists from earth were just settling down in this colony in some part of the planet XF-69, Surely nothing will go out of the ordinary this shift. // Stick to roleplay requirements, nobody but security must be visibly armed in green alert."))
	priority_announce(
		message = "It's the beginning of another shift in [SSmapping.configs[GROUND_MAP].map_name]. Make Phantom City proud!",
		title = "Good morning, crew.",
		type = ANNOUNCEMENT_PRIORITY,
		color_override = "blue"
	)
	var/sound/S = sound(get_sfx(SFX_QUEEN), channel = CHANNEL_ANNOUNCEMENTS, volume = 50)
	for(var/i in (GLOB.xeno_mob_list + GLOB.observer_list))
		var/mob/M = i
		SEND_SOUND(M, S)
		to_chat(M, assemble_alert(
			title = "Queen Mother Calls.",
			message = "Rise my children, it is time to assault this still unbuilt tall-host hive before they can call for help. You are alone, so take care and infect hosts to grow your hive. Do not let the talls find you out too soon, or you will have trouble.",
			color_override = "purple"
		))
		to_chat(M, span_information("You are a xenomorph, your primary goal is to breed as many hosts as possible while keeping yourself and the larvas in the hosts alive. You must still stick to roleplay standards. There is no time limit in this mode, take your time with erp or whatever rather than spamming impregnate on people. Game ends when all Xenos or Humans die. If you allow the talls to call for help, you will have trouble."))
		//to_chat("all", span_boldwarning("Xenos can not see mobs through walls in this mode."))


/datum/game_mode/infestation/colony_fall/check_finished()
	if(round_finished)
		return TRUE

	if(world.time < (SSticker.round_start_time + 5 MINUTES))
		return FALSE

	var/list/living_player_list = count_humans_and_xenos(count_flags = COUNT_IGNORE_HUMAN_SSD|COUNT_IGNORE_XENO_SSD| COUNT_CLF_TOWARDS_XENOS | COUNT_GREENOS_TOWARDS_MARINES)
	var/num_humans = living_player_list[1]
	var/datum/job/xeno_job = SSjob.GetJobType(/datum/job/xenomorph)
	var/num_xenos = xeno_job.total_positions
	if(round_finished)
		if(num_humans > num_xenos)
			message_admins("Round finished: NTC Minor Victory.") //there were more humans than xenos left when round ended.
			round_finished = MODE_INFESTATION_M_MINOR
		else if (num_humans >= 1 && num_humans < num_xenos)
			message_admins("Round finished: [MODE_INFESTATION_X_MINOR]") //there are survivors but xeno numbers are higher than humans.
			round_finished = MODE_INFESTATION_X_MINOR
			return TRUE
		to_chat("all", span_round_body("There were [num_humans] (non ssd) humans and [num_xenos] xenomorphs alive at round end."))
		return TRUE

	if(!num_humans)
		if(!num_xenos)
			message_admins("Round finished: [MODE_INFESTATION_DRAW_DEATH]") //everyone died at the same time, no one wins
			round_finished = MODE_INFESTATION_DRAW_DEATH
			return TRUE
		message_admins("Round finished: [MODE_INFESTATION_X_MAJOR]") //xenos wiped out ALL the marines without hijacking, xeno major victory
		round_finished = MODE_INFESTATION_X_MAJOR
		return TRUE
	if(!num_xenos)
		message_admins("Round finished: NTC Major Victory.") //marines win big
		round_finished = MODE_INFESTATION_M_MAJOR
		return TRUE


/datum/game_mode/infestation/colony_fall/survival
	name = "Colony Survival"
	config_tag = "Colony Survival"
	factions = list(FACTION_XENO, FACTION_ICC, FACTION_CLF)
	human_factions = list(FACTION_ICC, FACTION_CLF)
	valid_job_types = list(
		/datum/job/survivor/assistant = 2,
		/datum/job/survivor/scientist = 1,
		/datum/job/survivor/doctor = 2,
		/datum/job/survivor/liaison = 1,
		/datum/job/survivor/security = 4,
		/datum/job/survivor/civilian = 6,
		/datum/job/survivor/chef = 1,
		/datum/job/survivor/botanist = 1,
		/datum/job/survivor/atmos = 2,
		/datum/job/survivor/chaplain = 1,
		/datum/job/survivor/miner = 2,
		/datum/job/survivor/salesman = 1,
		/datum/job/survivor/marshal = 1,
		/datum/job/survivor/non_deployed_operative = 2,
		/datum/job/survivor/prisoner = 6,
		/datum/job/survivor/stripper = 4,
		/datum/job/survivor/maid = 4,
		/datum/job/survivor/synth = 1,
		/datum/job/clf/standard = 2,
		/datum/job/clf/medic = 1,
		/datum/job/clf/specialist = 1,
		/datum/job/clf/leader = 1,
		/datum/job/xenomorph = 5,//five since there will be CM
		/datum/job/icc_squad/standard = 2,
		/datum/job/icc_squad/medic = 1,
		/datum/job/icc_squad/tech = 1,
		/datum/job/icc_squad/spec = 1,
		/datum/job/icc_squad/leader = 1,
		/datum/job/icc/commander = 1,
		/datum/job/icc/fieldcommander = 1,
		/datum/job/icc/administrator = 4,
	)
	whitelist_ground_maps = null
	whitelist_antag_maps = null
	blacklist_ground_maps = list(MAP_WHISKEY_OUTPOST, MAP_OSCAR_OUTPOST, MAP_FORT_PHOBOS, MAP_COLONY1, MAP_CORSAT, MAP_LV_624BASES)

/datum/game_mode/infestation/colony_fall/survival/announce()
	to_chat("all", span_round_header("The current map is - [SSmapping.configs[GROUND_MAP].map_name]!"))
	to_chat("all", span_information("The brave colonists from earth have settled down and heard terrible things have happened to some other colonies across the world but it is hard to believe the rumors... Surely nothing will go out of the ordinary this shift. // Stick to roleplay requirements, nobody but security must be visibly armed in green alert."))
	priority_announce(
		message = "It's the beginning of another shift in [SSmapping.configs[GROUND_MAP].map_name]. Make Phantom City proud!",
		title = "Good morning, colonists.",
		type = ANNOUNCEMENT_PRIORITY,
		color_override = "blue"
	)
	var/sound/S = sound(get_sfx(SFX_QUEEN), channel = CHANNEL_ANNOUNCEMENTS, volume = 50)
	for(var/i in (GLOB.xeno_mob_list + GLOB.observer_list))
		var/mob/M = i
		SEND_SOUND(M, S)
		to_chat(M, assemble_alert(
			title = "Queen Mother Calls.",
			message = "Rise my children, it is time to assault this still unbuilt tall-host hive before they can call for help. You are alone, so take care and infect hosts to grow your hive. Do not let the talls find you out too soon, or you will have trouble.",
			color_override = "purple"
		))
		to_chat(M, span_information("You are a xenomorph, your primary goal is to breed as many hosts as possible while keeping yourself and the larvas in the hosts alive. You must still stick to roleplay standards. There is no time limit in this mode, take your time with erp or whatever rather than spamming impregnate on people. Game ends when all Xenos or Humans die. If you allow the talls to call for help, you will have trouble."))
		//to_chat("all", span_boldwarning("Xenos can not see mobs through walls in this mode."))
