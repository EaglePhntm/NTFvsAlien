#define DRIVER "driver"
#define PASSENGER "passenger"

/obj/item/mecha_parts/mecha_pieces/mecha_body
	name = "body"
	icon_state = "body"
	base_icon_state

	var/components_held = list()
	var/occupants_allowed = list(DRIVER = 1, PASSENGER = 1)
	var/cockpit_armor = COCKPIT_ARMORED
	var/enter_delay = EGRESS_TIME_SLOW
	var/exit_delay = EGRESS_TIME_SLOW

	var/pilot_coverage = 100
	var/show_pilot_body = FALSE
	repair_materials = list()

	layer = MECH_BASE_LAYER

	max_integrity = 500

/obj/item/mecha_parts/mecha_pieces/mecha_body/obj_break()
	pilot_coverage -= 70
	return ..()

///obj/item/mecha_parts/mecha_pieces/mecha_body/Destroy()

/obj/item/mecha_parts/mecha_pieces/mecha_body/phazon
	name = "phazon body"
	desc = "The body component for a Phazon exosuit. Sleek, lightweight, whilst retaining respectable armor of a patented composite."
	icon_state = "light_body"
	base_icon_state = "light_body"
	max_integrity = 200
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 30, BOMB = 10, BIO = 0, FIRE = 95, ACID = 50)

/obj/item/mecha_parts/mecha_pieces/mecha_body/clarke
	name = "clarke body"
	desc = "The body component for a Clarke exosuit."
	icon_state = "pod_body"
	base_icon_state = "pod_body"
	extra_overlays = TRUE
	max_integrity = 200
	soft_armor = list(MELEE = 40, BULLET = 5, LASER = 15, ENERGY = 0, BOMB = 5, BIO = 0, FIRE = 100, ACID = 95)

/obj/item/mecha_parts/mecha_pieces/mecha_body/durand
	name = "durand body"
	desc = "The body component for a Durand exosuit."
	icon_state = "combat_body"
	base_icon_state = "combat_body"
	max_integrity = 300
	soft_armor = list(MELEE = 50, BULLET = 40, LASER = 40, ENERGY = 15, BOMB = 10, BIO = 0, FIRE = 50, ACID = 50)

/obj/item/mecha_parts/mecha_pieces/mecha_body/marauder
	name = "marauder body"
	desc = "The body component for a Marauder exosuit."
	icon_state = "heavy_body"
	base_icon_state = "heavy_body"
	max_integrity = 500
	soft_armor = list(MELEE = 65, BULLET = 55, LASER = 40, ENERGY = 15, BOMB = 20, BIO = 0, FIRE = 50, ACID = 50)

/obj/item/mecha_parts/mecha_pieces/mecha_body/cubical
	name = "cubical body"
	desc = "A unbranded cubical body for an exosuit."
	icon_state = "cubical_body"
	base_icon_state = "cubical_body"
	max_integrity = 600
	soft_armor = list(MELEE = 70, BULLET = 60, LASER = 50, ENERGY = 15, BOMB = 20, BIO = 0, FIRE = 75, ACID = 75)
