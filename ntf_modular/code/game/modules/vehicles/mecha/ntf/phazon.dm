/obj/vehicle/sealed/mecha/ntf/phazon
	desc = "A light exosuit featuring an experimental composite plating designed by the now-defunct Nanotrasen Corp. \
	Built from a modified Gygax frame, the armor is ultra-light, yet, can be electrically strengthened to deflect a broad range of \
	threats from rifle calibers to grenade blasts."
	name = "\improper Phazon"
	icon_state = "phazon"
	base_icon_state = "phazon"
	max_integrity = 200
	allow_diagonal_movement = TRUE
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 50, ENERGY = 30, BOMB = 10, BIO = 0, FIRE = 100, ACID = 100)
	force = 20
	var/armor_shielded = FALSE
	cockpit_armor = COCKPIT_ARMORED

/obj/vehicle/sealed/mecha/combat/phazon/generate_actions()
	. = ..()
//	initialize_passenger_action_type(/datum/action/vehicle/sealed/mecha/mech_toggle_phazon_armor)

/datum/action/vehicle/sealed/mecha/mech_toggle_armor
	name = "Toggle Electro-Ceramic Armor Array"
	action_icon_state = "mech_phasing_off"

/datum/action/vehicle/sealed/mecha/mech_toggle_armor/action_activate(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return
//	chassis.armor_shielded = chassis.armor_shielded ? "" : "armor_shielded"
//	action_icon_state = "mech_phasing_[chassis.armor_shielded ? "on" : "off"]"
//	chassis.balloon_alert(owner, "[chassis.armor_shielded ? "enabled" : "disabled"] armor_shielded")
	update_button_icon()
