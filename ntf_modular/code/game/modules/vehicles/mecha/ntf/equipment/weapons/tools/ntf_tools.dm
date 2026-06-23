// Most of these modules are the same as, or a adjusted variant of greyscale modules

/obj/item/mecha_parts/mecha_equipment/ability/zoom
	name = "enhanced zoom"
	desc = "A magnifying module that allows the pilot to see much further than with the standard optics. Night vision not included."
	icon_state = "zoom"
	mech_flags = EXOSUIT_MODULE_NTF|EXOSUIT_MODULE_COMBAT
	ability_to_grant = /datum/action/vehicle/sealed/mecha/mech_zoom

/obj/item/mecha_parts/mecha_equipment/ability/zoom/try_attach_part(obj/vehicle/sealed/mecha/M, attach_right)
	.=..()
	if(istype(M, /obj/vehicle/sealed/mecha/ntf/marauder))
//		to_chat(user, span_warning("You are unable to attach [src] to [M]!"))
		return

/obj/item/mecha_parts/mecha_equipment/ability/cloak
	name = "cloak module"
	desc = "A mech stealth cloaking device. Cannot fire while cloaked, and cloaking drains energy."
	weight = 0
	icon_state = "cloak"
	mech_flags = EXOSUIT_MODULE_GREYSCALE|EXOSUIT_MODULE_VENDABLE
	ability_to_grant = /datum/action/vehicle/sealed/mecha/cloak

