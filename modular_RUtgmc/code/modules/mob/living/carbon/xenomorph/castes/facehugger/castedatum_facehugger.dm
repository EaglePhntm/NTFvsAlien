/datum/xeno_caste/facehugger
	caste_name = "Facehugger"
	display_name = "Facehugger"
	upgrade_name = ""
	caste_desc = "A fast, flexible creature that wants to hug your head."
	wound_type = ""
	job_type = /datum/job/xenomorph/facehugger
	caste_type_path = /mob/living/carbon/xenomorph/facehugger/larval
	base_strain_type = /mob/living/carbon/xenomorph/facehugger/larval

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
	//minimap_icon = "facehugger"
	minimap_icon = "xenominion"

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

//strains
/datum/xeno_caste/facehugger/larval //so it pops up in strains
	display_name = "Larval Facehugger"
	caste_name = "Larval Facehugger"

/datum/xeno_caste/facehugger/slash
	display_name = "Clawed Facehugger"
	caste_name = "Clawed Facehugger"
	caste_desc = "This one looks much more active than its fellows. This nasty little creature is a nightmarish scrabble of muscle and sharp, long claws."
	caste_type_path = /mob/living/carbon/xenomorph/facehugger/combat/slash
	melee_damage = 25
	attack_delay = 7
	speed = -1.5
	plasma_max = 50

/datum/xeno_caste/facehugger/neuro
	display_name = "Neurotoxin Facehugger"
	caste_name = "Neurotoxin Facehugger"
	caste_desc = "This one looks much more active than its fellows. This strange creature has a single prominent sharp proboscis."
	caste_type_path = /mob/living/carbon/xenomorph/facehugger/chemical/neurotoxin
	speed = -1.3
	attack_delay = 9

/datum/xeno_caste/facehugger/aphro
	display_name = "Aphrotoxin Facehugger"
	caste_name = "Aphrotoxin Facehugger"
	caste_desc = "This one looks much more active than its fellows. This strange creature has a single prominent sharp proboscis."
	caste_type_path = /mob/living/carbon/xenomorph/facehugger/chemical/aphrotoxin
	speed = -1.3
	attack_delay = 9

/datum/xeno_caste/facehugger/ozelomelyn
	display_name = "Ozelomelyn Facehugger"
	caste_name = "Ozelomelyn Facehugger"
	caste_desc = "This one looks much more active than its fellows. This strange creature has a single prominent sharp proboscis."
	caste_type_path = /mob/living/carbon/xenomorph/facehugger/chemical/ozelomelyn
	speed = -1.3
	attack_delay = 9

/datum/xeno_caste/facehugger/acid
	display_name = "Acid Facehugger"
	caste_name = "Acid Facehugger"
	caste_desc = "This one looks much more active than its fellows. This repulsive looking thing is bloated with throbbing, putrescent green sacks of flesh."
	caste_type_path = /mob/living/carbon/xenomorph/facehugger/combat/acid
	speed = -1.1
	plasma_max = 40 //very deadly

/datum/xeno_caste/facehugger/resin
	display_name = "Resin Facehugger"
	caste_name = "Resin Facehugger"
	caste_desc = "This one looks much more active than its fellows. This truly bizzare, bloated creature drips with purple, viscous resin."
	caste_type_path = /mob/living/carbon/xenomorph/facehugger/combat/resin
	speed = -1.1
	plasma_max = 50
