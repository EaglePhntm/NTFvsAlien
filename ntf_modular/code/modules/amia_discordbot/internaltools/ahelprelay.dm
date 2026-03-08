
/proc/amia_ahelprelay(ticketid, initckey, msg)
	SHOULD_NOT_SLEEP(TRUE)
	if(CONFIG_GET(flag/amia_enabled)) //Yes I know we had a check, but what about a second check?
		var/roundid = url_encode(GLOB.round_id)
		var/roundtime
		if (SSticker.HasRoundStarted())
			roundtime = url_encode(time2text((world.time - SSticker.round_start_time), "hh:mm", 0))
		else
			roundtime = "Pregame"
		var/encodedckey = url_encode(initckey)
		var/encodedmsg = url_encode(msg)
		ASYNC
			do_amia_export("ahelprelay?roundid=[roundid]&roundtime=[roundtime]&ticketid=[ticketid]&ckey=[encodedckey]&msg=[encodedmsg]", "ahelp relay of ticket #[ticketid]")
