/obj/vehicle/sealed/mecha/ntf/durand
	desc = "A rugged design that's seen wide proliferation since the dissolution of the Nanotrasen corporation. \
	Commonly seen among mercenaries, security companies and PMCs, the Durand is easily recognized by it's \
	iconic stainless steel outer shell and high-hardness steel inner shell."
	name = "\improper Durand"
	icon_state = "durand"
	base_icon_state = "durand"
	allow_diagonal_movement = FALSE
	move_delay = 4
	max_integrity = 400
	soft_armor = list(MELEE = 60, BULLET = 45, LASER = 30, ENERGY = 30, BOMB = 25, BIO = 0, FIRE = 65, ACID = 100)
	max_temperature = 25000
	force = 30
	wreckage = /obj/structure/mecha_wreckage/durand
	step_energy_drain = 10
	cockpit_armor = COCKPIT_TOUGHENED
