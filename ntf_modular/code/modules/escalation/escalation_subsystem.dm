SUBSYSTEM_DEF(escalation)
	name = "Escalation"
	var/list/datum/opportunity/ops = list()
	var/list/datum/escalation/escs = list()

/datum/controller/subsystem/escalation/Initialize()
	for(var/optocheck in subtypesof(/datum/opportunity))
		var/datum/opportunity/optypecasted = optocheck
		if(optypecasted.proper)
			ops += optypecasted


/*
/datum/controller/subsystem/escalation/proc/StartOp(datum/opportunity/op, mob/m)
*/

/datum/controller/subsystem/escalation/proc/AdminCreateOp(client/c)
	var/datum/opportunity/inputlistchoice = tgui_input_list(c.mob, "Choose an op to create", "Create New Op", ops, null)
	if(!inputlistchoice)
		to_chat(c,span_warning("Please pick one :c"))
		return
	var/mob/inputmobchoice = tgui_input_list(c.mob, "Choose an instigator for this Op", "Create New Op", GLOB.human_mob_list, null)
	if(!inputmobchoice)
		if(tgui_alert(c.mob,"Would you like to proceed without an instigator? This is heavily unsupported and should be reserved for events! Don't say you weren't warned!", "Input empty", list("Proceed.", "Cancel")) == "Cancel")
			return
	var/fac = inputmobchoice ? inputmobchoice.faction : tgui_input_list(c.mob, "Choose an instigator faction for this op", "Create New Op",list(FACTION_TERRAGOV, FACTION_CLF, FACTION_NANOTRASEN, FACTION_SOM, FACTION_ICC, FACTION_VSD))
	if(!fac)
		to_chat(c,span_warning("No faction picked, cancelling!"))
		return
	var/datum/escalation/esc = new /datum/escalation(inputlistchoice,inputmobchoice, fac)
	escs += esc
	if(tgui_alert(c.mob,"Escalation successfully created as [esc.name]! Would you like to change it?","Create New Op", list("Yes", "Leave it be")) == "Yes")
		esc.name = tgui_input_text(c.mob, "Choose the name", "Create New Op", esc.name)


/datum/controller/subsystem/escalation/proc/AdminStartOp(client/c)
	var/list/datum/escalation/escsreadytostart = list()
	for(var/datum/escalation/esc in escs)
		if(!esc.started)
			escsreadytostart += esc
	var/datum/escalation/inputlistchoice = tgui_input_list(c.mob, "Choose an op to start", "Start New Op", escsreadytostart, null)
	if(!inputlistchoice)
		to_chat(c,span_warning("Please pick one :c"))
		return
	var/forced = (tgui_alert(c.mob, "Forced? (Bypasses checks and doesn't deduct intel points)","Start New Op", list("Force it", "Do it normally")) == "Force it" ? TRUE : FALSE)
	inputlistchoice.start(forced)







