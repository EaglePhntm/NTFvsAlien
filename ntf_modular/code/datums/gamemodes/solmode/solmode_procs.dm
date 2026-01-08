/proc/play_sound_to_faction(mob/usr, sound_path, faction_choice)
	for(var/mob/M AS in GLOB.alive_living_list)
		if(!isnewplayer(M) && M.faction == faction_choice && M.client)
			M.playsound_local(sound_path, 100, CHANNEL_ADMIN)
