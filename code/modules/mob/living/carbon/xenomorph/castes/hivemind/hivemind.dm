#define TIME_TO_TRANSFORM 1.6 SECONDS
#define TIME_TO_TRANSFORM_COMBAT 10 SECONDS
#define HIVEMIND_COMBAT_DEATH_COOLDOWN 3 MINUTES

/mob/living/carbon/xenomorph/hivemind
	caste_base_type =/datum/xeno_caste/hivemind
	name = "Hivemind"
	real_name = "Hivemind"
	desc = "A glorious singular entity."

	icon_state = "hivemind_marker"
	bubble_icon = "alienroyal"
	icon = 'icons/Xeno/castes/hivemind.dmi'
	status_flags = GODMODE | INCORPOREAL
	resistance_flags = RESIST_ALL|BANISH_IMMUNE
	density = FALSE
	a_intent = INTENT_HELP
	health = 1000
	maxHealth = 1000
	plasma_stored = 5
	tier = XENO_TIER_ZERO
	upgrade = XENO_UPGRADE_BASETYPE
	pixel_x = -8

	see_invisible = SEE_INVISIBLE_LIVING
	invisibility = INVISIBILITY_MAXIMUM
	sight = SEE_MOBS|SEE_TURFS|SEE_OBJS
	move_on_shuttle = TRUE

	///The core of our hivemind
	var/datum/weakref/core
	///The minimum health we can have
	var/minimum_health = -300
	///pass_flags given when going incorporeal
	var/incorporeal_pass_flags = PASS_LOW_STRUCTURE|PASS_THROW|PASS_PROJECTILE|PASS_AIR|PASS_FIRE
	///pass_flags given when manifested
	var/manifest_pass_flags = PASS_LOW_STRUCTURE|PASS_MOB|PASS_XENO
	///list of cooldowns to share through forms
	var/list/saved_ability_cooldowns = list()

/mob/living/carbon/xenomorph/hivemind/Initialize(mapload, do_not_set_as_ruler, _hivenumber)
	var/obj/structure/xeno/hivemindcore/new_core = new /obj/structure/xeno/hivemindcore(loc, hivenumber)
	core = WEAKREF(new_core)
	. = ..()
	new_core.parent = WEAKREF(src)
	add_pass_flags(incorporeal_pass_flags, INNATE_TRAIT)
	update_action_buttons()

/mob/living/carbon/xenomorph/hivemind/upgrade_possible()
	return FALSE

/mob/living/carbon/xenomorph/hivemind/proc/is_combat_form()
	return upgrade == XENO_UPGRADE_HIVEMIND_COMBAT

/mob/living/carbon/xenomorph/hivemind/upgrade_xeno(newlevel, silent = FALSE)
	newlevel = XENO_UPGRADE_BASETYPE
	return ..()

/mob/living/carbon/xenomorph/hivemind/updatehealth()
	if(on_fire && !is_combat_form())
		ExtinguishMob()
	health = maxHealth - getFireLoss() - getBruteLoss() //Xenos can only take brute and fire damage.
	if(is_combat_form())
		if(health <= xeno_caste.crit_health)
			setBruteLoss(0)
			setFireLoss(-minimum_health)
			change_form(TRUE)
			set_stat(CONSCIOUS)
			drop_all_held_items()
			if(eaten_mob)
				eaten_mob.handle_unhaul()
				eject_victim()
			remove_status_effect(/datum/status_effect/spacefreeze)
			TIMER_COOLDOWN_START(src, COOLDOWN_HIVEMIND_MANIFESTATION_COMBAT, HIVEMIND_COMBAT_DEATH_COOLDOWN)
		else if(health < 0)
			set_stat(UNCONSCIOUS)
		else
			set_stat(CONSCIOUS)
	else if(health <= 0 && !(status_flags & INCORPOREAL))
		setBruteLoss(0)
		setFireLoss(-minimum_health)
		change_form()
		remove_status_effect(/datum/status_effect/spacefreeze)
	health = maxHealth - getFireLoss() - getBruteLoss()
	med_hud_set_health()
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	update_wounds()

