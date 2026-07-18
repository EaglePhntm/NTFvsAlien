/datum/game_mode/infestation/secret_of_life/alienonly/whiskey_outpost
	name = "Whiskey Outpost"
	config_tag = "Whiskey Outpost"
	whitelist_ship_maps = list(MAP_EAGLE_CLASSIC)
	whitelist_ground_maps = list(MAP_WHISKEY_OUTPOST)
	valid_job_types = list(
		/datum/job/terragov/command/captain = 1,
		/datum/job/terragov/command/fieldcommander = 1,
		/datum/job/terragov/command/staffofficer = 2,
		/datum/job/terragov/command/vanguard = 2,
		/datum/job/terragov/engineering/chief = 1,
		/datum/job/terragov/engineering/tech = 2,
		/datum/job/terragov/requisitions/officer = 2,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/medical/medicalofficer = 3,
		/datum/job/terragov/silicon/synthetic = 4,
		/datum/job/terragov/silicon/ai = 1,
		/datum/job/terragov/squad/engineer = 4,
		/datum/job/terragov/squad/corpsman = 4,
		/datum/job/terragov/squad/smartgunner = 4,
		/datum/job/terragov/squad/leader = 4,
		/datum/job/terragov/squad/specialist = 4,
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/slut = -1,
		/datum/job/xenomorph = 5,
		/datum/job/xenomorph/queen = 1,
	)

	respawn_time = 90 SECONDS
	randomize_miners = FALSE
	round_type_flags2 = MODE_2_CHILL_RULES

/datum/game_mode/infestation/secret_of_life/alienonly/whiskey_outpost/generate_nuke_disk_spawners()
	return //Just skip it.  They're not needed and the map's a bit small to fit the computers.
