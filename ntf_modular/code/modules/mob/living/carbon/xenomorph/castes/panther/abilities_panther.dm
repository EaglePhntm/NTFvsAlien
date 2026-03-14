GLOBAL_LIST_INIT(panther_toxin_type_list, list(
		/datum/reagent/toxin/xeno_hemodile,
		/datum/reagent/toxin/xeno_transvitox,
		/datum/reagent/toxin/xeno_ozelomelyn,
		/datum/reagent/toxin/xeno_sanguinal,
		/datum/reagent/toxin/xeno_aphrotoxin,
		))

/// runner abilities
/datum/action/ability/activable/xeno/psydrain/panther
	ability_cost = 10

/datum/action/ability/activable/xeno/pounce/panther
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PANTHER_POUNCE,
	)
	cooldown_duration = 13 SECONDS
	ability_cost = 20
	var/pantherplasmaheal = 45

/datum/action/ability/activable/xeno/pounce/panther/mob_hit(datum/source, mob/living/M)
	. = ..()
	xeno_owner.plasma_stored += pantherplasmaheal

///////////////////////////////////
// ***************************************
// *********** Tearing tail
// ***************************************

/datum/action/ability/xeno_action/tearingtail
	name = "Tearing tail"
	action_icon = 'modular_RUtgmc/icons/Xeno/actions.dmi'
	action_icon_state = "tearing_tail"
	desc = "Hit all nearby enemies around you, poisoning them with selected toxin and healing you for each target hit."
	ability_cost = 50
	cooldown_duration = 15 SECONDS
	var/tearing_tail_reagent
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TEARING_TAIL,
	)

/datum/action/ability/xeno_action/tearingtail/action_activate()
	xeno_owner.add_filter("defender_tail_sweep", 2, gauss_blur_filter(1)) //Add cool SFX
	xeno_owner.spin(4, 1)
	xeno_owner.AddComponent(/datum/component/throw_parry, duration = 0.6 SECONDS, _directional = FALSE, source = xeno_owner)
	playsound(xeno_owner, SFX_ALIEN_TAIL_SWIPE, 25, 1) //Sound effects

	var/sweep_range = 1
	var/list/L = orange(sweep_range, xeno_owner) // Not actually the fruit

	for(var/mob/living/carbon/human/human_target in L)
		step_away(human_target, src, sweep_range, 2)
		if(human_target.stat != DEAD && !isnestedhost(human_target) ) //No bullying
			var/damage = xeno_owner.xeno_caste.melee_damage
			var/affecting = human_target.get_limb(ran_zone(null, 0))
			if(!affecting) //Still nothing??
				affecting = human_target.get_limb("chest") //Gotta have a torso?!
			human_target.apply_damage(damage, BRUTE, affecting, MELEE)
			xeno_owner.plasma_stored += 25
			xeno_owner.heal_overall_damage(25, 25, updating_health = TRUE)
			if(human_target.can_sting())
				tearing_tail_reagent = xeno_owner.selected_reagent
				var/reagent_amount = (xeno_owner.selected_reagent == /datum/reagent/toxin/xeno_ozelomelyn) ? PANTHER_TEARING_TAIL_REAGENT_AMOUNT * 0.5 : PANTHER_TEARING_TAIL_REAGENT_AMOUNT
				human_target.reagents.add_reagent(tearing_tail_reagent, reagent_amount)
				playsound(human_target, 'sound/effects/spray3.ogg', 15, TRUE)
			shake_camera(human_target, 2, 1)
			to_chat(human_target, span_xenowarning("We are hit by \the [xeno_owner]'s tail sweep!"))
			playsound(human_target,'sound/weapons/alien_tail_attack.ogg', 50, 1)

	addtimer(CALLBACK(xeno_owner, TYPE_PROC_REF(/datum, remove_filter), "defender_tail_sweep"), 0.5 SECONDS) //Remove cool SFX
	succeed_activate()
	add_cooldown()

/datum/action/ability/xeno_action/tearingtail/on_cooldown_finish()
	to_chat(xeno_owner, span_notice("We gather enough strength to tear the skin again."))
	owner.playsound_local(owner, 'sound/effects/alien/new_larva.ogg', 25, 0, 1)
	return ..()

///////////////////////////////////
// ***************************************
// *********** Adrenaline Jump
// ***************************************
// lunge+fling idk

/datum/action/ability/activable/xeno/adrenalinejump
	name = "Adrenaline Jump"
	action_icon = 'modular_RUtgmc/icons/Xeno/actions.dmi'
	action_icon_state = "adrenaline_jump"
	desc = "Jump from some distance to target, knocking them down and pulling them to you, only works if you are at least from 3 to 8 meters away from the target, this ability sends Pounce on cooldown."
	ability_cost = 15
	cooldown_duration = 12 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ADRENALINE_JUMP,
	)
	target_flags = ABILITY_MOB_TARGET
	/// The target of our lunge, we keep it to check if we are adjacent everytime we move
	var/atom/lunge_target

/datum/action/ability/activable/xeno/adrenalinejump/on_cooldown_finish()
	to_chat(owner, span_xenodanger("We ready ourselves to jump again."))
	owner.playsound_local(owner, 'sound/effects/alien/new_larva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/activable/xeno/adrenalinejump/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE

	if(get_dist_euclidean_square(A, owner) > 64) //8 tiles range
		if(!silent)
			to_chat(owner, span_xenonotice("You are too far!"))
		return FALSE

	if(!line_of_sight(A, owner))
		if(!silent)
			owner.balloon_alert(owner, "We need clear jump line!")
		return FALSE

	if(!isliving(A))
		if(!silent)
			to_chat(owner, span_xenodanger("We can't jump at that!"))
		return FALSE

	var/mob/living/living_target = A
	if(living_target.stat == DEAD)
		if(!silent)
			to_chat(owner, span_xenodanger("We can't jump at that!"))
		return FALSE

/datum/action/ability/activable/xeno/adrenalinejump/use_ability(atom/targeted_atom)
	xeno_owner.visible_message(span_xenowarning("\The [xeno_owner] jump towards [targeted_atom]!"), \
	span_xenowarning("We jump at [targeted_atom]!"))

	lunge_target = targeted_atom

	RegisterSignal(lunge_target, COMSIG_QDELETING, PROC_REF(clean_lunge_target))
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_MOVED, PROC_REF(check_if_lunge_possible))
	RegisterSignal(xeno_owner, COMSIG_MOVABLE_POST_THROW, PROC_REF(clean_lunge_target))

	if(lunge_target.Adjacent(xeno_owner)) //They're already in range, pat their head, we messed up.
		to_chat(xeno_owner, span_xenodanger("We lost some of the adrenaline due to failed jump!."))
		playsound(xeno_owner,'sound/weapons/thudswoosh.ogg', 75, 1)
		xeno_owner.plasma_stored -= 50
		clean_lunge_target()
	else
		xeno_owner.throw_at(get_step_towards(targeted_atom, xeno_owner), 6, 2, xeno_owner)

	succeed_activate()
	add_cooldown()
	var/datum/action/ability/xeno_action/pounce = xeno_owner.actions_by_path[/datum/action/ability/activable/xeno/pounce/panther]
	if(pounce)
		pounce.add_cooldown()

	return TRUE

///Check if we are close enough to lunge, and if yes, fling them
/datum/action/ability/activable/xeno/adrenalinejump/proc/check_if_lunge_possible(datum/source)
	SIGNAL_HANDLER
	if(!lunge_target.Adjacent(source))
		return
	INVOKE_ASYNC(src, PROC_REF(pantherfling), lunge_target)

/// Null lunge target and reset throw vars
/datum/action/ability/activable/xeno/adrenalinejump/proc/clean_lunge_target()
	SIGNAL_HANDLER
	UnregisterSignal(lunge_target, COMSIG_QDELETING)
	UnregisterSignal(owner, COMSIG_MOVABLE_POST_THROW)
	lunge_target = null
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	owner.stop_throw()

