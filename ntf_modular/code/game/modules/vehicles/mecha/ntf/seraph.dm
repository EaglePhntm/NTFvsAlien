/obj/vehicle/sealed/mecha/ntf/marauder/seraph
	desc = "An up-armored Marauder exosuit, with upgraded motors and a highly optimized armor layout, increasing its mobility compared to the Marauder model. \
	Very expensive, and thus, rarely operated. A second set of controls allows any of the two pilots to dismount without leaving the exosuit unoperated."
	name = "\improper Seraph"
	icon = 'icons/mecha/exosuits.dmi'
	icon_state = "seraph"
	base_icon_state = "seraph"
	move_delay = 3
	max_integrity = 550
	max_occupants = 2
	max_drivers = 2 // Two can pilot it at the same time
	wreckage = /obj/structure/mecha_wreckage/seraph
	step_energy_drain = POWER_USAGE_STANDARD