/mob/living/carbon/xenomorph/hivemind/handle_living_health_updates(seconds_per_tick)
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	var/turf/T = loc
	if(!istype(T))
		return
	if(is_combat_form())
		if(health < 0)
			handle_critical_health_updates(seconds_per_tick)
			return
		if(!loc_weeds_type)
			return
		heal_wounds(XENO_RESTING_HEAL, TRUE, seconds_per_tick)
		updatehealth()
		return
	// If manifested and off weeds, lets deal some damage.
	if(!(status_flags & INCORPOREAL) && !loc_weeds_type)
		adjustBruteLoss(20 * XENO_RESTING_HEAL, TRUE)
		return
	// If not manifested
	if(health < minimum_health + maxHealth)
		setBruteLoss(0)
		setFireLoss(-minimum_health)
	if(health >= maxHealth) //can't regenerate.
		updatehealth() //Update health-related stats, like health itself (using brute and fireloss), health HUD and status.
		return
	heal_wounds(XENO_RESTING_HEAL)
	updatehealth()

/mob/living/carbon/xenomorph/hivemind/Destroy()
	var/obj/structure/xeno/hivemindcore/hive_core = get_core()
	if(hive_core)
		qdel(hive_core)
	return ..()


/mob/living/carbon/xenomorph/hivemind/on_death()
	var/obj/structure/xeno/hivemindcore/hive_core = get_core()
	if(!QDELETED(hive_core))
		qdel(hive_core)
	return ..()

/mob/living/carbon/xenomorph/hivemind/gib()
	return_to_core()

/mob/living/carbon/xenomorph/hivemind/set_resting()
	if(is_combat_form())
		return ..()
	return

/mob/living/carbon/xenomorph/hivemind/proc/cancel_manifestation(datum/source, damage, mob/living/attacker)
	SIGNAL_HANDLER

	Paralyze(10 SECONDS, TRUE, TRUE)

/mob/living/carbon/xenomorph/hivemind/proc/manifest_combat()
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		balloon_alert(src, "cannot manifest during transformation!")
		return
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_HIVEMIND_MANIFESTATION_COMBAT))
		balloon_alert(src, "died too recently!")
		return
	RegisterSignal(src, COMSIG_XENOMORPH_TAKING_DAMAGE, PROC_REF(cancel_manifestation))
	if(!do_after(src, TIME_TO_TRANSFORM_COMBAT, NONE, src, BUSY_ICON_DANGER))
		UnregisterSignal(src, COMSIG_XENOMORPH_TAKING_DAMAGE)
		return
	UnregisterSignal(src, COMSIG_XENOMORPH_TAKING_DAMAGE)
	if(health < maxHealth)
		balloon_alert(src, "must be at full health!")
		return
	if(is_combat_form())
		flick("Hivemind_materialisation_reverse", src)
		do_manifest_builder()
		return
	flick("Hivemind_materialisation", src)
	do_manifest_combat()

/mob/living/carbon/xenomorph/hivemind/proc/change_form(forced = FALSE)
	if(is_combat_form() && !forced)
		return
	if(status_flags & INCORPOREAL && health != maxHealth)
		to_chat(src, span_xenowarning("You do not have the strength to manifest yet!"))
		return
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	wound_overlay.icon_state = "none"
	TIMER_COOLDOWN_START(src, COOLDOWN_HIVEMIND_MANIFESTATION, TIME_TO_TRANSFORM)
	invisibility = 0
	flick(status_flags & INCORPOREAL ? "Hivemind_materialisation" : "Hivemind_materialisation_reverse", src)
	addtimer(CALLBACK(src, PROC_REF(do_change_form)), TIME_TO_TRANSFORM)

/mob/living/carbon/xenomorph/hivemind/set_jump_component(duration = 0.5 SECONDS, cooldown = 2 SECONDS, cost = 0, height = 16, sound = null, flags = JUMP_SHADOW, jump_pass_flags = PASS_LOW_STRUCTURE|PASS_FIRE|PASS_TANK)
	if(is_combat_form())
		return ..()
	remove_component(/datum/component/jump)

