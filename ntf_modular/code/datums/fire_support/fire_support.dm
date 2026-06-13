/datum/fire_support
	///time it takes to reload fully.
	var/solmode_rearm_duration = 3 MINUTES
	var/rearm_timer
	var/bino_cooldown_mult = 1
	var/always_available = FALSE

/datum/fire_support/gau/solmode
	fire_support_type = FIRESUPPORT_TYPE_GUN_SOLMODE
	uses = 4
	impact_quantity = 8
	solmode_rearm_duration = 10 MINUTES
	cooldown_duration = 1 MINUTES
	bino_cooldown_mult = 0.2

/datum/fire_support/laser/solmode
	fire_support_type = FIRESUPPORT_TYPE_LASER_SOLMODE
	uses = 4
	solmode_rearm_duration = 5 MINUTES
	cooldown_duration = 1 MINUTES
	bino_cooldown_mult = 0.2

/datum/fire_support/rockets/solmode
	fire_support_type = FIRESUPPORT_TYPE_ROCKETS_SOLMODE
	uses = 3
	solmode_rearm_duration = 12 MINUTES
	cooldown_duration = 2 MINUTES
	bino_cooldown_mult = 0.5

/datum/fire_support/cruise_missile/solmode
	fire_support_type = FIRESUPPORT_TYPE_CRUISE_MISSILE_SOLMODE
	uses = 2
	cooldown_duration = 1 MINUTES
	solmode_rearm_duration = 15 MINUTES

/datum/fire_support/droppod/solmode
	fire_support_type = FIRESUPPORT_TYPE_SENTRY_POD_SOLMODE
	solmode_rearm_duration = 4
	bino_cooldown_mult = 0.1
	always_available = TRUE

/datum/fire_support/droppod/supply/solmode
	fire_support_type = FIRESUPPORT_TYPE_SUPPLY_POD_SOLMODE
	solmode_rearm_duration = 4
	bino_cooldown_mult = 0.1
	always_available = TRUE

/datum/fire_support/mortar/solmode
	fire_support_type = FIRESUPPORT_TYPE_HE_MORTAR_SOLMODE
	uses = 1
	solmode_rearm_duration = 5 MINUTES
	cooldown_duration = 1 MINUTES
	bino_cooldown_mult = 0.2

/datum/fire_support/mortar/incendiary/solmode
	fire_support_type = FIRESUPPORT_TYPE_INCENDIARY_MORTAR_SOLMODE
	uses = 1
	solmode_rearm_duration = 5 MINUTES
	cooldown_duration = 1 MINUTES
	bino_cooldown_mult = 0.4

/datum/fire_support/mortar/smoke/solmode
	fire_support_type = FIRESUPPORT_TYPE_SMOKE_MORTAR_SOLMODE
	uses = 2
	solmode_rearm_duration = 5 MINUTES
	cooldown_duration = 1 MINUTES
	bino_cooldown_mult = 0.2

/datum/fire_support/mortar/smoke/acid/solmode
	fire_support_type = FIRESUPPORT_TYPE_ACID_SMOKE_MORTAR
	uses = 1
	solmode_rearm_duration = 5 MINUTES
	cooldown_duration = 1 MINUTES
	bino_cooldown_mult = 0.4

//som shit has also lasting fire and overall crazy so i gotta gut em a bit.
/datum/fire_support/volkite/solmode
	fire_support_type = FIRESUPPORT_TYPE_VOLKITE_SOLMODE
	uses = 3
	cooldown_duration = 1 MINUTES
	solmode_rearm_duration = 10 MINUTES
	bino_cooldown_mult = 0.2

/datum/fire_support/incendiary_rockets/solmode
	uses = 2
	fire_support_type = FIRESUPPORT_TYPE_INCEND_ROCKETS_SOLMODE
	solmode_rearm_duration = 12 MINUTES
	cooldown_duration = 2 MINUTES
	bino_cooldown_mult = 0.5

/datum/fire_support/rad_missile/solmode
	uses = 2
	cooldown_duration = 2 MINUTES
	fire_support_type = FIRESUPPORT_TYPE_RAD_MISSILE_SOLMODE
	solmode_rearm_duration = 15 MINUTES

/datum/fire_support/tele_cope/solmode
	uses = 2
	fire_support_type = FIRESUPPORT_TYPE_TELE_COPE_SOLMODE
	solmode_rearm_duration = 5 MINUTES //free cope.
	bino_cooldown_mult = 0.1
	always_available = TRUE

