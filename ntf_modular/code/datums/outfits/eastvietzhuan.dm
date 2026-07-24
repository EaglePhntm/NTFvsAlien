/datum/outfit/job/eastvietzhuan/villager
	name = "East Vietzhuan Villager"
	jobtype = /datum/job/civindep/eastvietzhuan/villager

	w_uniform = /obj/item/clothing/under/color/grey
	shoes = /obj/item/clothing/shoes/sandal
	back = /obj/item/storage/backpack/satchel/norm
	ears = /obj/item/radio/headset/survivor
	belt = /obj/item/storage/belt/utility/full
	head = /obj/item/clothing/head/strawhat
	l_pocket = /obj/item/flashlight

	backpack_contents = list(
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

/datum/outfit/job/eastvietzhuan/archaelogist
	name = "East Vietzhuan Archaelogist"
	jobtype = /datum/job/civindep/eastvietzhuan/archaelogist

	w_uniform = /obj/item/clothing/under/syndicate/tacticool
	wear_suit = /obj/item/clothing/suit/storage/labcoat/researcher
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel/norm
	ears = /obj/item/radio/headset/survivor
	l_hand = /obj/item/storage/firstaid/adv
	l_pocket = /obj/item/storage/pouch/surgery
	r_pocket = /obj/item/flashlight/combat

	backpack_contents = list(
		/obj/item/tool/crowbar = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

/datum/outfit/job/eastvietzhuan/archaelogist/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(prob(50))
		H.equip_to_slot_or_del(new /obj/item/deployable_vehicle/tiny, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/unmanned_vehicle_remote, SLOT_IN_BACKPACK)
	else
		H.equip_to_slot_or_del(new /obj/item/attachable/buildasentry, SLOT_IN_BACKPACK)


/datum/outfit/job/eastvietzhuan/doctor
	name = "East Vietzhuan Clinician"
	jobtype = /datum/job/civindep/eastvietzhuan/doctor

	w_uniform = /obj/item/clothing/under/rank/medical/purple
	wear_suit = /obj/item/clothing/suit/storage/labcoat
	shoes = /obj/item/clothing/shoes/sandal
	back = /obj/item/storage/backpack/satchel/med
	gloves = /obj/item/clothing/gloves/latex
	r_pocket = /obj/item/storage/pouch/surgery
	belt = /obj/item/storage/belt/rig
	mask = /obj/item/clothing/mask/surgical
	ears = /obj/item/radio/headset/survivor

	backpack_contents = list(
		/obj/item/flashlight = 1,
		/obj/item/tool/crowbar = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

	belt_contents = list(
		/obj/item/roller = 1,
		/obj/item/defibrillator = 1,
		/obj/item/healthanalyzer = 1,
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack = 2,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack = 2,
		/obj/item/stack/medical/splint = 2,
		/obj/item/storage/pill_bottle/packet/bicaridine = 1,
		/obj/item/storage/pill_bottle/packet/kelotane = 1,
		/obj/item/storage/pill_bottle/packet/tramadol = 1,
		/obj/item/storage/pill_bottle/packet/tricordrazine = 1,
		/obj/item/storage/pill_bottle/packet/dylovene = 1,
		/obj/item/storage/pill_bottle/packet/isotonic = 1,
		/obj/item/storage/pill_bottle/inaprovaline = 1,
	)

	r_pocket_contents = list(
		/obj/item/tweezers = 1,
	)

/datum/outfit/job/eastvietzhuan/liaison
	name = "East Vietzhuan Liaison"
	jobtype = /datum/job/civindep/eastvietzhuan/liaison

	w_uniform = /obj/item/clothing/under/liaison_suit/outing
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel/norm
	ears = /obj/item/radio/headset/survivor
	l_hand = /obj/item/flashlight/combat
	l_pocket = /obj/item/tool/crowbar

	backpack_contents = list(
		/obj/item/tool/pen = 1,
		/obj/item/folder/red = 1,
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
		/obj/item/paper = 5,
	)

/datum/outfit/job/eastvietzhuan/security
	name = "East Vietzhuan Guard"
	jobtype = /datum/job/civindep/eastvietzhuan/security

	w_uniform = /obj/item/clothing/under/rank/security/navyblue
	wear_suit = /obj/item/clothing/suit/armor/vest
	head = /obj/item/clothing/head/securitycap
	shoes = /obj/item/clothing/shoes/marine/full
	back = /obj/item/storage/backpack/satchel/sec
	belt = /obj/item/storage/belt/security/tactical
	gloves = /obj/item/clothing/gloves/black
	ears = /obj/item/radio/headset/survivor

	r_hand = /obj/item/weapon/gun/pistol/apsmart_pistol

	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/tricordrazine = 1,
		/obj/item/tool/crowbar = 1,
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

	belt_contents = list(
		/obj/item/ammo_magazine/pistol/standard_pistol/apsmart_pistol = 3,
		/obj/item/flashlight/combat = 1,
		/obj/item/weapon/telebaton = 1,
		/obj/item/restraints/handcuffs = 1,
	)

/datum/outfit/job/eastvietzhuan/civilian
	name = "East Vietzhuan Civilian"
	jobtype = /datum/job/civindep/eastvietzhuan/civilian

	w_uniform = /obj/item/clothing/under/colonist
	shoes = /obj/item/clothing/shoes/sandal
	back = /obj/item/storage/backpack/satchel/norm
	ears = /obj/item/radio/headset/survivor
	head = /obj/item/clothing/head/strawhat

	backpack_contents = list(
		/obj/item/tool/crowbar = 1,
		/obj/item/flashlight = 1,
		/obj/item/weapon/combat_knife/upp = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)


/datum/outfit/job/eastvietzhuan/chef
	name = "East Vietzhuan Chef"
	jobtype = /datum/job/civindep/eastvietzhuan/chef

	w_uniform = /obj/item/clothing/under/rank/chef
	wear_suit = /obj/item/clothing/suit/storage/chef
	shoes = /obj/item/clothing/shoes/sandal
	back = /obj/item/storage/backpack
	ears = /obj/item/radio/headset/survivor
	head = /obj/item/clothing/head/strawhat

	backpack_contents = list(
		/obj/item/flashlight = 1,
		/obj/item/tool/kitchen/knife/butcher = 1,
		/obj/item/reagent_containers/food/snacks/upp/rice = 1,
		/obj/item/reagent_containers/food/snacks/soup/boiledrice = 1,
		/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
		/obj/item/reagent_containers/food/snacks/soup/tomatosoup = 1,
		/obj/item/reagent_containers/food/snacks/meatsteak = 1,
		/obj/item/reagent_containers/food/snacks/meat/xeno = 1,
		/obj/item/reagent_containers/food/snacks/pastries/xemeatpie = 1,
		/obj/item/reagent_containers/food/snacks/egg = 1,
		/obj/item/tool/crowbar = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)


/datum/outfit/job/eastvietzhuan/botanist
	name = "East Vietzhuan Botanist"
	jobtype = /datum/job/civindep/eastvietzhuan/botanist

	w_uniform = /obj/item/clothing/under/colonist
	wear_suit = /obj/item/clothing/suit/storage/apron/overalls
	shoes = /obj/item/clothing/shoes/sandal
	back = /obj/item/storage/backpack/hydroponics
	ears = /obj/item/radio/headset/survivor
	head = /obj/item/clothing/head/strawhat
	l_pocket = /obj/item/flashlight
	r_pocket = /obj/item/tool/crowbar

	backpack_contents = list(
		/obj/item/seeds/riceseed = 4,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

/datum/outfit/job/eastvietzhuan/technician
	name = "East Vietzhuan Technician"
	jobtype = /datum/job/civindep/eastvietzhuan/technician

	w_uniform = /obj/item/clothing/under/colonist
	wear_suit = /obj/item/clothing/suit/storage/hazardvest
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel/som
	gloves = /obj/item/clothing/gloves/insulated
	head = /obj/item/clothing/head/hardhat/white
	glasses = /obj/item/clothing/glasses/welding
	r_pocket = /obj/item/storage/pouch/electronics/full
	l_pocket = /obj/item/storage/pouch/construction
	ears = /obj/item/radio/headset/survivor

	r_hand = /obj/item/storage/toolbox/mechanical

	backpack_contents = list(
		/obj/item/lightreplacer = 1,
		/obj/item/deployable_floodlight = 1,
		/obj/item/explosive/grenade/chem_grenade/metalfoam = 2,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

	l_pocket_contents = list(
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/stack/sheet/plasteel/small_stack = 1,
	)


/datum/outfit/job/eastvietzhuan/monk
	name = "East Vietzhuan Monk"
	jobtype = /datum/job/civindep/eastvietzhuan/monk

	w_uniform = /obj/item/clothing/under/marine/pantsred
	wear_suit = /obj/item/clothing/suit/pirate
	shoes = /obj/item/clothing/shoes/sandal
	back = /obj/item/storage/backpack/satchel/norm
	ears = /obj/item/radio/headset/survivor

	backpack_contents = list(
		/obj/item/storage/fancy/candle_box = 1,
		/obj/item/tool/candle = 3,
		/obj/item/tool/lighter = 1,
		/obj/item/tool/crowbar = 1,
	)

/datum/outfit/job/eastvietzhuan/miner
	name = "East Vietzhuan Miner"
	jobtype = /datum/job/civindep/eastvietzhuan/miner

	w_uniform = /obj/item/clothing/under/rank/miner
	head = /obj/item/clothing/head/hardhat/orange
	shoes = /obj/item/clothing/shoes/marine/clf
	gloves = /obj/item/clothing/gloves/ruggedgloves
	back = /obj/item/storage/backpack/satchel/som
	l_hand = /obj/item/tool/pickaxe
	r_pocket = /obj/item/reagent_containers/cup/glass/flask
	wear_suit = /obj/item/clothing/suit/storage/hazardvest
	ears = /obj/item/radio/headset/survivor

	backpack_contents = list(
		/obj/item/storage/fancy/cigarettes = 1,
		/obj/item/tool/lighter = 1,
		/obj/item/reagent_containers/food/drinks/bottle/whiskey = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)


/datum/outfit/job/eastvietzhuan/merchant
	name = "East Vietzhuan Merchant"
	jobtype = /datum/job/civindep/eastvietzhuan/merchant

	w_uniform = /obj/item/clothing/under/gentlesuit
	wear_suit = /obj/item/clothing/suit/modular/style/duster
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel
	mask = /obj/item/clothing/mask/cigarette/pipe/bonepipe
	glasses = /obj/item/clothing/glasses/sunglasses/aviator
	ears = /obj/item/radio/headset/survivor

	backpack_contents = list(
		/obj/item/weapon/gun/pistol/holdout = 1,
		/obj/item/ammo_magazine/pistol/holdout = 2,
		/obj/item/card/credstick = 1,
		/obj/item/tool/lighter/zippo = 1,
		/obj/item/tool/crowbar = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)


/datum/outfit/job/eastvietzhuan/watchman
	name = "East Vietzhuan Watchman"
	jobtype = /datum/job/civindep/eastvietzhuan/watchman

	w_uniform = /obj/item/clothing/under/icc/som
	wear_suit = /obj/item/clothing/suit/storage/marine/som
	shoes = /obj/item/clothing/shoes/sandal
	back = /obj/item/storage/backpack/satchel/sec
	belt = /obj/item/storage/belt/sparepouch
	gloves = /obj/item/clothing/gloves/ruggedgloves
	l_pocket = /obj/item/flashlight/combat
	ears = /obj/item/radio/headset/survivor
	head = /obj/item/clothing/head/strawhat

/datum/outfit/job/eastvietzhuan/watchman/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(prob(20))
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/som_carbine, SLOT_S_STORE)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/carbine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/upp/rice, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/restraints/handcuffs, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/drinks/cans/waterbottle, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_SUIT)
	if(prob(20))
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mpi_km, SLOT_S_STORE)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/plum, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/plum, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/plum, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/plum, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/upp/rice, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/restraints/handcuffs, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/drinks/cans/waterbottle, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_SUIT)
	if(prob(20))
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mpar/export, SLOT_S_STORE)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpar, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpar, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpar, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpar, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/upp/rice, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/restraints/handcuffs, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/drinks/cans/waterbottle, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_SUIT)
	if(prob(20))
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/skorpion, SLOT_S_STORE)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/skorpion, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/skorpion, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/skorpion, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/skorpion, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/skorpion, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/upp/rice, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/restraints/handcuffs, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/drinks/cans/waterbottle, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_SUIT)
	else
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/pump/trenchgun, SLOT_S_STORE)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/buckshot, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/upp/rice, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/restraints/handcuffs, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/drinks/cans/waterbottle, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/binoculars, SLOT_IN_SUIT)

