/datum/outfit/job/civindep/assistant
	name = "Assistant Colonist"
	jobtype = /datum/job/civindep/west/assistant

	w_uniform = /obj/item/clothing/under/color/grey
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel/norm
	ears = /obj/item/radio/headset/survivor
	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/flashlight

	backpack_contents = list(
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

/datum/outfit/job/civindep/scientist
	name = "Scientist Colonist"
	jobtype = /datum/job/civindep/west/scientist

	w_uniform = /obj/item/clothing/under/rank/scientist
	wear_suit = /obj/item/clothing/suit/storage/labcoat/researcher
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/toxins
	ears = /obj/item/radio/headset/survivor
	l_hand = /obj/item/storage/firstaid/adv
	l_pocket = /obj/item/storage/pouch/surgery
	r_pocket = /obj/item/flashlight/combat

	backpack_contents = list(
		/obj/item/roller = 1,
		/obj/item/defibrillator = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/polyhexanide = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/sleeptoxin = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/tool/crowbar = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)


/datum/outfit/job/civindep/doctor
	name = "Doctor's Assistant Colonist"
	jobtype = /datum/job/civindep/west/doctor

	w_uniform = /obj/item/clothing/under/rank/medical/blue
	wear_suit = /obj/item/clothing/suit/storage/labcoat
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel/med
	gloves = /obj/item/clothing/gloves/latex
	glasses = /obj/item/clothing/glasses/hud/health
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

/datum/outfit/job/civindep/officeworker
	name = "Office Worker Colonist"
	jobtype = /datum/job/civindep/west/officeworker

	w_uniform = /obj/item/clothing/under/liaison_suit
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel/norm
	ears = /obj/item/radio/headset/survivor
	l_hand = /obj/item/flashlight/combat
	l_pocket = /obj/item/tool/crowbar
	r_pocket = /obj/item/card/credstick

/datum/outfit/job/civindep/liaison
	name = "Liaison Colonist"
	jobtype = /datum/job/civindep/west/liaison

	w_uniform = /obj/item/clothing/under/liaison_suit
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

/datum/outfit/job/civindep/security
	name = "Security Guard Colonist"
	jobtype = /datum/job/civindep/west/security

	w_uniform = /obj/item/clothing/under/rank/security
	wear_suit = /obj/item/clothing/suit/armor/patrol
	head = /obj/item/clothing/head/securitycap
	shoes = /obj/item/clothing/shoes/marine/full
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	back = /obj/item/storage/backpack/satchel/sec
	belt = /obj/item/storage/belt/security/tactical
	gloves = /obj/item/clothing/gloves/black
	ears = /obj/item/radio/headset/survivor

	r_hand = /obj/item/weapon/gun/pistol/g22

	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/autoinjector/tricordrazine = 1,
		/obj/item/tool/crowbar = 1,
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/stack/medical/heal_pack/ointment = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
		/obj/item/book/manual/marine_law = 1,
	)

	belt_contents = list(
		/obj/item/ammo_magazine/pistol/g22 = 2,
		/obj/item/flashlight/combat = 1,
		/obj/item/weapon/telebaton = 1,
		/obj/item/restraints/handcuffs = 1,
		/obj/item/flash = 1,
	)

/datum/outfit/job/civindep/civilian
	name = "Civilian Colonist"
	jobtype = /datum/job/civindep/west/civilian

	w_uniform = /obj/item/clothing/under/colonist
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel/norm
	ears = /obj/item/radio/headset/survivor

	backpack_contents = list(
		/obj/item/tool/crowbar = 1,
		/obj/item/flashlight = 1,
		/obj/item/weapon/combat_knife/upp = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)


/datum/outfit/job/civindep/chef
	name = "Chef Colonist"
	jobtype = /datum/job/civindep/west/chef

	w_uniform = /obj/item/clothing/under/rank/chef
	wear_suit = /obj/item/clothing/suit/storage/chef
	head = /obj/item/clothing/head/chefhat
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack
	ears = /obj/item/radio/headset/survivor

	backpack_contents = list(
		/obj/item/flashlight = 1,
		/obj/item/tool/kitchen/knife/butcher = 1,
		/obj/item/reagent_containers/food/snacks/burger/crazy = 1,
		/obj/item/reagent_containers/food/snacks/soup/mysterysoup = 1,
		/obj/item/reagent_containers/food/snacks/packaged_hdogs = 1,
		/obj/item/reagent_containers/food/snacks/organ = 1,
		/obj/item/reagent_containers/food/snacks/chocolateegg = 1,
		/obj/item/reagent_containers/food/snacks/meat/xeno = 1,
		/obj/item/reagent_containers/food/snacks/pastries/xemeatpie = 1,
		/obj/item/reagent_containers/food/snacks/donut/meat = 1,
		/obj/item/tool/crowbar = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)


