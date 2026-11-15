/// url of the webhook to use for public status updates.  Caution: Anyone with the webhook url can use it.  Do not put webhook urls on github or in other public places.
/datum/config_entry/string/discord_webhook_public
	protection = CONFIG_ENTRY_HIDDEN

/// url of the webhook to use for admin updates like ahelp relays.  Caution: Anyone with the webhook url can use it.  Do not put webhook urls on github or in other public places.
/datum/config_entry/string/discord_webhook_admin
	protection = CONFIG_ENTRY_HIDDEN

///whether to even try to use the public webhook
/datum/config_entry/flag/webhook_enabled_public

///whether to even try to use the admin webhook
/datum/config_entry/flag/webhook_enabled_admin

ADMIN_VERB(toggle_webhook_public, R_SERVER, "Toggle public webhook", "Toggle the webhook for public status updates.", ADMIN_CATEGORY_SERVER)

	CONFIG_SET(flag/webhook_enabled_public, !CONFIG_GET(flag/webhook_enabled_public))

	log_admin("[key_name(user)] has [CONFIG_GET(flag/webhook_enabled_public) ? "enabled" : "disabled"] the public webhook.")
	message_admins("[ADMIN_TPMONTY(user.mob)] has [CONFIG_GET(flag/webhook_enabled_public) ? "enabled" : "disabled"] the public webhook.")

ADMIN_VERB(toggle_webhook_admin, R_SERVER, "Toggle admin webhook", "Toggle the webhook for admin status updates.", ADMIN_CATEGORY_SERVER)

	CONFIG_SET(flag/webhook_enabled_admin, !CONFIG_GET(flag/webhook_enabled_admin))

	log_admin("[key_name(user)] has [CONFIG_GET(flag/webhook_enabled_admin) ? "enabled" : "disabled"] the admin webhook.")
	message_admins("[ADMIN_TPMONTY(user.mob)] has [CONFIG_GET(flag/webhook_enabled_admin) ? "enabled" : "disabled"] the admin webhook.")

/proc/send_webhook_message_admin(message, pingid)
	if(!message)
		return FALSE
	var/webhook_url = CONFIG_GET(string/discord_webhook_admin)
	if(!webhook_url)
		log_world("Webhook request failed: Admin webhook enabled but url not set")
		return FALSE
	if(pingid)
		message = "[message]<@&[pingid]>"
	var/list/data = list("content" = message)
	var/list/response = world.Export(webhook_url, data, 0, null, "POST")
	if(!response)
		log_world("Discord webhook failed: No HTTP Response")
		return FALSE
	if(response["STATUS"] == "200" || response["STATUS"] == "204")
		return TRUE
	log_world("Discord webhook failed with HTTP status [response["STATUS"]]")
	return FALSE

/proc/send_webhook_message_public(message, pingid)
	if(!message)
		return FALSE
	var/webhook_url = CONFIG_GET(string/discord_webhook_public)
	if(!webhook_url)
		log_world("Webhook request failed: Public webhook enabled but url not set")
		return FALSE
	if(pingid)
		message = "[message]<@&[pingid]>"
	var/list/data = list("content" = message)
	var/list/response = world.Export(webhook_url, data, 0, null, "POST")
	if(!response)
		log_world("Discord webhook failed: No HTTP Response")
		return FALSE
	if(response["STATUS"] == "200" || response["STATUS"] == "204")
		return TRUE
	log_world("Discord webhook failed with HTTP status [response["STATUS"]]")
	return FALSE
