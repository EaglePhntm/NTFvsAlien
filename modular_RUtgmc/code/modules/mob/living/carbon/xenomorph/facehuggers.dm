/obj/item/clothing/mask/facehugger/equipped(mob/living/user, slot)
	. = ..()
	if(isxenofacehugger(source) && slot != SLOT_L_HAND && slot != SLOT_R_HAND)
		source.status_flags |= GODMODE
		ADD_TRAIT(source, TRAIT_HANDS_BLOCKED, REF(src))
		source.forceMove(user)
	if(slot == SLOT_L_HAND && slot == SLOT_R_HAND)
		reset_attach_status() //drop em


/obj/item/clothing/mask/facehugger/reset_attach_status(forcedrop)
	. = ..()
	//If hugger sentient, then we drop player's hugger
	if(isxenofacehugger(source) && isturf(loc))
		source.status_flags &= ~GODMODE
		REMOVE_TRAIT(source, TRAIT_HANDS_BLOCKED, REF(src))
		source.forceMove(get_turf(src))
		if(!QDELETED(src))
			qdel(src)

/obj/item/clothing/mask/facehugger/kill_hugger(melt_timer)
	. = ..()
	if(isxenofacehugger(source))
		if(!isturf(source.loc))
			source.forceMove(loc)
		source.death(FALSE)
		qdel(src)

/mob/living/carbon/xenomorph/facehugger/do_resist()
	if(next_move > world.time)
		return FALSE

	if(incapacitated(TRUE) || HAS_TRAIT(src, TRAIT_HAULED))
		to_chat(src, span_warning("You can't resist in your current state."))
		return FALSE

	if(sexcon)
		sexcon.try_stop_current_action()

	changeNext_move(CLICK_CD_RESIST)

	SEND_SIGNAL(src, COMSIG_LIVING_DO_RESIST)
	if(!isturf(loc))
		forceMove(mask.loc)
		if(mask)
			mask.reset_attach_status()
			qdel(mask)
	return TRUE
