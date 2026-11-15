GLOBAL_LIST_INIT(g16separatism_npc_jobs, typecacheof(/datum/job/g16separatism/union))
GLOBAL_LIST_EMPTY(spawn_eusmilitia)

//example that should work prolly, use for union too just change jobs n shit.
/obj/effect/landmark/spawn_marker/euseparatists
	var/datum/job/g16separatism/occupation = /datum/job/g16separatism

/obj/effect/landmark/spawn_marker/euseparatists/random
	name = "Random separatist spawner"

/obj/effect/landmark/spawn_marker/euseparatists/random/Initialize(mapload)
	occupation = pick(GLOB.g16separatism_npc_jobs)
	. = ..()

/obj/effect/landmark/spawn_marker/euseparatists/proc/trigger_now()
	occupation = SSjob.GetJobType(occupation) //get true job type ig
	var/mob/living/carbon/human/new_human = new(loc)
	new_human.apply_assigned_role_to_spawn(occupation, new_human.client, admin_action = TRUE)

	switch(occupation.npc_type)
		if("militant")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/g16separatism) //not monkey business
		if("medic")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/g16separatism/medic)
		if("sapper")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/g16separatism/sapper)
		if("deserter")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/g16separatism/deserter)
		if("advisor")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/g16separatism/advisor)
		if("idlemilitant")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/g16separatism/militantidle) //not monkey business
		if("idlemedic")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/g16separatism/medicidle)
		if("idlesapper")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/g16separatism/sapperidle)
		if("idledeserter")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/g16separatism/deserteridle)
		if("idleadvisor")
			new_human.AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/g16separatism/advisoridle)
	ADD_TRAIT(new_human, TRAIT_PSY_DRAINED, "union") //cant be used for larva or psydrain.
	ADD_TRAIT(new_human, TRAIT_MAPSPAWNED, "union")
	qdel(src)

/obj/effect/landmark/spawn_marker/euseparatists/Initialize(mapload)
	. = ..()
	GLOB.spawn_eusmilitia += src

/obj/effect/landmark/spawn_marker/euseparatists/militant
	name = "EUS militant spawner"
	occupation = /datum/job/g16separatism/union/militant

/obj/effect/landmark/spawn_marker/euseparatists/militantidle
	name = "EUS idle militant spawner"
	occupation = /datum/job/g16separatism/union/militantidle

/obj/effect/landmark/spawn_marker/euseparatists/medic
	name = "EUS medic spawner"
	occupation = /datum/job/g16separatism/union/medic

/obj/effect/landmark/spawn_marker/euseparatists/medicidle
	name = "EUS idle medic spawner"
	occupation = /datum/job/g16separatism/union/medicidle

/obj/effect/landmark/spawn_marker/euseparatists/sapper
	name = "EUS sapper spawner"
	occupation = /datum/job/g16separatism/union/sapper

/obj/effect/landmark/spawn_marker/euseparatists/sapperidle
	name = "EUS idle sapper spawner"
	occupation = /datum/job/g16separatism/union/sapperidle

/obj/effect/landmark/spawn_marker/euseparatists/deserter
	name = "EUS deserter spawner"
	occupation = /datum/job/g16separatism/union/deserter

/obj/effect/landmark/spawn_marker/euseparatists/deserteridle
	name = "EUS idle deserter spawner"
	occupation = /datum/job/g16separatism/union/deserteridle

/obj/effect/landmark/spawn_marker/euseparatists/advisorinfil
	name = "EUS advisor-infiltrator spawner"
	occupation = /datum/job/g16separatism/union/advisor/infiltrator

/obj/effect/landmark/spawn_marker/euseparatists/advisorrecon
	name = "EUS advisor-recon spawner"
	occupation = /datum/job/g16separatism/union/advisor/recon

/obj/effect/landmark/spawn_marker/euseparatists/advisorrifleman
	name = "EUS advisor-rifleman spawner"
	occupation = /datum/job/g16separatism/union/advisor/rifleman

/obj/effect/landmark/spawn_marker/euseparatists/advisorbreacher
	name = "EUS advisor-breacher spawner"
	occupation = /datum/job/g16separatism/union/advisor/breacher

/obj/effect/landmark/spawn_marker/euseparatists/advisorcommando
	name = "EUS advisor-commando spawner"
	occupation = /datum/job/g16separatism/union/advisor/commando

/obj/effect/landmark/spawn_marker/euseparatists/advisorpyro
	name = "EUS advisor-pyro spawner"
	occupation = /datum/job/g16separatism/union/advisor/firebat

/obj/effect/landmark/spawn_marker/euseparatists/advisormg
	name = "EUS advisor-mg spawner"
	occupation = /datum/job/g16separatism/union/advisor/machinegunner

