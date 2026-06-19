/obj/vehicle/sealed/mecha/ntf/ivan
	desc = "An ageing multi-purpose exosuit, the Ivan has been largely superseded by newer models, however \
	it remains a sight among poorly-funded combat units. Originally designed for materials handling, \
	the Mk-II features steel inserts over the original aluminium shell to adequately protect against some ballistic threats."
	name = "\improper Ivan Mk-II"
	icon_state = "ivan"
	base_icon_state = "ivan"
	allow_diagonal_movement = FALSE
	move_delay = 4
	max_integrity = 400
	soft_armor = list(MELEE = 50, BULLET = 35, LASER = 25, ENERGY = 30, BOMB = 10, BIO = 0, FIRE = 65, ACID = 100)
	force = 30
	wreckage = /obj/structure/mecha_wreckage/ivan
	step_energy_drain = 10
	cockpit_armor = COCKPIT_REINFORCED