/datum/outfit/job/eastvietzhuan/bartender
	name = "East Vietzhuan Bartender"
	jobtype = /datum/job/civindep/eastvietzhuan/bartender

	w_uniform = /obj/item/clothing/under/rank/bartender
	back = /obj/item/storage/backpack/satchel
	shoes = /obj/item/clothing/shoes/marine/clf
	head = /obj/item/clothing/head/strawhat
	ears = /obj/item/radio/headset/survivor
	glasses = /obj/item/clothing/glasses/sunglasses
	l_pocket = /obj/item/flashlight
	r_pocket = /obj/item/tool/crowbar

	backpack_contents = list(
		/obj/item/reagent_containers/food/drinks/bottle/whiskey = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vodka = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
		/obj/item/weapon/gun/pistol/highpower = 1,
	)

/datum/outfit/job/eastvietzhuan/drugdealer
	name = "East Vietzhuan Drug Dealer"
	jobtype = /datum/job/civindep/eastvietzhuan/drugdealer

	w_uniform = /obj/item/clothing/under/color/black
	wear_suit = /obj/item/clothing/suit/modular/style/leather_jacket
	back = /obj/item/storage/backpack/satchel
	gloves = /obj/item/clothing/gloves/latex
	shoes = /obj/item/clothing/shoes/marine/clf
	ears = /obj/item/radio/headset/survivor
	glasses = /obj/item/clothing/glasses/sunglasses
	l_pocket = /obj/item/flashlight
	r_pocket = /obj/item/tool/crowbar
	suit_store = /obj/item/healthanalyzer

	backpack_contents = list(
		/obj/item/reagent_containers/dropper = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/spacedrugs = 1,
		/obj/item/reagent_containers/syringe/drugs = 1,
		/obj/item/storage/pill_bottle/zoom = 1,
		/obj/item/storage/pill_bottle/happy = 1,
	)

