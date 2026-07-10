//These values are taken from TG... ish
//TG cannot buy iron sheets, but can sell them. TGMC cannot sell iron sheets, but can buy them?
//In TG a single sheet of iron sells for 5 credits, in TGMC you can buy a single sheet of iron for 4 req. Therefore, if we can sell the same thing for half the buying price, a sheet of iron should be sold for 2 req? And an ore for half that, at 1 req.
//Given that an iron sheet can be sold for 2 req, or 5 credits, a credit is worth approximetly 0.4 req points.
//Below is a list of all materials using TG credit export values, converted into req points using the 0.4 formula above
//Platinum doesn't exist in TG so pulling this number out of my ass. Considering that plat sells for 4 times as much as phoron... yeah this thing is fucked up?

GLOBAL_LIST_INIT(materials_to_reqpoints, list(

))

//Worth half the actual material value above
GLOBAL_LIST_INIT(ores_to_reqpoints, list(
	/obj/item/ore/iron = 1,
	/obj/item/ore/coal = 1,
	/obj/item/ore/glass = 0.8,
	/obj/item/ore/phoron = 40,
	/obj/item/ore/silver = 10,
	/obj/item/ore/gold = 25,
	/obj/item/ore/diamond = 100,
	/obj/item/ore/osmium = 160,
	/obj/item/ore/uranium = 20


))
