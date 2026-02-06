/datum/xeno_caste/facehugger
	caste_name = "Facehugger"
	display_name = "Facehugger"
	upgrade_name = ""
	caste_desc = "A fast, flexible creature that wants to hug your head."
	wound_type = ""
	job_type = /datum/job/xenomorph/facehugger
	caste_type_path = /mob/living/carbon/xenomorph/facehugger
	base_strain_type = /mob/living/carbon/xenomorph/facehugger

	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE

	// *** Melee Attacks *** //
	melee_damage = 5

	// *** Speed *** //
	speed = -1.5
	weeds_speed_mod = -0.2

	// *** Plasma *** //
	plasma_max = 100
	plasma_gain = 2

	// *** Health *** //
	max_health = 50
	crit_health = -25

	// *** Flags *** //
	caste_flags = CASTE_NOT_IN_BIOSCAN|CASTE_DO_NOT_ANNOUNCE_DEATH|CASTE_DO_NOT_ALERT_LOW_LIFE|CASTE_CAN_RIDE_CRUSHER|CASTE_CAN_BE_GIVEN_PLASMA
	caste_traits = list(TRAIT_CAN_VENTCRAWL)

	// *** Defense *** //
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

	// *** Minimap Icon *** //
	minimap_icon = "facehugger"

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/xeno_action/xenohide,
		/datum/action/ability/activable/xeno/pounce/hugger,
	)

	// *** Vent Crawl Parameters *** //
	vent_enter_speed = LARVA_VENT_CRAWL_TIME
	vent_exit_speed = LARVA_VENT_CRAWL_TIME
	silent_vent_crawl = TRUE
