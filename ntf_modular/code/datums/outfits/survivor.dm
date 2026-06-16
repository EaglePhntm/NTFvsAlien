/datum/outfit/job/survivor
	name = "Colonist"
	jobtype = /datum/job/survivor

	w_uniform = /obj/item/clothing/under/colonist
	shoes = /obj/item/clothing/shoes/marine/clf/full
	back = /obj/item/storage/backpack/satchel/norm
	wear_suit = /obj/item/clothing/suit/armor/vest
	ears = /obj/item/radio/headset/survivor
	belt = /obj/item/storage/belt/sparepouch
	glasses = /obj/item/clothing/glasses/welding
	r_pocket = /obj/item/storage/pouch/tools/full
	l_pocket = /obj/item/storage/pouch/survival/full
	id = /obj/item/card/id/captains_spare/survival
	backpack_contents = list(
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

/datum/outfit/job/survivor/non_deployed_operative
	name = "Non-Deployed Operative Colonist"
	jobtype = /datum/job/survivor/non_deployed_operative

	w_uniform = /obj/item/clothing/under/marine/service
	gloves = /obj/item/clothing/gloves/white
	shoes = /obj/item/clothing/shoes/marine/full
	head = /obj/item/clothing/head/servicecap
	back = /obj/item/storage/backpack/marine/satchel
	backpack_contents = list(
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
		/obj/item/tool/pen = 1,
		/obj/item/paper = 1,
		/obj/item/folder/white = 1,
	)

/datum/outfit/job/survivor/prisoner
	name = "Fugitive Colonist"
	jobtype = /datum/job/survivor/prisoner

	w_uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/orange
	back =  /obj/item/storage/backpack/satchel/rugged
	mask = /obj/item/clothing/mask/gas/modular/skimask
	backpack_contents = list(
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
		/obj/item/restraints/handcuffs = 1
	)

/datum/outfit/job/survivor/stripper
	name = "Stripper Colonist"
	jobtype = /datum/job/survivor/stripper

	w_uniform = /obj/item/clothing/under/lewd/stripper
	shoes = /obj/item/clothing/shoes/high_heels/red
	back =  /obj/item/storage/backpack/satchel
	head = /obj/item/clothing/head/bunny_ears
	backpack_contents = list(
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
	)

/datum/outfit/job/survivor/maid
	name = "Maid Colonist"
	jobtype = /datum/job/survivor/maid

	w_uniform = /obj/item/clothing/under/dress/maid
	gloves = /obj/item/clothing/gloves/latex
	shoes = /obj/item/clothing/shoes/high_heels
	back =  /obj/item/storage/backpack/satchel/norm
	backpack_contents = list(
		/obj/item/reagent_containers/food/drinks/cans/waterbottle = 1,
		/obj/item/tool/soap/deluxe = 1,
		/obj/item/reagent_containers/glass/bucket = 1,
	)

/datum/outfit/job/survivor/synth
	name = "Synthetic Colonist"
	jobtype = /datum/job/survivor/synth

	id = /obj/item/card/id/gold
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/rank/synthetic
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/insulated
	r_pocket = /obj/item/storage/pouch/general/medium
	l_pocket = /obj/item/storage/pouch/general/medium
