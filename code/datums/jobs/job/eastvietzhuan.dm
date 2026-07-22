/datum/job/eastvietzhuan // not a job meant for players, but rather AI civilians who roam the map
	title = "Generic East Vietzhuan"
	supervisors = "For anyone who cares enough, maybe SOM."
	paygrade = "CLNST"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_ICC_CARGO)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_ICC_CARGO)
	display_order = JOB_DISPLAY_ORDER_SURVIVOR
	faction = FACTION_SOM //SOM-aligned civilians
	total_positions = -1
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN|JOB_FLAG_ADDTOMANIFEST
	job_category = JOB_CAT_SURVIVOR
	skills_type = /datum/skills/civilian/survivor

/datum/job/survivor/after_spawn(mob/living/carbon/spawned_carbon, mob/M, latejoin = FALSE)
	. = ..()
	SSminimaps.add_marker(spawned_carbon, MINIMAP_FLAG_SURVIVOR, image('ntf_modular/icons/UI_icons/map_blips_job.dmi', null, "survivor"))
	var/datum/action/minimap/survivor/mini = new
	mini.give_action(spawned_carbon)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		spawned_carbon.equip_to_slot_or_del(new /obj/item/clothing/head/ushanka(spawned_carbon), SLOT_HEAD)
		spawned_carbon.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/snow_suit(spawned_carbon), SLOT_W_UNIFORM)
		spawned_carbon.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather(spawned_carbon), SLOT_WEAR_MASK)
		spawned_carbon.equip_to_slot_or_del(new /obj/item/clothing/shoes/snow(spawned_carbon), SLOT_SHOES)
		spawned_carbon.equip_to_slot_or_del(new /obj/item/clothing/gloves/black(spawned_carbon), SLOT_GLOVES)

	var/weapons = pick(SURVIVOR_WEAPONS)
	var/obj/item/weapon/picked_weapon = weapons[1]
	var/obj/item/ammo_magazine/picked_ammo = weapons[2]
	spawned_carbon.equip_to_slot_or_del(new /obj/item/belt_harness(spawned_carbon), SLOT_BELT)
	spawned_carbon.put_in_hands(new picked_weapon(spawned_carbon))
	spawned_carbon.equip_to_slot_or_del(new picked_ammo(spawned_carbon), SLOT_IN_BACKPACK)
	spawned_carbon.equip_to_slot_or_del(new picked_ammo(spawned_carbon), SLOT_IN_BACKPACK)
	spawned_carbon.equip_to_slot_or_del(new picked_ammo(spawned_carbon), SLOT_IN_BACKPACK)
	spawned_carbon.equip_to_slot_or_del(new /obj/item/weapon/combat_knife(spawned_carbon), SLOT_IN_BACKPACK)

	spawned_carbon.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding(spawned_carbon), SLOT_GLASSES)
	spawned_carbon.equip_to_slot_or_del(new /obj/item/storage/pouch/tools/full(spawned_carbon), SLOT_R_STORE)
	spawned_carbon.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/full(spawned_carbon), SLOT_L_STORE)
	spawned_carbon.equip_to_slot_or_del(new /obj/item/clothing/head/hardhat/rugged(spawned_carbon), SLOT_HEAD)

	switch(SSmapping.configs[GROUND_MAP].map_name)
		if(MAP_PRISON_STATION)
			to_chat(M, span_notice("You are a survivor of the attack on Fiorina Orbital Penitentiary. You worked or lived on the prison station, and managed to avoid the alien attacks... until now."))
		if(MAP_ICE_COLONY)
			to_chat(M, span_notice("You are a survivor of the attack on the ice habitat. You worked or lived on the colony, and managed to avoid the alien attacks... until now."))
		if(MAP_BIG_RED)
			to_chat(M, span_notice("You are a survivor of the attack on the colony. You worked or lived in the archaeology colony, and managed to avoid the alien attacks... until now."))
		if(MAP_LV_624)
			to_chat(M, span_notice("You are a survivor of the attack on the colony. You suspected something was wrong and tried to warn others, but it was too late..."))
		if(MAP_ICY_CAVES)
			to_chat(M, span_notice("You are a survivor of the attack on the icy cave system. You worked or lived on the site, and managed to avoid the alien attacks... until now."))
		if(MAP_RESEARCH_OUTPOST)
			to_chat(M, span_notice("You are a survivor of the attack on the outpost. But you question yourself: are you truely safe now?"))
		if(MAP_MAGMOOR_DIGSITE)
			to_chat(M, span_notice("You are a survivor of the attack on the Magmoor Digsite IV. You worked or lived on the digsite, and managed to avoid the alien attacks... until now."))
		else
			to_chat(M, span_notice("Through a miracle you managed to survive the attack. But are you truly safe now?"))

