#define PINGID_ADMIN_PING "1532223004506062978"

/proc/amia_ahelprelay(ticketid, initckey, msg)
	SHOULD_NOT_SLEEP(TRUE)
	var/roundid = replacetext(GLOB.log_directory, "data/logs/", "")
	var/roundtime
	if (SSticker.HasRoundStarted())
		roundtime = time2text((world.time - SSticker.round_start_time), "hh:mm", 0)
	else
		roundtime = "Pregame"
	if(CONFIG_GET(flag/webhook_enabled_admin))
		ASYNC
			send_webhook_message_admin("New ahelp from [initckey]\nRound:[roundid]\nRound duration:[roundtime]\nTicket #[ticketid]:\n[msg]", PINGID_ADMIN_PING)
	if(CONFIG_GET(flag/amia_enabled)) //Yes I know we had a check, but what about a second check?

		var/encodedckey = url_encode(initckey)
		var/encodedmsg = url_encode(msg)
		ASYNC
			do_amia_export("ahelprelay?roundid=[url_encode(roundid)]&roundtime=[url_encode(roundtime)]&ticketid=[ticketid]&ckey=[encodedckey]&msg=[encodedmsg]", "ahelp relay of ticket #[ticketid]")