/mob/living/carbon/xenomorph/hivemind/proc/do_manifest_builder()
	LAZYCLEARLIST(movespeed_modification)
	update_movespeed()
	hive.xenos_by_upgrade[upgrade] -= src
	upgrade = XENO_UPGRADE_MANIFESTATION
	set_datum(FALSE)
	status_flags = NONE
	sync_hivemind_abilities()
	add_pass_flags(manifest_pass_flags, MANIFESTED_TRAIT)
	hive.xenos_by_upgrade[upgrade] += src
	set_jump_component()
	update_wounds()
	update_icon()
	update_action_buttons()
	drop_all_held_items()
	if(eaten_mob)
		eaten_mob.handle_unhaul()
		eject_victim()

/mob/living/carbon/xenomorph/hivemind/proc/do_manifest_combat()
	LAZYCLEARLIST(movespeed_modification)
	update_movespeed()
	hive.xenos_by_upgrade[upgrade] -= src
	upgrade = XENO_UPGRADE_HIVEMIND_COMBAT
	set_datum(FALSE)
	status_flags = CANSTUN | CANKNOCKDOWN | CANKNOCKOUT | CANPUSH | CANUNCONSCIOUS | CANCONFUSE
	health = maxHealth
	sync_hivemind_abilities()
	remove_pass_flags(manifest_pass_flags, MANIFESTED_TRAIT)
	hive.xenos_by_upgrade[upgrade] += src
	set_jump_component()
	update_wounds()
	update_icon()
	update_action_buttons()

///Finish the form changing of the hivemind and give the needed stats
/mob/living/carbon/xenomorph/hivemind/proc/do_change_form()
	LAZYCLEARLIST(movespeed_modification)
	update_movespeed()
	if(status_flags & INCORPOREAL)
		status_flags = NONE
		resistance_flags = BANISH_IMMUNE
		remove_pass_flags(incorporeal_pass_flags, INNATE_TRAIT)
		add_pass_flags(manifest_pass_flags, MANIFESTED_TRAIT)
		density = TRUE
		hive.xenos_by_upgrade[upgrade] -= src
		upgrade = XENO_UPGRADE_MANIFESTATION
		set_datum(FALSE)
		sync_hivemind_abilities()
		hive.xenos_by_upgrade[upgrade] += src
		set_jump_component()
		update_wounds()
		update_icon()
		update_action_buttons()
		return
	status_flags = initial(status_flags)
	resistance_flags = initial(resistance_flags)
	remove_pass_flags(manifest_pass_flags, MANIFESTED_TRAIT)
	add_pass_flags(incorporeal_pass_flags, INNATE_TRAIT)
	density = FALSE
	hive.xenos_by_upgrade[upgrade] -= src
	upgrade = XENO_UPGRADE_BASETYPE
	set_datum(FALSE)
	sync_hivemind_abilities()
	hive.xenos_by_upgrade[upgrade] += src
	set_jump_component()
	update_wounds()
	update_icon()
	update_action_buttons()
	handle_weeds_adjacent_removed()
	if(eaten_mob)
		eaten_mob.handle_unhaul()
		eject_victim()

/mob/living/carbon/xenomorph/hivemind/fire_act(burn_level)
	if(is_combat_form())
		return ..()
	return_to_core()
	to_chat(src, span_xenonotice("We were on top of fire, we got moved to our core."))

/mob/living/carbon/xenomorph/hivemind/handle_weeds_adjacent_removed()
	if(is_combat_form())
		return
	if(loc_weeds_type || check_weeds(get_turf(src)))
		return
	return_to_core()
	to_chat(src, span_xenonotice("We had no weeds nearby, we got moved to our core."))

