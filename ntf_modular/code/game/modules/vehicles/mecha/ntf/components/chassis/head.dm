/obj/item/mecha_parts/mecha_pieces/mecha_head
	name = "head"
	icon_state = "loader_head"

	layer = MECH_INTERMEDIATE_LAYER

	type_of_piece = MECHA_HEAD

	var/vision_flags = 0
	var/see_invisible = 0
	var/active_sensors = 0

/obj/item/mecha_parts/mecha_pieces/mecha_head/powerloader
	name = "exosuit sensors"
	desc = "A primitive set of sensors designed to work in tandem with most MKI Eyeball platforms."
	max_integrity = 100

/obj/item/mecha_parts/mecha_pieces/mecha_head/light
	name = "light sensors"
	icon_state = "light_head"
	max_integrity = 50
	vision_flags = SEE_TURFS
//	see_invisible = SEE_INVISIBLE_NOLIGHTING
	desc = "A series of high resolution optical sensors. They can overlay several images to give the pilot a sense of location even in total darkness. "

/obj/item/mecha_parts/mecha_pieces/mecha_head/heavy
	name = "heavy sensors"
	desc = "A solitary sensor moves inside a recessed slit in the armour plates."
	icon_state = "heavy_head"
	max_integrity = 150

/obj/item/mecha_parts/mecha_pieces/mecha_head/combat
	name = "combat sensors"
	icon_state = "combat_head"
	vision_flags = SEE_MOBS
//	see_invisible = SEE_INVISIBLE_NOLIGHTING
	max_integrity = 100
