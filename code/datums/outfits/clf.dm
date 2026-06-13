//the base loadout for all Cultists
/datum/outfit/job/clf/standard
	name = "Cultist"
	jobtype = /datum/job/clf/standard

	id = /obj/item/card/id/clf
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/colonist
	shoes = /obj/item/clothing/shoes/marine/clf/full
	wear_suit = /obj/item/clothing/suit/modular/clf/cultist_robe
	gloves = /obj/item/clothing/gloves/black
	r_pocket = /obj/item/storage/pouch/medical_injectors/firstaid
	back = /obj/item/storage/backpack/satchel

	backpack_contents = list(
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/MRE = 1,
		/obj/item/explosive/grenade/incendiary/molotov = 2,
		/obj/item/storage/box/m94 = 1,
	)

	suit_contents = list(
		/obj/item/explosive/grenade/stick = 2,
	)


/datum/outfit/job/clf/standard/uzi
	belt = /obj/item/storage/belt/knifepouch
	suit_store = /obj/item/weapon/gun/smg/uzi/mag_harness

/datum/outfit/job/clf/standard/uzi/update_contents()
	backpack_contents += list(
		/obj/item/storage/box/m94 = 1,
		/obj/item/ammo_magazine/smg/uzi/extended = 8,
	)


/datum/outfit/job/clf/standard/skorpion
	belt = /obj/item/weapon/gun/shotgun/double/sawn
	suit_store = /obj/item/weapon/gun/smg/skorpion/mag_harness

/datum/outfit/job/clf/standard/skorpion/update_contents()
	backpack_contents += list(
		/obj/item/ammo_magazine/handful/buckshot = 2,
		/obj/item/ammo_magazine/smg/skorpion = 7,
	)


/datum/outfit/job/clf/standard/mpi_km
	belt = /obj/item/storage/belt/marine/som
	suit_store = /obj/item/weapon/gun/rifle/mpi_km/standard
	belt_contents = list(
		/obj/item/ammo_magazine/rifle/mpi_km = 6,
	)

/datum/outfit/job/clf/standard/mpi_km/update_contents()
	backpack_contents += list(
		/obj/item/storage/box/m94 = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/stack/sheet/metal/medium_stack = 1,
	)


/datum/outfit/job/clf/standard/shotgun
	belt = /obj/item/storage/belt/shotgun
	suit_store = /obj/item/weapon/gun/shotgun/pump/standard
	belt_contents = list(
		/obj/item/ammo_magazine/handful/buckshot = 7,
		/obj/item/ammo_magazine/handful/flechette = 7,
	)

/datum/outfit/job/clf/standard/shotgun/update_contents()
	backpack_contents += list(
		/obj/item/storage/box/m94 = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/stack/sheet/metal/medium_stack = 1,
	)


/datum/outfit/job/clf/standard/fanatic
	head = /obj/item/clothing/head/headband/rambo
	wear_suit = /obj/item/clothing/suit/storage/marine/boomvest/fast
	l_hand = /obj/item/clothing/suit/modular/clf/cultist_robe
	belt = /obj/item/weapon/gun/shotgun/double/sawn
	suit_store = /obj/item/weapon/gun/smg/skorpion/mag_harness

/datum/outfit/job/clf/standard/shotgun/update_contents()
	backpack_contents += list(
		/obj/item/ammo_magazine/handful/buckshot = 2,
		/obj/item/explosive/grenade/phosphorus/upp = 1,
		/obj/item/ammo_magazine/smg/skorpion = 5,
	)


/datum/outfit/job/clf/standard/som_smg
	belt = /obj/item/storage/belt/marine/som
	suit_store = /obj/item/weapon/gun/smg/som/basic
	belt_contents = list(
		/obj/item/ammo_magazine/smg/som = 6,
	)

/datum/outfit/job/clf/standard/som_smg/update_contents()
	backpack_contents += list(
		/obj/item/storage/box/m94 = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/stack/sheet/metal/medium_stack = 1,
	)


/datum/outfit/job/clf/standard/garand
	belt = /obj/item/storage/belt/marine/som
	suit_store = /obj/item/weapon/gun/rifle/garand
	belt_contents = list(
		/obj/item/ammo_magazine/rifle/garand = 6,
	)

/datum/outfit/job/clf/standard/garand/update_contents()
	backpack_contents += list(
		/obj/item/storage/box/m94 = 1,
		/obj/item/explosive/plastique = 1,
		/obj/item/stack/sheet/metal/medium_stack = 1,
	)


//the base loadout for all Cultist Menders
/datum/outfit/job/clf/medic
	name = "Cultist Mender"
	jobtype = /datum/job/clf/medic

	id = /obj/item/card/id/clf
	belt = /obj/item/storage/belt/lifesaver/full/upp
	ears = /obj/item/radio/headset/distress/dutch
	head = /obj/item/clothing/head/tgmcberet/bloodred
	w_uniform = /obj/item/clothing/under/colonist
	shoes = /obj/item/clothing/shoes/marine/clf/full
	wear_suit = /obj/item/clothing/suit/modular/clf/cultist_robe
	gloves = /obj/item/clothing/gloves/black
	glasses = /obj/item/clothing/glasses/hud/health
	suit_store = /obj/item/weapon/gun/smg/skorpion
	l_pocket = /obj/item/storage/pouch/medical_injectors/medic
	back = /obj/item/storage/backpack/marine/corpsman

	backpack_contents = list(
		/obj/item/defibrillator = 1,
		/obj/item/roller = 1,
		/obj/item/storage/box/MRE = 1,
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 1,
		/obj/item/explosive/grenade/incendiary/molotov = 1,
	)

	suit_contents = list(
		/obj/item/explosive/grenade/stick = 2,
	)


/datum/outfit/job/clf/medic/uzi
	suit_store = /obj/item/weapon/gun/smg/uzi/mag_harness
	r_pocket = /obj/item/storage/holster/flarepouch
	r_pocket_contents = list(
		/obj/item/weapon/gun/grenade_launcher/single_shot/flare = 1,
		/obj/item/explosive/grenade/flare = 6,
	)

/datum/outfit/job/clf/medic/uzi/update_contents()
	backpack_contents += list(
		/obj/item/ammo_magazine/smg/uzi/extended = 7,
	)


/datum/outfit/job/clf/medic/skorpion
	suit_store = /obj/item/weapon/gun/smg/skorpion/mag_harness
	r_pocket = /obj/item/storage/holster/flarepouch
	r_pocket_contents = list(
		/obj/item/weapon/gun/grenade_launcher/single_shot/flare = 1,
		/obj/item/explosive/grenade/flare = 6,
	)

/datum/outfit/job/clf/medic/skorpion/update_contents()
	backpack_contents += list(
		/obj/item/ammo_magazine/smg/skorpion = 7,
	)


/datum/outfit/job/clf/medic/paladin
	suit_store = /obj/item/weapon/gun/shotgun/pump/cmb/mag_harness
	r_pocket = /obj/item/storage/pouch/shotgun
	r_pocket_contents = list(
		/obj/item/ammo_magazine/handful/buckshot = 2,
		/obj/item/ammo_magazine/handful/flechette = 2,
	)

/datum/outfit/job/clf/medic/paladin/update_contents()
	backpack_contents = list(
		/obj/item/ammo_magazine/handful/buckshot = 2,
		/obj/item/ammo_magazine/handful/flechette = 2,
	)


//The base loadout for all Cultist Champions
/datum/outfit/job/clf/specialist
	name = "Cultist Champion"
	jobtype = /datum/job/clf/specialist

	id = /obj/item/card/id/clf
	belt = /obj/item/storage/belt/marine
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/colonist/webbing
	shoes = /obj/item/clothing/shoes/marine/clf/full
	wear_suit = /obj/item/clothing/suit/modular/clf/cultist_robe
	gloves = /obj/item/clothing/gloves/black
	head = /obj/item/clothing/head/helmet/marine
	r_pocket = /obj/item/storage/pouch/pistol
	l_pocket = /obj/item/storage/pouch/medical_injectors/firstaid
	back = /obj/item/storage/backpack/cultpack

	backpack_contents = list(
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/storage/box/MRE = 1,
		/obj/item/tool/crowbar/red = 1,
		/obj/item/explosive/plastique = 2,
	)

	suit_contents = list(
		/obj/item/explosive/grenade/stick = 2,
	)

	r_pocket_contents = list(
		/obj/item/weapon/gun/pistol/highpower = 1,
	)