/mob/living/carbon/xenomorph/hivemind/proc/return_to_core()
	if(!(status_flags & INCORPOREAL) && TIMER_COOLDOWN_FINISHED(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		do_change_form()
	for(var/obj/item/explosive/grenade/sticky/sticky_bomb in contents)
		sticky_bomb.unstick_from(src)
		sticky_bomb.forceMove(loc)
	forceMove(get_turf(get_core()))

///Start the teleportation process to send the hivemind manifestation to the selected turf
/mob/living/carbon/xenomorph/hivemind/proc/start_teleport(turf/T)
	if(!isopenturf(T))
		balloon_alert(src, "can't teleport into a wall!")
		return
	TIMER_COOLDOWN_START(src, COOLDOWN_HIVEMIND_MANIFESTATION, TIME_TO_TRANSFORM)
	flick("Hivemind_materialisation_fast_reverse", src)
	addtimer(CALLBACK(src, PROC_REF(end_teleport), T), TIME_TO_TRANSFORM / 2)

///Finish the teleportation process to send the hivemind manifestation to the selected turf
/mob/living/carbon/xenomorph/hivemind/proc/end_teleport(turf/T)
	flick("Hivemind_materialisation_fast", src)
	if(!check_weeds(T, TRUE))
		balloon_alert(src, "no weeds in destination!")
		return
	forceMove(T)
	flick("Hivemind_[initial(loc_weeds_type.color_variant)]_materialisation", src)
	setDir(SOUTH)

/mob/living/carbon/xenomorph/hivemind/Move(atom/newloc, direction, glide_size_override)
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	if(!(status_flags & INCORPOREAL))
		return ..()
	if(!check_weeds(newloc))
		return FALSE

	// FIXME: Port canpass refactor from tg
	// Don't allow them over the timed_late doors
	var/obj/machinery/door/poddoor/timed_late/door = locate() in newloc
	if(door && !door.CanPass(src, newloc))
		return FALSE

	abstract_move(newloc)

/mob/living/carbon/xenomorph/hivemind/receive_hivemind_message(mob/living/carbon/xenomorph/speaker, message)
	var/track = "<a href='byond://?src=[REF(src)];hivemind_jump=[REF(speaker)]'>(F)</a>"
	return show_message("[track] [speaker.hivemind_start()] [span_message("hisses, '[message]'")][speaker.hivemind_end()]", 2)

/mob/living/carbon/xenomorph/hivemind/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	if(href_list["hivemind_jump"])
		var/mob/living/carbon/xenomorph/xeno = locate(href_list["hivemind_jump"])
		if(!istype(xeno))
			return
		jump(xeno)

/// Jump hivemind's camera to the passed xeno, if they are on/near weeds
/mob/living/carbon/xenomorph/hivemind/proc/jump(mob/living/carbon/xenomorph/xeno)
	if(!check_weeds(get_turf(xeno), TRUE))
		balloon_alert(src, "no nearby weeds!")
		return
	if(!(status_flags & INCORPOREAL))
		start_teleport(get_turf(xeno))
		return
	abstract_move(get_turf(xeno))

/// handles hivemind updating with their respective weedtype
/mob/living/carbon/xenomorph/hivemind/update_icon_state()
	. = ..()
	if(status_flags & INCORPOREAL)
		icon_state = "hivemind_marker"
		return
	icon_state = "Hivemind"

/mob/living/carbon/xenomorph/hivemind/update_icon()
	. = ..()
	if(status_flags & INCORPOREAL)
		invisibility = INVISIBILITY_MAXIMUM
	else
		invisibility = 0

/mob/living/carbon/xenomorph/hivemind/update_icons(state_change = TRUE)
	if(status_flags & INCORPOREAL)
		return
	SEND_SIGNAL(src, COMSIG_XENOMORPH_UPDATE_ICONS, state_change)
	if(state_change)
		if(lying_angle)
			if((resting || IsSleeping()) && (!IsParalyzed() && !IsUnconscious() && health > 0))
				icon_state = "[xeno_caste.caste_name][is_a_rouny ? " rouny" : ""] Sleeping"
			else
				icon_state = "[xeno_caste.caste_name][is_a_rouny ? " rouny" : ""] Knocked Down"
		else
			icon_state = "[xeno_caste.caste_name][is_a_rouny ? " rouny" : ""]"
	update_fire() //the fire overlay depends on the xeno's stance, so we must update it.
	update_wounds()
	INVOKE_ASYNC(src, PROC_REF(update_xeno_gender))
	update_snowflake_overlays()

	hud_set_sunder()
	hud_set_firestacks()

/mob/living/carbon/xenomorph/hivemind/update_wounds()
	if(status_flags & INCORPOREAL)
		wound_overlay.icon_state = "none"
		return
	return ..()

/mob/living/carbon/xenomorph/hivemind/med_hud_set_health()
	. = ..()
	var/image/holder = hud_list[HEALTH_HUD_XENO]
	if(!holder)
		return
	holder.overlays.Cut()
	if(status_flags & INCORPOREAL)
		holder.overlays += image('icons/Xeno/castes/hivemind.dmi', src, "hivemind_marker")

/mob/living/carbon/xenomorph/hivemind/DblClickOn(atom/A, params)
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_HIVEMIND_MANIFESTATION))
		return
	if(is_combat_form())
		return
	var/list/modifiers = params2list(params)
	if(modifiers["right"])
		return
	var/turf/target_turf = get_turf(A)
	if(!check_weeds(target_turf, TRUE))
		return
	if(!(status_flags & INCORPOREAL))
		start_teleport(target_turf)
		return
	abstract_move(target_turf)

