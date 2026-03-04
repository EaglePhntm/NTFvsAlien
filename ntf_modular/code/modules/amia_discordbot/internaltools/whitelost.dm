/proc/amia_whitelistcheck(ckey)
	if(CONFIG_GET(flag/amia_enabled))
		var/encondedckey = url_encode(ckey)
		var/list/response = do_amia_export("CheckWL?ckey=[encondedckey]", "Whitelist check for ckey:[ckey]")
		var/content = file2text(response["CONTENT"])
		var/list/decoded = json_decode(content)
		if(decoded["ok"])
			return TRUE
		else
			return FALSE
	else
		return TRUE
