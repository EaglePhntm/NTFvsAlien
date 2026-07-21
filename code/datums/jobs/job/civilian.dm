/datum/job/civilian // not a job meant for players, but rather AI civilians who roam the map
	title = "Generic Civilian"
	supervisors = "anyone who might rescue you, Colonial Militia"
	paygrade = "CLNST"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_ICC_CARGO)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_ICC_CARGO)
	display_order = JOB_DISPLAY_ORDER_SURVIVOR
	faction = FACTION_ICC //closer to cm now
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
You appreciate the support of Ninetails should you be rescued.
You are not hostile to NTC, nor you should oppose or disrupt their objective, unless an admin says otherwise.
If you find any other survivors in the area, cooperate with them to increase your chances of survival.
Depending on the job you've undertook, you may have additional skills to help others when needed.
Good luck, but do not expect to survive."}


//Assistant
/datum/job/civilian/assistant
	title = "Assistant Colonist"
	outfit = /datum/outfit/job/civilian/assistant

//Scientist
/datum/job/civilian/scientist
	title = "Scientist Colonist"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/civilian/scientist

/datum/job/civilian/scientist/after_spawn(mob/living/carbon/C, mob/M, latejoin = FALSE)
	. = ..()
	ADD_TRAIT(C, TRAIT_RESEARCHER, "[type]")

//Doctor
/datum/job/civilian/doctor
	title = "Doctor Colonist"
	skills_type = /datum/skills/civilian/survivor/doctor
	outfit = /datum/outfit/job/civilian/doctor

//Liaison
/datum/job/civilian/liaison
	title = "Liaison Colonist"
	outfit = /datum/outfit/job/civilian/liaison

//Security Guard
/datum/job/civilian/security
	title = "Security Guard Colonist"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_MARINE_BRIG, ACCESS_ICC_SECURITY, ACCESS_ICC_CARGO)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_MARINE_BRIG, ACCESS_ICC_SECURITY, ACCESS_ICC_CARGO)
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/civilian/security

//Civilian
/datum/job/civilian/civilian
	title = "Civilian Colonist"
	outfit = /datum/outfit/job/civilian/civilian

//Chef
/datum/job/civilian/chef
	title = "Chef Colonist"
	skills_type = /datum/skills/civilian/survivor/chef
	outfit = /datum/outfit/job/civilian/chef

//Botanist
/datum/job/civilian/botanist
	title = "Botanist Colonist"
	outfit = /datum/outfit/job/civilian/botanist


/datum/job/civilian/botanist
	title = "Botanist Colonist"

//Atmospherics Technician
/datum/job/civilian/atmos
	title = "Technician Colonist"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/civilian/atmos

//Chaplain
/datum/job/civilian/chaplain
	title = "Chaplain Colonist"
	outfit = /datum/outfit/job/civilian/chaplain

//Miner
/datum/job/civilian/miner
	title = "Miner Colonist"
	skills_type = /datum/skills/civilian/survivor/miner
	outfit = /datum/outfit/job/civilian/miner

//Salesman
/datum/job/civilian/salesman
	title = "Salesman Colonist"
	outfit = /datum/outfit/job/civilian/salesman

//Colonial Marshal
/datum/job/civilian/marshal
	title = "Colonial Marshal Colonist"
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/civilian/marshal

//Bartender Survivor
/datum/job/civilian/bartender
	title = "Bartender Colonist"
	outfit = /datum/outfit/job/civilian/bartender

//Chemist Survivor
/datum/job/civilian/chemist
	title = "Pharmacy Technician Colonist"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/civilian/chemist

//Assistant
/datum/job/civilian/assistant
	title = "Assistant Colonist"
	outfit = /datum/outfit/job/civilian/assistant

//Roboticist Survivor
/datum/job/civilian/roboticist
	title = "Roboticist Colonist"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/civilian/roboticist

// Rambo Survivor - pretty overpowered, pls spawn with caution
/datum/job/civilian/rambo
	title = "Rambo Colonist"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/civilian/rambo
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN
