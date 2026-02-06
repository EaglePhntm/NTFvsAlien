/obj/item/clothing/mask/facehugger/equipped(mob/living/user, slot)
	. = ..()
	if(isxenofacehugger(source))
		source.status_flags |= GODMODE
		ADD_TRAIT(source, TRAIT_HANDS_BLOCKED, REF(src))

/obj/item/clothing/mask/facehugger/dropped(mob/user)
	. = ..()
	//If hugger sentient, then we drop player's hugger
	if(isxenofacehugger(source))
		var/mob/living/M = user
		source.status_flags &= ~GODMODE
		REMOVE_TRAIT(source, TRAIT_HANDS_BLOCKED, REF(src))
		source.forceMove(get_turf(M))
		if(source in M.client_mobs_in_contents)
			M.client_mobs_in_contents -= source
		if(sterile || M.status_flags & XENO_HOST)
			source.death()
		kill_hugger()

/obj/item/clothing/mask/facehugger/kill_hugger(melt_timer)
	. = ..()
	if(isxenofacehugger(source))
		qdel(src)
