/obj/vehicle/sealed/mecha/ntf/mob_exit(mob/M, silent, forced)
	var/atom/movable/mob_container
	var/turf/newloc = get_turf(src)
	if(ishuman(M))
		mob_container = M
	else
		return ..()
	mecha_flags  &= ~SILICON_PILOT
	mob_container.forceMove(newloc)//ejecting mob container
	log_message("[mob_container] moved out.", LOG_MECHA)
	SStgui.close_user_uis(M, src)
//	setDir(dir_in)
	return ..()
/*
/obj/vehicle/sealed/mecha/ntf/resisted_against(mob/living/user)
	to_chat(user, span_notice("You begin the ejection procedure. Equipment is disabled during this process. Hold still to finish ejecting."))
	is_currently_ejecting = TRUE
	if(do_after(user, exit_delay, target = src))
		if(!is_flipped && flip_status == FLIP_FORWARDS && hatch_position == HATCH_LOCATION_FRONT && hatch_status == HATCH_CLOSED)
			to_chat(user, span_notice("You exit the mech."))
			mob_exit(user, TRUE)
		else
			attempt_jammed_exit(user)
				to_chat(user, span_notice("You struggle against the jammed hatch!"))
				if(do_after(user, exit_delay * 3, target = src))
					(if(prob(50))
						to_chat(user, span_notice("You struggle against the jammed hatch!"))
	else
		to_chat(user, span_notice("You stop exiting the mech. Weapons are enabled again."))
	is_currently_ejecting = FALSE
*/
/obj/vehicle/sealed/mecha/ntf/proc/attempt_jammed_exit(mob/living/user)
