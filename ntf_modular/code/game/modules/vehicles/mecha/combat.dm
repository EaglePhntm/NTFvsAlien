/obj/vehicle/sealed/mecha/combat
	desc = "Wombat"
	allow_diagonal_movement = FALSE
	move_delay = 3
	max_integrity = 400
	soft_armor = list(MELEE = 60, BULLET = 40, LASER = 30, ENERGY = 30, BOMB = 25, BIO = 0, FIRE = 100, ACID = 100)
	max_temperature = 25000
	force = 30
	mech_type = EXOSUIT_MODULE_COMBAT|EXOSUIT_MODULE_WORKING
	max_equip_by_category = list(
		MECHA_UTILITY = 1,
		MECHA_POWER = 1,
		MECHA_ARMOR = 0,
	)
	step_energy_drain = 10

	facing_modifiers = list(VEHICLE_FRONT_ARMOUR = 0.75, VEHICLE_SIDE_ARMOUR = 1, VEHICLE_BACK_ARMOUR = 1.25)

	list/operation_req_access = list()
	list/internals_req_access = list()

	enter_delay = 30
	exit_delay = 30

/obj/vehicle/sealed/mecha
	/// How resistant the hull is to projectile penetration
	var/cockpit_armor = COCKPIT_TOUGHENED
