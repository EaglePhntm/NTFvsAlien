/obj/vehicle/sealed/mecha/ntf/honker
	desc = "A civilian exosuit, used for mass entertainment in parades and in theatres. \
	Designed to be indoors-safe, it features soft surfaces and torque-sensitive actuators. The effectors appear to have been modified.."
	name = "\improper Honker"
	icon_state = "honker"
	base_icon_state = "honker"
	allow_diagonal_movement = FALSE
	pivot_step = TRUE
	move_delay = 2
	max_integrity = 150
	soft_armor = list(MELEE = 25, BULLET = 5, LASER = 10, ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 25, ACID = 25)
	force = 10
	wreckage = /obj/structure/mecha_wreckage/honker
	step_energy_drain = POWER_USAGE_EFFICIENT
	cockpit_armor = COCKPIT_LIGHT
	stepsound = 'sound/items/bikehorn.ogg'
	turnsound = 'sound/items/bikehorn.ogg'
	enter_delay = EGRESS_TIME_QUICK
	exit_delay = EGRESS_TIME_QUICK
	exit_confusion = 0 SECONDS
