/proc/faction_announce(message, title = "Attention:", sound, list/receivers = GLOB.alive_human_list, should_play_sound = TRUE, to_faction = FACTION_TERRAGOV)
	if(!message)
		return

	var/sound/sussy
	if(!sound)
		sussy = sound('sound/misc/notice2.ogg')
	else
		sussy = sound(sound)
	sussy.channel = CHANNEL_ANNOUNCEMENTS
	for(var/mob/M AS in receivers)
		if(!isnewplayer(M) && !isdeaf(M) && M.faction == to_faction)
			to_chat(M, assemble_alert(
				title = title,
				message = message,
				minor = TRUE
			))
			if(should_play_sound)
				SEND_SOUND(M, sussy)
