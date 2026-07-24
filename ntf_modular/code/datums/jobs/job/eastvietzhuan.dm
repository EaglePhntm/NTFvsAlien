//viet
/obj/effect/landmark/spawn_marker/civilian/viet/random
	name = "sommie civilian spawner"
	occupation = /datum/job/civindep/eastvietzhuan

/obj/effect/landmark/spawn_marker/civilian/viet/random/Initialize(mapload)
	. = ..()
	occupation = pick(GLOB.eastvietzhuan_npc_jobs)

/obj/effect/landmark/spawn_marker/civilian/viet/doctor
	name = "sommie civilian doctor spawner"
	occupation = /datum/job/civindep/eastvietzhuan/doctor

/datum/job/civindep/eastvietzhuan // not a job meant for players, but rather AI civilians who roam the map
	title = "Generic East Vietzhuan"
	supervisors = "For anyone who cares enough, maybe SOM."
	paygrade = "CLNST"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS)
	faction = FACTION_SOM //SOM-aligned civilians

//Assistant
/datum/job/civindep/eastvietzhuan/villager
	title = "East Vietzhuan Villager"
	outfit = /datum/outfit/job/eastvietzhuan/villager

//Archaelogist
/datum/job/civindep/eastvietzhuan/archaelogist
	title = "East Vietzhuan Archaelogist"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/eastvietzhuan/archaelogist

/datum/job/civindep/eastvietzhuan/archaelogist/after_spawn(mob/living/carbon/C, mob/M, latejoin = FALSE)
	. = ..()
	ADD_TRAIT(C, TRAIT_RESEARCHER, "[type]")

//Doctor
/datum/job/civindep/eastvietzhuan/doctor
	title = "East Vietzhuan Doctor"
	skills_type = /datum/skills/civilian/survivor/doctor
	outfit = /datum/outfit/job/eastvietzhuan/doctor
	npc_type = "doctor"

//Liaison
/datum/job/civindep/eastvietzhuan/liaison
	title = "East Vietzhuan East"
	outfit = /datum/outfit/job/eastvietzhuan/liaison

//Security Guard
/datum/job/civindep/eastvietzhuan/security
	title = "East Vietzhuan Security Guard"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_MARINE_BRIG, ACCESS_ICC_SECURITY, ACCESS_ICC_CARGO)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_MARINE_BRIG, ACCESS_ICC_SECURITY, ACCESS_ICC_CARGO)
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/eastvietzhuan/security

//Civilian
/datum/job/civindep/eastvietzhuan/civilian
	title = "East Vietzhuan Civilian"
	outfit = /datum/outfit/job/eastvietzhuan/civilian

//Chef
/datum/job/civindep/eastvietzhuan/chef
	title = "East Vietzhuan Chef"
	skills_type = /datum/skills/civilian/survivor/chef
	outfit = /datum/outfit/job/eastvietzhuan/chef

//Botanist
/datum/job/civindep/eastvietzhuan/botanist
	title = "East Vietzhuan Botanist"
	outfit = /datum/outfit/job/eastvietzhuan/botanist

//Technician
/datum/job/civindep/eastvietzhuan/technician
	title = "East Vietzhuan Technician"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/eastvietzhuan/technician
	npc_type = "engineer"

//Monk
/datum/job/civindep/eastvietzhuan/monk
	title = "East Vietzhuan Monk"
	outfit = /datum/outfit/job/eastvietzhuan/monk

//Miner
/datum/job/civindep/eastvietzhuan/miner
	title = "East Vietzhuan Miner"
	skills_type = /datum/skills/civilian/survivor/miner
	outfit = /datum/outfit/job/eastvietzhuan/miner

//Merchant
/datum/job/civindep/eastvietzhuan/merchant
	title = "East Vietzhuan Merchant"
	outfit = /datum/outfit/job/eastvietzhuan/merchant

//Watchman
/datum/job/civindep/eastvietzhuan/watchman
	title = "East Vietzhuan Watchman"
	skills_type = /datum/skills/civilian/survivor/marshal
	outfit = /datum/outfit/job/eastvietzhuan/watchman

//Bartender
/datum/job/civindep/eastvietzhuan/bartender
	title = "East Vietzhuan Bartender"
	outfit = /datum/outfit/job/eastvietzhuan/bartender

//Drug Dealer
/datum/job/civindep/eastvietzhuan/drugdealer
	title = "East Vietzhuan Drug Dealer"
	skills_type = /datum/skills/civilian/survivor/scientist
	outfit = /datum/outfit/job/eastvietzhuan/drugdealer

//Profiteer
/datum/job/civindep/eastvietzhuan/profiteer
	title = "East Vietzhuan Profiteer"
	outfit = /datum/outfit/job/eastvietzhuan/profiteer

//Guitarist
/datum/job/civindep/eastvietzhuan/guitarist
	title = "East Vietzhuan Guitarist"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/eastvietzhuan/guitarist

// Vietzhong - East Vietzhuo survivors of the Vietzhuo-8 revolution
/datum/job/civindep/eastvietzhuan/vietzhong
	title = "East Vietzhuan Vietzhong"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/eastvietzhuan/vietzhong
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN
