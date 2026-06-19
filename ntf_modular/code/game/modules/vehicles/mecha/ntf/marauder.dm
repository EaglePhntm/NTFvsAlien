/obj/vehicle/sealed/mecha/ntf/marauder
	desc = "A modernized combat exosuit developed as a replacement for the Durand exosuit, improved in almost every way - except cost."
	name = "\improper Marauder"
	icon_state = "marauder"
	base_icon_state = "marauder"
	move_delay = 4
	max_integrity = 500
	soft_armor = list(MELEE = 75, BULLET = 55, LASER = 40, ENERGY = 30, BOMB = 55, BIO = 0, FIRE = 80, ACID = 100)
	max_temperature = 60000
	wreckage = /obj/structure/mecha_wreckage/marauder
	mecha_flags = CANSTRAFE | IS_ENCLOSED | HAS_HEADLIGHTS
	force = 30
	bumpsmash = FALSE
	cockpit_armor = COCKPIT_HEAVY

	equip_by_category = list(
		MECHA_L_ARM = null,
		MECHA_R_ARM = null,
		MECHA_UTILITY = list(),
		MECHA_POWER = list(),
		MECHA_ARMOR = list(),
	)

/obj/vehicle/sealed/mecha/combat/marauder/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_zoom)
