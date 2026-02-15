/datum/game_mode/infestation/secret_of_life
	name = "Secret of Life - Main"
	config_tag = "Secret of Life - Main"
	silo_scaling = 1
	round_type_flags = MODE_INFESTATION|MODE_PSY_POINTS|MODE_PSY_POINTS_ADVANCED|MODE_HIJACK_POSSIBLE|MODE_SILO_RESPAWN|MODE_ALLOW_XENO_QUICKBUILD|MODE_MUTATIONS_OBTAINABLE|MODE_XENO_GRAB_DEAD_ALLOWED|MODE_SINGLE_USE_NUKE_DISK_GENERATOR|MODE_CHILL_RULES
	round_type_flags2 = MODE_CAMPAIGN_LITE_SUPPORT|MODE_NO_GHOSTS|MODE_NO_ABDUCT
	shutters_drop_time = 15 MINUTES
	xeno_abilities_flags = ABILITY_ALL_GAMEMODE
	factions = list(FACTION_TERRAGOV, FACTION_SOM, FACTION_XENO, FACTION_CLF, FACTION_ICC, FACTION_VSD, FACTION_NANOTRASEN)
	human_factions = list(FACTION_TERRAGOV, FACTION_SOM, FACTION_CLF, FACTION_ICC, FACTION_VSD, FACTION_NANOTRASEN)
	valid_job_types = list(
		/datum/job/terragov/command/ceo = 1,
		/datum/job/terragov/command/nm_ceo = 1,
		/datum/job/terragov/command/captain = 1,
		/datum/job/terragov/command/fieldcommander = 1,
		/datum/job/terragov/command/corpseccommander = 1,
		/datum/job/terragov/command/staffofficer = 4,
		/datum/job/terragov/command/vanguard = 2,
		/datum/job/terragov/command/pilot = 1,
		/datum/job/terragov/command/transportofficer = 2,
		/datum/job/terragov/command/assault_crewman = 2,
		/datum/job/terragov/command/transport_crewman = 2,
		/datum/job/terragov/command/mech_pilot = 1,
		/datum/job/terragov/engineering/chief = 1,
		/datum/job/terragov/engineering/tech = 2,
		/datum/job/terragov/requisitions/officer = 1,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/medical/medicalofficer = 6,
		/datum/job/terragov/security/security_officer = 6,
		/datum/job/terragov/medical/researcher = 3,
		/datum/job/terragov/civilian/liaison = 1,
		/datum/job/terragov/silicon/synthetic = 4,
		/datum/job/terragov/silicon/ai = 1,
		/datum/job/terragov/squad/engineer = 8,
		/datum/job/terragov/squad/corpsman = 8,
		/datum/job/terragov/squad/leader = 4,
		/datum/job/terragov/squad/specialist = 4,
		/datum/job/terragov/squad/smartgunner = 4,
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/slut = -1,
		/datum/job/moraleofficer = -1,
		/datum/job/worker = -1,
		/datum/job/terragov/offduty = -1,
		/datum/job/survivor/assistant = -1,
		/datum/job/survivor/scientist = 2,
		/datum/job/survivor/doctor = 6,
		/datum/job/survivor/liaison = 1,
		/datum/job/survivor/security = 6,
		/datum/job/survivor/civilian = -1,
		/datum/job/survivor/chef = 1,
		/datum/job/survivor/botanist = 1,
		/datum/job/survivor/atmos = 2,
		/datum/job/survivor/chaplain = 1,
		/datum/job/survivor/miner = 2,
		/datum/job/survivor/salesman = 1,
		/datum/job/survivor/marshal = 1,
		/datum/job/survivor/non_deployed_operative = 2,
		/datum/job/survivor/prisoner = 2,
		/datum/job/survivor/stripper = -1,
		/datum/job/survivor/maid = 3,
		/datum/job/other/prisoner = 4,
		/datum/job/survivor/synth = 2,
		/datum/job/xenomorph = 8,
		/datum/job/xenomorph/green = FREE_XENO_AT_START_CORRUPT,
		/datum/job/xenomorph/queen = 1,
		/datum/job/som/silicon/synthetic/som = 1,
		/datum/job/som/command/commander = 1,
		/datum/job/som/command/fieldcommander = 1,
		/datum/job/som/command/staffofficer = 2,
		/datum/job/som/command/pilot = 1,
		/datum/job/som/command/assault_crewman = 2,
		/datum/job/som/command/mech_pilot = 1,
		/datum/job/som/requisitions/officer = 1,
		/datum/job/som/engineering/chief = 1,
		/datum/job/som/engineering/tech = 2,
		/datum/job/som/medical/professor = 1,
		/datum/job/som/medical/medicalofficer = 2,
		/datum/job/som/squad/standard = -1,
		/datum/job/som/squad/medic = 2,
		/datum/job/som/squad/engineer = 2,
		/datum/job/som/squad/leader = 2,
		/datum/job/som/squad/veteran = 3,
		/datum/job/other/prisonersom = 2,
		/datum/job/clf/breeder = -1,
		/datum/job/clf/standard = -1,
		/datum/job/clf/medic = 2,
		/datum/job/clf/specialist = 3,
		/datum/job/clf/tech = 3,
		/datum/job/clf/leader = 2,
		/datum/job/clf/silicon/synthetic/clf = 1,
		/datum/job/clf/mo = 1,
		/datum/job/other/prisonerclf = 2,
		/datum/job/vsd_squad/standard = -1,
		/datum/job/vsd_squad/medic = 1,
		/datum/job/vsd_squad/engineer = 1,
		/datum/job/vsd_squad/spec = 1,
		/datum/job/vsd_squad/leader = 1,
		/datum/job/icc_squad/standard = -1,
		/datum/job/icc_squad/medic = 2,
		/datum/job/icc_squad/tech = 2,
		/datum/job/icc_squad/spec = 2,
		/datum/job/icc_squad/leader = 2,
		/datum/job/terragov/civilian/liaison_archercorp = 1,
		/datum/job/terragov/civilian/liaison_novamed = 1,
		/datum/job/terragov/civilian/liaison_transco = 1,
		/datum/job/icc/liaison_cm = 1,
		/datum/job/clf/liaison_clf = 1,
		/datum/job/som/civilian/liaison_som = 1,
		/datum/job/vsd_squad/liaison_kaizoku = 1,
		/datum/job/pmc/squad/standard = -1,
		/datum/job/pmc/squad/medic = 2,
		/datum/job/pmc/squad/engineer = 2,
		/datum/job/pmc/squad/gunner = 1,
		/datum/job/pmc/squad/sniper = 1,
		/datum/job/pmc/squad/leader = 1,
	)
	enable_fun_tads = TRUE
	xenorespawn_time = 2 MINUTES
	respawn_time = 5 MINUTES
	bioscan_interval = 30 MINUTES
	deploy_time_lock = 15 SECONDS
	custom_dnr_time = SOL_DNR_TIME //40 minutes till DNR
	var/list/datum/job/stat_restricted_jobs = list(/datum/job/survivor/prisoner,/datum/job/other/prisoner,/datum/job/other/prisonersom,/datum/job/other/prisonerclf)

	var/pop_lock = FALSE //turns false post setup
	evo_requirements = list(
		/datum/xeno_caste/queen = 0,
		/datum/xeno_caste/king = 0,
		/datum/xeno_caste/dragon = 0,
	)
	max_larva_preg_at_once = MAX_LARVA_PREGNANCIES_SOL
	time_between_round_group = 0
	time_between_round_group_name = "GROUP_Extended"

