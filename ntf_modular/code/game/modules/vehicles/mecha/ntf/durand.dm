/obj/vehicle/sealed/mecha/ntf/durand
	desc = "A rugged design that's seen wide proliferation since the dissolution of the Nanotrasen corporation. \
	Commonly seen among mercenaries, security companies and PMCs, the Durand is easily recognized by it's \
	iconic stainless steel outer shell and high-hardness steel inner shell. \
	A jump seat behind the pilot allows it to carry a passenger."
	name = "\improper Durand"
	icon_state = "durand"
	base_icon_state = "durand"
	allow_diagonal_movement = FALSE
	move_delay = 3.7
	max_integrity = 400
	soft_armor = list(MELEE = 50, BULLET = 45, LASER = 30, ENERGY = 30, BOMB = 25, BIO = 0, FIRE = 75, ACID = 50)
	max_equip_by_category = list(
		MECHA_UTILITY = 1,
		MECHA_POWER = 1,
		MECHA_ARMOR = 0,
	)
	max_temperature = 25000
	force = 30
	max_occupants = 2
	wreckage = /obj/structure/mecha_wreckage/durand
	cockpit_armor = COCKPIT_TOUGHENED
