//xeno cuffs
/obj/item/restraints/handcuffs/shackles
	name = "xenomorph suppression shackles"
	desc = "Oversized alloy shackles used to restrain alien lifeforms and nullify their psionic abilities."
	icon = 'ntf_modular/icons/obj/items/items.dmi'
	icon_state = "xeno_cuffs"
	throwforce = 15 // Heavy as fuck
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 2
	throw_range = 2

/obj/item/restraints/handcuffs/shackles/attack(mob/living/carbon/C, mob/user)
	if(!istype(C))
		return ..()
	if(!C.handcuffed)
		place_handcuffs(C, user)

/obj/item/restraints/handcuffs/shackles/place_handcuffs(mob/living/carbon/target, mob/user)
	playsound(src.loc, cuff_sound, 25, 1, 4)

	if(user.do_actions)
		return

	if(isxeno(user))
		return

	if(!isxeno(target))
		return

	if(isxenolarva(target))
		return

	var/mob/living/carbon/xenomorph/X = target

	log_combat(user, X, "handcuffed", src, addition="(attempt)")

	user.visible_message(span_notice("[user] tries to put \The [src] on [X]."))
	if(do_mob(user, X, cuff_delay, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE, extra_checks = CALLBACK(user, TYPE_PROC_REF(/datum, Adjacent), X)) && !X.handcuffed)
		if(!X.handcuffed)
			X.update_handcuffed(new /obj/item/restraints/handcuffs/shackles(X))
			X.update_handcuffed_overlay()
			qdel(src)
			return TRUE

//---