/datum/game_mode/infestation/secret_of_life/pre_setup()
	. = ..()
	RegisterSignals(SSdcs, list(COMSIG_GLOB_PLAYER_ROUNDSTART_SPAWNED, COMSIG_GLOB_PLAYER_LATE_SPAWNED), PROC_REF(things_after_spawn))

/datum/game_mode/infestation/secret_of_life/proc/things_after_spawn(datum/source, mob/living/carbon/human/new_member)
	SIGNAL_HANDLER
	//no prisoner guns.
	if(new_member.job in stat_restricted_jobs)
		return
	//we use pdas for this
	var/datum/action/campaign_loadout/loadout = locate() in new_member.actions
	if(loadout)
		loadout.remove_action(new_member)

/datum/game_mode/infestation/secret_of_life/proc/toggle_pop_locks()
	// Apply Evolution Xeno Population Locks:
	pop_lock = !pop_lock
	var/sound_to_play = pop_lock ? pick('ntf_modular/sound/music/war_mode/hell_march_noearrape.ogg') : pick('ntf_modular/sound/music/war_mode/conflicttensionaltnoearrape.ogg', 'ntf_modular/sound/music/war_mode/konami-intro-metal-gear-solid.ogg')
	if(pop_lock)
		evo_requirements = list(
			/datum/xeno_caste/queen = 8,
			/datum/xeno_caste/king = 12,
			/datum/xeno_caste/dragon = 12,
		)
		/*
		for(var/mob/living/carbon/xenomorph/xeno in GLOB.xeno_mob_list)
			var/min_xenos = evo_requirements[xeno.xeno_caste.type]
			var/datum/hive_status/xenohive = xeno.get_hive()
			if(min_xenos && (xenohive.total_xenos_for_evolving() < min_xenos))
				xeno.balloon_alert(xeno, "The hive can not support the [min_xenos] xenos needed to keep this caste!")
				var/datum/xeno_caste/new_caste = GLOB.xeno_caste_datums[xeno.xeno_caste.deevolves_to][XENO_UPGRADE_BASETYPE]
				xeno.do_evolve(new_caste, TRUE) //sorry beno you are fucked.
				xeno.evolution_stored = xeno.xeno_caste.evolution_threshold //free evolution
		*/
		for(var/obj/item/teleporter_kit/indestructible/teles in GLOB.indestructible_teleporters)
			teles.resistance_flags = XENO_DAMAGEABLE
		respawn_time = 10 MINUTES //we have cloning here and small pop so its not 30 minutes.
		xenorespawn_time = 5 MINUTES
		bioscan_interval = 15 MINUTES
		round_type_flags &= ~MODE_XENO_GRAB_DEAD_ALLOWED
		round_type_flags &= ~MODE_CHILL_RULES
		GLOB.time_before_dnr = STANDARD_DNR_TIME
		GLOB.max_larva_count_per_mob = MAX_LARVA_PREGNANCIES
	else
		evo_requirements = list(
			/datum/xeno_caste/queen = 0,
			/datum/xeno_caste/king = 0,
			/datum/xeno_caste/dragon = 0,
		)
		for(var/obj/item/teleporter_kit/indestructible/teles in GLOB.indestructible_teleporters)
			teles.resistance_flags = initial(teles.resistance_flags)
		GLOB.time_before_dnr = SOL_DNR_TIME
		GLOB.max_larva_count_per_mob = MAX_LARVA_PREGNANCIES_SOL
		respawn_time = initial(respawn_time)
		xenorespawn_time = initial(xenorespawn_time)
		bioscan_interval = initial(bioscan_interval)
		round_type_flags |= MODE_XENO_GRAB_DEAD_ALLOWED
		round_type_flags |= MODE_CHILL_RULES

	for(var/datum/xeno_caste/caste AS in evo_requirements)
		GLOB.xeno_caste_datums[caste][XENO_UPGRADE_BASETYPE].evolve_min_xenos = evo_requirements[caste]
	send_ooc_announcement(
		sender_override = "[pop_lock ? "Heats of conflict are rising." : "Heat of conflict is likely dying out."]",
		title = "[pop_lock ? "It's so over." : "Back to typefucking."]",
		text = "Pop locks for xeno castes, DNR time, recloning rate, dead dragging, respawn timers, bioscans, destructability of teleporters and possibly other things will be affected.",
		sound_override = sound_to_play,
		style = OOC_ALERT_GAME,
	)
	SSvote.initiate_vote()


//sets NTC and SOM squads
/datum/game_mode/infestation/secret_of_life/set_valid_squads()
	SSjob.active_squads[FACTION_TERRAGOV] = list()
	SSjob.active_squads[FACTION_SOM] = list()
	for(var/key in SSjob.squads)
		var/datum/squad/squad = SSjob.squads[key]
		if(squad.faction == FACTION_TERRAGOV || squad.faction == FACTION_SOM) //We only want Marine and SOM squads, future proofs if more faction squads are added
			SSjob.active_squads[squad.faction] += squad
	return TRUE

/datum/game_mode/infestation/secret_of_life/announce()
	to_chat(world, "<b>The current game mode is - Extended Role-Playing!</b>")
	to_chat(world, "<b>Just have fun and role-play!</b>")

/datum/game_mode/infestation/secret_of_life/declare_completion()
	. = ..()
	to_chat(world, span_round_header("|[round_finished]|"))
	var/sound/S = sound(pick('sound/theme/neutral_hopeful1.ogg','sound/theme/neutral_hopeful2.ogg'), channel = CHANNEL_CINEMATIC)
	SEND_SOUND(world, S)

	log_game("[round_finished]\nGame mode: [name]\nRound time: [duration2text()]\nEnd round player population: [length(GLOB.clients)]\nTotal xenos spawned: [GLOB.round_statistics.total_xenos_created]\nTotal humans spawned: [GLOB.round_statistics.total_humans_created]")

/datum/game_mode/infestation/secret_of_life/post_setup()
	. = ..()
	for(var/i in GLOB.xeno_resin_silo_turfs)
		new /obj/structure/xeno/pherotower(i)
		if(prob(75))
			new /mob/living/carbon/human/species/monkey(i)

	for(var/hivenumber in GLOB.hive_datums)
		SSpoints.add_strategic_psy_points(hivenumber, 1400)
		SSpoints.add_tactical_psy_points(hivenumber, 300)
		SSpoints.add_biomass_points(hivenumber, 0) // Solely to make sure it isn't null.

	for(var/obj/effect/landmark/corpsespawner/corpse AS in GLOB.corpse_landmarks_list)
		corpse.create_mob()

//NTF addition start
	if(length(GLOB.miner_list) > MINIMUM_MINERS)
		var/list/obj/machinery/miner/platinum_list = list()
		var/list/obj/machinery/miner/phoron_list = list()
		for(var/obj/machinery/miner/miner in GLOB.miner_list)
			if(miner.is_platinum())
				platinum_list += miner
			else
				phoron_list += miner
		var/miners_kept = 0
		if(length(platinum_list) < MINIMUM_PLATINUM_MINERS)
			log_mapping("Only [length(platinum_list)] platinum miners found, less than minimum of [MINIMUM_PLATINUM_MINERS]!")
			miners_kept = length(platinum_list)
			platinum_list.Cut()
		else
			shuffle_inplace(platinum_list)
			#if (MINIMUM_PLATINUM_MINERS > 0)
			while(miners_kept < MINIMUM_PLATINUM_MINERS)
				miners_kept++
				platinum_list -= platinum_list[1]
			#endif
		var/list/obj/machinery/miner/shuffled_miners = platinum_list + phoron_list
		shuffle_inplace(shuffled_miners)
		var/miners_to_keep = miners_kept + rand((MINIMUM_MINERS - miners_kept), length(shuffled_miners))
		while(miners_kept < miners_to_keep)
			miners_kept++
			shuffled_miners -= shuffled_miners[1]
		QDEL_LIST(shuffled_miners)
	else
		if(length(GLOB.miner_list) < MINIMUM_MINERS)
			log_mapping("Only [length(GLOB.miner_list)] miners found, less than minimum of [MINIMUM_MINERS]!")
//NTF addition end

	for(var/mob/living/carbon/xenomorph/larva/xeno in GLOB.alive_xeno_list)
		xeno.evolution_stored = xeno.xeno_caste.evolution_threshold //Immediate roundstart evo for larva.

	generate_nuke_disk_spawners()

	RegisterSignal(SSdcs, COMSIG_GLOB_NUKE_EXPLODED, PROC_REF(on_nuclear_explosion))
	RegisterSignal(SSdcs, COMSIG_GLOB_NUKE_DEFUSED, PROC_REF(on_nuclear_defuse))
	RegisterSignal(SSdcs, COMSIG_GLOB_NUKE_START, PROC_REF(on_nuke_started))

