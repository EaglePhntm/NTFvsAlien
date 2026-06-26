/obj/vehicle/sealed/mecha/ntf/gygax
	desc = "A combat exosuit, commonly used by law enforcement or security firms as a patrol vehicle, or as part of a rapid response team. \
	It's lightweight polymer and aluminium shell give it adequate protection from most handgun to light rifle threats. It has room for up to two \
	occupants."
	name = "\improper Gygax"
	icon_state = "gygax"
	base_icon_state = "gygax"
	allow_diagonal_movement = TRUE
	move_delay = 3
	max_integrity = 300
	max_occupants = 2
	soft_armor = list(MELEE = 40, BULLET = 30, LASER = 40, ENERGY = 30, BOMB = 25, BIO = 0, FIRE = 60, ACID = 50)
	leg_overload_coeff = 5
	force = 20
	wreckage = /obj/structure/mecha_wreckage/gygax
	step_energy_drain = POWER_USAGE_STANDARD
	cockpit_armor = COCKPIT_ARMORED

/obj/vehicle/sealed/mecha/ntf/gygax/generate_actions()
	. = ..()
	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_overload_mode)

/obj/vehicle/sealed/mecha/ntf/gygax/dark
	desc = "A combat exosuit, commonly used by law enforcement or security firms as a patrol vehicle, or as part of a rapid response team. \
	It's lightweight polymer and aluminium shell give it adequate protection from most handgun to light rifle threats. It has room for up to two \
	occupants. This one has been painted a darker color."
	name = "\improper Dark Gygax"
	icon_state = "darkgygax"
	base_icon_state = "darkgygax"
