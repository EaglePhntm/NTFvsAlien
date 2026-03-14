/datum/xeno_caste/chimera
	caste_name = "Chimera"
	display_name = "Chimera"
	upgrade_name = ""
	base_strain_type = /mob/living/carbon/xenomorph/chimera
	caste_type_path = /mob/living/carbon/xenomorph/chimera
	caste_desc = "A slim, deadly alien creature. It has two additional arms with mantis blades."
	tier = XENO_TIER_THREE
	upgrade = XENO_UPGRADE_BASETYPE
	wound_type = "chimera" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 25
	attack_delay = 7

	// *** Speed *** //
	speed = -1

	// *** Plasma *** //
	plasma_max = 400
	plasma_gain = 35

	// *** Health *** //
	max_health = 350

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD

	deevolves_to = /datum/xeno_caste/wraith

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED
	can_flags = parent_type::can_flags|CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA

	// *** Defense *** //
	soft_armor = list(MELEE = 50, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 0, BIO = 50, FIRE = 0, ACID = 50)

	wraith_blink_range = 5

	minimap_icon = "wraith"

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/psychic_influence,
		/datum/action/ability/activable/xeno/impregnate,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/devour,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/blink/chimera,
		/datum/action/ability/xeno_action/phantom,
		/datum/action/ability/activable/xeno/pounce/abduction,
		/datum/action/ability/activable/xeno/body_swap,
		/datum/action/ability/xeno_action/warp_blast,
		/datum/action/ability/xeno_action/create_edible_jelly,
		/datum/action/ability/xeno_action/place_stew_pod,
	)

/datum/xeno_caste/chimera/normal
	upgrade = XENO_UPGRADE_NORMAL

/datum/xeno_caste/chimera/primordial
	upgrade_name = "Primordial"
	upgrade = XENO_UPGRADE_PRIMO

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/psychic_influence,
		/datum/action/ability/activable/xeno/impregnate,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/activable/xeno/devour,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/blink/chimera,
		/datum/action/ability/xeno_action/phantom,
		/datum/action/ability/activable/xeno/pounce/abduction,
		/datum/action/ability/activable/xeno/body_swap,
		/datum/action/ability/xeno_action/warp_blast,
		/datum/action/ability/xeno_action/crippling_strike,
		/datum/action/ability/xeno_action/create_edible_jelly,
		/datum/action/ability/xeno_action/place_stew_pod,
	)

/datum/xeno_caste/chimera/phantom
	caste_type_path = /mob/living/carbon/xenomorph/chimera/phantom
	caste_flags = CASTE_DO_NOT_ALERT_LOW_LIFE|CASTE_IS_A_MINION|CASTE_DO_NOT_ANNOUNCE_DEATH
	can_flags = CASTE_CAN_BE_QUEEN_HEALED
	caste_traits = null

	melee_damage = 20

	minimap_icon = "xenominion"

	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE

	max_health = 150

	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

	actions = null
