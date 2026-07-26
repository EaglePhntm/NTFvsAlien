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
	force = 10
	wreckage = /obj/structure/mecha_wreckage/honker
	step_energy_drain = POWER_USAGE_EFFICIENT
	cockpit_armor = COCKPIT_LIGHT
	stepsound = 'sound/items/bikehorn.ogg'
	turnsound = 'sound/items/bikehorn.ogg'
	enter_delay = EGRESS_TIME_QUICK
	exit_delay = EGRESS_TIME_QUICK
