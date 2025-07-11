/datum/xeno_caste/queen
	caste_name = "Queen"
	display_name = "Queen"
	upgrade_name = ""
	base_strain_type = /mob/living/carbon/xenomorph/queen
	caste_type_path = /mob/living/carbon/xenomorph/queen
	caste_desc = "The biggest and baddest xeno. The Queen controls the hive."
	job_type = /datum/job/xenomorph/queen

	tier = XENO_TIER_FOUR
	upgrade = XENO_UPGRADE_BASETYPE
	wound_type = "queen" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 28

	// *** Speed *** //
	speed = -0.3

	// *** Plasma *** //
	plasma_max = 1200
	plasma_gain = 90

	// *** Health *** //
	max_health = 600

	// *** Sunder *** //
	sunder_multiplier = 0.8

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD
	maximum_active_caste = 1
	death_evolution_delay = 5 MINUTES
	deevolves_to = /mob/living/carbon/xenomorph/drone

	// *** Flags *** //
	caste_flags = CASTE_IS_INTELLIGENT|CASTE_IS_BUILDER|CASTE_STAGGER_RESISTANT|CASTE_LEADER_TYPE|CASTE_INSTANT_EVOLUTION|CASTE_EVOLUTION_ALLOWED
	can_hold_eggs = CAN_HOLD_TWO_HANDS
	can_flags = CASTE_CAN_HOLD_FACEHUGGERS|CASTE_CAN_CORRUPT_GENERATOR|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_RULER
	caste_traits = list(TRAIT_CAN_TEAR_HOLE, TRAIT_CAN_DISABLE_MINER)

	// *** Defense *** //
	soft_armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 65, BOMB = 30, BIO = 60, FIRE = 60, ACID = 60)

	// *** Ranged Attack *** //
	spit_delay = 1.1 SECONDS
	spit_types = list(/datum/ammo/xeno/sticky, /datum/ammo/xeno/acid/medium, /datum/ammo/xeno/toxin/aphrotoxin/upgrade3, /datum/ammo/xeno/toxin/upgrade3)

	// *** Pheromones *** //
	aura_strength = 5 //The Queen's aura is strong and stays so, and gets devastating late game. Climbs by 1 to 5

	// *** Queen Abilities *** //
	queen_leader_limit = 4 //Amount of leaders allowed

	minimap_icon = "xenoqueen"

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/psychic_whisper,
		/datum/action/ability/xeno_action/psychic_influence,
		/datum/action/ability/activable/xeno/impregnate,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/devour,
		/datum/action/ability/activable/xeno/cocoon,
		/datum/action/ability/activable/xeno/plant_weeds,
		/datum/action/ability/xeno_action/lay_egg,
		/datum/action/ability/activable/xeno/secrete_resin/hivelord,
		/datum/action/ability/xeno_action/blessing_menu,
		/datum/action/ability/activable/xeno/tail_stab,
		/datum/action/ability/xeno_action/place_acidwell,
		/datum/action/ability/xeno_action/call_of_the_burrowed,
		/datum/action/ability/activable/xeno/screech,
		/datum/action/ability/xeno_action/bulwark,
		/datum/action/ability/activable/xeno/larval_growth_sting,
		/datum/action/ability/activable/xeno/corrosive_acid/strong,
		/datum/action/ability/activable/xeno/xeno_spit,
		/datum/action/ability/activable/xeno/psychic_cure/queen_give_heal,
		/datum/action/ability/activable/xeno/neurotox_sting/ozelomelyn,
		/datum/action/ability/xeno_action/pheromones,
		/datum/action/ability/xeno_action/pheromones/emit_recovery,
		/datum/action/ability/xeno_action/pheromones/emit_warding,
		/datum/action/ability/xeno_action/pheromones/emit_frenzy,
		/datum/action/ability/xeno_action/toggle_queen_zoom,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/xeno_action/set_xeno_lead,
		/datum/action/ability/activable/xeno/queen_give_plasma,
		/datum/action/ability/xeno_action/hive_message,
		/datum/action/ability/xeno_action/rally_hive,
		/datum/action/ability/activable/xeno/command_minions,
		/datum/action/ability/activable/psionic_interact, //Psychics for all the psykers!
		/datum/action/ability/activable/xeno/impregnatequeen, //So the Queen doesn't want to end themselves.
		/datum/action/ability/activable/xeno/place_pattern,
		/datum/action/ability/xeno_action/place_jelly_pod, // So queens can make jelly exports too
		/datum/action/ability/xeno_action/create_edible_jelly,
		/datum/action/ability/xeno_action/place_stew_pod,
	)


/datum/xeno_caste/queen/young
	upgrade = XENO_UPGRADE_NORMAL

/datum/xeno_caste/queen/primordial
	upgrade_name = "Primordial"
	caste_desc = "A fearsome Xeno hulk of titanic proportions. Nothing can stand in it's way."
	primordial_message = "Destiny bows to our will as the universe trembles before us."
	upgrade = XENO_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/psychic_whisper,
		/datum/action/ability/xeno_action/psychic_influence,
		/datum/action/ability/activable/xeno/impregnate,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/devour,
		/datum/action/ability/activable/xeno/cocoon,
		/datum/action/ability/activable/xeno/plant_weeds,
		/datum/action/ability/xeno_action/lay_egg,
		/datum/action/ability/activable/xeno/secrete_resin/hivelord,
		/datum/action/ability/xeno_action/blessing_menu,
		/datum/action/ability/activable/xeno/tail_stab,
		/datum/action/ability/xeno_action/place_acidwell,
		/datum/action/ability/xeno_action/call_of_the_burrowed,
		/datum/action/ability/activable/xeno/screech, // Primo enables alterative action for screech.
		/datum/action/ability/xeno_action/bulwark,
		/datum/action/ability/activable/xeno/larval_growth_sting,
		/datum/action/ability/activable/xeno/corrosive_acid/strong,
		/datum/action/ability/activable/xeno/xeno_spit,
		/datum/action/ability/activable/xeno/psychic_cure/queen_give_heal,
		/datum/action/ability/activable/xeno/neurotox_sting/ozelomelyn,
		/datum/action/ability/xeno_action/pheromones,
		/datum/action/ability/xeno_action/pheromones/emit_recovery,
		/datum/action/ability/xeno_action/pheromones/emit_warding,
		/datum/action/ability/xeno_action/pheromones/emit_frenzy,
		/datum/action/ability/xeno_action/toggle_queen_zoom,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/xeno_action/set_xeno_lead,
		/datum/action/ability/activable/xeno/queen_give_plasma,
		/datum/action/ability/xeno_action/hive_message,
		/datum/action/ability/xeno_action/rally_hive,
		/datum/action/ability/activable/xeno/command_minions,
		/datum/action/ability/activable/psionic_interact, //Psychics for all the psykers!
		/datum/action/ability/activable/xeno/impregnatequeen, //So the Queen doesn't want to end themselves.
		/datum/action/ability/xeno_action/ready_charge/queen_charge,
		/datum/action/ability/activable/xeno/place_pattern,
		/datum/action/ability/xeno_action/create_edible_jelly,
		/datum/action/ability/xeno_action/place_stew_pod,
	)