/mob/living/carbon/xenomorph/hivemind/CtrlClick(mob/user)
	if(!(status_flags & INCORPOREAL))
		return ..()
	return FALSE

/mob/living/carbon/xenomorph/hivemind/CtrlShiftClickOn(atom/A)
	if(!(status_flags & INCORPOREAL))
		return ..()
	return FALSE

/// Hiveminds specifically have no status hud element
/mob/living/carbon/xenomorph/hivemind/med_hud_set_status()
	return

/mob/living/carbon/xenomorph/hivemind/update_progression()
	return

/obj/fire/flamer/CanAllowThrough(atom/movable/mover, turf/target)
	if(isxenohivemind(mover))
		var/mob/living/carbon/xenomorph/hivemind/hivemind = mover
		if(!hivemind.is_combat_form())
			return FALSE
	return ..()

/// Getter proc for the weakref'd core
/mob/living/carbon/xenomorph/hivemind/proc/get_core()
	return core?.resolve()



/mob/living/carbon/xenomorph/hivemind/proc/sync_hivemind_abilities()
	for(var/datum/action/ability/xeno_action/action AS in mob_abilities)
		if(action.cooldown_timer)
			saved_ability_cooldowns[action.type] = timeleft(action.cooldown_timer)
		action.remove_action(src)

	mob_abilities = list()
	for(var/allowed_action_path in xeno_caste.actions)
		var/datum/action/ability/xeno_action/action = new allowed_action_path()
		if(!SSticker.mode || (SSticker.mode.xeno_abilities_flags & action.gamemode_flags))
			action.give_action(src)
			if(saved_ability_cooldowns[action.type])
				action.add_cooldown(saved_ability_cooldowns[action.type])
				saved_ability_cooldowns -= action.type

// =================
// hivemind core
/obj/structure/xeno/hivemindcore
	name = "hivemind core"
	desc = "A very weird, pulsating node. This looks almost alive."
	max_integrity = 600
	icon = 'icons/Xeno/1x1building.dmi'
	icon_state = "hivemind_core"
	xeno_structure_flags = CRITICAL_STRUCTURE|DEPART_DESTRUCTION_IMMUNE
	///The cooldown of the alert hivemind gets when a hostile is near it's core
	COOLDOWN_DECLARE(hivemind_proxy_alert_cooldown)
	///The weakref to the parent hivemind mob that we're attached to
	var/datum/weakref/parent

/obj/structure/xeno/hivemindcore/Initialize(mapload)
	. = ..()
	GLOB.hive_datums[hivenumber].hivemindcores += src
	new /obj/alien/weeds/node(loc)
	set_light(7, 5, LIGHT_COLOR_PURPLE)
	if(iszombiecrashgamemode(SSticker.mode))
		return
	for(var/turfs in RANGE_TURFS(XENO_HIVEMIND_DETECTION_RANGE, src))
		RegisterSignal(turfs, COMSIG_ATOM_ENTERED, PROC_REF(hivemind_proxy_alert))

