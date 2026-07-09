#define DEPTH_TO_LAYER 30
#define MINERALS_PER_LAYER 5

/obj/structure/oredeposit
	name = "Surface Ore Deposit"
	desc = "An ore deposit, ready to be surveyed, tapped, and drilled! This one is on the surface, promising less yield and more common ores."
	icon = 'ntf_modular/icons/obj/structures/advmining.dmi'
	icon_state = "miningsite"
	var/obj/effect/landmark/miningsite/parent
	var/minimapiconstate = "miner_surface"
	var/depth = 0
	var/surveyed = FALSE
	var/value = 500
	var/miningdifficulty = 1
	var/datum/escalation/esc
	var/list/BaseMineralContentsByLayer = list(
		list(
			/obj/item/ore/iron = 30,
			/obj/item/ore/glass = 50,
			/obj/item/ore/coal = 15,
			/obj/item/ore/phoron = 10,
		), list(
			/obj/item/ore/iron = 100,
			/obj/item/ore/coal = 50,
			/obj/item/ore/phoron = 20,
			/obj/item/ore/silver = 20,
			/obj/item/ore/gold = 10,
			/obj/item/ore/uranium = 10,
			/obj/item/ore/osmium = 20
		), list(
			/obj/item/ore/coal = 50,
			/obj/item/ore/phoron = 40,
			/obj/item/ore/silver = 40,
			/obj/item/ore/gold = 30,
			/obj/item/ore/uranium = 50,
			/obj/item/ore/osmium = 40,
			/obj/item/ore/diamond = 10
		)
	)
	var/list/CurrentMineralContentsByLayer = list()
	var/yield = 1

/obj/structure/oredeposit/New(loc, parent, escp, ...)
	. = ..()
	SSescalation.activedeposits += src
	src.parent = parent
	SSminimaps.add_marker(src, MINIMAP_FLAG_ALL, image('ntf_modular/icons/UI_icons/map_blips.dmi', null, minimapiconstate))
	value = round(value * randfloat(0.5,1.5))
	miningdifficulty = miningdifficulty * randfloat(0.8,2)
	yield = yield * randfloat(0.4, 1.6)
	esc = escp
	if(depth < DEPTH_TO_LAYER)
		CurrentMineralContentsByLayer[1] = list()
	else
		CurrentMineralContentsByLayer[1] = setupMineralLayer(1)
	CurrentMineralContentsByLayer[2] = setupMineralLayer(2)
	CurrentMineralContentsByLayer[3] = setupMineralLayer(3)

/obj/structure/oredeposit/proc/setupMineralLayer(layer)
	var/list/NewLayer = list()
	var/list/keys = list()
	for(var/key in BaseMineralContentsByLayer[layer])
		keys += key
	for(var/i = 0, i < MINERALS_PER_LAYER, i++)
		var/currkey = pick(keys)
		if(!NewLayer[currkey])
			NewLayer[currkey] = BaseMineralContentsByLayer[layer][currkey]
		else
			NewLayer[currkey] += BaseMineralContentsByLayer[layer][currkey]
	return NewLayer

/obj/structure/oredeposit/proc/pickMineralForCurrLayer()
	return pickweight(CurrentMineralContentsByLayer[GetLayer()])

/obj/structure/oredeposit/proc/generateRocc(obj/item/advmining_drill/drill)
	var/list/mineralsBeingDugUp = list()
	for(var/i = 0, i < MINERALS_PER_LAYER, i++)
		var/currentMineral = pickMineralForCurrLayer()
		if(!mineralsBeingDugUp[currentMineral])
			mineralsBeingDugUp[currentMineral] = 2000 * drill.yieldmod
		else
			mineralsBeingDugUp[currentMineral] += 2000 * drill.yieldmod
	if(drill.extra_loot)
		for(var/key in drill.extra_loot)
			if(!mineralsBeingDugUp[key])
				mineralsBeingDugUp[key] = drill.extra_loot[key]
			else
				mineralsBeingDugUp[key] += drill.extra_loot[key]
	var/obj/item/mixedminerals/mm = new(get_turf(src))
	mm.oresinside = mineralsBeingDugUp


/obj/structure/oredeposit/Destroy()
	. = ..()
	SSescalation.activedeposits -= src
	SSminimaps.remove_marker(src)
	parent.activedeposit = null
	esc.end()

/obj/structure/oredeposit/proc/GetLayer()
	var/layerrrr = 1 + floor(depth / DEPTH_TO_LAYER)
	return layerrrr > 3 ? 3 : layerrrr

/obj/structure/oredeposit/proc/GetDrilled(obj/item/advmining_drill/drill)
	generateRocc(drill)
	depth += drill.progressmod


/obj/structure/oredeposit/deep
	name = "Deep Ore Deposit"
	desc = "An ore deposit, ready to be surveyed, tapped, and drilled! This one is in the caves, promising more yield and rarer ores! Just don't mind the bugs!"
	icon_state = "miningsitedeep"
	minimapiconstate = "miner_deep"
	value = 1000
	miningdifficulty = 2
	yield = 1.5
	depth = DEPTH_TO_LAYER

#undef DEPTH_TO_LAYER
#undef MINERALS_PER_LAYER