/datum/job/survivor/get_spawn_message_information(mob/M)
	. = ..()
	. += separator_hr("[span_role_header("<b>[title] Information</b>")]")
	. += {"In whatever case you have been through, you are here to survive and get yourself rescued.
You appreciate the support of SOM should you be rescued.
You are not hostile to SOM, nor you should oppose or disrupt their objective, unless an admin says otherwise.
If you find any other survivors in the area, cooperate with them to increase your chances of survival.
Depending on the job you've undertook, you may have additional skills to help others when needed.
Good luck, but do not expect to survive."}


//Assistant
/datum/job/eastvietzhuan/villager
	title = "East Vietzhuan Villager"
	outfit = /datum/outfit/job/eastvietzhuan/villager

//Archaelogist
/datum/job/eastvietzhuan/archaelogist
	title = "East Vietzhuan Archaelogist"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/eastvietzhuan/archaelogist

/datum/job/eastvietzhuan/archaelogist/after_spawn(mob/living/carbon/C, mob/M, latejoin = FALSE)
	. = ..()
	ADD_TRAIT(C, TRAIT_RESEARCHER, "[type]")

//Doctor
/datum/job/eastvietzhuan/doctor
	title = "East Vietzhuan Doctor"
	skills_type = /datum/skills/civilian/survivor/doctor
	outfit = /datum/outfit/job/eastvietzhuan/doctor

//Liaison
/datum/job/eastvietzhuan/liaison
	title = "East Vietzhuan East"
	outfit = /datum/outfit/job/eastvietzhuan/liaison

//Security Guard
/datum/job/eastvietzhuan/security
	title = "East Vietzhuan Security Guard"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_MARINE_BRIG, ACCESS_ICC_SECURITY, ACCESS_ICC_CARGO)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_MARINE_BRIG, ACCESS_ICC_SECURITY, ACCESS_ICC_CARGO)
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/eastvietzhuan/security

//Civilian
/datum/job/eastvietzhuan/civilian
	title = "East Vietzhuan Civilian"
	outfit = /datum/outfit/job/eastvietzhuan/civilian

//Chef
/datum/job/eastvietzhuan/chef
	title = "East Vietzhuan Chef"
	skills_type = /datum/skills/civilian/survivor/chef
	outfit = /datum/outfit/job/eastvietzhuan/chef

//Botanist
/datum/job/eastvietzhuan/botanist
	title = "East Vietzhuan Botanist"
	outfit = /datum/outfit/job/eastvietzhuan/botanist

//Technician
/datum/job/eastvietzhuan/technician
	title = "East Vietzhuan Technician"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/eastvietzhuan/technician

//Monk
/datum/job/eastvietzhuan/monk
	title = "East Vietzhuan Monk"
	outfit = /datum/outfit/job/eastvietzhuan/monk

//Miner
/datum/job/eastvietzhuan/miner
	title = "East Vietzhuan Miner"
	skills_type = /datum/skills/civilian/survivor/miner
	outfit = /datum/outfit/job/eastvietzhuan/miner

//Merchant
/datum/job/eastvietzhuan/merchant
	title = "East Vietzhuan Merchant"
	outfit = /datum/outfit/job/eastvietzhuan/merchant

//Watchman
/datum/job/eastvietzhuan/watchman
	title = "East Vietzhuan Watchman"
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/eastvietzhuan/watchman

//Bartender
/datum/job/eastvietzhuan/bartender
	title = "East Vietzhuan Bartender"
	outfit = /datum/outfit/job/eastvietzhuan/bartender

//Drug Dealer
/datum/job/eastvietzhuan/drugdealer
	title = "East Vietzhuan Drug Dealer"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/eastvietzhuan/drugdealer

//Profiteer
/datum/job/eastvietzhuan/profiteer
	title = "East Vietzhuan Profiteer"
	outfit = /datum/outfit/job/eastvietzhuan/profiteer

//Guitarist
/datum/job/eastvietzhuan/guitarist
	title = "East Vietzhuan Guitarist"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/eastvietzhuan/guitarist

// Vietzhong - East Vietzhuo survivors of the Vietzhuo-8 revolution
/datum/job/eastvietzhuan/vietzhong
	title = "East Vietzhuan Vietzhong"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/eastvietzhuan/vietzhong
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN
