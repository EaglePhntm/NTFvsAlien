#define DRIVER "driver"
#define PASSENGER "passenger"

/obj/item/mecha_parts/mecha_body
	icon = 'icons/mecha/mecha_parts.dm'
	icon_state = "body"
	var/base_icon_state
	var/is_attached = FALSE
	var/is_functional = TRUE

	var/components_held = list()
	var/occupants_allowed = list(DRIVER = 1, PASSENGER = 1)
	var/cockpit_armor = COCKPIT_ARMORED
	var/enter_delay = EGRESS_TIME_SLOW
	var/exit_delay = EGRESS_TIME_SLOW

	var/pilot_coverage = 100
	var/show_pilot_body = FALSE
	var/repair_materials = list()

	max_integrity = 500

/obj/item/mecha_parts/mecha_body/examine(mob/user)
	. = ..()
	if(is_broken)
		. += span_warning("It looks broken!")

/obj/item/mecha_parts/mecha_body/obj_break()
	is_functional = FALSE
	set_broken_states()
	pilot_coverage -= 70

/obj/item/mecha_parts/mecha_body/Destroy()

/obj/item/mecha_parts/mecha_body/proc/set_broken_states() // sets -broken description and icon
	if(is_broken)
		return
	is_broken = TRUE
	if(!base_icon_state)
		base_icon_state = icon_state
	icon_state = "[base_icon_state]-broken"

/obj/item/mecha_parts/mecha_body/phazon
	name = "phazon body"
	desc = "The body component for a Phazon exosuit. Sleek, lightweight, whilst retaining respectable armor of a patented composite."
	base_icon_state = "body_phazon"
	max_integrity = 200
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 30, BOMB = 10, BIO = 0, FIRE = 95, ACID = 50)