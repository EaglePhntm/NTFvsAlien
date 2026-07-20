/obj/proc/check_inherent_access(mob/living/luser)
	if(!LAZYLEN(req_access) && !LAZYLEN(req_one_access))
		return TRUE

	if(!istype(luser))
		return FALSE

	if(!LAZYLEN(luser.inherent_accesses))
		return FALSE

	for(var/i in req_access)
		if(!(i in luser.inherent_accesses))
			return FALSE

	if(LAZYLEN(req_one_access))
		for(var/i in req_one_access)
			if(!(i in luser.inherent_accesses))
				continue
			return TRUE
		return FALSE

	return TRUE
