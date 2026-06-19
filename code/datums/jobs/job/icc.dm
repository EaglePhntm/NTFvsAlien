/datum/job/icc
	job_category = JOB_CAT_ICC
	access = ALL_ICC_ACCESS
	minimal_access = ALL_ICC_ACCESS
	skills_type = /datum/skills/craftier
	faction = FACTION_ICC
	minimap_icon = "icc"

/datum/job/icc/get_spawn_message_information(mob/M)
	. = ..()
	. += separator_hr("[span_role_header("<b>[title] Information</b>")]")
	. += {"You are part of the colonial militia that formed shortly after Xenomorph invasion,
after ransacking the armories of the colonies owned by NTC, you took arms to fight against the Xenomorph assault.
Though soon they turned less lethal, danger still persists, especially those that are alone, namely survivors. Which is your job to protect now.
You are all colonists hired by Ninetails, Novamed, TRANSCo and Archercorp, depending on your initial assignments. That's why you are here in this cursed planet to begin with.
For that CM is closer to NTC and the corps than the rest, they gave your families or just you hope and funds to live comfortably back in earth and you a possibiity of a new begginning until it is all taken away. \
CM believes the other factions to be vultures on top of a stillborn colonization. Corporate Council decided to appoint Colonial Milita as the governing force over the colonies, although while still serving under them."}


//ICC Standard
/datum/job/icc/standard
	title = "CM Standard"
	paygrade = "CMS"
	multiple_outfits = TRUE
	outfit = /datum/outfit/job/icc/standard/mpi_km
	outfits = list(
		/datum/outfit/job/icc/standard/mpi_km,
		/datum/outfit/job/icc/standard/icc_pdw,
		/datum/outfit/job/icc/standard/icc_battlecarbine,
		/datum/outfit/job/icc/standard/icc_assaultcarbine,
	)

/datum/outfit/job/icc
	name = "CM Standard"
	jobtype = /datum/job/icc

	id = /obj/item/card/id/silver
	w_uniform = /obj/item/clothing/under/icc/webbing
	belt = /obj/item/storage/belt/marine/icc
	ears = /obj/item/radio/headset/distress/icc
	w_uniform = /obj/item/clothing/under/icc/webbing
	shoes = /obj/item/clothing/shoes/marine/icc/knife
	wear_suit = /obj/item/clothing/suit/storage/marine/icc
	gloves = /obj/item/clothing/gloves/marine/icc
	head = /obj/item/clothing/head/helmet/marine/icc
	mask = /obj/item/clothing/mask/gas/icc

/datum/outfit/job/icc/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/wrapped/barcaridine, SLOT_IN_HEAD)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/oxycodone, SLOT_IN_HEAD)

// Basic standard equipment
/datum/outfit/job/icc/standard
	name = "CM Standard"
	jobtype = /datum/job/icc

	id = /obj/item/card/id/silver
	gloves = /obj/item/clothing/gloves/marine/icc/insulated
	r_pocket = /obj/item/storage/pouch/pistol/icc
	l_pocket = /obj/item/storage/pouch/medical_injectors/icc/firstaid
	back = /obj/item/storage/backpack/lightpack/icc


/datum/outfit/job/icc/standard/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_SUIT)

	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/icc_dpistol, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/icc_dpistol, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/icc_dpistol, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/screwdriver, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/wrench, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/icc_dpistol, SLOT_IN_R_POUCH)

	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_ACCESSORY)

/datum/outfit/job/icc/standard/mpi_km
	suit_store = /obj/item/weapon/gun/rifle/mpi_km/standard

/datum/outfit/job/icc/standard/mpi_km/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/mpi_km/black, SLOT_IN_BELT)

/datum/outfit/job/icc/standard/icc_pdw
	suit_store = /obj/item/weapon/gun/smg/icc_pdw/standard

/datum/outfit/job/icc/standard/icc_pdw/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_pdw, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_pdw, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_pdw, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_pdw, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_pdw, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_pdw, SLOT_IN_BELT)

