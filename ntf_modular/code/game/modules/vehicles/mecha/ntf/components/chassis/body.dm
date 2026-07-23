/obj/item/mecha_parts/mecha_pieces/mecha_body
	name = "body"
	icon_state = "body"
	base_icon_state

	var/components_held = list()
	var/occupants_allowed = list(DRIVER = 1, PASSENGER = 1)
	var/cockpit_armor = COCKPIT_ARMORED
	var/enter_delay = EGRESS_TIME_SLOW
	var/exit_delay = EGRESS_TIME_SLOW

	var/compatible_pieces = list(MECHA_BODY, MECHA_HEAD, MECHA_LEGS, MECHA_ARMS)
	var/wrecked_profile = /datum/wrecked_body/light

	var/pilot_coverage = 100
	var/show_pilot_body = FALSE

	repair_materials = list()

	type_of_piece = MECHA_BODY

	layer = MECH_BASE_LAYER

	max_integrity = 500
	var/wreck_health = 1000
/*
/obj/item/mecha_parts/mecha_pieces/mecha_body/obj_break()
	pilot_coverage -= 70
	return ..()
*/

///obj/item/mecha_parts/mecha_pieces/mecha_body/Destroy()

/obj/item/mecha_parts/mecha_pieces/mecha_body/light
	name = "light body"
	desc = "The body component for a lightphazon exosuit. Sleek, lightweight, whilst retaining respectable armor of a patented composite."
	icon_state = "light_body"
	base_icon_state = "light_body"
	repair_materials = list(STEEL = PRIMARY_REPAIR_AMT, GLASS = TERTIARY_REPAIR_AMT)
	max_integrity = 200
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 30, BOMB = 10, BIO = 0, FIRE = 95, ACID = 50)
	wrecked_profile = /datum/wrecked_body/light

/obj/item/mecha_parts/mecha_pieces/mecha_body/spherical
	name = "spherical body"
	desc = "The body component for a spherical exosuit."
	icon_state = "pod_body"
	base_icon_state = "pod_body"
	repair_materials = list(STEEL = PRIMARY_REPAIR_AMT, GLASS = TERTIARY_REPAIR_AMT)
	extra_overlays = TRUE
	max_integrity = 200
	soft_armor = list(MELEE = 40, BULLET = 5, LASER = 15, ENERGY = 0, BOMB = 5, BIO = 0, FIRE = 100, ACID = 95)
	wrecked_profile = /datum/wrecked_body/light

/obj/item/mecha_parts/mecha_pieces/mecha_body/combat
	name = "combat body"
	desc = "The body component for a combat exosuit."
	icon_state = "combat_body"
	base_icon_state = "combat_body"
	repair_materials = list(PLASTEEL = SECONDARY_REPAIR_AMT, STEEL = PRIMARY_REPAIR_AMT)
	max_integrity = 300
	soft_armor = list(MELEE = 50, BULLET = 40, LASER = 40, ENERGY = 15, BOMB = 10, BIO = 0, FIRE = 50, ACID = 50)
	wrecked_profile = /datum/wrecked_body/medium

/obj/item/mecha_parts/mecha_pieces/mecha_body/heavy
	name = "heavy body"
	desc = "The body component for a heavy exosuit."
	icon_state = "heavy_body"
	base_icon_state = "heavy_body"
	repair_materials = list(PLASTEEL = SECONDARY_REPAIR_AMT, URANIUM = TERTIARY_REPAIR_AMT)
	max_integrity = 500
	soft_armor = list(MELEE = 65, BULLET = 55, LASER = 40, ENERGY = 15, BOMB = 20, BIO = 0, FIRE = 50, ACID = 50)
	wrecked_profile = /datum/wrecked_body/heavy

/obj/item/mecha_parts/mecha_pieces/mecha_body/cubical
	name = "cubical body"
	desc = "A unbranded cubical body for an exosuit. Has integrated sensors, but doesn't support a external package."
	icon_state = "cubical_body"
	base_icon_state = "cubical_body"
	repair_materials = list(PLASTEEL = SECONDARY_REPAIR_AMT, URANIUM = TERTIARY_REPAIR_AMT)
	max_integrity = 600
	soft_armor = list(MELEE = 70, BULLET = 60, LASER = 50, ENERGY = 15, BOMB = 20, BIO = 0, FIRE = 75, ACID = 75)
	compatible_pieces = list(MECHA_BODY, MECHA_LEGS, MECHA_ARMS) // Reason: sprite-wise, it looks bad
	sensors_profile = EXOSUIT_SENSORS_ADV
	wrecked_profile = /datum/wrecked_body/heavy
