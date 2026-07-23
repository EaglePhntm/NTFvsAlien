GLOBAL_LIST_INIT(civindep_outfits, typecacheof(/datum/outfit/job/civindep))
GLOBAL_LIST_INIT(eastvietzhuan_outfits, typecacheof(/datum/outfit/job/eastvietzhuan))
GLOBAL_LIST_EMPTY(spawn_civneutral)
GLOBAL_LIST_EMPTY(spawn_evzcivneutral)

//example that should work prolly, use for viet too just change jobs n shit.
/obj/effect/landmark/spawn_marker/civilian
	name = "civilian spawner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x2"
	var/datum/job/occupation = /datum/job/civindep

/obj/effect/landmark/spawn_marker/civilian/random //for mappers

/obj/effect/landmark/spawn_marker/civilian/Initialize(mapload)
	. = ..()
	GLOB.spawn_civneutral += src

/obj/effect/landmark/spawn_marker/civilian/doctor
	name = "doctor spawner"
	occupation = /datum/job/civindep/doctor

/datum/job/civindep // not a job meant for players, but rather AI civilians who roam the map
	title = "Generic Civilian"
	supervisors = "anyone who might rescue you, Colonial Militia"
	paygrade = "CLNST"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_ICC_CARGO)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_ICC_CARGO)
	display_order = JOB_DISPLAY_ORDER_SURVIVOR
	faction = FACTION_ICC //closer to cm now
	total_positions = -1
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN
	job_category = JOB_CAT_SURVIVOR
	skills_type = /datum/skills/civilian/survivor
	var/occupation = "normal" //normal, doctor, engineer (for ai)

/datum/job/civindep/after_spawn(mob/living/carbon/spawned_carbon, mob/M, latejoin = FALSE)
	. = ..()
	if(ishuman(spawned_carbon))
		var/mob/living/carbon/human/shuman = spawned_carbon
		switch(occupation)
			if("normal")
				shuman.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/civilian) //not monkey business
			if("doctor")
				shuman.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/civilian/doctor)
			if("engineer")
				shuman.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/civilian/engineer)

//Assistant
/datum/job/civindep/assistant
	title = "Assistant Colonist"
	outfit = /datum/outfit/job/civindep/assistant

//Scientist
/datum/job/civindep/scientist
	title = "Scientist Colonist"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/civindep/scientist

/datum/job/civindep/scientist/after_spawn(mob/living/carbon/C, mob/M, latejoin = FALSE)
	. = ..()
	ADD_TRAIT(C, TRAIT_RESEARCHER, "[type]")

//Doctor
/datum/job/civindep/doctor
	title = "Doctor Colonist"
	skills_type = /datum/skills/civilian/survivor/doctor
	outfit = /datum/outfit/job/civindep/doctor
	occupation = "doctor"

//Liaison
/datum/job/civindep/officeworker
	title = "Office Worker Colonist"
	outfit = /datum/outfit/job/civindep/officeworker

//Liaison
/datum/job/civindep/liaison
	title = "Liaison Colonist"
	outfit = /datum/outfit/job/civindep/liaison

//Security Guard
/datum/job/civindep/security
	title = "Security Guard Colonist"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_MARINE_BRIG, ACCESS_ICC_SECURITY, ACCESS_ICC_CARGO)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_MARINE_BRIG, ACCESS_ICC_SECURITY, ACCESS_ICC_CARGO)
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/civindep/security

//Civilian
/datum/job/civindep/civilian
	title = "Civilian Colonist"
	outfit = /datum/outfit/job/civindep/civilian

//Chef
/datum/job/civindep/chef
	title = "Chef Colonist"
	skills_type = /datum/skills/civilian/survivor/chef
	outfit = /datum/outfit/job/civindep/chef

//Botanist
/datum/job/civindep/botanist
	title = "Botanist Colonist"
	outfit = /datum/outfit/job/civindep/botanist

//Atmospherics Technician
/datum/job/civindep/atmos
	title = "Technician Colonist"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/civindep/atmos
	occupation = "engineer"

//Chaplain
/datum/job/civindep/chaplain
	title = "Chaplain Colonist"
	outfit = /datum/outfit/job/civindep/chaplain

//Miner
/datum/job/civindep/miner
	title = "Miner Colonist"
	skills_type = /datum/skills/civilian/survivor/miner
	outfit = /datum/outfit/job/civindep/miner

//Salesman
/datum/job/civindep/salesman
	title = "Salesman Colonist"
	outfit = /datum/outfit/job/civindep/salesman

//Colonial Marshal
/datum/job/civindep/marshal
	title = "Colonial Marshal Colonist"
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/civindep/marshal

//Bartender Survivor
/datum/job/civindep/bartender
	title = "Bartender Colonist"
	outfit = /datum/outfit/job/civindep/bartender

//Chemist Survivor
/datum/job/civindep/chemist
	title = "Pharmacy Technician Colonist"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/civindep/chemist
	occupation = "doctor"

//Assistant
/datum/job/civindep/assistant
	title = "Assistant Colonist"
	outfit = /datum/outfit/job/civindep/assistant

//Roboticist Survivor
/datum/job/civindep/roboticist
	title = "Roboticist Colonist"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/civindep/roboticist
	occupation = "engineer"

// Rambo Survivor - pretty overpowered, pls spawn with caution
/datum/job/civindep/rambo
	title = "Rambo Colonist"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/civindep/rambo
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN
