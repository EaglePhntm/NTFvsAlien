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

/obj/vehicle/sealed/mecha/ntf/mob_try_enter(mob/entering_mob, mob/user, loc_override = FALSE)
	.=..()
	if(hatch_status == HATCH_LOCKED | hatch_status == HATCH_CLOSED)
		balloon_alert(user, "open hatch first")
		return ..()

/obj/vehicle/sealed/mecha/ntf/resisted_against(mob/living/user)
	if(hatch_status == HATCH_LOCKED | hatch_status == HATCH_CLOSED)
		balloon_alert(user, "open hatch first")
		return
	to_chat(user, span_notice("You begin the ejection procedure. Equipment is disabled during this process. Hold still to finish ejecting."))
	is_currently_ejecting = TRUE
	if(do_after(user, exit_delay, target = src))
		to_chat(user, span_notice("You exit the mech."))
		mob_exit(user, TRUE)
	else
		to_chat(user, span_notice("You stop exiting the mech. Weapons are enabled again."))
	is_currently_ejecting = FALSE

/obj/vehicle/sealed/mecha/ntf/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/jerrycan))
		var/obj/item/reagent_containers/jerrycan/gascan = I
		if(!body)
			return
		for(var/obj/item/mecha_parts/exosuit_engine/egnine as anything in body)
			if(body.engine.is_electric)
				balloon_alert(user, "doesn't take fuel!")
				return
			if(gascan.reagents.total_volume == 0)
				balloon_alert(user, "no fuel!")
				return
			if(body.engine.fuel_amount >= body.engine.fuel_max)
				balloon_alert(user, "full!")
				return

		var/fuel_transfer_amount = min(gascan.fuel_usage*2, gascan.reagents.total_volume)
		gascan.reagents.remove_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		body.engine.fuel_amount = min(body.engine.fuel_amount + FUEL_PER_CAN_POUR, body.engine.fuel_max)
		playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
		balloon_alert(user, "[body.engine.fuel_amount/body.engine.fuel_max*100]%")
		return TRUE
	return ..()