/datum/outfit/job/clf/specialist/dpm
	suit_store = /obj/item/weapon/gun/rifle/dpm

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/dpm = 6,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/stick = 4,
		/obj/item/explosive/grenade/smokebomb = 1,
	)


/datum/outfit/job/clf/specialist/clf_heavyrifle
	suit_store = /obj/item/weapon/gun/clf_heavyrifle
	back = /obj/item/big_ammo_box/clf_heavyrifle
	belt = /obj/item/storage/belt/utility/full

	webbing_contents = list(
		/obj/item/explosive/grenade/stick = 4,
		/obj/item/explosive/grenade/smokebomb = 1,
	)

	backpack_contents = null


/datum/outfit/job/clf/specialist/clf_heavymachinegun
	suit_store = /obj/item/weapon/gun/icc_hmg
	belt = /obj/item/storage/belt/sparepouch

	belt_contents = list(
		/obj/item/ammo_magazine/icc_hmg = 3,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/stick = 4,
		/obj/item/explosive/grenade/smokebomb = 1,
	)


//the base loadout for all Cultist Sect Leaders
/datum/outfit/job/clf/leader
	name = "Cultist Sect Leader"
	jobtype = /datum/job/clf/leader

	id = /obj/item/card/id/clf
	belt = /obj/item/storage/belt/marine
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/colonist/webbing
	shoes = /obj/item/clothing/shoes/marine/clf/full
	wear_suit = /obj/item/clothing/suit/modular/clf/cultist_robe
	gloves = /obj/item/clothing/gloves/black
	head = /obj/item/clothing/head/militia
	glasses = /obj/item/clothing/glasses/hud/health
	r_pocket = /obj/item/storage/pouch/pistol
	l_pocket = /obj/item/storage/pouch/medical_injectors/firstaid
	back = /obj/item/storage/backpack/lightpack

	backpack_contents = list(
		/obj/item/radio = 1,
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/storage/box/MRE = 1,
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 2,
		/obj/item/explosive/grenade/incendiary/molotov = 2,
		/obj/item/ammo_magazine/pistol/highpower = 2,
		/obj/item/explosive/plastique = 2,
	)

	suit_contents = list(
		/obj/item/binoculars = 1,
		/obj/item/radio = 1,
	)

	r_pocket_contents = list(
		/obj/item/weapon/gun/pistol/highpower = 1,
	)


/datum/outfit/job/clf/leader/assault_rifle
	suit_store = /obj/item/weapon/gun/rifle/m16/ugl

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/m16 = 6,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/stick = 4,
		/obj/item/explosive/grenade/smokebomb = 1,
	)


/datum/outfit/job/clf/leader/mpi_km
	suit_store = /obj/item/weapon/gun/rifle/mpi_km/grenadier
	belt = /obj/item/storage/belt/marine/som

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/mpi_km = 6,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/stick = 4,
		/obj/item/explosive/grenade/smokebomb = 1,
	)


/datum/outfit/job/clf/leader/som_rifle
	suit_store = /obj/item/weapon/gun/rifle/som/basic
	belt = /obj/item/storage/belt/marine/som

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/som = 6,
	)

	webbing_contents = list(
		/obj/item/ammo_magazine/handful/micro_grenade = 2,
		/obj/item/ammo_magazine/handful/micro_grenade/dragonbreath = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/cluster = 1,
		/obj/item/ammo_magazine/handful/micro_grenade/smoke_burst = 1,
	)


/datum/outfit/job/clf/leader/upp_rifle
	suit_store = /obj/item/weapon/gun/rifle/type71/flamer/standard

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/type71 = 6,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/stick = 2,
		/obj/item/ammo_magazine/flamer_tank/mini = 2,
		/obj/item/explosive/grenade/smokebomb = 1,
	)


/datum/outfit/job/clf/leader/lmg_d
	suit_store = /obj/item/weapon/gun/rifle/lmg_d/magharness
	belt = /obj/item/storage/belt/marine/som

	belt_contents = list(
		/obj/item/ammo_magazine/rifle/lmg_d = 6,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/stick = 4,
		/obj/item/explosive/grenade/smokebomb = 1,
	)

/datum/outfit/job/clf/breeder
	name = "Cult Offering"
	jobtype = /datum/job/clf/breeder

	id = /obj/item/card/id/clf
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/lewd/gear_harness
	shoes = /obj/item/clothing/shoes/marine/clf/full
	belt = /obj/item/storage/holster/t19/full
	r_pocket = /obj/item/flashlight
	l_pocket = /obj/item/storage/pouch/medkit/firstaid
	back = /obj/item/storage/backpack/marine/satchel

/datum/outfit/job/clf/breeder/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/peridaxon_plus, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/MRE, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/monkeycube/wrapped, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/monkeycube/wrapped, SLOT_IN_BELT)

/datum/outfit/job/civilian/synthetic/clf
	name = SYNTHETIC
	jobtype = /datum/job/clf/silicon/synthetic

	id = /obj/item/card/id/clf
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/rank/synthetic
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/insulated
	r_pocket = /obj/item/storage/pouch/general/medium
	l_pocket = /obj/item/storage/pouch/general/medium

/datum/outfit/job/clf/tech
	name = "Cultist Technomancer"
	jobtype = /datum/job/clf/tech

	id = /obj/item/card/id/clf
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/techpriest
	wear_suit = /obj/item/clothing/suit/modular/clf/techpriest_robe
	shoes = /obj/item/clothing/shoes/techpriest
	gloves = /obj/item/clothing/gloves/techpriest
	head = /obj/item/clothing/head/techpriest
	l_pocket = /obj/item/storage/pouch/general/medium
	suit_store = /obj/item/weapon/gun/shotgun/pump/cmb/mag_harness
	r_pocket = /obj/item/storage/pouch/shotgun
	back = /obj/item/storage/backpack/lightpack

	backpack_contents = list(
		/obj/item/ammo_magazine/handful/buckshot = 2,
		/obj/item/ammo_magazine/handful/flechette = 2,
	)

	r_pocket_contents = list(
		/obj/item/ammo_magazine/handful/buckshot = 2,
		/obj/item/ammo_magazine/handful/flechette = 2,
	)
/datum/outfit/job/clf/mo
	name = "Cultist Archmender"
	jobtype = /datum/job/clf/mo

	id = /obj/item/card/id/clf
	w_uniform = /obj/item/clothing/under/rank/medical/blue
	wear_suit = /obj/item/clothing/suit/modular/clf/cultist_robe
	shoes = /obj/item/clothing/shoes/marine/clf/full
	back = /obj/item/storage/backpack/lightpack
	gloves = /obj/item/clothing/gloves/latex
	glasses = /obj/item/clothing/glasses/hud/health
	r_pocket = /obj/item/storage/pouch/surgery
	l_pocket = /obj/item/storage/pouch/medical_injectors/icc/medic
	belt = /obj/item/storage/belt/lifesaver/icc/full
	mask = /obj/item/clothing/mask/surgical
	ears = /obj/item/radio/headset/distress/dutch

	backpack_contents = list(
		/obj/item/defibrillator = 1,
		/obj/item/roller = 1,
		/obj/item/storage/box/MRE = 1,
		/obj/item/tool/crowbar/red = 1,
		/obj/item/tweezers = 1,
	)

