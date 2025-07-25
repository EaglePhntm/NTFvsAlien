// ***************************************
// *********** Flay
// ***************************************
/datum/action/ability/activable/xeno/flay
	name = "Flay"
	action_icon_state = "flay"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "Takes a chunk of flesh from the victim marine through a quick swiping motion, adding 100 biomass to your biomass collection."

	ability_cost = 0
	cooldown_duration = 20 SECONDS
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_FLAY,
	)

/datum/action/ability/activable/xeno/flay/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/human/target_human = target
	if(!ishuman(target))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "not suitable!")
		return FALSE

	if(!xeno_owner.Adjacent(target_human))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "not adjacent!")
		return FALSE

	if(target_human.stat == DEAD)
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "dead!")
		return FALSE

/datum/action/ability/activable/xeno/flay/use_ability(mob/living/carbon/human/target_human)
	xeno_owner.face_atom(target_human)
	xeno_owner.do_attack_animation(target_human, ATTACK_EFFECT_REDSLASH)
	xeno_owner.visible_message(target_human, span_danger("[xeno_owner] flays and rips skin and flesh from [target_human]!"))
	playsound(target_human, SFX_ALIEN_CLAW_FLESH, 25, TRUE)
	target_human.emote("scream")
	xeno_owner.emote("roar")
	target_human.apply_damage(30, def_zone = BODY_ZONE_CHEST, blocked = MELEE, sharp = TRUE, edge = FALSE, updating_health = TRUE, penetration = 15)
	target_human.Paralyze(0.8 SECONDS)

	xeno_owner.gain_plasma(xeno_owner.xeno_caste.flay_plasma_gain)

	add_cooldown()

// ***************************************
// *********** Pincushion
// ***************************************
/datum/action/ability/activable/xeno/pincushion
	name = "Pincushion"
	action_icon_state = "pincushion"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "Launch a spine from your tail. This attack will help deter any organic as well as support your puppets and teammates in direct combat."
	cooldown_duration = 5 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PINCUSHION,
	)

/datum/action/ability/activable/xeno/pincushion/can_use_ability(atom/victim, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return
	if(xeno_owner.do_actions)
		return FALSE
	xeno_owner.face_atom(victim)
	if(!do_after(xeno_owner, 0.3 SECONDS, IGNORE_HELD_ITEM|IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE, victim, BUSY_ICON_DANGER, extra_checks = CALLBACK(xeno_owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = xeno_owner.health))))
		return FALSE
	succeed_activate()

/datum/action/ability/activable/xeno/pincushion/use_ability(atom/victim)
	var/turf/current_turf = get_turf(owner)
	playsound(xeno_owner.loc, 'sound/bullets/spear_armor1.ogg', 25, 1)
	xeno_owner.visible_message(span_warning("[xeno_owner] shoots a spike!"), span_xenonotice("We discharge a spinal spike from our body."))

	var/atom/movable/projectile/spine = new /atom/movable/projectile(current_turf)
	spine.generate_bullet(/datum/ammo/xeno/spine)
	spine.def_zone = xeno_owner.get_limbzone_target()
	spine.fire_at(victim, xeno_owner, xeno_owner, range = 6, speed = 1)

	add_cooldown()
// ***************************************
// *********** Dreadful Presence
// ***************************************
#define DREAD_RANGE 6
/datum/action/ability/xeno_action/dreadful_presence
	name = "Dreadful Presence"
	action_icon_state = "dreadful_presence"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "Emit a menacing presence, striking fear into the organics and slowing them for a short duration."
	ability_cost = 50
	cooldown_duration = 20 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_DREADFULPRESENCE,
	)

/datum/action/ability/xeno_action/dreadful_presence/action_activate()
	var/obj/effect/overlay/dread/effect = new
	owner.vis_contents += effect
	for(var/mob/living/carbon/human/human in view(DREAD_RANGE, owner.loc))
		to_chat(human, span_userdanger("An overwhelming sense of dread washes over you... You are temporarily slowed down!"))
		human.set_timed_status_effect(6 SECONDS, /datum/status_effect/dread)
		addtimer(CALLBACK(human, TYPE_PROC_REF(/mob/living/carbon/human, emote), "scream"), rand(1,2))
	addtimer(CALLBACK(src, PROC_REF(clear_effect), effect), 3 SECONDS)
	add_cooldown()
	succeed_activate()

/datum/action/ability/xeno_action/dreadful_presence/proc/clear_effect(atom/effect)
	owner.vis_contents -= effect
	qdel(effect)

#undef DREAD_RANGE
// ***************************************
// *********** Refurbish Husk
// ***************************************
/datum/action/ability/activable/xeno/refurbish_husk
	name = "Refurbish Husk"
	action_icon_state = "refurbish_husk"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "Harvest the biomass and organs of a body in order to create a meat puppet to do your bidding."
	cooldown_duration = 25 SECONDS
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_REFURBISHHUSK,
	)
	/// List of all our puppets
	var/list/mob/living/carbon/xenomorph/puppet/puppets = list()

/datum/action/ability/activable/xeno/refurbish_husk/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/target_human = target
	if(!ishuman(target))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "not suitable!")
		return FALSE
	if(length(puppets) >= xeno_owner.xeno_caste.max_puppets)
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "too many puppets! (max: [xeno_owner.xeno_caste.max_puppets])")
		return FALSE
	if(HAS_TRAIT(target, TRAIT_MAPSPAWNED) || HAS_TRAIT(target, TRAIT_HOLLOW))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "of no use!")
		return FALSE

	if(!xeno_owner.Adjacent(target_human))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "not adjacent!")
		return FALSE

#ifndef TESTING
	if(!HAS_TRAIT(target_human, TRAIT_UNDEFIBBABLE) || target_human.stat != DEAD)
		xeno_owner.balloon_alert(xeno_owner, "not dead and unrevivable!")
		return FALSE
#endif

	xeno_owner.face_atom(target_human)
	xeno_owner.visible_message(target_human, span_danger("[xeno_owner] begins carving out, doing all sorts of horrible things to [target_human]!"))
	if(!do_after(xeno_owner, 8 SECONDS, IGNORE_HELD_ITEM, target_human, BUSY_ICON_DANGER, extra_checks = CALLBACK(xeno_owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = xeno_owner.health))))
		return FALSE
	succeed_activate()

/datum/action/ability/activable/xeno/refurbish_husk/use_ability(mob/living/carbon/human/victim)
	var/turf/victim_turf = get_turf(victim)

	ADD_TRAIT(victim, TRAIT_HOLLOW, TRAIT_GENERIC)
	victim.spawn_gibs()
	var/mob/living/carbon/xenomorph/puppet/puppet = new(victim_turf, owner)
	puppet.voice = victim.voice
	add_puppet(puppet)
	add_cooldown()

/// Adds a puppet to our list
/datum/action/ability/activable/xeno/refurbish_husk/proc/add_puppet(mob/living/carbon/xenomorph/puppet/new_puppet)
	RegisterSignals(new_puppet, list(COMSIG_MOB_DEATH, COMSIG_QDELETING), PROC_REF(remove_puppet))
	RegisterSignal(new_puppet, COMSIG_XENOMORPH_POSTATTACK_LIVING, PROC_REF(postattack))
	puppets += new_puppet

/// Cleans up puppet from our list
/datum/action/ability/activable/xeno/refurbish_husk/proc/remove_puppet(datum/source)
	SIGNAL_HANDLER
	puppets -= source
	UnregisterSignal(source, list(COMSIG_MOB_DEATH, COMSIG_QDELETING, COMSIG_XENOMORPH_POSTATTACK_LIVING))

/datum/action/ability/activable/xeno/refurbish_husk/proc/postattack(mob/living/source, mob/living/target, damage)
	SIGNAL_HANDLER
	if(target.stat == DEAD)
		return
	xeno_owner.gain_plasma(floor(damage / 0.9))

// ***************************************
// *********** Stitch Puppet
// ***************************************
/datum/action/ability/activable/xeno/puppet
	name = "Stitch Puppet"
	action_icon_state = "stitch_puppet"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "Uses 125 biomass to create a flesh homunculus to do your bidding, at an adjacent target location."
	ability_cost = 125
	cooldown_duration = 25 SECONDS
	target_flags = ABILITY_TURF_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PUPPET,
	)

/datum/action/ability/activable/xeno/puppet/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return

	if(isclosedturf(target))
		if(!silent)
			target.balloon_alert(xeno_owner, "dense area")
		return FALSE

	var/datum/action/ability/activable/xeno/refurbish_husk/huskaction = owner.actions_by_path[/datum/action/ability/activable/xeno/refurbish_husk]
	if(length(huskaction.puppets) >= xeno_owner.xeno_caste.max_puppets)
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "too many puppets! (max: [xeno_owner.xeno_caste.max_puppets])")
		return FALSE

	if(!xeno_owner.Adjacent(target))
		if(!silent)
			xeno_owner.balloon_alert(xeno_owner, "not adjacent!")
		return FALSE

	xeno_owner.face_atom(target)
	//reverse gib here
	xeno_owner.visible_message(span_warning("[xeno_owner] begins to vomit out biomass and skillfully sews various bits and pieces together!"))
	if(!do_after(xeno_owner, 8 SECONDS, IGNORE_HELD_ITEM, target, BUSY_ICON_CLOCK, extra_checks = CALLBACK(xeno_owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = xeno_owner.health))))
		return FALSE
	xeno_owner.visible_message(span_warning("[xeno_owner] forms a repulsive puppet!"))
	succeed_activate()

/datum/action/ability/activable/xeno/puppet/use_ability(atom/target)
	var/turf/target_turf = get_turf(target)

	var/datum/action/ability/activable/xeno/refurbish_husk/huskaction = owner.actions_by_path[/datum/action/ability/activable/xeno/refurbish_husk]
	huskaction.add_puppet(new /mob/living/carbon/xenomorph/puppet(target_turf, owner))
	add_cooldown()

// ***************************************
// *********** Organic Bomb
// ***************************************
/datum/action/ability/activable/xeno/organic_bomb
	name = "Organic Bomb"
	action_icon_state = "organic_bomb"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "Causes one of our puppets to detonate on selection, spewing acid out of the puppet's body in all directions, gibbing the puppet."
	cooldown_duration = 30 SECONDS
	ability_cost = 100
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_ORGANICBOMB,
	)

/datum/action/ability/activable/xeno/organic_bomb/use_ability(mob/living/victim)
	. = ..()
	var/datum/action/ability/activable/xeno/refurbish_husk/huskaction = owner.actions_by_path[/datum/action/ability/activable/xeno/refurbish_husk]
	if(length(huskaction.puppets) <= 0)
		owner.balloon_alert(owner, "no puppets")
		return fail_activate()
	if(!istype(victim, /mob/living/carbon/xenomorph/puppet) || !(victim in huskaction.puppets))
		victim.balloon_alert(owner, "not our puppet")
		return fail_activate()
	if(!SEND_SIGNAL(victim, COMSIG_PUPPET_CHANGE_ORDER, PUPPET_SEEK_CLOSEST))
		victim.balloon_alert(owner, "fail")
		return fail_activate()
	RegisterSignal(victim, COMSIG_XENOMORPH_ATTACK_LIVING, PROC_REF(start_exploding))
	RegisterSignal(victim, COMSIG_MOB_DEATH, PROC_REF(detonate))
	addtimer(CALLBACK(src, PROC_REF(start_exploding), victim), 5 SECONDS)
	add_cooldown()

///asynchronous signal handler for start_exploding_async
/datum/action/ability/activable/xeno/organic_bomb/proc/start_exploding(mob/living/puppet)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(start_exploding_async), puppet)

///makes a puppet start a do_after to dexplode
/datum/action/ability/activable/xeno/organic_bomb/proc/start_exploding_async(mob/living/puppet)
	puppet.visible_message(span_danger("[puppet] bloats and slowly unfurls [puppet.p_their()] stitched body!"))
	if(do_after(puppet, 1.5 SECONDS, FALSE, puppet, BUSY_ICON_DANGER))
		detonate(puppet)

