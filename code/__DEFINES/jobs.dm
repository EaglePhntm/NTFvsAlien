#define SSJOB_OVERRIDE_JOBS_START (1<<0)

#define JOB_DISPLAY_ORDER_DEFAULT 0

#define JOB_DISPLAY_ORDER_XENO_QUEEN 1
#define JOB_DISPLAY_ORDER_XENOMORPH 2
#define JOB_DISPLAY_ORDER_CAPTAIN 3
#define JOB_DISPLAY_ORDER_EXECUTIVE_OFFICER 4
#define JOB_DISPLAY_ORDER_CORPSEC_COMMANDER 5
#define JOB_DISPLAY_ORDER_STAFF_OFFICER 6
#define JOB_DISPLAY_ORDER_PILOT_OFFICER 7
#define JOB_DISPLAY_ORDER_MECH_PILOT 8
#define JOB_DISPLAY_ORDER_CHIEF_EXECUTIVE_OFFICER 9
#define JOB_DISPLAY_ORDER_CORPORATE_LIAISON 10
#define JOB_DISPLAY_ORDER_SYNTHETIC 11
#define JOB_DISPLAY_ORDER_AI 12
#define JOB_DISPLAY_ORDER_TRANSPORT_OFFICER 13
#define JOB_DISPLAY_ORDER_CHIEF_ENGINEER 14
#define JOB_DISPLAY_ORDER_SHIP_TECH 15
#define JOB_DISPLAY_ORDER_REQUISITIONS_OFFICER 17
#define JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER 18
#define JOB_DISPLAY_ORDER_DOCTOR 19
#define JOB_DISPLAY_ORDER_MEDICAL_RESEARCHER 20
#define JOB_DISPLAY_ORDER_SQUAD_LEADER 21
#define JOB_DISPLAY_ORDER_SQUAD_SMARTGUNNER 22
#define JOB_DISPLAY_ORDER_SQUAD_CORPSMAN 23
#define JOB_DISPLAY_ORDER_SUQAD_ENGINEER 24
#define JOB_DISPLAY_ORDER_SQUAD_SPECIALIST 25
#define JOB_DISPLAY_ORDER_SQUAD_MARINE 26
#define JOB_DISPLAY_ORDER_SQUAD_SLUT 27
#define JOB_DISPLAY_ORDER_SURVIVOR 28
#define JOB_DISPLAY_ORDER_SECURITY_OFFICER 29
#define JOB_DISPLAY_ORDER_PRISONER 30
#define JOB_DISPLAY_ORDER_MOFFS 31

#define JOB_FLAG_SPECIALNAME (1<<0)
#define JOB_FLAG_LATEJOINABLE (1<<1) //Can this job be selected for prefs to join as?
#define JOB_FLAG_ROUNDSTARTJOINABLE (1<<2) //Joinable at roundstart
#define JOB_FLAG_NOHEADSET (1<<3) //Doesn't start with a headset on spawn.
#define JOB_FLAG_ALLOWS_PREFS_GEAR (1<<4) //Allows preference loadouts.
#define JOB_FLAG_PROVIDES_BANK_ACCOUNT (1<<5) //$$$
#define JOB_FLAG_OVERRIDELATEJOINSPAWN (1<<6) //AIs and xenos, for example.
#define JOB_FLAG_ADDTOMANIFEST (1<<7) //Add info to datacore.
#define JOB_FLAG_ISCOMMAND (1<<8)
#define JOB_FLAG_BOLD_NAME_ON_SELECTION (1<<9)
#define JOB_FLAG_PROVIDES_SQUAD_HUD (1<<10)
#define JOB_FLAG_HIDE_CURRENT_POSITIONS (1<<11) //You can't see how many people have joined as on the latejoin menu.
#define JOB_FLAG_CAN_SEE_ORDERS (1<<12) //Able to see rally and CIC orders
#define JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP (1<<13) //Will appear on all minimaps, including squad minimaps
#define JOB_FLAG_SHOW_OPEN_POSITIONS (1<<14) //You can only see how many positions are opened, and not how many positions are fullfilled
/// Job has a TTS volume bonus
#define JOB_FLAG_LOUDER_TTS (1<<15)

