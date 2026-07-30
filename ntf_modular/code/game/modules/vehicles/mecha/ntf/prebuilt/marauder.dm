/obj/vehicle/sealed/mecha/ntf/prebuilt/marauder
	name = "Marauder"
	desc = "A modernized combat exosuit developed as a replacement for the Durand exosuit, improved in almost every way - except cost."

/obj/vehicle/sealed/mecha/ntf/prebuilt/marauder/Initialize(mapload)
	if(!arms)
		arms = new /obj/item/mecha_parts/mecha_pieces/mecha_arms/heavy(src)
	if(!legs)
		legs = new /obj/item/mecha_parts/mecha_pieces/mecha_legs/tracks(src)
	if(!head)
		head = new /obj/item/mecha_parts/mecha_pieces/mecha_head/heavy(src)
	if(!body)
		body = new /obj/item/mecha_parts/mecha_pieces/mecha_body/heavy(src)
	.=..()
