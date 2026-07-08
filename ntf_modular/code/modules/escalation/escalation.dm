/datum/escalation
	var/name = "bugged escalation"
	var/datum/opportunity/op
	var/faction = FACTION_TERRAGOV
	var/mob/initiator
	var/started = FALSE
	var/concluded = FALSE

/datum/escalation/New(datum/opportunity/op, mob/m, forcedfaction)
	. = ..()
	initiator = m
	src.op = new op()
	if(forcedfaction)
		src.op.faction = forcedfaction
	else
		src.op.faction = initiator.faction
	SetName()

/datum/escalation/proc/SetName()
	name = GLOB.operation_namepool[/datum/operation_namepool].get_random_name() + " - [faction] [op.name]"

/datum/escalation/proc/start(forced)
	op.tryactivate(initiator, forced)