#define CAPTAIN "Commander"
#define EXECUTIVE_OFFICER "Executive Officer" //Currently disabled.
#define FIELD_COMMANDER "Field Commander"
#define CORPSEC_COMMANDER "Corpsec Commander"
#define STAFF_OFFICER "Staff Officer"
#define TRANSPORT_OFFICER "Transport Officer"
#define PILOT_OFFICER "Pilot Officer"
#define MECH_PILOT "Mech Pilot"
#define ASSAULT_CREWMAN "Assault Crewman"
#define TRANSPORT_CREWMAN "Transport Crewman"
#define REQUISITIONS_OFFICER "Requisitions Officer"
#define CHIEF_SHIP_ENGINEER "Chief Ship Engineer"
#define CHIEF_MEDICAL_OFFICER "Chief Medical Officer"
#define SECURITY_OFFICER "CorpSec Officer"
#define CHIEF_EXECUTIVE_OFFICER "Chief Executive Officer"
#define CORPORATE_LIAISON "Operations Officer"
#define SYNTHETIC "Synthetic"
#define SHIP_TECH "Ship Technician"
#define MEDICAL_DOCTOR "Medical Doctor"
#define MEDICAL_RESEARCHER "Medical Researcher"
#define SQUAD_LEADER "Squad Leader"
#define VANGUARD "Vanguard Unit"
#define SQUAD_SPECIALIST "Specialist Operative"
#define SQUAD_SMARTGUNNER "Squad Smartgunner"
#define SQUAD_CORPSMAN "Squad Corpsman"
#define SQUAD_ENGINEER "Squad Engineer"
#define SQUAD_MARINE "Squad Operative"
#define SQUAD_SLUT "Squad Slut"
#define SQUAD_ROBOT "Squad Robot"
#define SQUAD_VATGROWN "Squad VatGrown"
#define SILICON_AI "AI"
#define PMC_STANDARD "PMC Standard"
#define PMC_MEDIC "PMC Medic"
#define PMC_ENGINEER "PMC Engineer"
#define PMC_GUNNER "PMC Gunner"
#define PMC_SNIPER "PMC Specialist"
#define PMC_LEADER "PMC Squad Leader"

//ICC

#define ICC_STANDARD "CM Standard"
#define ICC_GUARD "CM Guardsman"
#define ICC_MEDIC "CM Medic"
#define ICC_SQUAD_LEADER "CM Squad Leader"

//SOM
#define SOM_COMMANDER "SOM Commander"
#define SOM_FIELD_COMMANDER "SOM Field Commander"
#define SOM_STAFF_OFFICER "SOM Staff Officer"
#define SOM_PILOT_OFFICER "SOM Pilot Officer"
#define SOM_MECH_PILOT "SOM Mech Pilot"
#define SOM_ASSAULT_CREWMAN "SOM Assault Crewman"
#define SOM_REQUISITIONS_OFFICER "SOM Requisitions Officer"
#define SOM_CHIEF_ENGINEER "SOM Chief Engineer"
#define SOM_CHIEF_MEDICAL_OFFICER "SOM Chief Medical Officer"
#define SOM_TECH "SOM Technician"
#define SOM_MEDICAL_DOCTOR "SOM Medical Doctor"
#define SOM_CHEF "SOM Chef"

#define SOM_SQUAD_LEADER "SOM Squad Leader"
#define SOM_SQUAD_CORPSMAN "SOM Squad Medic"
#define SOM_SQUAD_ENGINEER "SOM Squad Engineer"
#define SOM_SQUAD_VETERAN "SOM Squad Veteran"
#define SOM_SQUAD_MARINE "SOM Squad Standard"
#define SOM_SQUAD_SLUT "SOM Squad Slut"

// VSD
#define VSD_STANDARD "KZ Standard"
#define VSD_ENGINEER "KZ Engineer"
#define VSD_MEDIC "KZ Medic"
#define VSD_SPECIALIST "KZ Specialist"
#define VSD_LEADER "KZ Squad Leader"

#define JOB_CAT_COMMAND "Command"
#define JOB_CAT_SILICON "Silicon"
#define JOB_CAT_REQUISITIONS "Requisitions"
#define JOB_CAT_MEDICAL "Medical"
#define JOB_CAT_ENGINEERING "Engineering"
#define JOB_CAT_CIVILIAN "Civilian"
#define JOB_CAT_MARINE "Military"
#define JOB_CAT_XENO "Xenomorph"
#define JOB_CAT_UNASSIGNED "Unassigned"
#define JOB_CAT_PMC "Private Military Company"
#define JOB_CAT_VSD "Kaizoku Corporation"

#define JOB_CAT_COMMANDSOM "SOM Command"
#define JOB_CAT_MARINESOM "Sons of Mars"
#define JOB_CAT_REQUISITIONSSOM "SOM Requisitions"
#define JOB_CAT_MEDICALSOM "SOM Medical"
#define JOB_CAT_ENGINEERINGSOM "SOM Engineering"

#define JOB_COMM_TITLE_SQUAD_LEADER "SL"

#define ROLE_XENOMORPH "Xenomorph"
#define ROLE_XENO_QUEEN "Xeno Queen"
#define ROLE_ERT "Emergency Response Team"
#define ROLE_VALHALLA "Valhalla"

#define ROLE_FALLEN(role) ("Fallen " + ##role)

