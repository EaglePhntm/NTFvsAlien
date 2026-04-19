/datum/game_mode/infestation/secret_of_life/alienonly/whiskey_outpost
	name = "Whiskey Outpost"
	config_tag = "Whiskey Outpost"
	whitelist_ship_maps = list(MAP_EAGLE_CLASSIC)
	whitelist_ground_maps = list(MAP_WHISKEY_OUTPOST)
	respawn_time = 90 SECONDS
	randomize_miners = FALSE

/datum/game_mode/infestation/secret_of_life/alienonly/whiskey_outpost/generate_nuke_disk_spawners()
	return //Just skip it.  They're not needed and the map's a bit small to fit the computers.
