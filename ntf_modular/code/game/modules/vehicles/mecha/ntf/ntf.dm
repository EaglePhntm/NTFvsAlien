/obj/vehicle/sealed/mecha/ntf
	desc = "NTF Exosuit"
	allow_diagonal_movement = FALSE
	move_delay = 3
	max_integrity = 400
	soft_armor = list(MELEE = 60, BULLET = 40, LASER = 30, ENERGY = 30, BOMB = 25, BIO = 0, FIRE = 50, ACID = 100)
	max_temperature = 25000
	force = 30
	mech_type = EXOSUIT_MODULE_NTF|EXOSUIT_MODULE_COMBAT
	max_equip_by_category = list(
		MECHA_UTILITY = 1,
		MECHA_POWER = 1,
		MECHA_ARMOR = 0,
	)
	step_energy_drain = 10

	facing_modifiers = list(VEHICLE_FRONT_ARMOUR = 0.75, VEHICLE_SIDE_ARMOUR = 1, VEHICLE_BACK_ARMOUR = 1.25)

	list/operation_req_access = list()
	list/internals_req_access = list()

	can_dna_lock = FALSE

	enter_delay = 25
	exit_delay = 25
/// How resistant the hull is to projectile penetration
	var/cockpit_armor = COCKPIT_TOUGHENED

/obj/vehicle/sealed/mecha/ntf/fire_act(burn_level)
	if(burn_level > 25)
		take_damage(burn_level, FIRE)

/obj/vehicle/sealed/mecha
	///Whether or not adding a DNA is possible
	var/can_dna_lock = TRUE
