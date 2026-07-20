/proc/amia_whitelistcheck(ckey, datum/callback/result_callback)
	if(CONFIG_GET(flag/amia_enabled) && CONFIG_GET(flag/amia_whitelist_enabled))
		var/encondedckey = url_encode(ckey)
		ASYNC
			var/list/response = do_amia_export("CheckWL?ckey=[encondedckey]", "Whitelist check for ckey:[ckey]")
			if(!islist(response))
				result_callback.Invoke(ckey, "Errored")
			var/content = file2text(response["CONTENT"])
			var/list/decoded = json_decode(content)
			if(decoded["ok"])
				result_callback.Invoke(ckey, "Passed")
			else
				result_callback.Invoke(ckey, "Failed")
	else
		result_callback.Invoke(ckey, "Skipped")
