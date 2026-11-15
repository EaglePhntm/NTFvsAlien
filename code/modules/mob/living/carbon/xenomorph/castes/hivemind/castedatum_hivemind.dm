/datum/xeno_caste/hivemind
	caste_name = "Hivemind"
	display_name = "Hivemind"
	upgrade_name = ""
	caste_desc = "The mind of the hive"
	caste_type_path = /mob/living/carbon/xenomorph/hivemind
	tier = XENO_TIER_ZERO
	upgrade = XENO_UPGRADE_BASETYPE
	wound_type = ""
	// *** Melee Attacks *** //
	melee_damage = 0

	// *** Speed *** //
	speed = 0

	// *** Plasma *** //
	plasma_max = 1200 //  75 is the cost of plant_weeds
	plasma_gain = 80

	// *** Health *** //
	max_health = 115

	maximum_active_caste = 1
	// *** Flags *** //
	caste_flags = CASTE_INNATE_PLASMA_REGEN|CASTE_FIRE_IMMUNE|CASTE_IS_BUILDER|CASTE_DO_NOT_ALERT_LOW_LIFE
	can_flags = CASTE_CAN_BE_GIVEN_PLASMA
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

	// *** Minimap Icon *** //
	minimap_icon = "hivemind"

	// *** Ranged Attack *** //
	spit_delay = 0 SECONDS
	spit_types = list()

	aura_strength = 4 // Incorporeal, rts commander. Buff allies

	// *** Abilities *** //

	resin_max_range = 4

	actions = list(
		/datum/action/ability/xeno_action/watch_xeno/hivemind,
		/datum/action/ability/xeno_action/change_form,
		/datum/action/ability/xeno_action/return_to_core,
		/datum/action/ability/xeno_action/teleport,
		/datum/action/ability/xeno_action/rally_hive/hivemind,
		/datum/action/ability/activable/xeno/command_minions,
		/datum/action/ability/xeno_action/psychic_influence,
		/datum/action/ability/xeno_action/psychic_radiance,
		/datum/action/ability/xeno_action/pheromones/hivemind,
		/datum/action/ability/xeno_action/pheromones/emit_recovery,
		/datum/action/ability/xeno_action/pheromones/emit_warding,
		/datum/action/ability/xeno_action/pheromones/emit_frenzy,
		/datum/action/ability/activable/psionic_interact,
		/datum/action/ability/activable/xeno/shoot_xeno_artillery,
		/datum/action/ability/xeno_action/psychic_scan,
		/datum/action/ability/activable/xeno/possession,
	)

/datum/xeno_caste/hivemind/on_caste_applied(mob/xenomorph)
	var/mob/living/carbon/xenomorph/hivemind/hivemind = xenomorph
	if(hivemind.is_combat_form())
		return ..()
	return

/datum/xeno_caste/hivemind/on_caste_removed(mob/xenomorph)
	var/mob/living/carbon/xenomorph/hivemind/hivemind = xenomorph
	if(hivemind.is_combat_form())
		return ..()
	return

