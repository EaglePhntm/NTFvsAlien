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
	wreckage = /obj/structure/mecha_wreckage/clarke
	possible_int_damage = MECHA_INT_FIRE|MECHA_INT_CONTROL_LOST|MECHA_INT_SHORT_CIRCUIT
	enter_delay = 20
	exit_delay = 20
	max_occupants = 2
	pivot_step = TRUE
	/// Custom Clarke step and turning sounds (from NTC)
	stepsound = 'ntf_modular\sound\effects\engine.ogg'
	turnsound = 'sound/mecha/powerloader_turn2.ogg'
	cockpit_armor = COCKPIT_TOUGHENED
