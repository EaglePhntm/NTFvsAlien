
/proc/amia_arbitrary_status_update(msg, pingid)
	SHOULD_NOT_SLEEP(TRUE)
	if(CONFIG_GET(flag/amia_enabled)) //Yes I know we had a check, but what about a second check?
		var/encodedmsg = url_encode(msg)
		var/constring
		if(pingid){
			constring = "arbitrarystatusupdate?pingid=[pingid]&msg=[encodedmsg]"
		}else{
			constring = "arbitrarystatusupdate?msg=[encodedmsg]"
		}
		ASYNC
			do_amia_export(constring, "public status update: [constring]")
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(status_update_heartbeat)), 1 HOURS, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE|TIMER_NO_HASH_WAIT)