/datum/fire_support/mortar/som/solmode
	fire_support_type = FIRESUPPORT_TYPE_HE_MORTAR_SOM_SOLMODE
	uses = 1
	solmode_rearm_duration = 5 MINUTES
	cooldown_duration = 1 MINUTES
	bino_cooldown_mult = 0.2

/datum/fire_support/mortar/incendiary/som/solmode
	fire_support_type = FIRESUPPORT_TYPE_INCENDIARY_MORTAR_SOM_SOLMODE
	uses = 1
	solmode_rearm_duration = 5 MINUTES
	cooldown_duration = 1 MINUTES
	bino_cooldown_mult = 0.4

/datum/fire_support/mortar/smoke/som/solmode
	fire_support_type = FIRESUPPORT_TYPE_SMOKE_MORTAR_SOM_SOLMODE
	uses = 2
	solmode_rearm_duration = 5 MINUTES
	cooldown_duration = 2 MINUTES
	bino_cooldown_mult = 0.2

/datum/fire_support/mortar/smoke/satrapine/solmode
	fire_support_type = FIRESUPPORT_TYPE_SATRAPINE_SMOKE_MORTAR
	uses = 1
	solmode_rearm_duration = 5 MINUTES
	cooldown_duration = 2 MINUTES
	bino_cooldown_mult = 0.4

/obj/item/binoculars/fire_support/extended
	name = "pair of NTC command laser-designator"
	desc = "A pair of binoculars, used to mark targets for tactical strikes, connected directly to factional ship systems and squadrons. Unique action to toggle mode. Ctrl+Click when using to target something."
	mode_list = list(
		FIRESUPPORT_TYPE_GUN_SOLMODE,
		FIRESUPPORT_TYPE_LASER_SOLMODE,
		FIRESUPPORT_TYPE_ROCKETS_SOLMODE,
		FIRESUPPORT_TYPE_HE_MORTAR_SOLMODE,
		FIRESUPPORT_TYPE_INCENDIARY_MORTAR_SOLMODE,
		FIRESUPPORT_TYPE_SMOKE_MORTAR_SOLMODE,
		FIRESUPPORT_TYPE_ACID_SMOKE_MORTAR_SOLMODE,
		FIRESUPPORT_TYPE_CRUISE_MISSILE_SOLMODE,
		FIRESUPPORT_TYPE_SUPPLY_POD_SOLMODE,
		FIRESUPPORT_TYPE_SENTRY_POD_SOLMODE,
	)
	var/bino_cooldown = 30 SECONDS
	var/bino_cooldown_timer = 0
	var/list/weapon_cooldowns = list()
	faction = FACTION_TERRAGOV
	color = COLOR_RED_GRAY //so its distinguishable hopefully

/obj/item/binoculars/fire_support/extended/sl
	name = "pair of NTC SL laser-designator"
	mode_list = list(
		FIRESUPPORT_TYPE_GUN_SOLMODE,
		FIRESUPPORT_TYPE_LASER_SOLMODE,
		FIRESUPPORT_TYPE_ROCKETS_SOLMODE,
		FIRESUPPORT_TYPE_HE_MORTAR_SOLMODE,
		FIRESUPPORT_TYPE_INCENDIARY_MORTAR_SOLMODE,
		FIRESUPPORT_TYPE_SMOKE_MORTAR_SOLMODE,
		FIRESUPPORT_TYPE_ACID_SMOKE_MORTAR_SOLMODE,
		FIRESUPPORT_TYPE_SUPPLY_POD_SOLMODE,
		FIRESUPPORT_TYPE_SENTRY_POD_SOLMODE,
	)

/obj/item/binoculars/fire_support/extended/som
	name = "pair of SOM command laser-designator"
	mode_list = list(
		FIRESUPPORT_TYPE_VOLKITE_SOLMODE,
		FIRESUPPORT_TYPE_INCEND_ROCKETS_SOLMODE,
		FIRESUPPORT_TYPE_HE_MORTAR_SOM_SOLMODE,
		FIRESUPPORT_TYPE_INCENDIARY_MORTAR_SOM_SOLMODE,
		FIRESUPPORT_TYPE_SMOKE_MORTAR_SOM_SOLMODE,
		FIRESUPPORT_TYPE_SATRAPINE_SMOKE_MORTAR_SOLMODE,
		FIRESUPPORT_TYPE_RAD_MISSILE_SOLMODE,
		FIRESUPPORT_TYPE_TELE_COPE_SOLMODE,
	)
	faction = FACTION_SOM
	color = COLOR_TAN_ORANGE