/datum/outfit/job/eastvietzhuan/drugdealer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(prob(50))
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/synaptizine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/synaptizine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/rt3, SLOT_R_HAND)
		H.equip_to_slot_or_del(new /obj/item/clothing/underwear/shirt/tank_top, SLOT_SHIRT)
	else
		H.equip_to_slot_or_del(new /obj/item/card/credstick, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/highpower, SLOT_R_HAND)
		H.equip_to_slot_or_del(new /obj/item/clothing/underwear/shirt/tank_top, SLOT_SHIRT)

/datum/outfit/job/eastvietzhuan/profiteer
	name = "East Vietzhuan Profiteer"
	jobtype = /datum/job/civindep/eastvietzhuan/profiteer

	w_uniform = /obj/item/clothing/under/rank/vice
	wear_suit = /obj/item/clothing/suit/modular/style/leather_jacket
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel
	ears = /obj/item/radio/headset/survivor
	glasses = /obj/item/clothing/glasses/sunglasses
	l_pocket = /obj/item/reagent_containers/syringe/drugs
	r_pocket = /obj/item/flashlight/combat
	head = /obj/item/clothing/head/modular/style/cap

	backpack_contents = list(
		/obj/item/stack/cable_coil = 2,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

/datum/outfit/job/eastvietzhuan/profiteer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(prob(50))
		H.equip_to_slot_or_del(new /obj/item/stack/sheet/mineral/gold, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/sheet/mineral/diamond, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/minib, SLOT_R_HAND)
	else
		H.equip_to_slot_or_del(new /obj/item/card/credstick, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/spacecash/c500, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/highpower, SLOT_R_HAND)

/datum/outfit/job/eastvietzhuan/guitarist
	name = "East Vietzhuan Guitarist"
	jobtype = /datum/job/civindep/eastvietzhuan/guitarist

	w_uniform = /obj/item/clothing/under/rank/bartender
	wear_suit = /obj/item/clothing/suit/modular/style/leather_jacket
	shoes = /obj/item/clothing/shoes/sandal
	back = /obj/item/storage/backpack/satchel
	ears = /obj/item/radio/headset/survivor
	glasses = /obj/item/clothing/glasses/sunglasses
	r_pocket = /obj/item/flashlight/combat

	r_hand = /obj/item/instrument/guitar

	backpack_contents = list(
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/stack/sheet/plasteel/small_stack = 1,
		/obj/item/spacecash/c50 = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

/datum/outfit/job/eastvietzhuan/vietzhong
	name = "East Vietzhuo Vietzhong"
	jobtype = /datum/job/civindep/eastvietzhuan/vietzhong
	w_uniform = /obj/item/clothing/under/marine/pantsblack
	wear_suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/marine/som/knife
	back = /obj/item/storage/holster/blade/katana/full
	gloves = /obj/item/clothing/gloves/ruggedgloves
	l_pocket = /obj/item/storage/pouch/medical_injectors/firstaid
	r_pocket = /obj/item/flashlight/combat
	head = /obj/item/clothing/head/headband/red
	ears = /obj/item/radio/headset/survivor
	backpack_contents = list()
