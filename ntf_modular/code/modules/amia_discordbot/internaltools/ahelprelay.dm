
/proc/amia_ahelprelay(ticketid, initckey, msg)
	if(CONFIG_GET(flag/amia_enabled)) //Yes I know we had a check, but what about a second check?
		var/roundid = url_encode(GLOB.round_id)
		var/roundtime
		if (SSticker.HasRoundStarted())
			roundtime = url_encode(time2text((world.time - SSticker.round_start_time), "hh:mm", 0))
		else
			roundtime = "Pregame"
		var/encodedckey = url_encode(initckey)
		var/encodedmsg = url_encode(msg)
		var/constring =  amia_constring() + "ahelprelay?roundid=[roundid]&roundtime=[roundtime]&ticketid=[ticketid]&ckey=[encodedckey]&msg=[encodedmsg]"
		var/list/response = world.Export(constring)
		if(!islist(response))
			log_runtime("Can't reach AMIA")
			return FALSE
