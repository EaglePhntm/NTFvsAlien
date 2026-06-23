/obj/vehicle/sealed/mecha/ntf/clarke
	desc = "A converted electric excavator, designed for swift handling of materials and delicate items in any condition. \
	Features a NBC-proofed chassis and cockpit, designed to operate safely in hazardous environments. Can carry up to two occupants."
	name = "\improper APLU MK-I \"Clarke\""
	icon_state = "clarke"
	base_icon_state = "clarke"
	silicon_icon_state = "clarke-empty"
	move_delay = 2.5
	max_integrity = 300
	lights_power = 10
	soft_armor = list(MELEE = 35, BULLET = 10, LASER = 20, ENERGY = 20, BOMB = 40, BIO = 0, FIRE = 95, ACID = 100)
	max_equip_by_category = list(
		MECHA_UTILITY = 3,
		MECHA_POWER = 1,
		MECHA_ARMOR = 0,
	)
	wreckage = /obj/structure/mecha_wreckage/clarke
	possible_int_damage = MECHA_INT_FIRE|MECHA_INT_CONTROL_LOST|MECHA_INT_SHORT_CIRCUIT
	mecha_flags = ADDING_ACCESS_POSSIBLE | IS_ENCLOSED | HAS_HEADLIGHTS
	enter_delay = EGRESS_TIME_QUICK
	exit_delay = EGRESS_TIME_QUICK
	max_occupants = 2
	pivot_step = TRUE
	step_energy_drain = POWER_USAGE_EFFICIENT
	/// Custom Clarke step and turning sounds (from NTC)
	stepsound = 'ntf_modular/sound/effects/engine.ogg'
	turnsound = 'sound/mecha/powerloader_turn2.ogg'
	cockpit_armor = COCKPIT_TOUGHENED
