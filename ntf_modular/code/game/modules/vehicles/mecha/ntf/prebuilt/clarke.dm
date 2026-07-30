/obj/vehicle/sealed/mecha/ntf/prebuilt/clarke
	name = "Clarke"
	desc = "A converted electric excavator, designed for swift handling of materials and delicate items in any condition. \
	Features a NBC-proofed chassis and cockpit, designed to operate safely in hazardous environments. Can carry up to two occupants."

/obj/vehicle/sealed/mecha/ntf/prebuilt/clarke/Initialize(mapload)
	if(!arms)
		arms = new /obj/item/mecha_parts/mecha_pieces/mecha_arms/light(src)
	if(!legs)
		legs = new /obj/item/mecha_parts/mecha_pieces/mecha_legs/tracks(src)
	if(!body)
		body = new /obj/item/mecha_parts/mecha_pieces/mecha_body/spherical(src)
	.=..()
