/datum/xeno_caste/runner/panther
	caste_name = "Panther"
	display_name = "Panther"
	upgrade_name = ""
	caste_desc = "Run fast, hit hard, die young."
	caste_type_path = /mob/living/carbon/xenomorph/runner/panther
	tier = XENO_TIER_ONE
	upgrade = XENO_UPGRADE_BASETYPE
	wound_type = "panther" //used to match appropriate wound overlays

	gib_anim = "gibbed-a-corpse-runner"
	gib_flick = "gibbed-a-runner"

	// *** Melee Attacks *** //
	melee_damage = 18
	attack_delay = 6

	// *** Speed *** //
	speed = -1.5

	// *** Plasma *** //
	plasma_max = 150
	plasma_gain = 0
	plasma_regen_limit = 0.2
	plasma_icon_state = "fury"

	// *** Health *** //
	max_health = 240

	// *** Flags *** //
	caste_flags = CASTE_INNATE_PLASMA_REGEN|CASTE_PLASMADRAIN_IMMUNE|CASTE_EVOLUTION_ALLOWED|CASTE_MUTATIONS_ALLOWED
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_LEADER|CASTE_CAN_RIDE_CRUSHER
	caste_traits = list(TRAIT_CAN_VENTCRAWL)

	// *** Defense *** //
	soft_armor = list(MELEE = 20, BULLET = 19, LASER = 19, ENERGY = 19, BOMB = 0, BIO = 7, FIRE = 19, ACID = 7)

	// *** Minimap Icon *** //
	//minimap_icon = "panther"

	// *** Abilities *** ///
	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/psychic_influence,
		/datum/action/ability/activable/xeno/impregnate,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain/panther,
		/datum/action/ability/activable/xeno/devour,
		/datum/action/ability/xeno_action/xenohide,
		/datum/action/ability/activable/xeno/tail_stab,
		/datum/action/ability/activable/xeno/pounce/panther,
		/datum/action/ability/activable/xeno/adrenalinejump,
		/datum/action/ability/xeno_action/evasion,
		/datum/action/ability/xeno_action/tearingtail,
		/datum/action/ability/xeno_action/select_reagent/panther,
		/datum/action/ability/xeno_action/create_edible_jelly,
		/datum/action/ability/xeno_action/place_stew_pod,
	)


	mutations = list(
		/datum/mutation_upgrade/shell/upfront_evasion,
		/datum/mutation_upgrade/shell/borrowed_time,
		/datum/mutation_upgrade/shell/ingrained_evasion,
		/datum/mutation_upgrade/spur/sneak_attack,
		/datum/mutation_upgrade/spur/right_here,
		/datum/mutation_upgrade/veil/headslam,
		/datum/mutation_upgrade/veil/passing_glance
	)

/datum/xeno_caste/runner/panther/normal
	upgrade = XENO_UPGRADE_NORMAL

/datum/xeno_caste/runner/panther/primordial
	upgrade_name = "Primordial"
	caste_desc = "Run fast, hit hard, die never."
	primordial_message = "We will never die."
	upgrade = XENO_UPGRADE_PRIMO

	// *** Abilities *** ///
	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/psychic_influence,
		/datum/action/ability/activable/xeno/impregnate,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/psydrain/panther,
		/datum/action/ability/activable/xeno/devour,
		/datum/action/ability/xeno_action/xenohide,
		/datum/action/ability/activable/xeno/tail_stab,
		/datum/action/ability/activable/xeno/pounce/panther,
		/datum/action/ability/activable/xeno/adrenalinejump,
		/datum/action/ability/xeno_action/evasion,
		/datum/action/ability/xeno_action/tearingtail,
		/datum/action/ability/xeno_action/select_reagent/panther,
		/datum/action/ability/xeno_action/adrenaline_rush,
		/datum/action/ability/xeno_action/create_edible_jelly,
		/datum/action/ability/xeno_action/place_stew_pod,
	)
