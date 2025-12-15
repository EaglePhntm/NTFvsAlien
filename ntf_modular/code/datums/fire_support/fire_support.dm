/datum/fire_support
	///cooldown added for unlimited weapons used in extended gamemode
	var/ex_recharge_duration = 3 MINUTES

/datum/fire_support/gau/unlimited
	ex_recharge_duration = 3 MINUTES

/datum/fire_support/rockets/unlimited
	ex_recharge_duration = 10 MINUTES
	scatter_range = 6
	impact_quantity = 8

/datum/fire_support/cruise_missile/unlimited
	ex_recharge_duration = 15 MINUTES

/datum/fire_support/droppod
	fire_support_type = FIRESUPPORT_TYPE_SENTRY_POD
	ex_recharge_duration = 3 SECONDS //you gotta manually load those apparently fucking hell.

/datum/fire_support/droppod/supply
	uses = -1
	ex_recharge_duration = 3 SECONDS

/datum/fire_support/volkite/unlimited
	uses = -1
	fire_support_type = FIRESUPPORT_TYPE_VOLKITE_UNLIMITED

/datum/fire_support/incendiary_rockets/unlimited
	uses = -1
	scatter_range = 6
	impact_quantity = 4
	fire_support_type = FIRESUPPORT_TYPE_INCEND_ROCKETS_UNLIMITED
	ex_recharge_duration = 10 MINUTES

/datum/fire_support/rad_missile/unlimited
	uses = -1
	fire_support_type = FIRESUPPORT_TYPE_RAD_MISSILE_UNLIMITED
	ex_recharge_duration = 15 MINUTES

/datum/fire_support/tele_cope/unlimited
	uses = -1
	fire_support_type = FIRESUPPORT_TYPE_TELE_COPE_UNLIMITED
	ex_recharge_duration = 10 MINUTES //free cope.

/obj/item/binoculars/fire_support/extended
	name = "pair of NTC command laser-designator"
	desc = "A pair of binoculars, used to mark targets for tactical strikes, connected directly to factional ship systems and squadrons. Unique action to toggle mode. Ctrl+Click when using to target something."
	mode_list = list(
		FIRESUPPORT_TYPE_GUN_UNLIMITED,
		FIRESUPPORT_TYPE_ROCKETS_UNLIMITED,
		FIRESUPPORT_TYPE_CRUISE_MISSILE_UNLIMITED,
		FIRESUPPORT_TYPE_SUPPLY_POD,
		FIRESUPPORT_TYPE_SENTRY_POD,
	)
	var/bino_cooldown = 1 MINUTES
	var/bino_cooldown_timer = 0
	var/list/weapon_cooldowns = list()
	faction = FACTION_TERRAGOV
	color = COLOR_ALMOST_BLACK //so its distinguishable hopefully

/obj/item/binoculars/fire_support/extended/sl
	name = "pair of NTC SL laser-designator"
	mode_list = list(
		FIRESUPPORT_TYPE_GUN_UNLIMITED,
		FIRESUPPORT_TYPE_SUPPLY_POD,
		FIRESUPPORT_TYPE_SENTRY_POD,
	)

/obj/item/binoculars/fire_support/extended/som
	name = "pair of SOM command laser-designator"
	mode_list = list(
		FIRESUPPORT_TYPE_VOLKITE_UNLIMITED,
		FIRESUPPORT_TYPE_INCEND_ROCKETS_UNLIMITED,
		FIRESUPPORT_TYPE_RAD_MISSILE_UNLIMITED,
		FIRESUPPORT_TYPE_TELE_COPE_UNLIMITED,
	)
	faction = FACTION_SOM
	color = COLOR_TAN_ORANGE

/obj/item/binoculars/fire_support/extended/som/sl
	name = "pair of SOM SL laser-designator"
	mode_list = list(
		FIRESUPPORT_TYPE_VOLKITE_UNLIMITED,
		FIRESUPPORT_TYPE_TELE_COPE_UNLIMITED,
	)

/obj/item/binoculars/fire_support/extended/equipped(mob/user, slot)
	. = ..()
	if(user.faction != faction)
		user.balloon_alert_to_viewers("drops [src] due to an electric shock!")
		user.dropItemToGround(src)

/obj/item/binoculars/fire_support/extended/acquire_target(atom/target, mob/living/carbon/human/user)
	if(!(COOLDOWN_FINISHED(src, bino_cooldown_timer)))
		balloon_alert(user, "Too soon! Systems recalibrating... [round(((bino_cooldown_timer + bino_cooldown) - world.time)/10)]s")
		return
	. = ..()
	if(!target_atom)
		return
	if(mode && mode.ex_recharge_duration)
		mode_list -= mode.fire_support_type
		addtimer(CALLBACK(src, PROC_REF(recharge_weapon), mode, user), mode.ex_recharge_duration)
	COOLDOWN_START(src, bino_cooldown_timer, bino_cooldown)

/obj/item/binoculars/fire_support/extended/proc/recharge_weapon(var/datum/fire_support/weapontype, mob/living/carbon/human/user)
	playsound(loc, 'sound/effects/radiostatic.ogg', 50, TRUE)
	mode = null
	if(user.get_active_held_item(src)) //if still holding this shit
		balloon_alert(user, "[weapontype] is ready to be used again.")
		to_chat(user, span_notice("[weapontype] is ready to be used again."))
	mode_list[weapontype.fire_support_type] += GLOB.fire_support_types[weapontype.fire_support_type]

/obj/item/binoculars/fire_support/extended/select_radial(mob/user)
	if(!length(mode_list))
		balloon_alert(user, "No weapons are ready to use yet.")
		return
	. = ..()
