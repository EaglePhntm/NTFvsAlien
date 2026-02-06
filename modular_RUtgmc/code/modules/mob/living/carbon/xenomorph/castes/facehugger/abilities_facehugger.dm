// ***************************************
// *********** Hug
// ***************************************

/datum/action/ability/activable/xeno/pounce/hugger
	name = "Pounce"
	action_icon_state = "pounce"
	desc = "Leap at your target and knock them down, if you jump close you will hug the target."
	ability_cost = 25
	cooldown_duration = 5 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOMORPH_POUNCE,
	)
	use_state_flags = ABILITY_USE_BUCKLED
	///How long is the windup before leap
	var/windup_time = 1 SECONDS
	///Where do we start the leap from
	var/start_turf

	pounce_range = 6
	stun_duration = 1 SECONDS
	self_immobilize_duration = 1 SECONDS
	leap_pass_flags = PASS_LOW_STRUCTURE|PASS_FIRE


/datum/action/ability/activable/xeno/pounce/hugger/movement_fx()
	. = ..()

// TODO: merge this ability into runner pounce (can't do it right now - the runner's pounce has too many unnecessary sounds/messages)
/datum/action/ability/activable/xeno/pounce/hugger/pounce_complete()
	. = ..()
	var/mob/living/carbon/xenomorph/caster = owner
	caster.icon_state = "[caster.xeno_caste.caste_name] Walking"

/datum/action/ability/activable/xeno/pounce/hugger/object_hit(datum/source, obj/target, speed)
	. = ..()
	target.hitby(owner, speed)
	pounce_complete()

/datum/action/ability/activable/xeno/pounce/hugger/mob_hit(datum/source, mob/living/M)
	if(M.stat || isxeno(M))
		return

	var/mob/living/carbon/xenomorph/facehugger/caster = owner

	caster.visible_message(span_danger("[caster] leaps on [M]!"),
				span_xenodanger("We leap on [M]!"), null, 5)
	playsound(caster.loc, 'ntf_modular/sound/voice/alien/roar_larva3.ogg', 25, TRUE) //TODO: I NEED ACTUAL HUGGERS SOUND DAMMED

	if(ishuman(M) && (M.dir in reverse_nearby_direction(caster.dir)))
		var/mob/living/carbon/human/H = M
		if(!H.check_shields(COMBAT_TOUCH_ATTACK, 30, "melee"))
			caster.Paralyze(6 SECONDS)
			caster.set_throwing(FALSE) //Reset throwing manually.
			return COMPONENT_KEEP_THROWING

	caster.forceMove(get_turf(M))
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(get_dist(start_turf, H) <= caster.hug_range) //Check whether we hugged the target or just knocked it down
			INVOKE_ASYNC(caster, TYPE_PROC_REF(/mob/living/carbon/xenomorph/facehugger, try_attach), H)
		else
			if(stun_duration)
				H.Paralyze(stun_duration)

			if(self_immobilize_duration)
				caster.Immobilize(self_immobilize_duration)

	pounce_complete()

/datum/action/ability/activable/xeno/pounce/hugger/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE

	if(!A || A.layer >= FLY_LAYER)
		return FALSE

/datum/action/ability/activable/xeno/pounce/hugger/proc/prepare_to_pounce()
	if(owner.layer == BELOW_TABLE_LAYER) //Xeno is currently hiding, unhide him
		owner.layer = MOB_LAYER
		var/datum/action/ability/xeno_action/xenohide/hide_action = owner.actions_by_path[/datum/action/ability/xeno_action/xenohide]
		hide_action?.button?.cut_overlay(mutable_appearance('icons/Xeno/actions.dmi', "selected_purple_frame", ACTION_LAYER_ACTION_ICON_STATE, FLOAT_PLANE)) // Removes Hide action icon border
	if(owner.buckled)
		owner.buckled.unbuckle_mob(owner)

/datum/action/ability/activable/xeno/pounce/hugger/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/caster = owner

	prepare_to_pounce()
	if(!do_after(caster, windup_time, FALSE, caster, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_ability), A, FALSE, ABILITY_USE_BUSY)))
		return fail_activate()

	caster.icon_state = "[caster.xeno_caste.caste_name] Thrown"

	start_turf = get_turf(caster)
	caster.throw_at(A, pounce_range, 2, caster)
	return ..()

	//AI stuff
/datum/action/ability/activable/xeno/pounce/hugger/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/pounce/hugger/ai_should_use(atom/target)
	if(!ishuman(target))
		return FALSE
	var/mob/living/carbon/xenomorph/facehugger/caster = owner
	if(!line_of_sight(owner, target, caster.hug_range))
		return FALSE
	if(!can_use_action(override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_xeno_hivenumber() == owner.get_xeno_hivenumber())
		return FALSE
	action_activate()
	LAZYINCREMENT(owner.do_actions, target)
	addtimer(CALLBACK(src, PROC_REF(decrease_do_action), target), windup_time)
	return TRUE

///Decrease the do_actions of the owner
/datum/action/ability/activable/xeno/pounce/hugger/proc/decrease_do_action(atom/target)
	LAZYDECREMENT(owner.do_actions, target)
