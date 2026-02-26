/datum/action/ability/xeno_action/phantom
	name = "Phantom"
	action_icon = 'modular_RUtgmc/icons/Xeno/actions.dmi'
	action_icon_state = "phantom"
	desc = "Create a physical clone and hide in shadows."
	cooldown_duration = 30 SECONDS
	ability_cost = 100
	use_state_flags = ABILITY_USE_STAGGERED
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CHIMERA_PHANTOM,
	)
	var/stealth_duration = 5 SECONDS
	var/mob/living/carbon/xenomorph/chimera/ai/phantom
	var/clone_duration = 7 SECONDS
	var/obj/effect/abstract/particle_holder/warpdust

/datum/action/ability/xeno_action/phantom/on_cooldown_finish()
	to_chat(owner, span_xenodanger("We gather enough strength to create a new phantom."))
	owner.playsound_local(owner, 'sound/effects/alien/new_larva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/xeno_action/phantom/action_activate()
	. = ..()
	var/mob/living/carbon/xenomorph/chimera/X = owner

	phantom = new /mob/living/carbon/xenomorph/chimera/phantom(get_turf(X))
	phantom.transfer_to_hive(X.get_xeno_hivenumber())
	addtimer(CALLBACK(phantom, TYPE_PROC_REF(/mob, gib)), clone_duration)

	succeed_activate()
	add_cooldown()

	new /obj/effect/temp_visual/alien_fruit_eaten(get_turf(X))
	playsound(X,'sound/effects/magic.ogg', 25, TRUE)

	if(X.on_fire)
		phantom.IgniteMob()
		return

	X.alpha = HUNTER_STEALTH_STILL_ALPHA
	addtimer(CALLBACK(src, PROC_REF(uncloak)), stealth_duration)

	RegisterSignals(X, list(
		COMSIG_XENOMORPH_GRAB,
		COMSIG_XENOMORPH_THROW_HIT,
		COMSIG_LIVING_IGNITED,
		COMSIG_XENOMORPH_ATTACK_OBJ,
		COMSIG_XENOMORPH_ATTACK_LIVING,
		COMSIG_XENO_LIVING_THROW_HIT,
		COMSIG_XENOMORPH_DISARM_HUMAN), PROC_REF(uncloak))

	ADD_TRAIT(X, TRAIT_TURRET_HIDDEN, STEALTH_TRAIT)

/datum/action/ability/xeno_action/phantom/proc/uncloak()
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/chimera/X = owner
	X.alpha = 255

	UnregisterSignal(X, list(
		COMSIG_XENOMORPH_GRAB,
		COMSIG_XENOMORPH_THROW_HIT,
		COMSIG_LIVING_IGNITED,
		COMSIG_XENOMORPH_ATTACK_OBJ,
		COMSIG_XENOMORPH_ATTACK_LIVING,
		COMSIG_XENO_LIVING_THROW_HIT,
		COMSIG_XENOMORPH_DISARM_HUMAN,))

	REMOVE_TRAIT(X, TRAIT_TURRET_HIDDEN, STEALTH_TRAIT)

/datum/action/ability/xeno_action/phantom/ai_should_start_consider()
	return FALSE

/datum/action/ability/xeno_action/phantom/ai_should_use(target)
	return FALSE

/datum/action/ability/activable/xeno/pounce/abduction
	name = "Abduction"
	action_icon = 'modular_RUtgmc/icons/Xeno/actions.dmi'
	action_icon_state = "abduction"
	desc = "Abduct the prey."
	cooldown_duration = 20 SECONDS
	ability_cost = 100
	use_state_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CHIMERA_ABDUCTION,
	)
	use_state_flags = null
	pounce_range = 5
	var/turf/initial_turf
	var/slowdown_amount = 6
	var/stagger_duration = 3 SECONDS

/datum/action/ability/activable/xeno/pounce/abduction/on_cooldown_finish()
	to_chat(owner, span_xenodanger("We gather enough strength to abduct another one."))
	owner.playsound_local(owner, 'sound/effects/alien/new_larva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/activable/xeno/pounce/abduction/use_ability(atom/A)
	initial_turf = get_turf(owner)
	return ..()

/datum/action/ability/activable/xeno/pounce/abduction/mob_hit(datum/source, mob/living/living_target)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(abduct), living_target)

/datum/action/ability/activable/xeno/pounce/abduction/proc/abduct(mob/living/target)
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(movement_fx))
	if(!do_after(xeno_owner, 0.5 SECONDS, IGNORE_HELD_ITEM, target, BUSY_ICON_DANGER))
		UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
		return
	xeno_owner.throw_at(initial_turf, pounce_range, XENO_POUNCE_SPEED, xeno_owner)
	if(target)
		target.throw_at(initial_turf, pounce_range, XENO_POUNCE_SPEED, xeno_owner)
		target.add_slowdown(slowdown_amount)
		target.adjust_stagger(stagger_duration)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

/datum/action/ability/activable/xeno/pounce/abduction/ai_should_start_consider()
	return FALSE

/datum/action/ability/activable/xeno/pounce/abduction/ai_should_use(target)
	return FALSE

/datum/action/ability/xeno_action/warp_blast
	name = "Warp Blast"
	action_icon = 'modular_RUtgmc/icons/Xeno/actions.dmi'
	action_icon_state = "warp_blast"
	desc = "Create a pure force explosion that damages and knockbacks targets around."
	cooldown_duration = 20 SECONDS
	ability_cost = 100
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CHIMERA_WARP_BLAST,
	)
	var/range = 2
	var/warp_blast_damage = 30

/datum/action/ability/xeno_action/warp_blast/action_activate()
	. = ..()
	playsound(owner,'sound/effects/bamf.ogg', 75, TRUE)
	new /obj/effect/temp_visual/shockwave(get_turf(owner), range)
	for(var/mob/living/living_target in cheap_get_humans_near(get_turf(owner), range))

		if(living_target.stat == DEAD || living_target == owner || !line_of_sight(owner, living_target))
			continue

		playsound(living_target,'sound/weapons/alien_claw_block.ogg', 75, 1)
		living_target.apply_effects(0.5 SECONDS, 0.5 SECONDS)
		living_target.apply_damage(warp_blast_damage, BRUTE, blocked = BOMB)
		living_target.apply_damage(warp_blast_damage * 2, STAMINA, blocked = BOMB)
		var/throwlocation = living_target.loc
		for(var/x in 1 to 3)
			throwlocation = get_step(throwlocation, get_dir(owner, living_target))
		living_target.throw_at(throwlocation, 2, 1, owner, TRUE)
	succeed_activate()
	add_cooldown()

/datum/action/ability/activable/xeno/body_swap
	name = "Body swap"
	action_icon = 'modular_RUtgmc/icons/Xeno/actions.dmi'
	action_icon_state = "bodyswap"
	desc = "Swap places with another alien."
	use_state_flags = ABILITY_MOB_TARGET
	cooldown_duration = 20 SECONDS
	ability_cost = 100
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CHIMERA_BODYSWAP,
	)

/datum/action/ability/activable/xeno/body_swap/on_cooldown_finish()
	to_chat(owner, span_xenodanger("We gather enough strength to perform body swap again."))
	owner.playsound_local(owner, 'sound/effects/alien/new_larva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/activable/xeno/body_swap/use_ability(atom/A)
	. = ..()
	if(!isxeno(A))
		owner.balloon_alert(owner, "We can only swap places with another alien.")
		return fail_activate()
	if(get_dist(owner, A) > 9 || owner.z != A.z)
		owner.balloon_alert(owner, "We are too far away!")
		return fail_activate()

	var/mob/living/carbon/xenomorph/target = A
	var/mob/living/carbon/xenomorph/chimera/X = owner
	var/turf/target_turf = get_turf(A)
	var/turf/origin_turf = get_turf(X)

	new /obj/effect/temp_visual/blink_portal(origin_turf)
	new /obj/effect/temp_visual/blink_portal(target_turf)
	new /obj/effect/particle_effect/sparks(origin_turf)
	new /obj/effect/particle_effect/sparks(target_turf)
	playsound(target_turf, 'sound/effects/EMPulse.ogg', 25, TRUE)

	X.face_atom(target_turf)
	target.forceMove(origin_turf)
	X.forceMove(target_turf)

	succeed_activate()
	add_cooldown()

/particles/xeno_slash/vampirism/crippling_strike
	icon_state = "x"
	color = "#440088"
	count = 0
	velocity = list(50, 50)
	drift = generator(GEN_CIRCLE, 15, 15, NORMAL_RAND)
	gravity = list(0, 0)

/datum/action/ability/xeno_action/crippling_strike
	name = "Toggle crippling strike"
	action_icon = 'modular_RUtgmc/icons/Xeno/actions.dmi'
	action_icon_state = "neuroclaws_off"
	desc = "Toggle on to enable crippling attacks"
	ability_cost = 0
	cooldown_duration = 1 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY | ABILITY_IGNORE_SELECTED_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CHIMERA_CRIPPLING_STRIKE,
	)
	var/mob/living/old_target
	var/additional_damage = 2
	var/slowdown_amount = 1
	var/stagger_duration = 0.2 SECONDS
	var/heal_amount = 25
	var/plasma_gain = 30
	var/stacks = 0
	var/stacks_max = 5
	var/decay_time = 7 SECONDS
	var/obj/effect/abstract/particle_holder/particle_holder

/datum/action/ability/xeno_action/crippling_strike/update_button_icon()
	var/mob/living/carbon/xenomorph/xeno = owner
	action_icon_state = xeno.vampirism ? "neuroclaws_on" : "neuroclaws_off"
	return ..()

/datum/action/ability/xeno_action/crippling_strike/give_action(mob/living/L)
	. = ..()
	var/mob/living/carbon/xenomorph/xeno = L
	xeno.vampirism = TRUE
	particle_holder = new(xeno, /particles/xeno_slash/vampirism/crippling_strike)
	particle_holder.pixel_y = 18
	particle_holder.pixel_x = 18
	START_PROCESSING(SSprocessing, src)
	RegisterSignal(L, COMSIG_XENOMORPH_POSTATTACK_LIVING, PROC_REF(on_slash))

/datum/action/ability/xeno_action/crippling_strike/remove_action(mob/living/L)
	. = ..()
	var/mob/living/carbon/xenomorph/xeno = L
	xeno.vampirism = FALSE
	stacks = 0
	QDEL_NULL(particle_holder)
	STOP_PROCESSING(SSprocessing, src)
	UnregisterSignal(L, COMSIG_XENOMORPH_POSTATTACK_LIVING)

/datum/action/ability/xeno_action/crippling_strike/action_activate()
	. = ..()
	var/mob/living/carbon/xenomorph/xeno = owner
	xeno.vampirism = !xeno.vampirism
	if(xeno.vampirism)
		particle_holder = new(xeno, /particles/xeno_slash/vampirism/crippling_strike)
		particle_holder.pixel_y = 18
		particle_holder.pixel_x = 18
		START_PROCESSING(SSprocessing, src)
		RegisterSignal(xeno, COMSIG_XENOMORPH_POSTATTACK_LIVING, PROC_REF(on_slash))
	else
		stacks = 0
		QDEL_NULL(particle_holder)
		STOP_PROCESSING(SSprocessing, src)
		UnregisterSignal(xeno, COMSIG_XENOMORPH_POSTATTACK_LIVING)
	to_chat(xeno, span_xenonotice("You will now[xeno.vampirism ? "" : " no longer"] debuff targets"))

/datum/action/ability/xeno_action/crippling_strike/process()
	particle_holder.particles.count = stacks * stacks
	if(decay_time > 0)
		decay_time -= 1 SECONDS
		return
	if(stacks > 0)
		stacks--
	if(stacks == 0)
		particle_holder.particles.count = 0

/datum/action/ability/xeno_action/crippling_strike/proc/on_slash(datum/source, mob/living/target, damage, list/damage_mod, list/armor_mod)
	SIGNAL_HANDLER
	if(target.stat == DEAD)
		return
	if(!ishuman(target))
		return
	if(old_target != target)
		old_target = target
		stacks = max(0, stacks - 2)
	var/mob/living/carbon/xenomorph/X = owner
	target.apply_damage(additional_damage * stacks, BRUTE, X.zone_selected, blocked = FALSE)
	target.add_slowdown(slowdown_amount * stacks)
	target.adjust_stagger(stagger_duration * stacks)
	if(stacks == stacks_max)
		X.heal_overall_damage(heal_amount, heal_amount, updating_health = TRUE)
		X.gain_plasma(plasma_gain)
	if(stacks < stacks_max)
		stacks++
	decay_time = initial(decay_time)
	update_button_icon()

/datum/action/ability/activable/xeno/blink/chimera
	ability_cost = 75
