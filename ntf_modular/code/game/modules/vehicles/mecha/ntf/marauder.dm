/obj/vehicle/sealed/mecha/ntf/marauder
	desc = "A modernized combat exosuit developed as a replacement for the Durand exosuit, improved in almost every way - except cost."
	name = "\improper Marauder"
	icon_state = "marauder"
	icon = 'icons/mecha/exosuits.dmi'
	base_icon_state = "marauder"
	move_delay = 4
	max_integrity = 500
	soft_armor = list(MELEE = 60, BULLET = 55, LASER = 40, ENERGY = 30, BOMB = 30, BIO = 0, FIRE = 75, ACID = 40)
	max_temperature = 60000
	wreckage = /obj/structure/mecha_wreckage/marauder
	force = 30
	cockpit_armor = COCKPIT_HEAVY
	step_energy_drain = POWER_USAGE_HEAVY
	destruction_sleep_duration = 12
	enter_delay = EGRESS_TIME_SLOW
	exit_delay = EGRESS_TIME_SLOW

/obj/vehicle/sealed/mecha/ntf/marauder/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_zoom)