/datum/xeno_caste/hivemind/hivemind_manifestation
	caste_desc = "The manifestation of the hivemind"
	wound_type = "hivemind"

	upgrade = XENO_UPGRADE_MANIFESTATION

	// *** Flags *** //
	caste_flags = CASTE_IS_BUILDER|CASTE_FIRE_IMMUNE

	aura_strength = 3 // Semi-manifested

	speed = 1.8

	actions = list(
		/datum/action/ability/xeno_action/watch_xeno/hivemind,
		/datum/action/ability/xeno_action/change_form,
		/datum/action/ability/xeno_action/manifest_combat,
		/datum/action/ability/xeno_action/return_to_core,
		/datum/action/ability/xeno_action/teleport,
		/datum/action/ability/xeno_action/rally_hive/hivemind,
		/datum/action/ability/activable/xeno/command_minions,
		/datum/action/ability/xeno_action/psychic_influence,
		/datum/action/ability/xeno_action/psychic_radiance,
		/datum/action/ability/activable/xeno/impregnate,
		/datum/action/ability/activable/xeno/larval_growth_sting,
		/datum/action/ability/activable/xeno/psychic_cure/queen_give_heal/hivemind,
		/datum/action/ability/activable/xeno/transfer_plasma/hivemind,
		/datum/action/ability/activable/xeno/healing_infusion,
		/datum/action/ability/activable/xeno/plant_weeds/ranged,
		/datum/action/ability/xeno_action/pheromones/hivemind,
		/datum/action/ability/xeno_action/pheromones/emit_recovery,
		/datum/action/ability/xeno_action/pheromones/emit_warding,
		/datum/action/ability/xeno_action/pheromones/emit_frenzy,
		/datum/action/ability/activable/xeno/secrete_resin/hivemind,
		/datum/action/ability/activable/xeno/corrosive_acid/hivemind,
		/datum/action/ability/xeno_action/place_acidwell,
		/datum/action/ability/activable/psionic_interact,
		/datum/action/ability/activable/xeno/shoot_xeno_artillery,
		/datum/action/ability/xeno_action/place_stew_pod,
		/datum/action/ability/activable/xeno/creation,
		/datum/action/ability/activable/xeno/creation/beetle,
		/datum/action/ability/activable/xeno/creation/mantis,
		/datum/action/ability/activable/xeno/creation/scorpion,
		/datum/action/ability/activable/xeno/recycle,
	)

/datum/xeno_caste/hivemind/hivemind_combat
	caste_desc = "The fully manifested body of the hivemind"
	wound_type = "hivemind"

	upgrade = XENO_UPGRADE_HIVEMIND_COMBAT

	// *** Melee Attacks *** //
	melee_damage = 19

	// *** Plasma *** //
	plasma_max = 1200 //  75 is the cost of plant_weeds
	plasma_gain = 80

	// *** Health *** //
	max_health = 415

	// *** Flags *** //
	caste_flags = CASTE_IS_BUILDER

	// *** Defense *** //
	soft_armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 0, BIO = 15, FIRE = 30, ACID = 15)

	speed = 1.8

	aura_strength = 2 // Full manifest. Have some aura as a treat

	resin_max_range = 1

	actions = list(
		/datum/action/ability/xeno_action/xeno_resting,
		/datum/action/ability/xeno_action/watch_xeno,
		/datum/action/ability/xeno_action/manifest_combat,
		/datum/action/ability/xeno_action/rally_hive/hivemind,
		/datum/action/ability/activable/xeno/command_minions,
		/datum/action/ability/xeno_action/psychic_influence,
		/datum/action/ability/xeno_action/psychic_radiance,
		/datum/action/ability/activable/xeno/psydrain,
		/datum/action/ability/activable/xeno/devour,
		/datum/action/ability/activable/xeno/cocoon,
		/datum/action/ability/activable/xeno/tail_stab/hivemind,
		/datum/action/ability/activable/xeno/impregnate,
		/datum/action/ability/activable/xeno/larval_growth_sting,
		/datum/action/ability/activable/xeno/psychic_cure/queen_give_heal/hivemind,
		/datum/action/ability/activable/xeno/transfer_plasma/hivemind,
		/datum/action/ability/activable/xeno/plant_weeds,
		/datum/action/ability/xeno_action/pheromones/hivemind,
		/datum/action/ability/xeno_action/pheromones/emit_recovery,
		/datum/action/ability/xeno_action/pheromones/emit_warding,
		/datum/action/ability/xeno_action/pheromones/emit_frenzy,
		/datum/action/ability/activable/xeno/secrete_resin/hivemind,
		/datum/action/ability/activable/psionic_interact,
		/datum/action/ability/activable/xeno/shoot_xeno_artillery,
		/datum/action/ability/xeno_action/place_stew_pod,
		/datum/action/ability/xeno_action/blessing_menu,
		/datum/action/ability/activable/xeno/recycle,
	)