GLOBAL_LIST_EMPTY(jobs_command)
GLOBAL_LIST_INIT(jobs_officers, list(CAPTAIN, EXECUTIVE_OFFICER, CHIEF_EXECUTIVE_OFFICER, FIELD_COMMANDER, CORPSEC_COMMANDER, STAFF_OFFICER, PILOT_OFFICER, TRANSPORT_OFFICER, MECH_PILOT, ASSAULT_CREWMAN, TRANSPORT_CREWMAN, CORPORATE_LIAISON, SYNTHETIC, SILICON_AI))
GLOBAL_LIST_INIT(jobs_support, list(PILOT_OFFICER, TRANSPORT_OFFICER, MECH_PILOT, REQUISITIONS_OFFICER, SYNTHETIC, SILICON_AI))
GLOBAL_LIST_INIT(jobs_engineering, list(CHIEF_SHIP_ENGINEER, SHIP_TECH, SOM_CHIEF_ENGINEER, SOM_TECH))
GLOBAL_LIST_INIT(jobs_requisitions, list(REQUISITIONS_OFFICER, SOM_REQUISITIONS_OFFICER))
GLOBAL_LIST_INIT(jobs_medical, list(CHIEF_MEDICAL_OFFICER, MEDICAL_DOCTOR, MEDICAL_RESEARCHER, SOM_CHIEF_MEDICAL_OFFICER, SOM_MEDICAL_DOCTOR))
GLOBAL_LIST_INIT(jobs_marines, list(SECURITY_OFFICER, SQUAD_LEADER, SQUAD_SPECIALIST, SQUAD_SMARTGUNNER, SQUAD_CORPSMAN, SQUAD_ENGINEER, SQUAD_MARINE, SQUAD_SLUT, PMC_MEDIC, PMC_ENGINEER, PMC_GUNNER, PMC_STANDARD, PMC_SNIPER, PMC_LEADER))
GLOBAL_LIST_INIT(jobs_som, list(SOM_SQUAD_MARINE, SOM_SQUAD_VETERAN, SOM_SQUAD_ENGINEER, SOM_SQUAD_CORPSMAN, SOM_SQUAD_LEADER, , SOM_STAFF_OFFICER, SOM_COMMANDER, SOM_SQUAD_SLUT, SOM_PILOT_OFFICER, SOM_MECH_PILOT, SOM_REQUISITIONS_OFFICER, SOM_CHIEF_MEDICAL_OFFICER, SOM_TECH, SOM_MEDICAL_DOCTOR, SOM_CHEF))
GLOBAL_LIST_INIT(jobs_regular_all, list(CAPTAIN, EXECUTIVE_OFFICER, SECURITY_OFFICER, CHIEF_EXECUTIVE_OFFICER, FIELD_COMMANDER, CORPSEC_COMMANDER, STAFF_OFFICER, PILOT_OFFICER, TRANSPORT_OFFICER, MECH_PILOT, REQUISITIONS_OFFICER, CHIEF_SHIP_ENGINEER, \
CHIEF_MEDICAL_OFFICER, SYNTHETIC, SILICON_AI, CORPORATE_LIAISON, SHIP_TECH, ASSAULT_CREWMAN, TRANSPORT_CREWMAN, \
MEDICAL_DOCTOR, MEDICAL_RESEARCHER, SQUAD_LEADER, SQUAD_SPECIALIST, SQUAD_SMARTGUNNER, SQUAD_CORPSMAN, SQUAD_ENGINEER, SQUAD_MARINE, SQUAD_SLUT, SQUAD_ROBOT, SQUAD_VATGROWN, \
SOM_SQUAD_SLUT, SOM_SQUAD_MARINE, SOM_SQUAD_VETERAN, SOM_SQUAD_ENGINEER, SOM_SQUAD_CORPSMAN, SOM_SQUAD_LEADER, SOM_CHEF, SOM_MEDICAL_DOCTOR, SOM_TECH, SOM_CHIEF_MEDICAL_OFFICER, SOM_CHIEF_ENGINEER, SOM_REQUISITIONS_OFFICER, SOM_MECH_PILOT, SOM_PILOT_OFFICER, SOM_ASSAULT_CREWMAN, SOM_FIELD_COMMANDER, SOM_STAFF_OFFICER, SOM_COMMANDER, \
PMC_MEDIC, PMC_ENGINEER, PMC_GUNNER, PMC_STANDARD, PMC_SNIPER, PMC_LEADER))
GLOBAL_LIST_INIT(jobs_xenos, list(ROLE_XENOMORPH, ROLE_XENO_QUEEN))
GLOBAL_LIST_INIT(jobs_fallen_marine, typecacheof(list(/datum/job/fallen/marine), TRUE))
///Squad type role, regardless of faction
GLOBAL_LIST_INIT(jobs_squad_roles, list(SQUAD_LEADER, SQUAD_SMARTGUNNER, SQUAD_CORPSMAN, SQUAD_ENGINEER, SQUAD_MARINE, SOM_SQUAD_MARINE, SOM_SQUAD_VETERAN, SOM_SQUAD_ENGINEER, SOM_SQUAD_CORPSMAN, SOM_SQUAD_LEADER))