/datum/game_mode/infestation/secret_of_life/check_finished()
	if(round_finished)
		return TRUE

	if(world.time < (SSticker.round_start_time + 5 SECONDS))
		return FALSE

	var/list/living_player_list = count_humans_and_xenos(count_flags = COUNT_IGNORE_ALIVE_SSD|COUNT_IGNORE_XENO_SPECIAL_AREA| COUNT_CLF_TOWARDS_XENOS | COUNT_GREENOS_TOWARDS_MARINES )
	var/num_xenos = living_player_list[2]
	var/num_humans_ship = living_player_list[3]

	if(SSevacuation.dest_status == NUKE_EXPLOSION_FINISHED)
		message_admins("Round finished: [MODE_GENERIC_DRAW_NUKE]") //ship blows, no one wins
		round_finished = MODE_GENERIC_DRAW_NUKE
		return TRUE

	switch(planet_nuked)
		if(INFESTATION_NUKE_COMPLETED)
			message_admins("Round finished: [MODE_INFESTATION_M_MINOR]") //marines managed to nuke the colony
			round_finished = MODE_INFESTATION_M_MINOR
			return TRUE
		if(INFESTATION_NUKE_COMPLETED_SHIPSIDE)
			message_admins("Round finished: [MODE_INFESTATION_X_MAJOR]") //marines managed to nuke their own ship
			round_finished = MODE_INFESTATION_X_MAJOR
			return TRUE
		if(INFESTATION_NUKE_COMPLETED_OTHER)
			message_admins("Round finished: [MODE_INFESTATION_X_MINOR]") //marines managed to nuke transit or something
			round_finished = MODE_INFESTATION_X_MINOR
			return TRUE

	if(!num_xenos)
		if(round_stage == INFESTATION_MARINE_CRASHING)
			message_admins("Round finished: [MODE_INFESTATION_M_MINOR]") //marines lost the ground operation but managed to wipe out Xenos on the ship at a greater cost, minor victory
			round_finished = MODE_INFESTATION_M_MINOR
			return TRUE
	if(round_stage == INFESTATION_MARINE_CRASHING && !num_humans_ship)
		if(SSevacuation.human_escaped > SSevacuation.initial_human_on_ship * 0.5)
			message_admins("Round finished: [MODE_INFESTATION_X_MINOR]") //xenos have control of the ship, but most marines managed to flee
			round_finished = MODE_INFESTATION_X_MINOR
			return
	return FALSE


/*

alt gamemodes

*/
/datum/game_mode/infestation/secret_of_life/nosub
	name = "Secret of Life - No subfactions"
	config_tag = "Secret of Life - No Subfactions"
	factions = list(FACTION_TERRAGOV, FACTION_SOM,FACTION_XENO, FACTION_CLF)
	human_factions = list(FACTION_TERRAGOV, FACTION_SOM, FACTION_CLF)
	valid_job_types = list(
		/datum/job/terragov/command/captain = 1,
		/datum/job/terragov/command/fieldcommander = 1,
		/datum/job/terragov/command/corpseccommander = 1,
		/datum/job/terragov/command/staffofficer = 2,
		/datum/job/terragov/command/vanguard = 2,
		/datum/job/terragov/command/pilot = 2,
		/datum/job/terragov/command/transportofficer = 2,
		/datum/job/terragov/command/transport_crewman = 3,
		/datum/job/terragov/command/mech_pilot = 1,
		/datum/job/terragov/engineering/chief = 1,
		/datum/job/terragov/engineering/tech = 2,
		/datum/job/terragov/requisitions/officer = 2,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/medical/medicalofficer = 3,
		/datum/job/terragov/security/security_officer = 3,
		/datum/job/terragov/medical/researcher = 1,
		/datum/job/terragov/civilian/liaison = 1,
		/datum/job/terragov/silicon/synthetic = 4,
		/datum/job/clf/silicon/synthetic/clf = 1,
		/datum/job/terragov/silicon/ai = 1,
		/datum/job/terragov/squad/engineer = 4,
		/datum/job/terragov/squad/corpsman = 4,
		/datum/job/terragov/squad/smartgunner = 2,
		/datum/job/terragov/squad/leader = 2,
		/datum/job/terragov/squad/specialist = 2,
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/slut = -1,
		/datum/job/moraleofficer = -1,
		/datum/job/worker = -1,
		/datum/job/terragov/offduty = -1,
		/datum/job/other/prisoner = 4,
		/datum/job/xenomorph = 5,
		/datum/job/xenomorph/queen = 1,
		/datum/job/clf/leader = 2,
		/datum/job/clf/specialist = 2,
		/datum/job/clf/tech = 2,
		/datum/job/clf/medic = 4,
		/datum/job/clf/mo = 1,
		/datum/job/clf/standard = -1,
		/datum/job/clf/breeder = -1,
		/datum/job/other/prisonerclf = 2,
		/datum/job/som/silicon/synthetic/som = 1,
		/datum/job/som/command/commander = 1,
		/datum/job/som/command/fieldcommander = 1,
		/datum/job/som/command/staffofficer = 2,
		/datum/job/som/command/pilot = 1,
		/datum/job/som/command/assault_crewman = 2,
		/datum/job/som/command/mech_pilot = 1,
		/datum/job/som/requisitions/officer = 1,
		/datum/job/som/engineering/chief = 1,
		/datum/job/som/engineering/tech = 2,
		/datum/job/som/medical/professor = 1,
		/datum/job/som/medical/medicalofficer = 2,
		/datum/job/som/squad/standard = -1,
		/datum/job/som/squad/medic = 2,
		/datum/job/som/squad/engineer = 2,
		/datum/job/som/squad/leader = 2,
		/datum/job/som/squad/veteran = 3,
		/datum/job/other/prisonersom = 2,
		/datum/job/terragov/civilian/liaison_archercorp = 1,
		/datum/job/terragov/civilian/liaison_novamed = 1,
		/datum/job/terragov/civilian/liaison_transco = 1,
		/datum/job/clf/liaison_clf = 1,
		/datum/job/som/civilian/liaison_som = 1,
	)