///detonates a puppet causing a spray of acid
/datum/action/ability/activable/xeno/organic_bomb/proc/detonate(mob/living/puppet)
	SIGNAL_HANDLER
	UnregisterSignal(puppet, list(COMSIG_XENOMORPH_ATTACK_LIVING, COMSIG_MOB_DEATH))
	var/turf/our_turf = get_turf(puppet)
	our_turf.visible_message(span_danger("[puppet] ruptures, releasing corrosive acid!"))
	playsound(our_turf, 'sound/bullets/acid_impact1.ogg', 50, 1)
	if(!QDELETED(puppet))
		puppet.gib()

	for(var/turf/acid_tile AS in RANGE_TURFS(2, our_turf))
		if(!line_of_sight(our_turf,acid_tile) || isclosedturf(acid_tile))
			continue
		xenomorph_spray(acid_tile, 12 SECONDS, 18, null, TRUE)
// ***************************************
// *********** Articulate
// ***************************************
/datum/action/ability/activable/xeno/articulate
	name = "Articulate"
	action_icon_state = "mimicry"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "Takes direct control of a Puppet’s vocal chords. Allows you to speak directly through your puppet to the talls."
	cooldown_duration = 10 SECONDS
	target_flags = ABILITY_MOB_TARGET
	///Whether we should cancel instead of doing the thing when activated
	var/talking = FALSE
	///our current target
	var/mob/living/carbon/active_target

/datum/action/ability/activable/xeno/articulate/use_ability(mob/living/victim)
	if(talking)
		cancel(owner)
		return fail_activate()
	var/datum/action/ability/activable/xeno/refurbish_husk/huskaction = owner.actions_by_path[/datum/action/ability/activable/xeno/refurbish_husk]
	if(!istype(victim, /mob/living/carbon/xenomorph/puppet) || !(victim in huskaction.puppets))
		victim.balloon_alert(owner, "not our puppet")
		return fail_activate()
	owner.balloon_alert(owner, "channeling voice, move or activate to cancel!")
	active_target = victim
	RegisterSignal(owner, COMSIG_MOB_SAY, PROC_REF(relay_speech))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(cancel))
	RegisterSignal(victim, COMSIG_QDELETING, PROC_REF(cancel))
	talking = TRUE
	add_cooldown()

/datum/action/ability/activable/xeno/articulate/proc/relay_speech(mob/living/carbon/source, arguments)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(relay_speech_async), active_target, arguments[SPEECH_MESSAGE])

/datum/action/ability/activable/xeno/articulate/proc/relay_speech_async(mob/living/carbon/target, text)
	target.say(text, language = /datum/language/common, forced = "puppeteer articulate ability")

/datum/action/ability/activable/xeno/articulate/proc/cancel(atom/target)
	SIGNAL_HANDLER
	if(talking)
		owner.balloon_alert(owner, "cancelled!")
	talking = FALSE
	active_target = null
	UnregisterSignal(owner, list(COMSIG_MOB_SAY, COMSIG_MOVABLE_MOVED, COMSIG_QDELETING))

// ***************************************
// *********** Tendrils (Primordial)
// ***************************************
/datum/action/ability/activable/xeno/tendril_patch
	name = "Tendrils"
	action_icon_state = "living_construct"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "Burrow freshly created tendrils to tangle organics in a 3x3 patch."
	ability_cost = 175
	cooldown_duration = 40 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TENDRILS,
	)

/datum/action/ability/activable/xeno/tendril_patch/use_ability(atom/movable/victim)
	var/turf/their_turf = get_turf(victim)
	var/mob/living/living_owner = owner
	living_owner.face_atom(victim)
	living_owner.visible_message(span_warning("[living_owner] begins to form biomass and force it into the ground!"))
	if(!do_after(living_owner, 3 SECONDS, FALSE, victim, BUSY_ICON_DANGER, extra_checks = CALLBACK(living_owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = living_owner.health))))
		return FALSE
	their_turf.visible_message(span_warning("[living_owner]'s tendrils burst out from the ground!"))
	for(var/turf/tile AS in RANGE_TURFS(1, their_turf))
		if(!locate(/obj/effect/tentacle) in tile.contents)
			new /obj/effect/tentacle(tile)
	add_cooldown()

/obj/effect/tentacle
	name = "tendril"
	icon = 'icons/effects/effects.dmi'
	icon_state = "tendril_1"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	anchored = TRUE

/obj/effect/tentacle/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(start_grabbing)), 0.4 SECONDS)

/// change our icon state and start a 0.3 second timer to call grab()
/obj/effect/tentacle/proc/start_grabbing()
	icon_state = "tendril_2"
	addtimer(CALLBACK(src, PROC_REF(grab)), 0.3 SECONDS, TIMER_STOPPABLE)