/datum/job/g16separatism // not a job meant for players, but rather hostile AI who roam and guard the area
	title = "Generic EUS Supporter"
	var/npc_type = "militant" //normal, doctor, engineer, nationaldefense (for ai)
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN
	job_category = JOB_CAT_SURVIVOR
	skills_type = /datum/skills/civilian/survivor
	total_positions = -1
	display_order = JOB_DISPLAY_ORDER_SURVIVOR

/datum/job/g16separatism/union

	supervisors = "who knows? Could be your local union leader or the Russinian Domain advisor sent to train you."
	paygrade = "EUS"
	access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_ICC_CARGO)
	minimal_access = list(ACCESS_CIVILIAN_PUBLIC, ACCESS_CIVILIAN_RESEARCH, ACCESS_CIVILIAN_ENGINEERING, ACCESS_CIVILIAN_LOGISTICS, ACCESS_ICC_CARGO)
	faction = FACTION_HOSTILE //they don't want anybody

//EUS Militant, Low-End Grunts
/datum/job/g16separatism/union/militant
	title = "Separatist Militant"
	outfit = /datum/outfit/job/g16separatism/militant
	npc_type = "militant"
	paygrade = "EUS-MIL"

/datum/job/g16separatism/union/militantidle
	title = "Separatist Militant"
	outfit = /datum/outfit/job/g16separatism/militant
	npc_type = "idlemilitant"
	paygrade = "EUS-MIL"

//EUS Medic, Low-End Doctors
/datum/job/g16separatism/union/medic
	title = "Separatist Medic"
	skills_type = /datum/skills/civilian/survivor
	outfit = /datum/outfit/job/g16separatism/medic
	npc_type = "medic"
	paygrade = "EUS-MED"

/datum/job/g16separatism/union/medicidle
	title = "Separatist Medic"
	skills_type = /datum/skills/civilian/survivor
	outfit = /datum/outfit/job/g16separatism/medic
	npc_type = "idlemedic"
	paygrade = "EUS-MED"

//EUS Sapper, Separatist Technicians
/datum/job/g16separatism/union/sapper
	title = "Separatist Sapper"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/g16separatism/sapper
	npc_type = "sapper"
	paygrade = "EUS-ENG"

/datum/job/g16separatism/union/sapperidle
	title = "Separatist Sapper"
	skills_type = /datum/skills/civilian/survivor/atmos
	outfit = /datum/outfit/job/g16separatism/sapper
	npc_type = "idlesapper"
	paygrade = "EUS-ENG"

//EUS Deserter, Medium-Tier Infantry
/datum/job/g16separatism/union/deserter
	title = "Separatist Deserter"
	skills_type = /datum/skills/veteran
	outfit = /datum/outfit/job/g16separatism/deserter
	npc_type = "deserter"
	paygrade = "EUS-DSRTR"

/datum/job/g16separatism/union/deserteridle
	title = "Separatist Deserter"
	skills_type = /datum/skills/veteran
	outfit = /datum/outfit/job/g16separatism/deserter
	npc_type = "idledeserter"
	paygrade = "EUS-DSRTR"

// EUS Russinian Advisors - High-Tier Operators
/datum/job/g16separatism/union/advisor/infiltrator
	title = "Separatist Advisor Specop"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/g16separatism/advisor/infiltrator
	npc_type = "advisor"
	paygrade = "EUS-ADV"

/datum/job/g16separatism/union/advisor/recon
	title = "Separatist Advisor Recon"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/g16separatism/advisor/recon
	npc_type = "advisor"
	paygrade = "EUS-ADV"

/datum/job/g16separatism/union/advisor/rifleman
	title = "Separatist Advisor Rifleman"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/g16separatism/advisor/rifleman
	npc_type = "advisor"
	paygrade = "EUS-ADV"

/datum/job/g16separatism/union/advisor/breacher
	title = "Separatist Advisor Breacher"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/g16separatism/advisor/breacher
	npc_type = "advisor"
	paygrade = "EUS-ADV"

/datum/job/g16separatism/union/advisor/commando
	title = "Separatist Advisor Commando"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/g16separatism/advisor/commando
	npc_type = "advisor"
	paygrade = "EUS-ADV"

/datum/job/g16separatism/union/advisor/firebat
	title = "Separatist Advisor Flamethrower"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/g16separatism/advisor/firebat
	npc_type = "advisor"
	paygrade = "EUS-ADV"

/datum/job/g16separatism/union/advisor/machinegunner
	title = "Separatist Advisor Machinegunner"
	skills_type = /datum/skills/civilian/survivor/master
	outfit = /datum/outfit/job/g16separatism/advisor/machinegunner
	npc_type = "advisor"
	paygrade = "EUS-ADV"
