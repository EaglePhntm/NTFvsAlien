#define INTEGRITY_200 400

/obj/item/mecha_parts/mecha_pieces
	icon = 'icons/mecha/mecha_pieces.dmi'
	icon_state = "body"
	base_icon_state
	var/repair_materials = list(STEEL = PRIMARY_REPAIR_AMT)
	var/is_attached = FALSE
	var/is_functional = TRUE
	var/suitable_mech = /obj/vehicle/sealed/mecha/ntf
	var/type_of_piece = MECHA_BODY

	integrity_failure = 0.5

	destroy_sound = 'sound/effects/glassbr2.ogg'

	var/sensors_profile

	var/extra_overlays = FALSE // for pod and light body

/obj/item/mecha_parts/mecha_pieces/proc/set_broken_states() // sets -broken description and icon
	if(is_functional)
		return
	if(!base_icon_state)
		base_icon_state = icon_state
	icon_state = "[base_icon_state]-broken"

/obj/item/mecha_parts/mecha_pieces/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	is_functional = FALSE
	set_broken_states()

/obj/item/mecha_parts/mecha_pieces/examine(mob/user)
	. = ..()
	if(!is_functional)
		. += span_warning("It looks broken!")
