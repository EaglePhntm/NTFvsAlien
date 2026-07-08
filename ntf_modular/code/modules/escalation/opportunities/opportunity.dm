/datum/opportunity
	var/proper = FALSE
	var/name = "\improper opportunity"
	var/desc = "This be naught finished! Tell a coder!"
	var/announcefac = "Me when uh... I don't know... I forgor"
	var/announcehumanoid = "Nothing ever happens"
	var/announcexenos = "The queen mother decrees: Put your larva's evolve plasma on red"
	var/cost = 0
	var/faction = FACTION_TERRAGOV
	///First movers' adventage before all of the server knows what you are up to
	var/firstmovers = 60 SECONDS


/datum/opportunity/proc/eligible(mob/m)
	return TRUE

/datum/opportunity/proc/tryactivate(mob/m, forced)
	if(!forced)
		if(!eligible(m))
			return
		if(SSpoints.intel_points[m.faction] < cost)
			return
		SSpoints.intel_points[m.faction] -= cost
	activate(m)

	announceselffac()
	addtimer(CALLBACK(src, PROC_REF(announceenemyfacs)),firstmovers)


/datum/opportunity/proc/activate(mob/m)
	return

/datum/opportunity/proc/announceselffac()
	minor_announce(announcefac,"[faction] ICAP", GLOB.alive_human_list_faction[faction] + GLOB.observer_list)

/datum/opportunity/proc/announceenemyfacs()
	minor_announce(announcehumanoid,"Reactive Intelligence Network", GLOB.alive_human_list + GLOB.observer_list)
	minor_announce(announcexenos, "Sensor Nodules", GLOB.alive_xeno_list + GLOB.observer_list)

