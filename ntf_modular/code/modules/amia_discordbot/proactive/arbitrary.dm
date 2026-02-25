
/proc/amia_arbitrary_status_update(msg, pingid)
	if(CONFIG_GET(flag/amia_enabled)) //Yes I know we had a check, but what about a second check?
		var/encodedmsg = url_encode(msg)
		var/constring
		if(pingid){
			constring =  amia_constring() + "arbitrarystatusupdate?pingid=[pingid]&msg=[encodedmsg]"
		}else{
			constring =  amia_constring() + "arbitrarystatusupdate?msg=[encodedmsg]"
		}

		var/list/response = world.Export(constring)
		if(!islist(response))
			log_runtime("Can't reach AMIA")
			return FALSE
