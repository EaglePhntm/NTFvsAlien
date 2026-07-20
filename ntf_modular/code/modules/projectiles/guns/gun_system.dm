/obj/item/weapon/gun/proc/bipod_check(mob/user)
	if(user.lying_angle && !(gun_skill_category == SKILL_PISTOLS || gun_skill_category == SKILL_SMGS || gun_skill_category == SKILL_RIFLES || gun_skill_category == SKILL_POLICE))
		var/obj/item/attachable/foldable/bipod/bipussy
		for(var/key in attachments_by_slot)
			var/obj/item/attachment = attachments_by_slot[key]
			if(!istype(attachment, /obj/item/attachable/foldable/bipod))
				continue
			bipussy = attachment
		if(bipussy)
			if(bipussy.folded)
				balloon_alert(user, "Bipod is not unfolded!")
				to_chat(user, span_warning("The bipod is not unfolded!"))
				return FALSE
			else
				return TRUE
		balloon_alert(user, "Can't use this while laying!")
		to_chat(user, span_warning("You can't use this while laying! Maybe a bipod fits?"))
		return FALSE
	return TRUE

/obj/item/weapon/gun/proc/unique_action_under(mob/user, special_treatment = FALSE)
	SIGNAL_HANDLER
	if(!ismob(user))
		return
	if(!gun_user)
		return
	var/obj/item/under = attachments_by_slot[ATTACHMENT_SLOT_UNDER]
	if(!under)
		return
	under.unique_action(user, special_treatment)
