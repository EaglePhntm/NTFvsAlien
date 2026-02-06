/obj/item/clothing/mask/facehugger/equipped(mob/living/user, slot)
	. = ..()
	if(isxenofacehugger(source))
		source.status_flags |= GODMODE
		ADD_TRAIT(source, TRAIT_HANDS_BLOCKED, REF(src))

/obj/item/clothing/mask/facehugger/dropped(mob/user)
	. = ..()
	//If hugger sentient, then we drop player's hugger
	if(isxenofacehugger(source) && isturf(loc))
		var/mob/living/M = user
		var/mob/living/carbon/xenomorph/facehugger/phugger = source
		source.status_flags &= ~GODMODE
		REMOVE_TRAIT(source, TRAIT_HANDS_BLOCKED, REF(src))
		source.forceMove(get_turf(M))
		if(source in M.client_mobs_in_contents)
			M.client_mobs_in_contents -= source

/obj/item/clothing/mask/facehugger/kill_hugger(melt_timer)
	. = ..()
	if(isxenofacehugger(source))
		qdel(src)

/mob/living/carbon/human/relaymove(mob/user, direction)
	if(user.incapacitated(TRUE))
		return
	if(!isxenofacehugger(user))
		var/mob/living/carbon/xenomorph/facehugger/fhug = user
		fhug.forceMove(loc)
		if(fhug.mask)
			fhug.mask.dropped()
			qdel(fhug.mask)
