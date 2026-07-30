/obj/vehicle/sealed/mecha/ntf/prebuilt/durand
	name = "Durand"
	desc = "A rugged design that's seen wide proliferation since the dissolution of the Nanotrasen corporation. \
	Commonly seen among mercenaries, security companies and PMCs, the Durand is easily recognized by it's \
	iconic stainless steel outer shell and high-hardness steel inner shell. \
	A jump seat behind the pilot allows it to carry a passenger."

/obj/vehicle/sealed/mecha/ntf/prebuilt/durand/Initialize(mapload)
	if(!arms)
		arms = new /obj/item/mecha_parts/mecha_pieces/mecha_arms/loader(src)
	if(!legs)
		legs = new /obj/item/mecha_parts/mecha_pieces/mecha_legs/loader(src)
	if(!head)
		head = new /obj/item/mecha_parts/mecha_pieces/mecha_head/heavy(src)
	if(!body)
		body = new /obj/item/mecha_parts/mecha_pieces/mecha_body/combat(src)
	.=..()