///Is an SL type job
GLOBAL_LIST_INIT(jobs_squad_leader, list(SQUAD_LEADER, SOM_SQUAD_LEADER))
///Is a corpsman type job
GLOBAL_LIST_INIT(jobs_squad_corpsman, list(SQUAD_CORPSMAN, SOM_SQUAD_CORPSMAN))
///Is a engineer type job
GLOBAL_LIST_INIT(jobs_squad_engineer, list(SQUAD_ENGINEER, SOM_SQUAD_ENGINEER))
///Is a specialist type job
GLOBAL_LIST_INIT(jobs_squad_specialist, list(SQUAD_SMARTGUNNER, SOM_SQUAD_VETERAN))
///Is a squad standard type job
GLOBAL_LIST_INIT(jobs_squad_standard, list(SQUAD_MARINE, SOM_SQUAD_MARINE))

//Playtime tracking system, see jobs_exp.dm
#define EXP_TYPE_LIVING "Living"
#define EXP_TYPE_REGULAR_ALL "Human"
#define EXP_TYPE_COMMAND "Command"
#define EXP_TYPE_ENGINEERING "Engineering"
#define EXP_TYPE_MEDICAL "Medical"
#define EXP_TYPE_MARINES "Marines"
#define EXP_TYPE_REQUISITIONS "Requisitions"
#define EXP_TYPE_SILICON "Silicon"
#define EXP_TYPE_SPECIAL "Special"
#define EXP_TYPE_GHOST "Ghost"
#define EXP_TYPE_ADMIN "Admin"

// hypersleep bay flags
#define CRYO_MED "Medical"
#define CRYO_ENGI "Engineering"
#define CRYO_REQ "Requisitions"
#define CRYO_ALPHA "Alpha Squad"
#define CRYO_BRAVO "Bravo Squad"
#define CRYO_CHARLIE "Charlie Squad"
#define CRYO_DELTA "Delta Squad"


#define XP_REQ_UNSEASONED 60
#define XP_REQ_INTERMEDIATE 180
#define XP_REQ_EXPERIENCED 600
#define XP_REQ_EXPERT 900

// how much a job is going to contribute towards burrowed larva. see config for points required to larva. old balance was 1 larva per 3 humans.
#define LARVA_POINTS_SHIPSIDE 1
#define LARVA_POINTS_SHIPSIDE_STRONG 1.5
#define LARVA_POINTS_REGULAR 3.25
///How many marines per xeno at optimal ratio
#define XENO_MARINE_RATIO 2.46

#define SURVIVOR_POINTS_REGULAR 1

#define SMARTIE_POINTS_REGULAR 1
#define SMARTIE_POINTS_MEDIUM 2
#define SMARTIE_POINTS_HIGH 3
#define SYNTH_POINTS_REGULAR 1
#define MECH_POINTS_REGULAR 1

#define VETERAN_POINTS_REGULAR 1

#define MARINE_SPAWN_ORIGIN "xenos from marine spawn"
#define PSY_DRAIN_ORIGIN "xenos from psy drained bodies"
#define COCOON_ORIGIN "xenos from cocoon that reached its endlife"
#define SILO_ORIGIN "xenos from silo generation"

#define SQUAD_MAX_POSITIONS(total_positions) CEILING(total_positions / length(SSjob.active_squads), 1)

/// How many points a marine can spend in job specific vendors by default
#define DEFAULT_TOTAL_BUY_POINTS 45
/// How many points a medic can spend on pills
#define MEDIC_TOTAL_BUY_POINTS 45
/// How many points an engineer can spend
#define ENGINEER_TOTAL_BUY_POINTS 75
/// How many points the field commander can spend
#define COMMANDER_TOTAL_BUY_POINTS 45

GLOBAL_LIST_INIT(default_marine_points, list(
		"STANDARD SUPPLIES" = DEFAULT_TOTAL_BUY_POINTS,
		"SMARTGUNNER SUPPLIES" = DEFAULT_TOTAL_BUY_POINTS,
		"ENGINEERING SUPPLIES" = ENGINEER_TOTAL_BUY_POINTS,
		"LEADER SUPPLIES" = DEFAULT_TOTAL_BUY_POINTS,
		"MEDICAL SUPPLIES" = MEDIC_TOTAL_BUY_POINTS,
		"SPECIALIST SUPPLIES" = DEFAULT_TOTAL_BUY_POINTS,
		"COMMANDER SUPPLIES" = COMMANDER_TOTAL_BUY_POINTS,
	))