/obj/item/binoculars/fire_support/extended/som/sl
	name = "pair of SOM SL laser-designator"
	mode_list = list(
		FIRESUPPORT_TYPE_VOLKITE_SOLMODE,
		FIRESUPPORT_TYPE_INCEND_ROCKETS_SOLMODE,
		FIRESUPPORT_TYPE_HE_MORTAR_SOM_SOLMODE,
		FIRESUPPORT_TYPE_INCENDIARY_MORTAR_SOM_SOLMODE,
		FIRESUPPORT_TYPE_SMOKE_MORTAR_SOM_SOLMODE,
		FIRESUPPORT_TYPE_SATRAPINE_SMOKE_MORTAR_SOLMODE,
		FIRESUPPORT_TYPE_TELE_COPE_SOLMODE,
	)

/obj/item/binoculars/fire_support/extended/examine(mob/user)
	. = ..()
	if(!mode)
		return
	for(var/modething in mode_list)
		var/datum/fire_support/themode = GLOB.fire_support_types[modething]
		if(timeleft(themode.rearm_timer))
			. += span_warning("-[themode.name] - full rearm in [round(timeleft(themode.rearm_timer) MILLISECONDS)] seconds.")

/obj/item/binoculars/fire_support/extended/equipped(mob/user, slot)
	. = ..()
	if(user.faction != faction)
		user.balloon_alert_to_viewers("drops [src] due to an electric shock!")
		user.dropItemToGround(src)

/obj/item/binoculars/fire_support/extended/acquire_target(atom/target, mob/living/carbon/human/user)
	set waitfor = 0
	//had issues with parent so fuck it
	if(!(SSticker.mode.round_type_flags2 & MODE_2_CAMPAIGN_LITE_SUPPORT))
		if(mode && !mode.always_available)
			user.balloon_alert(user, "This fire-support is not available for this mission.")
			return
	if(!(COOLDOWN_FINISHED(src, bino_cooldown_timer)))
		balloon_alert(user, "Too soon! Systems recalibrating... [round((bino_cooldown_timer - world.time)/10)]s")
		return
	if(user.do_actions)
		balloon_alert_to_viewers("busy!")
		return
	if(is_mainship_level(user.z))
		user.balloon_alert(user, "can't use these here!")
		return
	if(faction && user.faction != faction)
		balloon_alert_to_viewers("security locks engaged")
		return
	if(laser_overlay)
		to_chat(user, span_warning("You're already targeting something."))
		return
	if(!bino_checks(target, user))
		return
	if(!can_see_target(target, user))
		balloon_alert_to_viewers("no clear view!")
		return

	playsound(src, 'sound/effects/nightvision.ogg', 35)
	to_chat(user, span_notice("INITIATING LASER TARGETING. Stand still."))
	target_atom = target
	laser_overlay = image('icons/obj/items/projectiles.dmi', icon_state = "sniper_laser", layer =-LASER_LAYER)
	target_atom.apply_fire_support_laser(laser_overlay)
	if(!do_after(user, target_acquisition_delay, NONE, user, BUSY_ICON_HOSTILE, extra_checks = CALLBACK(src, PROC_REF(can_see_target), target, user)))
		to_chat(user, span_danger("You lose sight of your target!"))
		playsound(user,'sound/machines/click.ogg', 25, 1)
		unset_target()
		return
	if(!bino_checks(target, user))
		return

	playsound(src, 'sound/effects/binoctarget.ogg', 35)
	mode.initiate_fire_support(get_turf(target_atom), user)
	unset_target()
	if(mode && mode.solmode_rearm_duration && !timeleft(mode.rearm_timer)) //start rearming timer after first use.
		mode.rearm_timer = addtimer(CALLBACK(src, PROC_REF(recharge_weapon), mode, user), mode.solmode_rearm_duration, TIMER_STOPPABLE)
	COOLDOWN_START(src, bino_cooldown_timer, (bino_cooldown * mode.bino_cooldown_mult))

/obj/item/binoculars/fire_support/extended/proc/recharge_weapon(var/datum/fire_support/weapontype, mob/living/carbon/human/user)
	playsound(loc, 'sound/effects/radiostatic.ogg', 50, TRUE)
	weapontype.enable_firesupport(initial(weapontype.uses) - weapontype.uses)
	if(user.get_active_held_item(src)) //if still holding this shit
		balloon_alert(user, "[weapontype] fully rearmed.")
		to_chat(user, span_notice("[weapontype] fully rearmed."))
