/obj/vehicle/sealed/mecha/ntf/prebuilt/seraph
	name = "Seraph"
	desc = "A combat exosuit, commonly used by law enforcement or security firms as a patrol vehicle, or as part of a rapid response team. \
	It's lightweight polymer and aluminium shell give it adequate protection from most handgun to light rifle threats. It has room for up to two \
	occupants."


/obj/vehicle/sealed/mecha/ntf/prebuilt/seraph/Initialize(mapload)
	if(!arms)
		arms = new /obj/item/mecha_parts/mecha_pieces/mecha_arms/heavy(src)
	if(!legs)
		legs = new /obj/item/mecha_parts/mecha_pieces/mecha_legs/tracks(src)
	if(!body)
		body = new /obj/item/mecha_parts/mecha_pieces/mecha_body/cubical(src)
	.=..()