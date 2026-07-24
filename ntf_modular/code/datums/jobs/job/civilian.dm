GLOBAL_LIST_INIT(civindep_npc_jobs, typecacheof(/datum/job/civindep/west))
GLOBAL_LIST_INIT(eastvietzhuan_npc_jobs, typecacheof(/datum/job/civindep/eastvietzhuan))
GLOBAL_LIST_EMPTY(spawn_civneutral)
GLOBAL_LIST_EMPTY(spawn_evzcivneutral)

//example that should work prolly, use for viet too just change jobs n shit.
/obj/effect/landmark/spawn_marker/civilian
	name = "MAPPER DONT USE THIS, USE CHILD TYPES"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x2"
	var/datum/job/civindep/occupation = /datum/job/civindep

/obj/effect/landmark/spawn_marker/civilian/random
	name = "Random civilian spawner"

/obj/effect/landmark/spawn_marker/civilian/random/Initialize(mapload)
	occupation = pick(GLOB.civindep_npc_jobs)
	. = ..()

/obj/effect/landmark/spawn_marker/civilian/proc/trigger_now()
	occupation = SSjob.GetJobType(occupation) //get true job type ig
	var/mob/living/carbon/human/new_human = new(loc)
	new_human.apply_assigned_role_to_spawn(occupation, new_human.client, admin_action = TRUE)
	switch(occupation.npc_type)
		if("normal")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/civilian) //not monkey business
		if("doctor")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/civilian/doctor)
		if("engineer")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/civilian/engineer)
	qdel(src)

/obj/effect/landmark/spawn_marker/civilian/Initialize(mapload)
	. = ..()
	GLOB.spawn_civneutral += src

/obj/effect/landmark/spawn_marker/civilian/doctor
	name = "doctor spawner"
	occupation = /datum/job/civindep/west/doctor

/obj/effect/landmark/spawn_marker/civilian/atmos
	name = "technician spawner"
	occupation = /datum/job/civindep/west/atmos

/obj/effect/landmark/spawn_marker/civilian/nationaldefense
	name = "national defense spawner"
	occupation = /datum/job/civindep/west/nationaldefense

/datum/job/civindep // not a job meant for players, but rather AI civilians who roam the map
	title = "Generic Civilian"
	var/npc_type = "normal" //normal, doctor, engineer, nationaldefense (for ai)
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN
	job_category = JOB_CAT_SURVIVOR
	skills_type = /datum/skills/civilian/survivor
	total_positions = -1
	display_order = JOB_DISPLAY_ORDER_SURVIVOR

/datum/job/civindep/west

	supervisors = "anyone who might rescue you, Colonial Militia"
	paygrade = "CLNST"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_ICC_CARGO)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_ICC_CARGO)
	faction = FACTION_ICC //closer to cm now

//Assistant
/datum/job/civindep/west/assistant
	title = "Assistant Colonist"
	outfit = /datum/outfit/job/civindep/assistant

//Scientist
/datum/job/civindep/west/scientist
	title = "Scientist Colonist"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/civindep/scientist

/datum/job/civindep/west/scientist/after_spawn(mob/living/carbon/C, mob/M, latejoin = FALSE)
	. = ..()
	ADD_TRAIT(C, TRAIT_RESEARCHER, "[type]")

//Doctor
/datum/job/civindep/west/doctor
	title = "Doctor Colonist"
	skills_type = /datum/skills/civilian/survivor/doctor
	outfit = /datum/outfit/job/civindep/doctor
	npc_type = "doctor"

//Liaison
/datum/job/civindep/west/officeworker
	title = "Office Worker Colonist"
	outfit = /datum/outfit/job/civindep/officeworker

//Liaison
/datum/job/civindep/west/liaison
	title = "Liaison Colonist"
	outfit = /datum/outfit/job/civindep/liaison

//Security Guard
/datum/job/civindep/west/security
	title = "Security Guard Colonist"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_MARINE_BRIG, ACCESS_ICC_SECURITY, ACCESS_ICC_CARGO)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_MARINE_BRIG, ACCESS_ICC_SECURITY, ACCESS_ICC_CARGO)
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/civindep/security

//Civilian
/datum/job/civindep/west/civilian
	title = "Civilian Colonist"
	outfit = /datum/outfit/job/civindep/civilian

//Chef
/datum/job/civindep/west/chef
	title = "Chef Colonist"
	skills_type = /datum/skills/civilian/survivor/chef
	outfit = /datum/outfit/job/civindep/chef

//Botanist
/datum/job/civindep/west/botanist
	title = "Botanist Colonist"
	outfit = /datum/outfit/job/civindep/botanist

//Atmospherics Technician
/datum/job/civindep/west/atmos
	title = "Technician Colonist"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/civindep/atmos
	npc_type = "engineer"

//Chaplain
/datum/job/civindep/west/chaplain
	title = "Chaplain Colonist"
	outfit = /datum/outfit/job/civindep/chaplain

//Miner
/datum/job/civindep/west/miner
	title = "Miner Colonist"
	skills_type = /datum/skills/civilian/survivor/miner
	outfit = /datum/outfit/job/civindep/miner

//Salesman
/datum/job/civindep/west/salesman
	title = "Salesman Colonist"
	outfit = /datum/outfit/job/civindep/salesman

//Colonial Marshal
/datum/job/civindep/west/marshal
	title = "Colonial Marshal Colonist"
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/civindep/marshal

//Bartender Survivor
/datum/job/civindep/west/bartender
	title = "Bartender Colonist"
	outfit = /datum/outfit/job/civindep/bartender

//Chemist Survivor
/datum/job/civindep/west/chemist
	title = "Pharmacy Technician Colonist"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/civindep/chemist
	npc_type = "doctor"

//Assistant
/datum/job/civindep/west/assistant
	title = "Assistant Colonist"
	outfit = /datum/outfit/job/civindep/assistant

//Roboticist Survivor
/datum/job/civindep/west/roboticist
	title = "Roboticist Colonist"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/civindep/roboticist
	npc_type = "engineer"

// Rambo Survivor - pretty overpowered, pls spawn with caution
/datum/job/civindep/west/rambo
	title = "Rambo Colonist"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/civindep/rambo
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN

// National Guard - pretty overpowered, pls spawn with caution
/datum/job/civindep/west/nationaldefense
	title = "National Guard Colonist"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/civindep/nationaldefense
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN
