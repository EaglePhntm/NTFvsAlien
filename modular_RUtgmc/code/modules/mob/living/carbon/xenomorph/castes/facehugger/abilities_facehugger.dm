// ***************************************
// *********** Hug
// ***************************************

/datum/action/ability/activable/xeno/pounce/hugger
	name = "Pounce"
	action_icon_state = "pounce"
	desc = "Leap at your target and knock them down, if you jump close you will hug the target or apply other effects depending on your type."
	ability_cost = 25
	cooldown_duration = 5 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_RUNNER_POUNCE,
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
	pounce_sound = null

/datum/action/ability/activable/xeno/pounce/hugger/give_action(mob/living/L)
	. = ..()
	var/mob/living/carbon/xenomorph/facehugger/caster = owner
	if(!caster)
		return
	desc = "Leap at your target and knock them down, if you jump within [caster.hug_range] tiles, you will hug the target and apply any other effects depending on your type."

// TODO: merge this ability into runner pounce (can't do it right now - the runner's pounce has too many unnecessary sounds/messages)
/datum/action/ability/activable/xeno/pounce/hugger/pounce_complete()
	. = ..()
	var/mob/living/carbon/xenomorph/facehugger/caster = owner
	caster.icon_state = "[caster.xeno_caste.caste_name] Walking"
	for(var/mob/living/carbon/human/H in caster.loc.contents)
		if(H.in_throw_mode && !H.get_active_held_item() && prob(75))
			playsound(caster.loc, 'sound/weapons/punch1.ogg', 30, TRUE)
			H.do_attack_animation(caster, ATTACK_EFFECT_PUNCH)
			H.visible_message(span_warning("[H] smacks [caster] down mid air!"))
			caster.Paralyze(self_immobilize_duration)
			caster.apply_damage(caster.xeno_caste.max_health/3, BRUTE, blocked = MELEE)
			return
		if(get_dist(start_turf, caster.loc) <= caster.hug_range)
			caster.forceMove(get_turf(H))
			caster.special_pounce(H)
			if(caster.try_attach(H))
				caster.forceMove(H)
			break
		else //we gotta do it here cuz huggers are pass through and shit was fucked even without.
			H.Paralyze(stun_duration)
			caster.Immobilize(self_immobilize_duration)

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
	playsound(caster.loc, 'ntf_modular/sound/voice/alien/headcrab-jump.ogg', 20, TRUE)

	caster.icon_state = "[caster.xeno_caste.caste_name] Thrown"

	start_turf = get_turf(caster)
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
