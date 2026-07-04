/datum/job/vsd_squad
	job_category =  JOB_CAT_VSD
	supervisors = "Kaizoku Corporation high command."
	selection_color = "#ffeeee"
	faction = FACTION_VSD
	minimap_icon = "pmc2"

/datum/job/vsd_squad/get_spawn_message_information(mob/M)
	. = ..()
	. += separator_hr("[span_role_header("<b>[title] Information</b>")]")
	. += {"You are trained loyal mercenaries of Kaizoku Corporation, though in company rumors are Kaizoku is backed by Yakuza Syndicate which nuked the Corporate Sector. Surely it is unbased else it would be disasterous.
Kaizoku is in the corporate council that leads Phantom City, or what's left of it for now. Therefore it shares a table with Ninetails and all the other megacorps, which makes it vital they play along to ensure survival and prosperity of the corporation.
and at the same time Kaizoku is pressured into playing along with SOM by their said similiarly powerful shareholder, Keep in mind your situation when choosing who to support when it is time, with enough justification you can get around accusations."}

//VSD Standard
/datum/job/vsd_squad/standard
	title = "KZ Standard"
	paygrade = "KZ1"
	comm_title = "JSGT"
	skills_type = /datum/skills/crafty
	access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_CARGO, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	minimal_access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_CARGO, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	display_order = JOB_DISPLAY_ORDER_SQUAD_MARINE
	total_positions = -1
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_OVERRIDELATEJOINSPAWN
	outfit = /datum/outfit/job/vsd_squad/standard
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/som/squad/veteran = VETERAN_POINTS_REGULAR,
	)

/datum/outfit/job/vsd_squad/standard
	name = "KZ Standard"
	jobtype = /datum/job/vsd_squad/standard

	id = /obj/item/card/id/dogtag
	ears = /obj/item/radio/headset/mainship/vsd

//VSD Engineer
/datum/job/vsd_squad/engineer
	title = "KZ Engineer"
	paygrade = "KZ3"
	comm_title = "SGM"
	skills_type = /datum/skills/combat_engineer
	access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_CARGO, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	minimal_access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_CARGO, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	display_order = JOB_DISPLAY_ORDER_SQUAD_MARINE
	total_positions = -1
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_OVERRIDELATEJOINSPAWN
	outfit = /datum/outfit/job/vsd_squad/engineer
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/som/squad/veteran = VETERAN_POINTS_REGULAR,
	)
	minimap_icon = "pmc2"

/datum/outfit/job/vsd_squad/engineer
	name = "KZ Engineer"
	jobtype = /datum/job/vsd_squad/engineer

	id = /obj/item/card/id/dogtag/engineer
	ears = /obj/item/radio/headset/mainship/vsd
	glasses = /obj/item/clothing/glasses/meson

//VSD Medic
/datum/job/vsd_squad/medic
	title = "KZ Medic"
	paygrade = "KZ2"
	comm_title = "SSGT"
	skills_type = /datum/skills/combat_medic
	access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_CARGO, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	minimal_access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_CARGO, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	display_order = JOB_DISPLAY_ORDER_SQUAD_MARINE
	total_positions = -1
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_OVERRIDELATEJOINSPAWN
	outfit = /datum/outfit/job/vsd_squad/medic
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/som/squad/veteran = VETERAN_POINTS_REGULAR,
	)
	minimap_icon = "pmc2"

/datum/outfit/job/vsd_squad/medic
	name = "KZ Medic"
	jobtype = /datum/job/vsd/medic

	id = /obj/item/card/id/dogtag/corpsman
	ears = /obj/item/radio/headset/mainship/vsd

//VSD Spec
/datum/job/vsd_squad/spec
	title = "KZ Specialist"
	paygrade = "KZ4"
	comm_title = "LT"
	skills_type = /datum/skills/specialist_vsd
	access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_SPECPREP, ACCESS_VSD_LEADPREP, ACCESS_VSD_CARGO, ACCESS_VSD_TADPOLE, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	minimal_access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_SPECPREP, ACCESS_VSD_LEADPREP, ACCESS_VSD_CARGO, ACCESS_VSD_TADPOLE, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	display_order = JOB_DISPLAY_ORDER_SQUAD_MARINE
	total_positions = 5
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_OVERRIDELATEJOINSPAWN
	outfit = /datum/outfit/job/vsd_squad/spec
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/som/squad/veteran = VETERAN_POINTS_REGULAR,
	)

/datum/outfit/job/vsd_squad/spec
	name = "KZ Specialist"
	jobtype = /datum/job/vsd_squad/spec

	id = /obj/item/card/id/dogtag/specialist
	ears = /obj/item/radio/headset/mainship/vsd

//VSD Squad Leader
/datum/job/vsd_squad/leader
	title = "KZ Squad Leader"
	paygrade = "KZ5"
	comm_title = "KZCOMM"
	skills_type = /datum/skills/sl/kz
	access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_LEADPREP, ACCESS_VSD_CARGO, ACCESS_VSD_TADPOLE, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	minimal_access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_LEADPREP, ACCESS_VSD_CARGO, ACCESS_VSD_TADPOLE, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	display_order = JOB_DISPLAY_ORDER_SQUAD_MARINE
	total_positions = 5
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_OVERRIDELATEJOINSPAWN
	outfit = /datum/outfit/job/vsd_squad/leader
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/som/squad/veteran = VETERAN_POINTS_REGULAR,
	)

/datum/outfit/job/vsd_squad/leader
	name = "KZ Squad Leader"
	jobtype = /datum/job/vsd_squad/leader

	id = /obj/item/card/id/dogtag/leader
	ears = /obj/item/radio/headset/mainship/vsd

