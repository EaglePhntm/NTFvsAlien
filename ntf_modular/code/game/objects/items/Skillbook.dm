/obj/item/generic_skillbook
	name = "Generic Skillbook"
	desc = "This is a generic skillbook. You really shouldn't have this but if you do, HI!"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scrollstamp"
	w_class = WEIGHT_CLASS_SMALL
	var/list/skills = list()
	var/datum/job/role = null
	var/title = ""
	var/description = ""
	var/increase_amount = 0
	/// Do we want to delete the skillbook when it's used
	var/del_done = TRUE
	/// Is this a exclusive skillbook (IE, corpsman uses a skill book they get given for +1 surgery, meaning they cannot use another of that same skillbook, if another corpsman drops it to them.)
	var/exclusive = TRUE

/obj/item/generic_skillbook/attack_self(mob/user)
	. = ..()
	if(istype(user.mind.assigned_role, role))
		if(exclusive)
			if(user.mind.skillbookused)
				to_chat(user, span_warning("You've already used a skill book this operation."))
				return
		var/choice = tgui_input_list(user, description, title, skills)
		if(choice == null)
			to_chat(user, span_warning("You decide to use this later."))
			return
		else if(!(choice in skills))
			message_admins("MOB: "+user.name+", played by CKEY: "+user.client.ckey+" returned a result when using a skill book that their book shouldn't be capable of. Risk of input injection (potential hackerman).", null, TRUE)
			return
		switch(choice)
			if("unarmed")
				user.skills.unarmed += increase_amount
			if("melee_weapons")
				user.skills.melee_weapons += increase_amount
			if("combat")
				user.skills.combat += increase_amount
			if("pistols")
				user.skills.pistols += increase_amount
			if("shotguns")
				user.skills.shotguns += increase_amount
			if("rifles")
				user.skills.rifles += increase_amount
			if("smgs")
				user.skills.smgs += increase_amount
			if("heavy_weapons")
				user.skills.heavy_weapons += increase_amount
			if("smartgun")
				user.skills.smartgun += increase_amount
			if("engineer")
				user.skills.engineer += increase_amount
			if("construction")
				user.skills.construction += increase_amount
			if("leadership")
				user.skills.leadership += increase_amount
			if("medical")
				user.skills.medical += increase_amount
			if("surgery")
				user.skills.surgery += increase_amount
			if("pilot")
				user.skills.pilot += increase_amount
			if("police")
				user.skills.police += increase_amount
			if("powerloader")
				user.skills.powerloader += increase_amount
			if("large_vehicle")
				user.skills.large_vehicle += increase_amount
			if("mech")
				user.skills.mech += increase_amount
			if("stamina")
				user.skills.stamina += increase_amount
			if("sex")
				user.skills.sex += increase_amount
			if(null) /// Probably not needed but better safe than sorry.
				to_chat(user, span_warning("You decide to use this later."))
				return
		user.mind.skillbookused = TRUE
		if(del_done)
			qdel(src)

/obj/item/generic_skillbook/fcskill
	name = "Field Commander's Diploma"
	desc = "The diploma of the NTF Field Commander; showing the batchelors in which they specialised and achieved a degree in at the university of Phantom City."
	skills = list("surgery", "engineering")
	role = /datum/job/terragov/command/fieldcommander
	title = "Field Commander Specialisation."
	description = "What did I get my degree in?"
	increase_amount = 1
	/// Do we want to delete the skillbook when it's used
	del_done = FALSE
	/// Is this a exclusive skillbook (IE, corpsman uses a skill book they get given for +1 surgery, meaning they cannot use another of that same skillbook, if another corpsman drops it to them.)
	exclusive = TRUE

/obj/item/generic_skillbook/somfcskill
	name = "SOM Field Commander's Diploma"
	desc = "The diploma of the SOM Field Commander; showing the batchelors in which they specialised and achieved a degree in at the university of Olympus Mons."
	skills = list("surgery", "engineering")
	role = /datum/job/som/command/fieldcommander
	title = "Sons of Mars Field Commander Specialisation."
	description = "What did I get my degree in?"
	increase_amount = 1
	/// Do we want to delete the skillbook when it's used?
	del_done = FALSE
	/// Is this a exclusive skillbook?
	exclusive = TRUE