/datum/outfit/job/civindep/botanist
	name = "Botanist Colonist"
	jobtype = /datum/job/civindep/west/botanist

	w_uniform = /obj/item/clothing/under/rank/hydroponics
	wear_suit = /obj/item/clothing/suit/storage/apron/overalls
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/hydroponics
	ears = /obj/item/radio/headset/survivor
	l_pocket = /obj/item/flashlight
	r_pocket = /obj/item/tool/crowbar

	backpack_contents = list(
		/obj/item/reagent_containers/food/snacks/grown/ambrosiavulgaris = 2,
		/obj/item/reagent_containers/food/snacks/grown/ambrosiadeus = 2,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

/datum/outfit/job/civindep/atmos
	name = "Atmospherics Technician Colonist"
	jobtype = /datum/job/civindep/west/atmos

	w_uniform = /obj/item/clothing/under/rank/atmospheric_technician
	wear_suit = /obj/item/clothing/suit/storage/hazardvest
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel/som
	gloves = /obj/item/clothing/gloves/insulated
	belt = /obj/item/storage/belt
	head = /obj/item/clothing/head/hardhat/white
	glasses = /obj/item/clothing/glasses/welding
	r_pocket = /obj/item/storage/pouch/electronics/full
	l_pocket = /obj/item/storage/pouch/construction
	ears = /obj/item/radio/headset/survivor

	backpack_contents = list(
		/obj/item/lightreplacer = 1,
		/obj/item/deployable_floodlight = 1,
		/obj/item/explosive/grenade/chem_grenade/metalfoam = 2,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

	belt_contents = list(
		/obj/item/tool/screwdriver = 1,
		/obj/item/tool/wrench = 1,
		/obj/item/tool/wirecutters = 1,
		/obj/item/tool/crowbar = 1,
		/obj/item/tool/weldingtool = 1,
		/obj/item/tool/multitool = 1,
		/obj/item/stack/cable_coil = 1,
	)

	l_pocket_contents = list(
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/stack/sheet/plasteel/small_stack = 1,
	)


/datum/outfit/job/civindep/chaplain
	name = "Chaplain Colonist"
	jobtype = /datum/job/civindep/west/chaplain

	w_uniform = /obj/item/clothing/under/rank/chaplain
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel/norm
	ears = /obj/item/radio/headset/survivor

	r_hand = /obj/item/storage/bible

	backpack_contents = list(
		/obj/item/storage/fancy/candle_box = 1,
		/obj/item/tool/candle = 3,
		/obj/item/tool/lighter = 1,
		/obj/item/storage/bible = 1,
		/obj/item/tool/crowbar = 1,
		/obj/item/reagent_containers/cup/glass/bottle/holywater = 1,
	)

/datum/outfit/job/civindep/miner
	name = "Miner Colonist"
	jobtype = /datum/job/civindep/west/miner

	w_uniform = /obj/item/clothing/under/rank/miner
	head = /obj/item/clothing/head/helmet/space/rig/mining
	glasses = /obj/item/clothing/glasses/meson
	shoes = /obj/item/clothing/shoes/marine/clf
	gloves = /obj/item/clothing/gloves/ruggedgloves
	back = /obj/item/storage/backpack/satchel/som
	l_hand = /obj/item/weapon/twohanded/sledgehammer
	r_pocket = /obj/item/reagent_containers/cup/glass/flask
	wear_suit = /obj/item/clothing/suit/space/rig/mining
	ears = /obj/item/radio/headset/survivor

	backpack_contents = list(
		/obj/item/storage/fancy/cigarettes = 1,
		/obj/item/tool/lighter = 1,
		/obj/item/reagent_containers/food/drinks/bottle/whiskey = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)


/datum/outfit/job/civindep/salesman
	name = "Salesman Colonist"
	jobtype = /datum/job/civindep/west/salesman

	w_uniform = /obj/item/clothing/under/lawyer/purpsuit
	wear_suit = /obj/item/clothing/suit/storage/lawyer/purpjacket
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel
	mask = /obj/item/clothing/mask/cigarette/pipe/bonepipe
	glasses = /obj/item/clothing/glasses/sunglasses/aviator
	ears = /obj/item/radio/headset/survivor

	backpack_contents = list(
		/obj/item/weapon/gun/pistol/holdout = 1,
		/obj/item/ammo_magazine/pistol/holdout = 3,
		/obj/item/tool/lighter/zippo = 1,
		/obj/item/tool/crowbar = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)


/datum/outfit/job/civindep/marshal
	name = "Colonial Marshal Colonist"
	jobtype = /datum/job/civindep/west/marshal

	w_uniform = /obj/item/clothing/under/CM_uniform
	shoes = /obj/item/clothing/shoes/marine/clf/full
	back = /obj/item/storage/backpack/satchel/sec
	suit_store = /obj/item/storage/holster/belt/m44/full
	belt = /obj/item/storage/belt/sparepouch
	gloves = /obj/item/clothing/gloves/ruggedgloves
	l_pocket = /obj/item/flashlight/combat
	ears = /obj/item/radio/headset/survivor
	head = /obj/item/clothing/head/slouch

	r_hand = /obj/item/weapon/gun/revolver/cmb

	belt_contents = list(
		/obj/item/restraints/handcuffs = 1,
		/obj/item/stack/medical/heal_pack/gauze = 1,
		/obj/item/tool/crowbar = 1,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

	backpack_contents = list(
		/obj/item/book/manual/marine_law = 1,
		/obj/item/ammo_magazine/revolver/cmb = 3,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

/datum/outfit/job/civindep/bartender
	name = "Bartender Colonist"
	jobtype = /datum/job/civindep/west/bartender

	w_uniform = /obj/item/clothing/under/rank/bartender
	back = /obj/item/storage/backpack/satchel
	shoes = /obj/item/clothing/shoes/marine/clf
	head = /obj/item/clothing/head/collectable/tophat
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

/datum/outfit/job/civindep/chemist
	name = "Pharmacy Technician Colonist"
	jobtype = /datum/job/civindep/west/chemist

	w_uniform = /obj/item/clothing/under/rank/chemist
	wear_suit = /obj/item/clothing/suit/storage/labcoat/chemist
	back = /obj/item/storage/backpack/satchel/chem
	belt = /obj/item/storage/belt/hypospraybelt
	gloves = /obj/item/clothing/gloves/latex
	shoes = /obj/item/clothing/shoes/marine/clf
	ears = /obj/item/radio/headset/survivor
	glasses = /obj/item/clothing/glasses/science
	l_pocket = /obj/item/flashlight
	r_pocket = /obj/item/tool/crowbar
	suit_store = /obj/item/healthanalyzer

	backpack_contents = list(
		/obj/item/reagent_containers/dropper = 1,
		/obj/item/stack/medical/heal_pack/advanced/bruise_pack = 1,
		/obj/item/stack/medical/heal_pack/advanced/burn_pack = 1,
		/obj/item/stack/medical/splint = 2,
		/obj/item/defibrillator = 1,
		/obj/item/clothing/glasses/hud/health = 1,
	)

	belt_contents = list(
		/obj/item/reagent_containers/glass/bottle/bicaridine = 1,
		/obj/item/reagent_containers/glass/bottle/kelotane = 1,
		/obj/item/reagent_containers/glass/bottle/tramadol = 1,
		/obj/item/reagent_containers/glass/bottle/tricordrazine = 1,
		/obj/item/reagent_containers/glass/bottle/lemoline/doctor = 1,
		/obj/item/reagent_containers/glass/beaker/large = 2,
		/obj/item/reagent_containers/hypospray/advanced/bicaridine = 1,
		/obj/item/reagent_containers/hypospray/advanced/kelotane = 1,
		/obj/item/reagent_containers/hypospray/advanced/tramadol = 1,
		/obj/item/reagent_containers/hypospray/advanced/tricordrazine = 1,
		/obj/item/reagent_containers/hypospray/advanced/dylovene = 1,
		/obj/item/reagent_containers/hypospray/advanced/inaprovaline = 1,
		/obj/item/reagent_containers/hypospray/advanced/hypervene = 1,
		/obj/item/reagent_containers/hypospray/advanced/imialky = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus = 1,
		/obj/item/reagent_containers/hypospray/autoinjector/quickclotplus = 1,
		/obj/item/reagent_containers/hypospray/advanced/big = 2,
		/obj/item/storage/syringe_case/empty = 2,
	)

/datum/outfit/job/civindep/roboticist
	name = "Roboticist Colonist"
	jobtype = /datum/job/civindep/west/roboticist

	w_uniform = /obj/item/clothing/under/rank/roboticist
	wear_suit = /obj/item/clothing/suit/storage/labcoat/science
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/backpack/satchel/tox
	ears = /obj/item/radio/headset/survivor
	glasses = /obj/item/clothing/glasses/welding/flipped
	l_pocket = /obj/item/storage/pouch/electronics/full
	r_pocket = /obj/item/flashlight/combat

	backpack_contents = list(
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/stack/sheet/plasteel/small_stack = 1,
		/obj/item/cell/high = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

/datum/outfit/job/civindep/roboticist/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(prob(50))
		H.equip_to_slot_or_del(new /obj/item/deployable_vehicle/tiny, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/unmanned_vehicle_remote, SLOT_IN_BACKPACK)
	else
		H.equip_to_slot_or_del(new /obj/item/attachable/buildasentry, SLOT_IN_BACKPACK)


/datum/outfit/job/civindep/rambo
	name = "Veteran Colonist"
	jobtype = /datum/job/civindep/west/rambo
	w_uniform = /obj/item/clothing/under/marine/striped
	wear_suit = /obj/item/clothing/suit/armor/patrol
	shoes = /obj/item/clothing/shoes/marine/clf
	back = /obj/item/storage/holster/blade/machete/full
	gloves = /obj/item/clothing/gloves/ruggedgloves
	l_pocket = /obj/item/storage/pouch/medical_injectors/firstaid
	r_pocket = /obj/item/flashlight/combat
	head = /obj/item/clothing/head/headband
	ears = /obj/item/radio/headset/survivor
	backpack_contents = list()

/datum/outfit/job/civindep/nationaldefense
	name = "National Defense Colonist"
	jobtype = /datum/job/civindep/west/nationaldefense
	w_uniform = /obj/item/clothing/under/marine/camo/woodland
	wear_suit = /obj/item/clothing/suit/armor/bulletproof
	shoes = /obj/item/clothing/shoes/marine/clf
	gloves = /obj/item/clothing/gloves/ruggedgloves
	l_pocket = /obj/item/storage/pouch/medkit/firstaid
	r_pocket = /obj/item/flashlight/combat
	head = /obj/item/clothing/head/modular/m10x
	ears = /obj/item/radio/headset/survivor
	backpack_contents = list()

/datum/outfit/job/civindep/nationaldefense/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(prob(20))
		H.equip_to_slot_or_del(new /obj/item/storage/belt/marine, SLOT_BELT)
		H.equip_to_slot_or_del(new /obj/item/storage/backpack/marine, SLOT_BACK)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/khm4, SLOT_S_STORE)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/bodybag/tarp, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/binoculars/tactical/range, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/drinks/flask/marine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/small_stack, SLOT_IN_BACKPACK)
	if(prob(20))
		H.equip_to_slot_or_del(new /obj/item/storage/belt/marine, SLOT_BELT)
		H.equip_to_slot_or_del(new /obj/item/storage/backpack/marine, SLOT_BACK)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m16, SLOT_S_STORE)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m16, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/bodybag/tarp, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/drinks/flask/marine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/small_stack, SLOT_IN_BACKPACK)
	if(prob(20))
		H.equip_to_slot_or_del(new /obj/item/storage/belt/marine, SLOT_BELT)
		H.equip_to_slot_or_del(new /obj/item/storage/backpack/marine, SLOT_BACK)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/mpar/mil, SLOT_S_STORE)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpar, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpar, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpar, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpar, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpar, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpar, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/bodybag/tarp, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/attachable/scope/marine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/drinks/flask/marine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/small_stack, SLOT_IN_BACKPACK)
	if(prob(20))
		H.equip_to_slot_or_del(new /obj/item/storage/belt/marine, SLOT_BELT)
		H.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/radiopack, SLOT_BACK)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m25, SLOT_S_STORE)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m25, SLOT_IN_BELT)
		H.equip_to_slot_or_del(new /obj/item/bodybag/tarp, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/tool/screwdriver, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/drinks/flask/marine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/circuitboard/apc, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/cable_coil, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/small_stack, SLOT_IN_BACKPACK)
	else
		H.equip_to_slot_or_del(new /obj/item/storage/belt/shotgun/mixed, SLOT_BELT)
		H.equip_to_slot_or_del(new /obj/item/storage/backpack/marine, SLOT_BACK)
		H.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/pump, SLOT_S_STORE)
		H.equip_to_slot_or_del(new /obj/item/bodybag/tarp, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/drinks/flask/marine, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/explosive/plastique/genghis_charge, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/explosive/plastique/genghis_charge, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/sandbags/large_stack, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/small_stack, SLOT_IN_BACKPACK)
		H.equip_to_slot_or_del(new /obj/item/stack/barbed_wire/small_stack, SLOT_IN_BACKPACK)
