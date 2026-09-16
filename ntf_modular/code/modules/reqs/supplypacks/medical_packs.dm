/datum/supply_packs/medical/healfoam
	name = "EMS-02 Healing Foam Grenade (x3)"
	notes = "Three healing foam grenades to be used by corpsmen."
	contains = list(
	/obj/item/explosive/grenade/chem_grenade/healing_foam,
	/obj/item/explosive/grenade/chem_grenade/healing_foam,
	/obj/item/explosive/grenade/chem_grenade/healing_foam,
	)
	cost = 200
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/optable_crate
	name = "Medical operation crate (x1)"
	notes = "A crate containing an operating table, two tanks of anasthetic, a surgery kit, some anasthetic injectors, and some space cleaner."
	contains = list(/obj/structure/largecrate/supply/medicine/optable)
	containertype = null
	cost = 500
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/iv_crate
	name = "IV stand crate (x3)"
	notes = "A crate containing three IV stands."
	contains = list(/obj/structure/largecrate/supply/medicine/iv)
	cost = 50
	containertype = null
	access = null

/datum/supply_packs/medical/medvend
	name = "NovaMed Plus crate (x1)"
	notes = "A crate containing one fully-stocked Novamed Plus medical vendor."
	contains = list(/obj/structure/largecrate/supply/medicine/novamed)
	containertype = null
	cost = 2500
	access = ACCESS_MARINE_MEDBAY

/obj/structure/largecrate/supply/medicine/marinemed
	name = "\improper NovaMed Plus crate (x1)"
	desc = "A crate containing one fully-stocked Novamed Plus medical vendor."
	supplies = list(/obj/machinery/vending/medical = 1)

/datum/supply_packs/medical/marinemed
	name = "MarineMed crate (x1)"
	notes = "A crate containing one fully-stocked MarineMed medical vendor."
	contains = list(/obj/machinery/vending/MarineMed)
	containertype = null
	cost = 1500
	access = ACCESS_MARINE_MEDBAY

/datum/supply_packs/medical/soldering_tool
	name = "Soldering tool"
	notes = "contains 1 soldering tool for repair robots."
	contains = list(/obj/item/tool/surgery/solderingtool)
	cost = 30