//old school mode, no ship, one map with bases in it, no subfactions.
/datum/game_mode/infestation/secret_of_life/classic
	name = "Secret of Life - Classic"
	config_tag = "Secret of Life - Classic"
	factions = list(FACTION_TERRAGOV, FACTION_SOM,FACTION_XENO, FACTION_CLF)
	human_factions = list(FACTION_TERRAGOV, FACTION_SOM, FACTION_CLF)
	whitelist_ship_maps = list(MAP_EAGLE_CLASSIC)
	whitelist_ground_maps = list(MAP_LV_624BASES)
	whitelist_antag_maps = list(MAP_ANTAGMAP_NOSPAWN)
	valid_job_types = list(
		/datum/job/terragov/command/captain = 1,
		/datum/job/terragov/command/fieldcommander = 1,
		/datum/job/terragov/command/corpseccommander = 1,
		/datum/job/terragov/command/staffofficer = 2,
		/datum/job/terragov/command/vanguard = 2,
		/datum/job/terragov/command/pilot = 2,
		/datum/job/terragov/command/transportofficer = 2,
		/datum/job/terragov/command/transport_crewman = 3,
		/datum/job/terragov/command/mech_pilot = 1,
		/datum/job/terragov/engineering/chief = 1,
		/datum/job/terragov/engineering/tech = 2,
		/datum/job/terragov/requisitions/officer = 2,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/medical/medicalofficer = 3,
		/datum/job/terragov/security/security_officer = 3,
		/datum/job/terragov/medical/researcher = 1,
		/datum/job/terragov/civilian/liaison = 1,
		/datum/job/terragov/silicon/synthetic = 4,
		/datum/job/clf/silicon/synthetic/clf = 1,
		/datum/job/terragov/silicon/ai = 1,
		/datum/job/terragov/squad/engineer = 4,
		/datum/job/terragov/squad/corpsman = 4,
		/datum/job/terragov/squad/smartgunner = 2,
		/datum/job/terragov/squad/leader = 2,
		/datum/job/terragov/squad/specialist = 2,
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/slut = -1,
		/datum/job/moraleofficer = -1,
		/datum/job/worker = -1,
		/datum/job/terragov/offduty = -1,
		/datum/job/other/prisoner = 4,
		/datum/job/xenomorph = 5,
		/datum/job/xenomorph/queen = 1,
		/datum/job/clf/leader = 2,
		/datum/job/clf/specialist = 2,
		/datum/job/clf/tech = 2,
		/datum/job/clf/medic = 4,
		/datum/job/clf/standard = -1,
		/datum/job/clf/mo = 1,
		/datum/job/clf/breeder = -1,
		/datum/job/som/silicon/synthetic/som = 1,
		/datum/job/som/command/commander = 1,
		/datum/job/som/command/fieldcommander = 1,
		/datum/job/som/command/staffofficer = 2,
		/datum/job/som/command/pilot = 1,
		/datum/job/som/command/assault_crewman = 2,
		/datum/job/som/command/mech_pilot = 1,
		/datum/job/som/requisitions/officer = 1,
		/datum/job/som/engineering/chief = 1,
		/datum/job/som/engineering/tech = 2,
		/datum/job/som/medical/professor = 1,
		/datum/job/som/medical/medicalofficer = 2,
		/datum/job/som/squad/standard = -1,
		/datum/job/som/squad/medic = 2,
		/datum/job/som/squad/engineer = 2,
		/datum/job/som/squad/leader = 2,
		/datum/job/som/squad/veteran = 3,
		/datum/job/other/prisonersom = 2,
		/datum/job/terragov/civilian/liaison_archercorp = 1,
		/datum/job/terragov/civilian/liaison_novamed = 1,
		/datum/job/terragov/civilian/liaison_transco = 1,
		/datum/job/clf/liaison_clf = 1,
		/datum/job/som/civilian/liaison_som = 1,
	)

/datum/game_mode/infestation/secret_of_life/alienonly
	name = "Secret of Life - NTF vs Alien only"
	config_tag = "Secret of Life - Alien only"
	factions = list(FACTION_TERRAGOV, FACTION_XENO)
	human_factions = list(FACTION_TERRAGOV)
	valid_job_types = list(
		/datum/job/terragov/command/captain = 1,
		/datum/job/terragov/command/fieldcommander = 1,
		/datum/job/terragov/command/corpseccommander = 1,
		/datum/job/terragov/command/staffofficer = 2,
		/datum/job/terragov/command/vanguard = 2,
		/datum/job/terragov/command/pilot = 2,
		/datum/job/terragov/command/transportofficer = 2,
		/datum/job/terragov/command/transport_crewman = 3,
		/datum/job/terragov/command/mech_pilot = 1,
		/datum/job/terragov/engineering/chief = 1,
		/datum/job/terragov/engineering/tech = 2,
		/datum/job/terragov/requisitions/officer = 2,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/medical/medicalofficer = 3,
		/datum/job/terragov/security/security_officer = 3,
		/datum/job/terragov/medical/researcher = 1,
		/datum/job/terragov/civilian/liaison = 1,
		/datum/job/terragov/silicon/synthetic = 4,
		/datum/job/clf/silicon/synthetic/clf = 1,
		/datum/job/terragov/silicon/ai = 1,
		/datum/job/terragov/squad/engineer = 4,
		/datum/job/terragov/squad/corpsman = 4,
		/datum/job/terragov/squad/smartgunner = 2,
		/datum/job/terragov/squad/leader = 2,
		/datum/job/terragov/squad/specialist = 2,
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/slut = -1,
		/datum/job/moraleofficer = -1,
		/datum/job/worker = -1,
		/datum/job/terragov/offduty = -1,
		/datum/job/other/prisoner = 4,
		/datum/job/xenomorph = 5,
		/datum/job/xenomorph/queen = 1,
		/datum/job/terragov/civilian/liaison_archercorp = 1,
		/datum/job/terragov/civilian/liaison_novamed = 1,
		/datum/job/terragov/civilian/liaison_transco = 1,
	)