/// brute damage and paralyze everyone on our tile
/obj/effect/tentacle/proc/grab()
	for (var/mob/living/victim in loc)
		if (victim.stat == DEAD)
			continue
		if(isxeno(victim))
			continue
		balloon_alert(victim, "tangled!")
		visible_message(span_danger("[src] tangles [victim]!"))
		victim.adjustBruteLoss(10)
		victim.Paralyze(2 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(retract)), 0.3 SECONDS)

/// change our icon to our retracting icon and delete in 0.3 seconds
/obj/effect/tentacle/proc/retract()
	icon_state = "tendril_3"
	QDEL_IN(src, 0.4 SECONDS)

// ***************************************
// *********** Blessing
// ***************************************
/datum/action/ability/activable/xeno/puppet_blessings
	name = "Bestow Blessing"
	action_icon_state = "emit_pheromones"
	ability_cost = 200
	desc = "Give a permanent upgrade to a puppet."
	cooldown_duration = 30 SECONDS
	use_state_flags = ABILITY_USE_STAGGERED|ABILITY_USE_NOTTURF|ABILITY_USE_BUSY|ABILITY_USE_LYING
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_BESTOWBLESSINGS,
	)

/datum/action/ability/activable/xeno/puppet_blessings/can_use_ability(mob/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return fail_activate()
	if(!istype(target, /mob/living/carbon/xenomorph/puppet))
		owner.balloon_alert(owner, "not a puppet")
		return fail_activate()
	succeed_activate()

/datum/action/ability/activable/xeno/puppet_blessings/use_ability(mob/living/victim)
	var/choice = show_radial_menu(owner, owner, GLOB.puppeteer_phero_images_list, radius = 35)
	if(!choice)
		return fail_activate()
	var/effect_path
	switch(choice)
		if(AURA_XENO_BLESSFRENZY)
			effect_path = /datum/status_effect/blessing/frenzy
		if(AURA_XENO_BLESSFURY)
			effect_path = /datum/status_effect/blessing/fury
		if(AURA_XENO_BLESSWARDING)
			effect_path = /datum/status_effect/blessing/warding
	if(victim.has_status_effect(effect_path))
		victim.balloon_alert(owner, "already has this blessing!")
		return fail_activate()
	victim.balloon_alert(owner, "[choice]")
	victim.apply_status_effect(effect_path, xeno_owner)
	victim.med_hud_set_status()
	playsound(get_turf(xeno_owner), SFX_ALIEN_DROOL, 25)
	add_cooldown()

// ***************************************
// *********** Unleash puppets
// ***************************************
/datum/action/ability/xeno_action/puppeteer_unleash
	name = "Unleash Puppets"
	action_icon_state = "enrage"
	action_icon = 'icons/Xeno/actions/puppeteer.dmi'
	desc = "Send out your puppets to attack nearby humans"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_UNLEASHPUPPETS,
	)

/datum/action/ability/xeno_action/puppeteer_unleash/action_activate(mob/living/victim)
	if(SEND_SIGNAL(owner, COMSIG_PUPPET_CHANGE_ALL_ORDER, PUPPET_ATTACK))
		owner.balloon_alert(owner, "success")
		owner.visible_message(span_warning("[owner] swiftly manipulates the psychic strings of the puppets, ordering them to attack!"))
	else
		owner.balloon_alert(owner, "fail")

// ***************************************
// *********** Recall puppets
// ***************************************
/datum/action/ability/xeno_action/puppeteer_recall
	name = "Recall Puppets"
	action_icon = 'icons/mob/actions.dmi'
	action_icon_state = "rally"
	desc = "Recall your puppets to follow you once more"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_RECALLPUPPETS,
	)

/datum/action/ability/xeno_action/puppeteer_recall/action_activate(mob/living/victim)
	if(SEND_SIGNAL(owner, COMSIG_PUPPET_CHANGE_ALL_ORDER, PUPPET_RECALL))
		owner.balloon_alert(owner, "success")
		owner.visible_message(span_warning("[owner] quickly manipulates the psychic strings of the puppets, drawing them near!"))
	else
		owner.balloon_alert(owner, "fail")
