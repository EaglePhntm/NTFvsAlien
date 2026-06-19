/obj/vehicle/sealed/mecha/ntf/phazon
	desc = "A light exosuit featuring an experimental composite plating designed by the now-defunct Nanotrasen Corp. \
	Built from a modified Gygax frame, the armor is ultra-light, yet, can be electrically strengthened to deflect a broad range of \
	threats from rifle calibers to grenade blasts."
	name = "\improper Phazon"
	icon_state = "phazon"
	base_icon_state = "phazon"
	move_delay = 2
	max_integrity = 200
	allow_diagonal_movement = TRUE
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 50, ENERGY = 30, BOMB = 25, BIO = 0, FIRE = 85, ACID = 100)
	force = 20
	cockpit_armor = COCKPIT_ARMORED
	wreckage = /obj/structure/mecha_wreckage/phazon

/obj/vehicle/sealed/mecha/ntf/phazon/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/pulsearmor/weak)