/datum/game_mode/infestation/secret_of_life/ntf_vs_clf
	name = "Secret of Life - NTF vs CLF"
	config_tag = "Secret of Life - NTF vs CLF"
	factions = list(FACTION_TERRAGOV, FACTION_XENO, FACTION_CLF)
	human_factions = list(FACTION_TERRAGOV, FACTION_CLF)
	valid_job_types = list(
		/datum/job/terragov/command/ceo = 1,
		/datum/job/terragov/command/nm_ceo = 1,
		/datum/job/terragov/command/captain = 1,
		/datum/job/terragov/command/fieldcommander = 1,
		/datum/job/terragov/command/corpseccommander = 1,
		/datum/job/terragov/command/staffofficer = 2,
		/datum/job/terragov/command/vanguard = 2,
		/datum/job/terragov/command/pilot = 1,
		/datum/job/terragov/command/transportofficer = 2,
		/datum/job/terragov/command/assault_crewman = 2,
		/datum/job/terragov/command/transport_crewman = 2,
		/datum/job/terragov/command/mech_pilot = 1,
		/datum/job/terragov/engineering/chief = 1,
		/datum/job/terragov/engineering/tech = 2,
		/datum/job/terragov/requisitions/officer = 1,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/medical/medicalofficer = 3,
		/datum/job/terragov/security/security_officer = 3,
		/datum/job/terragov/medical/researcher = 3,
		/datum/job/terragov/civilian/liaison = 1,
		/datum/job/terragov/silicon/synthetic = 3,
		/datum/job/terragov/silicon/ai = 1,
		/datum/job/terragov/squad/engineer = 4,
		/datum/job/terragov/squad/corpsman = 4,
		/datum/job/terragov/squad/leader = 2,
		/datum/job/terragov/squad/specialist = 2,
		/datum/job/terragov/squad/smartgunner = 2,
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/slut = -1,
		/datum/job/moraleofficer = -1,
		/datum/job/worker = -1,
		/datum/job/terragov/offduty = -1,
		/datum/job/survivor/assistant = 1,
		/datum/job/survivor/scientist = 1,
		/datum/job/survivor/doctor = 1,
		/datum/job/survivor/liaison = 1,
		/datum/job/survivor/security = 1,
		/datum/job/survivor/civilian = 4,
		/datum/job/survivor/chef = 1,
		/datum/job/survivor/botanist = 1,
		/datum/job/survivor/atmos = 1,
		/datum/job/survivor/chaplain = 1,
		/datum/job/survivor/miner = 1,
		/datum/job/survivor/salesman = 1,
		/datum/job/survivor/marshal = 1,
		/datum/job/survivor/non_deployed_operative = 2,
		/datum/job/survivor/prisoner = 4,
		/datum/job/survivor/stripper = -1,
		/datum/job/survivor/maid = 4,
		/datum/job/survivor/synth = 1,
		/datum/job/other/prisoner = 4,
		/datum/job/xenomorph = 5,
		/datum/job/xenomorph/green = FREE_XENO_AT_START_CORRUPT,
		/datum/job/xenomorph/queen = 1,
		/datum/job/clf/breeder = -1,
		/datum/job/clf/standard = -1,
		/datum/job/clf/medic = 6,
		/datum/job/clf/tech = 6,
		/datum/job/clf/specialist = 4,
		/datum/job/clf/mo = 1,
		/datum/job/clf/leader = 2,
		/datum/job/clf/silicon/synthetic/clf = 1,
		/datum/job/other/prisonerclf = 2,
		/datum/job/terragov/civilian/liaison_archercorp = 1,
		/datum/job/terragov/civilian/liaison_novamed = 1,
		/datum/job/terragov/civilian/liaison_transco = 1,
		/datum/job/clf/liaison_clf = 1,
	)