/obj/structure/xeno/hivemindcore/Destroy()
	GLOB.hive_datums[hivenumber].hivemindcores -= src
	var/mob/living/carbon/xenomorph/hivemind/our_parent = get_parent()
	if(isnull(our_parent))
		return ..()
	our_parent.playsound_local(our_parent, SFX_ALIEN_HELP, 30, TRUE)
	to_chat(our_parent, span_xenouserdanger("Your core has been destroyed!"))
	xeno_message("A sudden tremor ripples through the hive... \the [our_parent] has been slain!", "xenoannounce", 5, our_parent.get_xeno_hivenumber())
	GLOB.key_to_time_of_role_death[our_parent.key] = world.time
	GLOB.key_to_time_of_death[our_parent.key] = world.time
	our_parent.ghostize()
	if(!QDELETED(our_parent))
		qdel(our_parent)
	return ..()

//hivemind cores

/obj/structure/xeno/hivemindcore/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage * xeno_attacker.xeno_melee_damage_modifier, damage_type = BRUTE, armor_type = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(!issamexenohive(xeno_attacker))
		return ..()
	if(isxenoqueen(xeno_attacker) || xeno_attacker == GLOB.hive_datums[hivenumber]?.living_xeno_ruler)
		var/choice = tgui_alert(xeno_attacker, "Are you sure you want to destroy the hivemind?", "Destroy hivemind", list("Yes", "Cancel"))
		if(choice == "Yes")
			deconstruct(FALSE)
			return

	xeno_attacker.visible_message(span_danger("[xeno_attacker] nudges [xeno_attacker.p_their()] head against [src]."), \
	span_danger("You nudge your head against [src]."))

/obj/structure/xeno/hivemindcore/take_damage(damage_amount, damage_type = BRUTE, armor_type = null, effects = TRUE, attack_dir, armour_penetration = 0, mob/living/blame_mob, silent)
	. = ..()
	var/mob/living/carbon/xenomorph/hivemind/our_parent = get_parent()
	if(isnull(our_parent))
		return
	var/health_percent = round((max_integrity / obj_integrity) * 100)
	switch(health_percent)
		if(-INFINITY to 25)
			to_chat(our_parent, span_xenouserdanger("Your core is under attack, and dangerous low on health!"))
		if(26 to 75)
			to_chat(our_parent, span_xenodanger("Your core is under attack, and low on health!"))
		if(76 to INFINITY)
			to_chat(our_parent, span_xenodanger("Your core is under attack!"))

/**
 * Proc checks if we should alert the hivemind, and if it can, it does so.
 * datum/source - the atom (in this case it should be a turf) sending the crossed signal
 * atom/movable/hostile - the atom that triggered the crossed signal, in this case we're looking for a mob
 */
/obj/structure/xeno/hivemindcore/proc/hivemind_proxy_alert(datum/source, atom/movable/hostile)
	SIGNAL_HANDLER
	if(!COOLDOWN_FINISHED(src, hivemind_proxy_alert_cooldown)) //Proxy alert triggered too recently; abort
		return

	if(!isliving(hostile))
		return

	var/mob/living/living_triggerer = hostile
	if(get_xeno_hivenumber(hostile) == hivenumber)
		return
	if(living_triggerer.stat == DEAD) //We don't care about the dead
		return
	if(ishuman(hostile))
		var/mob/living/carbon/human/human_triggerer = hostile
		if(get_xeno_hivenumber(human_triggerer) == hivenumber)
			return

	if(isxeno(hostile))
		if(issamexenohive(hostile)) //Trigger proxy alert only for hostile xenos
			return

	to_chat(get_parent(), span_xenoannounce("Our [src.name] has detected a nearby hostile [hostile] at [get_area(hostile)] (X: [hostile.x], Y: [hostile.y])."))
	SEND_SOUND(get_parent(), sound('ntf_modular/sound/voice/help1nonearrape.ogg',))
	COOLDOWN_START(src, hivemind_proxy_alert_cooldown, XENO_HIVEMIND_DETECTION_COOLDOWN) //set the cooldown.

/// Getter for the parent of this hive core
/obj/structure/xeno/hivemindcore/proc/get_parent()
	return parent?.resolve()