//VSD Combat Escort
/datum/job/vsd_squad/escort
	title = "KZ Combat Escort"
	paygrade = "KZ4"
	comm_title = "LT"
	skills_type = /datum/skills/specialist_vsdescort
	access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_SPECPREP, ACCESS_VSD_LEADPREP, ACCESS_VSD_CARGO, ACCESS_VSD_TADPOLE, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	minimal_access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_SPECPREP, ACCESS_VSD_LEADPREP, ACCESS_VSD_CARGO, ACCESS_VSD_TADPOLE, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	display_order = JOB_DISPLAY_ORDER_SQUAD_MARINE
	total_positions = 2
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_OVERRIDELATEJOINSPAWN
	outfit = /datum/outfit/job/vsd_squad/escort
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/som/squad/veteran = VETERAN_POINTS_REGULAR,
	)

/datum/outfit/job/vsd_squad/escort
	name = "KZ Combat Escort"
	jobtype = /datum/job/vsd_squad/escort

	id = /obj/item/card/id/dogtag/specialist
	ears = /obj/item/radio/headset/mainship/vsd

/datum/job/vsd_squad/escort/get_spawn_message_information(mob/M)
	. = ..()
	. += separator_hr("[span_role_header("<b>[title] Information</b>")]")
	. += {"\nYou are a chosen elite of the Kaizoku Corporation, handpicked for your exceptional combat skills and unwavering loyalty. Protect Valuable Corporate Assets, Relieve pressure from the frontline troops deployed alongside you and broker deals with the factions planetside, especially if it means using your body!"}

//KZ Synthetic

/datum/job/vsd_squad/silicon/synthetic
	title = "KZ Synthetic"
	req_admin_notify = TRUE
	comm_title = "Syn"
	paygrade = "Mk.I"
	supervisors = "The Squad Leader, Liaison, Kaizoku Zaibatsu."
	total_positions = 1
	skills_type = /datum/skills/synthetic
	access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_SPECPREP, ACCESS_VSD_LEADPREP, ACCESS_VSD_CARGO, ACCESS_VSD_TADPOLE, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	minimal_access = list (ACCESS_VSD_PREP, ACCESS_VSD_MEDPREP, ACCESS_VSD_ENGPREP, ACCESS_VSD_SPECPREP, ACCESS_VSD_LEADPREP, ACCESS_VSD_CARGO, ACCESS_VSD_TADPOLE, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_SOM_MEDICAL)
	display_order = JOB_DISPLAY_ORDER_SYNTHETIC
	outfit = /datum/outfit/job/civilian/synthetic
	exp_requirements = XP_REQ_EXPERIENCED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_SPECIALNAME|JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
/* NTF removal
	job_points_needed = 40
*/
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE_STRONG,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/squad/specialist = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Soul Crushing<br /><br />
		<b>You answer to the</b> acting Command Staff and the human crew<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Crash, Nuclear War<br /><br /><br />
		<b>Duty</b>: Support and assist in every department of Kaizoku Zaibatsu, use your incredibly developed skills to help the mercenaries during their missions.
	"}
	minimap_icon = "synth"

/datum/outfit/job/vsd_squad/silicon/synthetic
	name = SYNTHETIC
	jobtype = /datum/job/vsd_squad/silicon/synthetic

	id = /obj/item/card/id/dogtag/specialist
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/mainship/vsd
	w_uniform = /obj/item/clothing/under/rank/synthetic
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/insulated
	r_pocket = /obj/item/storage/pouch/general/medium
	l_pocket = /obj/item/storage/pouch/general/medium

/datum/job/vsd_squad/silicon/synthetic/get_special_name(client/preference_source)
	return preference_source.prefs.synthetic_name

/datum/job/vsd_squad/silicon/synthetic/special_check_latejoin(client/C)
	. = ..()
	if(!.)
		return FALSE
	for(var/mob/living/carbon/human/human AS in GLOB.alive_human_list)
		if(human.job?.type == type)
			to_chat(C, span_warning("The ship already has a Synthetic."))
			return FALSE
	return TRUE

/datum/job/vsd_squad/silicon/synthetic/return_spawn_type(datum/preferences/prefs)
	if(prefs?.synthetic_type == "Early Synthetic")
		return /mob/living/carbon/human/species/early_synthetic
	if(prefs?.synthetic_type == "Robot")
		return /mob/living/carbon/human/species/robot
	return /mob/living/carbon/human/species/synthetic

/datum/job/vsd_squad/silicon/synthetic/return_skills_type(datum/preferences/prefs)
	if(prefs?.synthetic_type == "Early Synthetic")
		return /datum/skills/early_synthetic
	return ..()

/datum/job/vsd_squad/silicon/synthetic/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	ADD_TRAIT(new_mob, TRAIT_RESEARCHER, "[type]")
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // starting
			new_human.wear_id.paygrade = "Mk.I"
		if(601 to 1500) // 10hrs
			new_human.wear_id.paygrade = "Mk.II"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "Mk.III"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "Mk.IV"
		if(18001 to INFINITY) // 300 hrs
			new_human.wear_id.paygrade = "Mk.V"
	new_human.wear_id.update_label()

/datum/job/vsd_squad/silicon/synthetic/get_spawn_message_information(mob/M)
	. = ..()
	. += separator_hr("[span_role_header("<b>[title] Information</b>")]")
	. += "Your primary job is to support and assist all KZ departments and personnel on-board. \
		In addition, being a Synthetic gives you knowledge in every field and specialization possible on-board the ship."