/datum/outfit/job/icc/standard/icc_battlecarbine
	suit_store = /obj/item/weapon/gun/rifle/icc_battlecarbine/standard

/datum/outfit/job/icc/standard/icc_battlecarbine/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_battlecarbine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_battlecarbine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_battlecarbine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_battlecarbine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_battlecarbine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_battlecarbine, SLOT_IN_BELT)

/datum/outfit/job/icc/standard/icc_assaultcarbine
	suit_store = /obj/item/weapon/gun/rifle/icc_assaultcarbine

/datum/outfit/job/icc/standard/icc_assaultcarbine/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_assaultcarbine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_assaultcarbine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_assaultcarbine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_assaultcarbine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_assaultcarbine, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_assaultcarbine, SLOT_IN_BELT)

//ICC Guard
/datum/job/icc/guard
	title = "CM Guard"
	paygrade = "CM3"
	comm_title = "CMG"
	outfit = /datum/outfit/job/icc/guard/coilgun
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/icc/guard/coilgun,
		/datum/outfit/job/icc/guard/icc_autoshotgun,
		/datum/outfit/job/icc/guard/icc_bagmg,
	)

/datum/outfit/job/icc/guard
	name = "CM Guard"
	jobtype = /datum/job/icc/guard

	shoes = /obj/item/clothing/shoes/marine/icc/guard/knife
	wear_suit = /obj/item/clothing/suit/storage/marine/icc/guard
	gloves = /obj/item/clothing/gloves/marine/icc/guard
	head = /obj/item/clothing/head/helmet/marine/icc/guard


/datum/outfit/job/icc/guard/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_SUIT)

	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/russian_red, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/synaptizine, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/tricordrazine, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/tramadol, SLOT_IN_ACCESSORY)


/datum/outfit/job/icc/guard/coilgun
	suit_store = /obj/item/weapon/gun/launcher/rocket/icc
	back = /obj/item/weapon/gun/rifle/icc_coilgun
	l_pocket = /obj/item/storage/pouch/explosive/icc
	r_pocket = /obj/item/storage/pouch/explosive/icc

/datum/outfit/job/icc/guard/coilgun/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/icc, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/icc, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/icc, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/icc, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/icc/thermobaric, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/icc/thermobaric, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/icc/heat, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rocket/icc/heat, SLOT_IN_L_POUCH)


	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)

/datum/outfit/job/icc/guard/icc_autoshotgun
	suit_store = /obj/item/weapon/gun/rifle/icc_coilgun
	back = /obj/item/weapon/gun/rifle/icc_autoshotgun/guard
	l_pocket = /obj/item/storage/pouch/magazine/large/icc
	r_pocket = /obj/item/storage/pouch/magazine/large/icc

/datum/outfit/job/icc/guard/icc_autoshotgun/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_BELT)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_autoshotgun, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_autoshotgun, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_autoshotgun, SLOT_IN_R_POUCH)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_autoshotgun/frag, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_autoshotgun/frag, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_autoshotgun/frag, SLOT_IN_L_POUCH)

/datum/outfit/job/icc/guard/icc_bagmg
	wear_suit = /obj/item/clothing/suit/storage/marine/icc/guard/heavy
	head = /obj/item/clothing/head/helmet/marine/icc/guard/heavy
	suit_store = /obj/item/weapon/gun/rifle/icc_coilgun
	back = /obj/item/storage/holster/icc_mg/full
	belt = /obj/item/ammo_magazine/icc_mg/belt
	l_pocket = /obj/item/storage/pouch/magazine/large/icc
	r_pocket = /obj/item/storage/pouch/magazine/large/icc

/datum/outfit/job/icc/guard/icc_bagmg/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_coilgun, SLOT_IN_R_POUCH)


