/obj/vehicle/sealed/mecha/ntf/prebuilt/crawler
	name = "Crawler"
	desc = "A exosuit."

/obj/vehicle/sealed/mecha/ntf/prebuilt/crawler/Initialize(mapload)
	if(!legs)
		legs = new /obj/item/mecha_parts/mecha_pieces/mecha_legs/quadlegs(src)
	if(!body)
		body = new /obj/item/mecha_parts/mecha_pieces/mecha_body/crawler(src)
	.=..()
