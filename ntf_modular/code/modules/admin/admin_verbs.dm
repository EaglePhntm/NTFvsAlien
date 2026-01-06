ADMIN_VERB(toggle_war_mode, R_ADMIN, "Toggle War Mode", "Toggles pop locks etc, use when war is happening.", ADMIN_CATEGORY_MAIN)
	if(istype(SSticker.mode, /datum/game_mode/infestation/extended_plus/secret_of_life))
		var/datum/game_mode/infestation/extended_plus/secret_of_life/gaymode = SSticker.mode
		gaymode.toggle_pop_locks()
	else
		to_chat(usr, span_notice("Need to be in SOL mode to toggle war mode."))

ADMIN_VERB(play_sound_to_faction, R_ADMIN, "Play Sound to Faction", "Plays a sound to a specific faction.", ADMIN_CATEGORY_FUN)
	var/sound_path = input(usr, "Enter the sound path to play (e.g. /sound/effects/alarm.ogg):", "Sound Path")
	if(!sound_path || sound_path == "")
		return
	var/faction_choice = input(usr, "Select a faction:", "Faction") as null|anything in SSticker.mode.factions
	if(!faction_choice)
		return
	for(var/mob/M AS in GLOB.alive_living_list)
		if(!isnewplayer(M) && M.faction == faction_choice && M.client)
			M.playsound_local(sound_path, 100, CHANNEL_ADMIN)

ADMIN_VERB(play_sound_to_all, R_ADMIN, "Play Sound to All", "Plays a sound to all players.", ADMIN_CATEGORY_FUN)
	var/sound_path = input(usr, "Enter the sound path to play (e.g. /sound/effects/alarm.ogg):", "Sound Path")
	if(!sound_path || sound_path == "")
		return
	for(var/mob/M AS in GLOB.alive_living_list)
		if(!isnewplayer(M) && M.client)
			M.playsound_local(sound_path, 100, CHANNEL_ADMIN)

ADMIN_VERB(play_warmode_action_music, R_ADMIN, "Quick-play War Music to Factions", "Plays each faction a random fitting music.", ADMIN_CATEGORY_FUN)
	for(var/faction_choice in SSticker.mode.factions)
		var/sound_path
		switch(faction_choice)
			if(FACTION_TERRAGOV||FACTION_ICC)
				sound_path = pick('ntf_modular/sound/music/war_mode/adminmusic/rock_and_awe_ra3.ogg')
			if(FACTION_SOM)
				sound_path = pick('ntf_modular/sound/music/war_mode/adminmusic/hell_march_ra3.ogg')
			if(FACTION_VSD)
				sound_path = pick('ntf_modular/sound/music/war_mode/adminmusic/hell_march_ra3.ogg')
			if(FACTION_XENO||FACTION_CLF)
				//sound_path = pick('ntf_modular/sound/music/war_mode/adminmusic/xeno_theme.ogg')
		if(!sound_path || sound_path == "")
			continue
		for(var/mob/M AS in GLOB.alive_living_list)
			if(!isnewplayer(M) && M.faction == faction_choice && M.client)
				M.playsound_local(sound_path, 100, CHANNEL_ADMIN)

ADMIN_VERB(stop_warmode_action_music, R_ADMIN, "Stop War Music to Factions", "Stops war action music for all factions.", ADMIN_CATEGORY_FUN)
	for(var/mob/M AS in GLOB.alive_living_list)
		if(!isnewplayer(M) && M.client)
			M.stopsound_local(CHANNEL_ADMIN)