//ICC Medic
/datum/job/icc/medic
	title = "CM Medic"
	paygrade = "CM2"
	comm_title = "CMM"
	skills_type = /datum/skills/combat_medic/crafty
	multiple_outfits = TRUE
	outfit = /datum/outfit/job/icc/medic/icc_machinepistol
	outfits = list(
		/datum/outfit/job/icc/medic/icc_machinepistol,
		/datum/outfit/job/icc/medic/icc_sharpshooter,
	)

/datum/outfit/job/icc/medic
	name = "CM Medic"
	jobtype = /datum/job/icc/medic

	id = /obj/item/card/id/silver
	gloves = /obj/item/clothing/gloves/marine/icc
	back = /obj/item/storage/backpack/lightpack/icc
	belt = /obj/item/storage/belt/lifesaver/icc/ert
	glasses = /obj/item/clothing/glasses/hud/health

/datum/outfit/job/icc/medic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/food/snacks/wrapped/barcaridine, SLOT_IN_SUIT)

	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/defibrillator, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/icc_dpistol, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/icc_dpistol, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/roller, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/tweezers, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/storage/pill_bottle/spaceacillin, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/nanoblood, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/bodybag/cryobag, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/advanced/combat_advanced, SLOT_IN_ACCESSORY)

/datum/outfit/job/icc/medic/icc_machinepistol
	suit_store = /obj/item/weapon/gun/smg/icc_machinepistol/medic
	l_pocket = /obj/item/storage/pouch/magazine/large/icc
	r_pocket = /obj/item/storage/pouch/magazine/large/icc

/datum/outfit/job/icc/medic/icc_machinepistol/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_machinepistol, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_machinepistol, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_machinepistol, SLOT_IN_R_POUCH)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_machinepistol/hp, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_machinepistol/hp, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_machinepistol/hp, SLOT_IN_L_POUCH)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_machinepistol, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_machinepistol, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/icc_machinepistol, SLOT_IN_BACKPACK)

/datum/outfit/job/icc/medic/icc_sharpshooter
	suit_store = /obj/item/weapon/gun/rifle/icc_sharpshooter/medic
	l_pocket = /obj/item/storage/pouch/magazine/large/icc
	r_pocket = /obj/item/storage/pouch/magazine/large/icc

/datum/outfit/job/icc/medic/icc_sharpshooter/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_sharpshooter, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_sharpshooter, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_sharpshooter, SLOT_IN_R_POUCH)

	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_sharpshooter, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_sharpshooter, SLOT_IN_L_POUCH)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_sharpshooter, SLOT_IN_L_POUCH)

/datum/job/icc/leader
	title = "CM Leader"
	paygrade = "CM2"
	comm_title = "CML"
	outfit = /datum/outfit/job/icc/leader/icc_heavyshotgun
	skills_type = /datum/skills/sl/icc
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/icc/leader/icc_heavyshotgun,
		/datum/outfit/job/icc/leader/icc_confrontationrifle,
	)


/datum/outfit/job/icc/leader
	name = "CM Leader"
	jobtype = /datum/job/icc/leader

	shoes = /obj/item/clothing/shoes/marine/icc/knife
	wear_suit = /obj/item/clothing/suit/storage/marine/icc/guard
	gloves = /obj/item/clothing/gloves/marine/icc/guard
	head = /obj/item/clothing/head/helmet/marine/icc/guard
	back = /obj/item/storage/backpack/lightpack/icc/guard
	l_pocket = /obj/item/storage/pouch/medical_injectors/icc/firstaid
	r_pocket = /obj/item/storage/pouch/construction/icc/full


/datum/outfit/job/icc/leader/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/gauze, SLOT_IN_SUIT)
	H.equip_to_slot_or_del(new /obj/item/stack/medical/heal_pack/ointment, SLOT_IN_SUIT)

	H.equip_to_slot_or_del(new /obj/item/tool/crowbar/red, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/explosive/grenade/incendiary/som, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/storage/box/m94, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/tool/extinguisher, SLOT_IN_BACKPACK)
	H.equip_to_slot_or_del(new /obj/item/reagent_containers/hypospray/autoinjector/combat_advanced, SLOT_IN_BACKPACK)

	H.equip_to_slot_or_del(new /obj/item/binoculars/tactical/range, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_ACCESSORY)
	H.equip_to_slot_or_del(new /obj/item/explosive/plastique, SLOT_IN_ACCESSORY)

/datum/outfit/job/icc/leader/icc_heavyshotgun
	suit_store = /obj/item/weapon/gun/shotgun/pump/icc_heavyshotgun/icc_leader
	belt = /obj/item/storage/belt/shotgun/icc/mixed

/datum/outfit/job/icc/leader/icc_confrontationrifle
	belt = /obj/item/storage/belt/marine/icc
	suit_store = /obj/item/weapon/gun/rifle/icc_confrontationrifle/leader

/datum/outfit/job/icc/leader/icc_confrontationrifle/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_confrontationrifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_confrontationrifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_confrontationrifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_confrontationrifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_confrontationrifle, SLOT_IN_BELT)
	H.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/icc_confrontationrifle, SLOT_IN_BELT)

//ICC command
/datum/job/icc/commander
	title = "CM Commander"
	paygrade = "COL"
	comm_title = "CMC"
	supervisors = "CM/NTC high command"
	skills_type = /datum/skills/captain
	access = ALL_ICC_ACCESS
	minimal_access = ALL_ICC_ACCESS
	exp_requirements = XP_REQ_EXPERT
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP|JOB_FLAG_LOUDER_TTS|JOB_FLAG_OVERRIDELATEJOINSPAWN
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/squad/specialist = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	total_positions = 1
	outfit = /datum/outfit/job/icc/commander

/datum/job/icc/commander/get_spawn_message_information(mob/M)
	. = ..()
	. += separator_hr("[span_role_header("<b>[title] Information</b>")]")
	. += {"As the Commander of the colonial militia you are held by higher standard and are expected to act competently. you report to CM High command and corporate management when necessary.
Your primary task is the safety of colonial militia base and then the colony you are assigned to oversee, ensuring the survival and success of the colony.
Your first order of business should be briefing the marines on the mission they are about to undertake.
If you require any help, use <b>Mentorhelp</b> to ask mentors about what you're supposed to do.
Godspeed, Commander! And remember, you are not above the law."}

/datum/job/icc/commander/after_spawn(mob/living/new_mob, mob/user, latejoin)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "COL"
		if(1501 to 7500) // 25hrs
			new_human.wear_id.paygrade = "MGEN"
		if(7501 to INFINITY) //125 hrs
			new_human.wear_id.paygrade = "GEN"

/datum/outfit/job/icc/commander
	name = "CM Commander"
	jobtype = /datum/job/icc/commander

	id = /obj/item/card/id/gold
	belt = /obj/item/storage/holster/belt/pistol/smart_pistol/full
	ears = /obj/item/radio/headset/mainship/marine/icc
	w_uniform = /obj/item/clothing/under/marine/officer/command
	shoes = /obj/item/clothing/shoes/marinechief/captain
	gloves = /obj/item/clothing/gloves/marine/techofficer/captain
	head = /obj/item/clothing/head/beret/marine/captain
	r_pocket = /obj/item/storage/pouch/general/large/command
	l_pocket = /obj/item/hud_tablet/leadership
	back = /obj/item/storage/backpack/marine/satchel/captain_cloak

//Field Commander
/datum/job/icc/fieldcommander
	title = "CM Militia Captain"
	req_admin_notify = TRUE
	paygrade = "O3"
	comm_title = "CMMC"
	total_positions = 1
	skills_type = /datum/skills/fo
	access = ALL_ICC_ACCESS
	minimal_access = ALL_ICC_ACCESS
	outfit = /datum/outfit/job/command/fieldcommandericc
	exp_requirements = XP_REQ_EXPERIENCED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP|JOB_FLAG_LOUDER_TTS|JOB_FLAG_OVERRIDELATEJOINSPAWN
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/squad/specialist = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	minimap_icon = "fieldcommander"

/datum/outfit/job/command/fieldcommandericc
	name = "CM Militia Captain"
	jobtype = /datum/job/icc/fieldcommander

	id = /obj/item/card/id/dogtag/fc
	belt = /obj/item/storage/holster/blade/officer/full
	ears = /obj/item/radio/headset/mainship/marine/icc
	w_uniform = /obj/item/clothing/under/marine/officer/exec
	wear_suit = /obj/item/clothing/suit/modular/xenonauten
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/marine/officer
	head = /obj/item/clothing/head/tgmcberet/fc
	r_pocket = /obj/item/storage/pouch/general/large/command
	l_pocket = /obj/item/hud_tablet/fieldcommand
	suit_store = /obj/item/storage/holster/belt/pistol/m4a3/fieldcommander

/datum/job/icc/fieldcommander/get_spawn_message_information(mob/M)
	. = ..()
	. += separator_hr("[span_role_header("<b>[title] Information</b>")]")
	. += {"You are charged with overseeing the security on the assigned colony, and are the highest-ranked deployed militia.
Your duties are to ensure soldiers hold when ordered, and push when they are cowering behind barricades.
Do not ask your men to do anything you would not do side by side with them.
Make the CM proud!"}

/datum/job/icc/fieldcommander/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	SSdirection.set_leader(TRACKING_ID_MARINE_COMMANDER, new_mob)
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "O3"
		if(1501 to 6000) // 25hrs
			new_human.wear_id.paygrade = "MO4"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "MO5"
		if(18001 to 60000) // 300 hrs
			new_human.wear_id.paygrade = "MO6"
		if(60001 to INFINITY) // 1000 hrs
			new_human.wear_id.paygrade = "M10" //If you play way too much TGMC. 1000 hours.
	new_human.wear_id.update_label()

//be assigned to jobs for colony management
/datum/job/icc/administrator
	title = "CM Colony Administrator"
	paygrade = "O1"
	comm_title = "ADM"
	total_positions = 4
	access = ALL_ICC_ACCESS
	minimal_access = ALL_ICC_ACCESS
	skills_type = /datum/skills/so
	display_order = JOB_DISPLAY_ORDER_STAFF_OFFICER
	outfit = /datum/outfit/job/administrator
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/administrator,
	)
	exp_requirements = XP_REQ_INTERMEDIATE
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP|JOB_FLAG_OVERRIDELATEJOINSPAWN
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/squad/specialist = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> CM Commander<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Be assigned to a colony department as the administrator and manage it, in rare cases, the entire colony departments.
	"}

	minimap_icon = "staffofficer"

/datum/job/icc/administrator/get_spawn_message_information(mob/M)
	. = ..()
	. += separator_hr("[span_role_header("<b>[title] Information</b>")]")
	. += {"Your job is to ensure the colony is running as intended, usually you will be assigned to a department in colony or for CM itself, by a CM commander, \
	but if there isn't enough administrators you may need to oversee the entire colony departments..."}

/datum/job/icc/administrator/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // starting
			new_human.wear_id.paygrade = "O1"
		if(601 to 1500) // 10hrs
			new_human.wear_id.paygrade = "O2"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "O3"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "O4"
		if(18001 to INFINITY) // 300 hrs
			new_human.wear_id.paygrade = "O5"
	new_human.wear_id.update_label()

/datum/outfit/job/administrator
	name = "CM Colony Administrator"
	jobtype = /datum/job/icc/administrator

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/holster/belt/pistol/m4a3/officer
	ears = /obj/item/radio/headset/mainship/marine/icc
	w_uniform = /obj/item/clothing/under/marine/officer/bridge
	shoes = /obj/item/clothing/shoes/marine/full
	head = /obj/item/clothing/head/tgmccap/ro
	r_pocket = /obj/item/storage/pouch/general/large
	l_pocket = /obj/item/binoculars/tactical