/datum/outfit/job/clf/messiah
	id = /obj/item/card/id/clf
	belt = /obj/item/storage/belt/marine
	ears = /obj/item/radio/headset/distress/dutch
	w_uniform = /obj/item/clothing/under/colonist/webbing
	shoes = /obj/item/clothing/shoes/marine/clf/full
	wear_suit = /obj/item/clothing/suit/modular/clf/cultist_robe
	gloves = /obj/item/clothing/gloves/black
	head = /obj/item/clothing/head/collectable/xenom
	glasses = /obj/item/clothing/glasses/hud/health
	r_pocket = /obj/item/storage/pouch/pistol
	l_pocket = /obj/item/storage/pouch/medical_injectors/firstaid
	back = /obj/item/storage/backpack/lightpack

	backpack_contents = list(
		/obj/item/radio = 1,
		/obj/item/stack/sheet/metal/medium_stack = 1,
		/obj/item/storage/box/MRE = 1,
		/obj/item/tool/crowbar/red = 1,
		/obj/item/storage/box/m94 = 2,
		/obj/item/ammo_magazine/pistol/highpower = 2,
	)

	suit_contents = list(
		/obj/item/binoculars = 1,
	)

	r_pocket_contents = list(
		/obj/item/weapon/gun/pistol/highpower = 1,
	)

	webbing_contents = list(
		/obj/item/explosive/grenade/stick = 4,
		/obj/item/explosive/grenade/smokebomb = 1,
	)

/obj/item/clothing/suit/modular/clf
	name = "cult robes"
	icon = 'icons/obj/clothing/suits/suits.dmi'
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/clothing/suits_left.dmi',
		slot_r_hand_str = 'icons/mob/inhands/clothing/suits_right.dmi',
	)
	attachments_allowed = list(
// Armor Modules
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/module/fire_proof,
		/obj/item/armor_module/module/tyr_extra_armor,
		/obj/item/armor_module/module/tyr_extra_armor/mark1,
		/obj/item/armor_module/module/mimir_environment_protection,
		/obj/item/armor_module/module/mimir_environment_protection/mark1,
		/obj/item/armor_module/module/hlin_explosive_armor,
		/obj/item/armor_module/module/ballistic_armor,
		/obj/item/armor_module/module/chemsystem,
		/obj/item/armor_module/module/knight,
		/obj/item/armor_module/module/eshield,
		/obj/item/armor_module/module/eshield/som,
		/obj/item/armor_module/module/eshield/som/overclocked,
		/obj/item/armor_module/module/mimir_environment_protection/som,
		/obj/item/armor_module/module/knight/som,
		/obj/item/armor_module/module/tyr_extra_armor/som,
		/obj/item/armor_module/module/fire_proof/som,
		/obj/item/armor_module/module/valkyrie_autodoc/som,
		/obj/item/armor_module/module/mirage,
		/obj/item/armor_module/module/armorlock,
// Storage Modules
		/obj/item/armor_module/storage/general,
		/obj/item/armor_module/storage/ammo_mag,
		/obj/item/armor_module/storage/engineering,
		/obj/item/armor_module/storage/medical,
		/obj/item/armor_module/storage/general/som,
		/obj/item/armor_module/storage/engineering/som,
		/obj/item/armor_module/storage/medical/som,
		/obj/item/armor_module/storage/injector,
		/obj/item/armor_module/storage/grenade,
		/obj/item/armor_module/storage/integrated,
		/obj/item/armor_module/armor/badge,
// Equalizer Modules
		/obj/item/armor_module/module/style/light_armor,
		/obj/item/armor_module/module/style/medium_armor,
		/obj/item/armor_module/module/style/heavy_armor,
	)
	soft_armor = MARINE_ARMOR_LIGHT
	slowdown = SLOWDOWN_ARMOR_LIGHT

/obj/item/clothing/suit/modular/clf/cultist_robe
	name = "cultist robes"
	desc = "Heavy, royal purple robes threaded with psychic amplifiers and weird, bulbous lenses. Do not machine wash."
	icon_state = "psyamp"
	worn_icon_state = "psyamp"

/obj/item/clothing/suit/modular/clf/techpriest_robe
	name = "Techpriest Robes"
	desc = "Praise the omnissiah!"
	icon_state = "tp_bodyrobes"
	worn_icon_state = "tp_bodyrobes"
