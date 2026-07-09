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
	var/hidden = FALSE
	var/datum/escalation/parent

/datum/opportunity/New(datum/escalation/parent)
	. = ..()
	src.parent = parent


/datum/opportunity/proc/eligible(mob/m)
	return TRUE

/datum/opportunity/proc/tryactivate(mob/m, forced)
	if(!forced)
		if(!m)
			return FALSE
		if(!eligible(m))
			return FALSE
		if(SSpoints.intel_points[m.faction] < cost)
			return FALSE
		SSpoints.intel_points[m.faction] -= cost
	return activate(m)

/datum/opportunity/proc/activate(mob/m)
	return


