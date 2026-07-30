/obj/vehicle/sealed/mecha/ntf/prebuilt/ivan
	name = "Ivan"
	desc = "An ageing multi-purpose exosuit, the Ivan has been largely superseded by newer models, however \
	it remains a sight among poorly-funded combat units. Originally designed for materials handling, \
	the Mk-II features steel inserts over the original aluminium shell to adequately protect against some ballistic threats. \
	A jump seat behind the pilot allows it to carry a passenger."

/obj/vehicle/sealed/mecha/ntf/prebuilt/ivan/Initialize(mapload)
	if(!arms)
		arms = new /obj/item/mecha_parts/mecha_pieces/mecha_arms/loader(src)
	if(!legs)
		legs = new /obj/item/mecha_parts/mecha_pieces/mecha_legs/loader(src)
	if(!head)
		head = new /obj/item/mecha_parts/mecha_pieces/mecha_head/loader(src)
	if(!body)
		body = new /obj/item/mecha_parts/mecha_pieces/mecha_body/loader(src)
	.=..()