/datum/action/ability/activable/xeno/adrenalinejump/proc/pantherfling(atom/targeted_atom)
	var/mob/living/lunge_target = targeted_atom
	var/fling_distance = 1

	xeno_owner.face_atom(lunge_target) //Face towards the victim

	xeno_owner.visible_message(span_xenowarning("\The [xeno_owner] effortlessly trips [lunge_target]!"), \
	span_xenowarning("We effortlessly trip [lunge_target]!"))
	playsound(lunge_target,'sound/weapons/alien_claw_block.ogg', 75, 1)

	xeno_owner.do_attack_animation(lunge_target, ATTACK_EFFECT_DISARM2)
	xeno_owner.plasma_stored += 50 //reward for our smart little panther

	if(isxeno(lunge_target))
		var/mob/living/carbon/xenomorph/xeno_lunge_target = lunge_target
		if(xeno_owner.issamexenohive(xeno_lunge_target)) //We don't fuck up friendlies
			return

	lunge_target.ParalyzeNoChain(1 SECONDS)
	lunge_target.throw_at(xeno_owner, fling_distance, 1, xeno_owner) //go under us


///////////////////////////////////
// ***************************************
// *********** Adrenaline rush
// ***************************************

/datum/action/ability/xeno_action/adrenaline_rush
	name = "Adrenaline rush"
	action_icon = 'modular_RUtgmc/icons/Xeno/actions.dmi'
	action_icon_state = "adrenaline_rush"
	desc = "Move faster."
	ability_cost = 10
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ADRENALINE_RUSH,
	)
	use_state_flags = ABILITY_USE_LYING
	action_type = ACTION_TOGGLE
	var/speed_activated = FALSE
	var/speed_bonus_active = FALSE

/datum/action/ability/xeno_action/adrenaline_rush/remove_action()
	rush_off(TRUE) // Ensure we remove the movespeed
	return ..()

/datum/action/ability/xeno_action/adrenaline_rush/can_use_action(silent = FALSE, override_flags)
	. = ..()
	if(speed_activated)
		return TRUE

/datum/action/ability/xeno_action/adrenaline_rush/action_activate()
	if(speed_activated)
		rush_off()
		return fail_activate()
	rush_on()
	succeed_activate()


/datum/action/ability/xeno_action/adrenaline_rush/proc/rush_on(silent = FALSE)
	var/mob/living/carbon/xenomorph/walker = owner
	speed_activated = TRUE
	if(!silent)
		owner.balloon_alert(owner, "It's time to run")
	if(walker.loc_weeds_type)
		speed_bonus_active = TRUE
		walker.add_movespeed_modifier(type, TRUE, 0, NONE, TRUE, -1.5)
	set_toggle(TRUE)
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(rush_on_moved))


/datum/action/ability/xeno_action/adrenaline_rush/proc/rush_off(silent = FALSE)
	var/mob/living/carbon/xenomorph/walker = owner
	if(!silent)
		owner.balloon_alert(owner, "Adrenaline rush is over")
	if(speed_bonus_active)
		walker.remove_movespeed_modifier(type)
		speed_bonus_active = FALSE
	speed_activated = FALSE
	set_toggle(FALSE)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)


/datum/action/ability/xeno_action/adrenaline_rush/proc/rush_on_moved(datum/source, atom/oldloc, direction, Forced = FALSE)
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/walker = owner
	if(!isturf(walker.loc) || walker.plasma_stored < 3)
		owner.balloon_alert(owner, "We are too tired to run so fast")
		rush_off(TRUE)
		return
	if(owner.m_intent == MOVE_INTENT_RUN)
		if(!speed_bonus_active)
			speed_bonus_active = TRUE
			walker.add_movespeed_modifier(type, TRUE, 0, NONE, TRUE, -1.5)
		walker.use_plasma(3)
		return
	if(!speed_bonus_active)
		return
	speed_bonus_active = FALSE
	walker.remove_movespeed_modifier(type)

// ***************************************
// *********** Select reagent (panther)
// ***************************************
/datum/action/ability/xeno_action/select_reagent/panther
	name = "Select Reagent"
	action_icon = 'modular_RUtgmc/icons/Xeno/actions.dmi'
	action_icon_state = "select_reagent0"
	desc = "Selects which reagent to use for tearing tail. Hemodile slows by 25%, increased to 50% with neurotoxin present, and deals 20% of damage received as stamina damage. Transvitox converts brute/burn damage to toxin based on 40% of damage received up to 45 toxin on target, upon reaching which causes a stun. Neurotoxin deals increasing stamina damage the longer it remains in the victim's system and prevents stamina regeneration. Ozelomelyn purges medical chemicals from humans, while also causing slight intoxication. Sanguinal does damage depending on presence and amount of all previously mentioned reagents, also causes light brute damage and bleeding."
	use_state_flags = ABILITY_USE_BUSY|ABILITY_USE_LYING
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PANTHER_SELECT_REAGENT,
		KEYBINDING_ALTERNATE = COMSIG_XENOABILITY_RADIAL_SELECT_REAGENT,
	)

/datum/action/ability/xeno_action/select_reagent/panther/give_action(mob/living/L)
	. = ..()
	xeno_owner.selected_reagent = GLOB.panther_toxin_type_list[1] //Set our default
	update_button_icon() //Update immediately to get our default

/datum/action/ability/xeno_action/select_reagent/panther/action_activate()
	var/i = GLOB.panther_toxin_type_list.Find(xeno_owner.selected_reagent)
	if(length_char(GLOB.panther_toxin_type_list) == i)
		xeno_owner.selected_reagent = GLOB.panther_toxin_type_list[1]
	else
		xeno_owner.selected_reagent = GLOB.panther_toxin_type_list[i+1]

	var/atom/A = xeno_owner.selected_reagent
	xeno_owner.balloon_alert(xeno_owner, "[initial(A.name)]")
	update_button_icon()
	return succeed_activate()

/datum/action/ability/xeno_action/select_reagent/panther/select_reagent_radial()
	//List of toxin images
	// This is cursed, don't copy this code its the WRONG way to do this.
	// TODO: generate this from GLOB.panther_toxin_type_list (or wait while offtgmc reworks the defiler code and then copy it )
	var/static/list/panther_toxin_images_list = list(
			PANTHER_HEMODILE = image('modular_RUtgmc/icons/Xeno/actions.dmi', icon_state = PANTHER_HEMODILE),
			PANTHER_TRANSVITOX = image('modular_RUtgmc/icons/Xeno/actions.dmi', icon_state = PANTHER_TRANSVITOX),
			PANTHER_OZELOMELYN = image('modular_RUtgmc/icons/Xeno/actions.dmi', icon_state = PANTHER_OZELOMELYN),
			PANTHER_SANGUINAL = image('modular_RUtgmc/icons/Xeno/actions.dmi', icon_state = PANTHER_SANGUINAL),
			PANTHER_APHROTOXIN = image('ntf_modular/icons/Xeno/actions.dmi', icon_state = PANTHER_APHROTOXIN),
			)
	var/toxin_choice = show_radial_menu(owner, owner, panther_toxin_images_list, radius = 48)
	if(!toxin_choice)
		return
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	for(var/toxin in GLOB.panther_toxin_type_list)
		var/datum/reagent/our_reagent = GLOB.chemical_reagents_list[toxin]
		if(our_reagent.name == toxin_choice)
			xeno_owner.selected_reagent = our_reagent.type
			break
	xeno_owner.balloon_alert(xeno_owner, "[toxin_choice]")
	update_button_icon()
	return succeed_activate()

#undef PANTHER_HEMODILE
#undef PANTHER_TRANSVITOX
#undef PANTHER_OZELOMELYN
#undef PANTHER_SANGUINAL
#undef PANTHER_APHROTOXIN
