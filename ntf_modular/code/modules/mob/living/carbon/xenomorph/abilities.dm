
// Stew pod
/datum/action/ability/xeno_action/place_stew_pod
	name = "Place Ambrosia Pot"
	action_icon_state = "resin_stew_pod"
	action_icon = 'ntf_modular/icons/xeno/construction.dmi'
	desc = "Place down a dispenser that allows you to retrieve expensive jelly that may sold to humans. Each xeno can only own two pots at once."
	ability_cost = 50
	cooldown_duration = 10 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PLACE_STEW_POD,
	)

	gamemode_flags = ABILITY_ALL_GAMEMODE
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/xeno_action/place_stew_pod/can_use_action(silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return
	var/turf/T = get_turf(owner)
	if(!T || !T.is_weedable() || T.density)
		if(!silent)
			owner.balloon_alert(owner, "Cannot place pot")
		return FALSE

	if(!xeno_owner.loc_weeds_type)
		if(!silent)
			owner.balloon_alert(owner, "Cannot place pot, no weeds")
		return FALSE

	if(!T.check_disallow_alien_fortification(owner, silent))
		return FALSE

	if(!T.check_alien_construction(owner, silent, /obj/structure/xeno/resin_stew_pod))
		return FALSE

	var/hivenumber = owner.get_xeno_hivenumber()
	for(var/obj/silo AS in GLOB.xeno_resin_silos_by_hive[hivenumber])
		if((silo.z == xeno_owner.z) && (get_dist(xeno_owner, silo) <= 5))
			if(!silent)
				owner.balloon_alert(owner, "One of our hive's silos is too close!")
			return FALSE
	var/datum/hive_status/hive = GLOB.hive_datums[hivenumber]
	for(var/obj/req_jelly_pod AS in hive.req_jelly_pods)
		if((req_jelly_pod.z == xeno_owner.z) && (get_dist(xeno_owner, req_jelly_pod) <= 5))
			if(!silent)
				owner.balloon_alert(owner, "One of our hive's ambrosia pots is too close!")
			return FALSE

/datum/action/ability/xeno_action/place_stew_pod/action_activate()
	var/turf/T = get_turf(owner)

	succeed_activate()
	var/hivenumber = owner.get_xeno_hivenumber()
	var/datum/hive_status/hive = GLOB.hive_datums[hivenumber]
	var/list/existing_pods = list()
	for(var/obj/structure/xeno/resin_stew_pod/resin_stew_pod AS in hive.req_jelly_pods)
		if(resin_stew_pod.creator_ckey == xeno_owner.ckey)
			existing_pods += resin_stew_pod
			if(length(existing_pods) >= 2) // max two per xeno
				qdel(existing_pods[1]) // should be the oldest one
				existing_pods -= null
				to_chat(owner, span_xenonotice("One of your existing ambrosia pots was destroyed because you have too many."))
	playsound(owner, SFX_ALIEN_RESIN_BUILD, 25)
	var/obj/structure/xeno/resin_stew_pod/pod = new(T, hivenumber)
	pod.creator_ckey = owner.ckey
	to_chat(owner, span_xenonotice("We shape some resin into \a [pod]."))
	add_cooldown()

// ***************************************
// *********** Psychic Radiance
// ***************************************
/datum/action/ability/xeno_action/psychic_radiance
	name = "Psychic Radiance"
	desc = "Use your psychic powers to send a message to all humans you can see."
	action_icon_state = "psychic_radiance"
	action_icon = 'ntf_modular/icons/xeno/actions.dmi'
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PSYCHIC_RADIANCE,
	)
	use_state_flags = ABILITY_USE_INCAP|ABILITY_USE_LYING|ABILITY_USE_BUCKLED|ABILITY_USE_STAGGERED|ABILITY_USE_FORTIFIED|ABILITY_USE_NOTTURF|ABILITY_USE_BUSY|ABILITY_USE_SOLIDOBJECT|ABILITY_USE_BURROWED // Proudly copypasted from psychic whisper
	target_flags = ABILITY_MOB_TARGET

/datum/action/ability/xeno_action/psychic_radiance/action_activate()
	var/mob/living/carbon/xenomorph/X = owner
	var/list/target_list = list()
	for(var/mob/living/possible_target in view(WORLD_VIEW, X))
		if(possible_target == X || !possible_target.client || isxeno(possible_target)) // Would ruin the whole point if we whisper to xenos too
			continue
		target_list += possible_target

	if(!length(target_list))
		to_chat(X, span_warning("There's nobody nearby to radiate to."))
		return

	var/msg = tgui_input_text(usr, desc, name, "", MAX_MESSAGE_LEN, multiline = TRUE, encode = FALSE)

	msg = copytext_char(trim(sanitize(msg)), 1, MAX_MESSAGE_LEN)

	if(!msg)
		return

	if(X.stat)
		to_chat(src, span_warning("We cannot do this while not conscious."))
		return

	for(var/mob/living/L in target_list)
		to_chat(L, span_psychicin("You hear a strange, alien voice in your head. <i>\"[msg]\"</i>"))
		log_directed_talk(X, L, msg, LOG_SAY, "psychic radiance")

	to_chat(X, span_psychicout("We radiated: \"[msg]\" to everyone nearby."))
	message_admins("[ADMIN_LOOKUP(X)] has sent this psychic radiance: \"[msg]\" at [ADMIN_VERBOSEJMP(X)].")

// ***************************************
// *********** Psychic Influence
// ***************************************
/datum/action/ability/xeno_action/psychic_influence
	name = "Psychic Influence"
	desc = "Use your psychic powers to plant a thought in the mind of an individual you can see."
	action_icon = 'ntf_modular/icons/Xeno/actions.dmi'
	action_icon_state = "psychic_whisper"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_PSYCHIC_INFLUENCE,
	)
	use_state_flags = ABILITY_USE_INCAP|ABILITY_USE_LYING|ABILITY_USE_BUCKLED|ABILITY_USE_STAGGERED|ABILITY_USE_FORTIFIED|ABILITY_USE_NOTTURF|ABILITY_USE_BUSY|ABILITY_USE_SOLIDOBJECT|ABILITY_USE_BURROWED
	target_flags = ABILITY_MOB_TARGET


/datum/action/ability/xeno_action/psychic_influence/action_activate()
	var/mob/living/carbon/xenomorph/X = owner
	var/list/target_list = list()
	for(var/mob/living/possible_target in view(WORLD_VIEW, X))
		if(possible_target == X || !possible_target.client) // Removed the Isxeno; time for some xeno on xeno psychic shenanigans ;
			continue
		target_list += possible_target

	if(!length(target_list))
		to_chat(X, "<span class='warning'>There's nobody nearby to influence.</span>")
		return

	var/mob/living/L = tgui_input_list(X, "Target", "Send a Psychic Influence to whom?", target_list)
	if(!L)
		return

	if(X.stat)
		to_chat(src, span_warning("We cannot do this while not conscious."))
		return

	var/msg = tgui_input_text(usr, desc, name, "", MAX_MESSAGE_LEN, multiline = TRUE, encode = FALSE)

	msg = copytext_char(trim(sanitize(msg)), 1, MAX_MESSAGE_LEN)

	if(!msg)
		return

	if(X.stat)
		to_chat(src, span_warning("We cannot do this while not conscious."))
		return

	log_directed_talk(X, L, msg, LOG_SAY, "psychic influence")
	to_chat(L, "<span class='psychicin'><i>[msg]</i></span>")
	to_chat(X, "<span class='psychicout'>We influenced: [msg] to [L]</span>")
	for(var/_M in GLOB.observer_list) // it's the xeno's main method of S M U T, so it should be visible
		var/mob/M = _M
		if(M == L || M == X)
			continue
		if(M.stat != DEAD) //not dead, not important
			continue
		if(!M.client)
			continue
		if(get_dist(M, X) > 7 || M.z != X.z) //they're out of range of normal S M U T
			if(!(M.client.prefs.toggles_chat & CHAT_GHOSTEARS) && !check_other_rights(M.client, R_ADMIN, FALSE))
				continue
		if((istype(M.remote_control, /mob/camera/aiEye) || isAI(M))) // Not sure why this is here really, but better S M U T than sorry
			continue

		if(check_other_rights(M.client, R_ADMIN, FALSE))
			to_chat(M, "[FOLLOW_LINK(M, X)]<span class='psychicin'>Psychic Influence: <b>[ADMIN_LOOKUP(X)] > [ADMIN_LOOKUP(L)]:</b> <i>\"[msg]\"</i></span>")
		else
			to_chat(M, "[FOLLOW_LINK(M, X)]<span class='psychicin'>Psychic Influence: <b>[X] > [L]:</b> <i>\"[msg]\"</i></span>")

//Xeno Larval Growth Sting
/datum/action/ability/activable/xeno/larval_growth_sting
	name = "Larval Growth Sting"
	action_icon = 'ntf_modular/icons/Xeno/actions.dmi'
	action_icon_state = "larval_growth"
	desc = "Inject an impregnated host with growth serum, causing the larva inside to grow quicker. Has harmful effects for non-infected hosts while stabilizing larva-infected hosts."

	ability_cost = 150
	cooldown_duration = 30 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_LARVAL_GROWTH_STING,
	)
	target_flags = ABILITY_MOB_TARGET

/datum/action/ability/activable/xeno/larval_growth_sting/on_cooldown_finish()
	playsound(owner.loc, SFX_ALIEN_DROOL, 25, 1)
	to_chat(owner, "<span class='xenodanger'>We feel our growth toxin glands refill. We can use Growth Sting again.</span>")
	return ..()

/datum/action/ability/activable/xeno/larval_growth_sting/can_use_ability(mob/living/carbon/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE

	if(QDELETED(A))
		return FALSE

	if(!A?.can_sting())
		if(!silent)
			to_chat(owner, "<span class='warning'>Our sting won't affect this target!</span>")
		return FALSE

	if(!owner.Adjacent(A))
		var/mob/living/carbon/xenomorph/X = owner
		if(!silent && world.time > (X.recent_notice + X.notice_delay))
			to_chat(X, "<span class='warning'>We can't reach this target!</span>")
			X.recent_notice = world.time //anti-notice spam
		return FALSE

/datum/action/ability/activable/xeno/larval_growth_sting/use_ability(mob/living/carbon/A)
	var/mob/living/carbon/xenomorph/X = owner

	succeed_activate()

	add_cooldown()
	if(locate(/obj/item/alien_embryo) in A)
		X.recurring_injection(A, list(/datum/reagent/consumable/larvajelly,/datum/reagent/medicine/tricordrazine,/datum/reagent/medicine/inaprovaline,/datum/reagent/medicine/dexalin), XENO_LARVAL_CHANNEL_TIME, XENO_LARVAL_AMOUNT_RECURRING, 3)
		A.reagents.add_reagent(/datum/reagent/medicine/spaceacillin, 1)
	else
		X.recurring_injection(A, list(/datum/reagent/toxin/xeno_neurotoxin,/datum/reagent/consumable/larvajelly), XENO_LARVAL_CHANNEL_TIME, XENO_LARVAL_AMOUNT_RECURRING, 3)

/mob/living/carbon/human/salve_healing()
	. = ..()
	xeno_heals++
	if((xeno_heals % 3) == 0)
		for(var/datum/limb/limb_to_fix in shuffle(limbs))
			if(limb_to_fix.limb_status & (LIMB_BROKEN | LIMB_SPLINTED | LIMB_STABILIZED))
				if(limb_to_fix.brute_dam > limb_to_fix.min_broken_damage)
					continue
				limb_to_fix.remove_limb_flags(LIMB_BROKEN | LIMB_SPLINTED | LIMB_STABILIZED)
				limb_to_fix.add_limb_flags(LIMB_REPAIRED)
				visible_message("[src]'s broken [limb_to_fix.name] is repaired by the healing!", "Your broken [limb_to_fix.name] is repaired by the healing!")
				break

/mob/living/carbon/human/psychic_cure()
	. = ..()
	xeno_heals++
	if((xeno_heals % 3) == 0)
		for(var/datum/limb/limb_to_fix in shuffle(limbs))
			if(limb_to_fix.limb_status & (LIMB_BROKEN | LIMB_SPLINTED | LIMB_STABILIZED))
				if(limb_to_fix.brute_dam > limb_to_fix.min_broken_damage)
					continue
				limb_to_fix.remove_limb_flags(LIMB_BROKEN | LIMB_SPLINTED | LIMB_STABILIZED)
				limb_to_fix.add_limb_flags(LIMB_REPAIRED)
				visible_message("[src]'s broken [limb_to_fix.name] is repaired by the healing!", "Your broken [limb_to_fix.name] is repaired by the healing!")
				break

///
/// ******** Possession *****
/// For taking over mobs as mob makers/hivemind
/datum/action/ability/activable/xeno/possession
	name = "Minion Possession"
	action_icon = 'ntf_modular/icons/Xeno/actions.dmi'
	action_icon_state = "baneling"
	desc = "Take control of a minion that you have jurisdiction over."

	ability_cost = 1 // Change later
	cooldown_duration = 1 SECONDS // Same here
	action_type = ACTION_SELECT
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_POSSESS,
	)
	target_flags = ABILITY_XENO_TARGET

/*/datum/action/ability/activable/xeno/possession/can_use_action(silent, override_flags, selecting)
	. = ..()
	if(!.)
		return
	if (owner.status_flags & INCORPOREAL)
		return FALSE*/

/datum/action/ability/activable/xeno/possession/use_ability(atom/movable/A)
	var/mob/living/carbon/xenomorph/X = owner
	if(!ismob(A))
		return FALSE
	if(X.do_actions)
		return FALSE
	if(!X.issamexenohive(A))
		return FALSE
	if(!can_use_action(X, TRUE))
		return FALSE
	if(!isxeno(A))
		return FALSE

	var/mob/living/carbon/xenomorph/new_mob = A
	if(istype(X.xeno_caste, /datum/xeno_caste/hivemind))
		if(!istype(new_mob.xeno_caste, /datum/xeno_caste/beetle) && \
			!istype(new_mob.xeno_caste, /datum/xeno_caste/mantis) && \
			!istype(new_mob.xeno_caste, /datum/xeno_caste/scorpion) && \
			!istype(new_mob.xeno_caste, /datum/xeno_caste/nymph) \
		)
			return FALSE

	if(isxenopuppeteer(X))
		if(!istype(new_mob.xeno_caste, /datum/xeno_caste/puppet))
			return FALSE
			/*if( /datum/weakref/weak_master < puppytear ref) Allows puppeteers to take over other peoples puppets until this works... nobody plays puppeteer though*/

	if(isxenowidow(X))
		if(!istype(new_mob.xeno_caste, /datum/xeno_caste/spiderling))
			return FALSE
			/*if( mob/living/carbon/xenomorph/spidermother < widdy ref) Allows widows to take over other peoples spiders until this works... nobody plays widow though*/

	A.visible_message(span_xenowarning("[A] lightly shimmers and wakes up."), \
	span_xenowarning("We feel a controlling chill."))
	playsound(A, SFX_ALIEN_DROOL, 25)
	new /obj/effect/temp_visual/telekinesis(get_turf(A))
	succeed_activate()
	add_cooldown()
	if(HAS_TRAIT(new_mob, TRAIT_POSSESSING))
		to_chat(X, span_warning("That mob is currently possessing a different mob."))
		return FALSE

	if(new_mob.client)
		to_chat(X, span_warning("That mob has been occupied."))
		return FALSE

	if(new_mob.stat == DEAD)
		to_chat(X, span_warning("You cannot join if the mob is dead."))
		return FALSE

	if(!ishuman(new_mob))
		var/datum/action/ability/xeno_action/return_to_body/returning = new_mob.actions_by_path[/datum/action/ability/xeno_action/return_to_body]
		if(returning)
			if(!returning.action_activate())
				returning.remove_action(new_mob)
		log_admin("[owner.key] took control of [new_mob.name] as [new_mob.p_they()] used the possession ability.")
		new_mob.transfer_mob(owner)
		returning = new
		returning.give_action(new_mob)
		returning.old_mob = owner
		ADD_TRAIT(X, TRAIT_POSSESSING, TRAIT_POSSESSING)
		return TRUE

///****For getting back to your body****
/datum/action/ability/xeno_action/return_to_body
	name = "Return to Body"
	action_icon = 'ntf_modular/icons/Xeno/actions.dmi'
	action_icon_state = "baneling"
	desc = "Release control of a minion that you have jurisdiction over."
	ability_cost = 0 // Change later
	cooldown_duration = 0 SECONDS // Same here
	action_type = ACTION_CLICK
	target_flags = ABILITY_XENO_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_RETURN,
	)

/datum/action/ability/xeno_action/return_to_body
	var/mob/living/carbon/xenomorph/old_mob = null

	var/datum/action/ability/xeno_action/return_to_body/leaving = /datum/action/ability/xeno_action/return_to_body
	use_state_flags = ABILITY_USE_INCAP|ABILITY_USE_LYING|ABILITY_USE_BUCKLED|ABILITY_USE_STAGGERED|ABILITY_USE_FORTIFIED|ABILITY_USE_NOTTURF|ABILITY_USE_BUSY|ABILITY_USE_SOLIDOBJECT|ABILITY_USE_BURROWED


/datum/action/ability/xeno_action/return_to_body/action_activate(xeno_owner)
	var/mob/living/carbon/xenomorph/X = owner
	if(!owner || QDELETED(old_mob))
		to_chat(src, span_warning("Your old body is gone."))
		return FALSE

	if(old_mob.key)
		to_chat(src, span_warning("Another consciousness is in your body...It is resisting you."))
		return FALSE

	old_mob.transfer_mob(owner)
	X.possessor = null
	leaving.remove_action(X)
	src.old_mob = null
	REMOVE_TRAIT(old_mob, TRAIT_POSSESSING, TRAIT_POSSESSING)
	return TRUE

// For the hivemind to create non-AI driven minions, unfortunately this doesn't work right now. Try again later.
/*/datum/action/ability/activable/xeno/creation
	name = "Minion Creation"
	action_icon = 'ntf_modular/icons/Xeno/actions.dmi'
	action_icon_state = "spawn_pod"
	desc = "Create a brainless minion to be possessed by you."

	ability_cost = 1 // Change later
	cooldown_duration = 1 SECONDS // Same here
	action_type = ACTION_TOGGLE
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_CREATE,
	)
	target_flags = ABILITY_TURF_TARGET
	var/list/spawnable_minions = list(
		/mob/living/carbon/xenomorph/beetle,
		/mob/living/carbon/xenomorph/nymph,
		/mob/living/carbon/xenomorph/mantis,
		/mob/living/carbon/xenomorph/scorpion,)


/datum/action/ability/activable/xeno/creation/can_use_action(silent, override_flags, selecting)
	. = ..()
	if(!.)
		return
	if (owner.status_flags & INCORPOREAL)
		return FALSE

/datum/action/ability/activable/xeno/creation/action_activate()
	//Left click on the secrete resin button opens up radial menu (new type of changing structures).
	if(xeno_owner.selected_ability != src)
		return ..()
	. = ..()
	var/spawn_choice = show_radial_menu(owner, owner, GLOB.spawnable_minion_list, radius = 35)
	if(!spawn_choice)
		return
	set_spawn_type(spawnable_minions[GLOB.spawnable_minion_list.Find(spawn_choice)])

/*	var/mob/living/carbon/xenomorph/spiderling/new_spiderling = new(owner.loc, owner, owner)*/

/datum/action/ability/activable/xeno/creation/proc/set_spawn_type(new_spawn, silent = FALSE)
	var/mob/living/carbon/xenomorph/xeno_owner = owner
	xeno_owner.spawn_choice = new_spawn
	update_button_icon()
	if(silent)
		return
	var/atom/spawnn = xeno_owner.spawn_choice
	xeno_owner.balloon_alert(xeno_owner, lowertext(spawnn::name))

	/datum/action/ability/activable/xeno/creation/proc/choose_spawn()
	var/list/available_spawns = list()
	for(var/obj/alien/weeds/node/minion_type_possible AS in spawnable_minions)
		var/minion_image = GLOB.spawnable_minion_list[initial(weed_type_possible.name)]
		if(!minion_image)
			continue
		available_spawns[initial(minion_type_possible.name)] = minion_image

	var/weed_choice = show_radial_menu(xeno_owner, xeno_owner, available_weeds, radius = 48)
	if(!weed_choice)
		return
	else
		for(var/obj/alien/weeds/node/weed_type_possible AS in GLOB.weed_type_list)
			if(initial(weed_type_possible.name) == weed_choice)
				weed_type = weed_type_possible
				update_ability_cost()
				break
		to_chat(owner, span_xenonotice("We will now spawn <b>[weed_choice]\s</b> when using the plant weeds ability."))
	update_button_icon()*/

/////////////////////////////////
// Devour/Abduct
/////////////////////////////////
/datum/action/ability/activable/xeno/devour
	name = "Abduct"
	action_icon = 'ntf_modular/icons/Xeno/actions.dmi'
	action_icon_state = "abduct_on"
	desc = "Abduct your victim to be able to carry it around. RCLICK to toggle between haul and devour modes."
	use_state_flags = ABILITY_USE_STAGGERED|ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED //can't use while staggered, defender fortified or crest down
	ability_cost = 0
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_DEVOUR,
	)
	var/haul_mode = TRUE

/datum/action/ability/activable/xeno/devour/can_use_ability(atom/target, silent, override_flags)
	. = ..()
	if(!.)
		return
	if(!ismob(target))
		if(!silent)
			to_chat(owner, span_warning("That wouldn't work."))
		return FALSE
	if(haul_mode && !ishuman(target))
		if(!silent)
			to_chat(owner, span_warning("We can only carry humanoids."))
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human = target
		if(human.stat == DEAD && !(SSticker.mode.round_type_flags & MODE_XENO_GRAB_DEAD_ALLOWED)) // Can't drag dead human bodies.
			to_chat(owner,span_xenowarning("We have no reason to do that."))
			return FALSE
	if(isxeno(target) && haul_mode)
		to_chat(owner,span_xenowarning("We cant carry them."))
		return FALSE
	var/mob/living/carbon/human/victim = target
	if(owner.status_flags & INCORPOREAL)
		if(!silent)
			to_chat(owner, span_warning("Can't do while in flight!"))
		return FALSE
	if(owner.do_actions) //can't use if busy
		return FALSE
	if(!owner.Adjacent(victim)) //checks if owner next to target
		return FALSE
	if(HAS_TRAIT(victim, TRAIT_TIME_SHIFTED))
		to_chat(owner, span_warning("They are anchored in time!"))
		return FALSE
	if(isxeno(victim))
		if(!isxenolarva(victim))
			to_chat(owner, span_warning("Not a larva, it would be hard to pick this one up"))
			return FALSE
	if(victim.buckled)
		if(!silent)
			to_chat(owner, span_warning("[victim] is buckled to something."))
		return FALSE
	var/mob/living/carbon/xenomorph/owner_xeno = owner
	if(owner_xeno.eaten_mob)
		if(!silent)
			to_chat(owner_xeno, span_warning("We already have one with us."))
		return FALSE
	if(HAS_TRAIT(target, TRAIT_HAULED))
		to_chat(owner_xeno, span_warning("They are already being hauled by someone else."))
		return FALSE
	if(owner_xeno.on_fire)
		if(!silent)
			to_chat(owner_xeno, span_warning("We're too busy being on fire to do this!"))
		return FALSE
	for(var/obj/effect/forcefield/fog in range(1, owner_xeno))
		if(!silent)
			to_chat(owner_xeno, span_warning("We are too close to the fog."))
		return FALSE

/datum/action/ability/activable/xeno/devour/action_activate()
	. = ..()
	var/mob/living/carbon/xenomorph/owner_xeno = owner
	var/mob/living/carbon/human/victim = owner_xeno.eaten_mob
	if(!victim)
		return

	var/channel = SSsounds.random_available_channel()
	if(!haul_mode)
		playsound(owner_xeno, 'sound/vore/escape.ogg', 40, channel = channel)
	else
		release_haul()
		return
	if(!do_after(owner_xeno, GORGER_REGURGITATE_DELAY, FALSE, null, BUSY_ICON_DANGER))
		to_chat(owner, span_warning("We moved too soon!"))
		owner_xeno.stop_sound_channel(channel)
		return
	owner_xeno.eject_victim()
	owner_xeno.remove_movespeed_modifier("devourer", TRUE)
	log_combat(owner_xeno, victim, "released", addition="from being devoured")
	REMOVE_TRAIT(victim, TRAIT_STASIS, TRAIT_STASIS)

/datum/action/ability/activable/xeno/devour/use_ability(atom/target)
	var/mob/living/carbon/human/victim = target
	var/mob/living/carbon/xenomorph/owner_xeno = owner
	owner_xeno.face_atom(victim)
	var/devour_delay = GORGER_DEVOUR_DELAY * 2
	if(isxenogorger(owner_xeno)) //gorgers balling
		devour_delay = GORGER_DEVOUR_DELAY
	if((HAS_TRAIT(victim, TRAIT_UNDEFIBBABLE) || !victim.client || victim.lying_angle || victim.incapacitated()) && !isxeno(victim))
		devour_delay -= 1 SECONDS
	if(haul_mode) //easier to do
		devour_delay -= 1 SECONDS
	if(haul_mode && devour_delay)
		if(!do_after(owner_xeno, devour_delay, FALSE, victim, BUSY_ICON_DANGER, extra_checks = CALLBACK(owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = owner_xeno.health))))
			to_chat(owner, span_warning("We stop trying to pick up \the [victim]."))
			return
		haul(target)
		add_cooldown()
		return
	owner_xeno.visible_message(span_danger("[owner_xeno] starts devouring [victim]!"), span_danger("We start to devour [victim]!"), null, 5)
	log_combat(owner_xeno, victim, "started to devour")
	var/channel = SSsounds.random_available_channel()
	playsound(owner_xeno, 'sound/vore/struggle.ogg', 40, channel = channel)
	owner_xeno.devouring_mob = victim
	if(!do_after(owner_xeno, devour_delay, FALSE, victim, BUSY_ICON_DANGER, extra_checks = CALLBACK(owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = owner_xeno.health))))
		owner_xeno.devouring_mob = null
		to_chat(owner, span_warning("We stop devouring \the [victim]."))
		owner_xeno.stop_sound_channel(channel)
		return
	owner_xeno.devouring_mob = null
	log_combat(owner_xeno, victim, "devoured")
	owner.visible_message(span_warning("[owner_xeno] devour [victim]!"), span_warning("We devour [victim]!"), null, 5)
	ADD_TRAIT(victim, TRAIT_STASIS, TRAIT_STASIS)
	victim.forceMove(owner_xeno)
	owner_xeno.eaten_mob = victim
	if(xeno_owner.eaten_mob?.mob_size)
		xeno_owner.add_movespeed_modifier("devourer", TRUE, 0, NONE, TRUE, xeno_owner.eaten_mob.mob_size)
	if(ishuman(victim))
		var/obj/item/radio/headset/mainship/headset = victim.wear_ear
		if(istype(headset))
			headset.disable_locator(40 SECONDS)
	add_cooldown()

/datum/action/ability/activable/xeno/devour/ai_should_use(atom/target)
	return FALSE

//ntf procs, haul stuff ported from cm sort of cherry picked
/datum/action/ability/activable/xeno/devour/alternate_action_activate()
	if(xeno_owner.eaten_mob)
		to_chat(xeno_owner, span_xenowarning("We must release the one we got first, that's too much."))
		return FALSE
	haul_mode = !haul_mode
	owner.balloon_alert(owner, "Haul [haul_mode ? "activated" : "deactivated"]")
	action_icon_state = "abduct_[haul_mode? "on" : "off"]"
	update_button_icon()

/mob/living/carbon/human/Life(seconds_per_tick, times_fired)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_HAULED))
		handle_haul_resist()

/datum/action/ability/activable/xeno/devour/proc/haul(atom/target)
	if(!xeno_owner.eaten_mob)
		xeno_owner.visible_message(span_warning("[xeno_owner] restrains [target], hauling them effortlessly!"),
		span_warning("We fully restrain [target] and start hauling them!"), null, 5)
		playsound(xeno_owner.loc, 'sound/weapons/thudswoosh.ogg', 25, 1, 7)

		xeno_owner.eaten_mob = target
		if(xeno_owner.eaten_mob?.mob_size)
			xeno_owner.add_movespeed_modifier("hauler", TRUE, 0, NONE, TRUE, xeno_owner.eaten_mob.mob_size)
		xeno_owner.eaten_mob.forceMove(xeno_owner.loc, get_dir(target.loc, xeno_owner.loc))
		xeno_owner.eaten_mob.handle_haul(xeno_owner)
		RegisterSignal(xeno_owner.eaten_mob, COMSIG_MOB_DEATH, PROC_REF(release_dead_haul))

/datum/action/ability/activable/xeno/devour/proc/release_dead_haul()
	SIGNAL_HANDLER
	var/mob/living/carbon/human/user = xeno_owner.eaten_mob
	to_chat(src, span_warning("[user] is dead. No more use for them now."))
	user.handle_unhaul()
	UnregisterSignal(user, COMSIG_MOB_DEATH)
	UnregisterSignal(src, COMSIG_ATOM_DIR_CHANGE)
	xeno_owner.eaten_mob = null

// Releasing a hauled mob
/datum/action/ability/activable/xeno/devour/proc/release_haul(stuns = FALSE)
	deltimer(xeno_owner.haul_timer)
	var/mob/living/carbon/human/user = xeno_owner.eaten_mob
	if(!user)
		to_chat(src, span_warning("We are not hauling anyone."))
		return
	xeno_owner.remove_movespeed_modifier("hauler", TRUE)
	user.handle_unhaul()
	xeno_owner.visible_message(span_xenowarning("[src] releases [user] from their grip!"),
	span_xenowarning("We release [user] from our grip!"), null, 5)
	playsound(xeno_owner.loc, 'sound/voice/alien/growl1.ogg', 15)
	if(stuns)
		user.AdjustStun(2)
	UnregisterSignal(user, COMSIG_MOB_DEATH)
	UnregisterSignal(src, COMSIG_ATOM_DIR_CHANGE)
	xeno_owner.eaten_mob = null

// ***************************************
// *********** Tail Stab
// ***************************************
//totally not stolen from punch code
/datum/action/ability/activable/xeno/tail_stab
	name = "Tail Stab"
	action_icon = 'ntf_modular/icons/Xeno/actions.dmi'
	action_icon_state = "tail_attack"
	desc = "Strike a target within two tiles with a sharp tail for armor-piercing damage, stagger and slowdown. Deals more AP, damage, stagger and slowdown to grappled targets, structures and machinery."
	ability_cost = 30
	cooldown_duration = 10 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_XENOABILITY_TAIL_STAB,
	)
	target_flags = ABILITY_MOB_TARGET
	use_state_flags = ABILITY_USE_LYING|ABILITY_USE_BUCKLED|ABILITY_USE_BUSY|ABILITY_USE_CRESTED|ABILITY_USE_FORTIFIED
	///the length of our tail, better not change this.
	var/range = 2
	///our stabbing style.
	var/stab_description = "swift tail-jab!"
	///the flat armor penetration damage, doubled when grabbed. Blunt tailed xenos wont have sharpness but will have 1.2x more penetration, like maces from most games i guess.
	var/penetration = 15
	///the multiplier for damage against structures.
	var/structure_damage_multiplier = 2
	///how much we want to blur eyes, slowdown and stagger.
	var/disorientamount = 2
	var/can_hit_turf = FALSE
	var/list/ignored_things = list(
		/obj/alien/weeds,
		/obj/alien/weeds/node,
		/obj/alien/weeds/resting,
		/obj/alien/weeds/sticky,
		/obj/alien/weeds/node/resting,
		/obj/alien/weeds/node/sticky
		)

/datum/action/ability/activable/xeno/tail_stab/on_cooldown_finish()
	var/mob/living/carbon/xenomorph/xeno = owner
	to_chat(xeno, span_xenodanger("We feel ready to stab again."))
	owner.playsound_local(owner, 'sound/effects/alien/new_larva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/activable/xeno/tail_stab/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return
	if(owner.status_flags & INCORPOREAL) //Cant while incorporeal
		return FALSE
	var/mob/living/carbon/xenomorph/xeno = owner
	//i could not make it so the mob turns away if at range here, for some reason, the xeno one for example or empty tile.
	if(HAS_TRAIT(A, TRAIT_HAULED))
		return FALSE
	if(!(get_dist(owner,A) <= range))
		if(!silent)
			to_chat(owner, span_xenodanger("Our target must be closer!"))
		return FALSE

	if(get_turf(A) != check_path(owner, A, PASS_LOW_STRUCTURE|PASS_MOB|PASS_THROW|PASS_PROJECTILE|PASS_WALKOVER|PASS_TANK))
		if(!silent)
			to_chat(owner, span_xenodanger("Path to target blocked!"))
		return FALSE

	if(A.resistance_flags & (INDESTRUCTIBLE|CRUSHER_IMMUNE)) //no bolting down indestructible airlocks.
		if(!silent)
			to_chat(owner, span_xenodanger("We cannot damage this target!"))
		return FALSE

	if(isxeno(A) && A.issamexenohive(owner))
		if(!silent)
			owner.visible_message(span_xenowarning("\The [owner] swipes their tail through the air!"), span_xenowarning("We swipe our tail through the air!"))
		add_cooldown(1 SECONDS)
		playsound(owner, "alien_tail_swipe", 50, TRUE)
		if(xeno.blunt_stab)
			owner.do_attack_animation(A, ATTACK_EFFECT_SMASH)
		else if(xeno.fiery_stab)
			owner.do_attack_animation(A, ATTACK_EFFECT_LASERSWORD)
		else
			owner.do_attack_animation(A, ATTACK_EFFECT_REDSTAB)
		return FALSE

	if(!isliving(A) && !isstructure(A) && !ismachinery(A) && !isvehicle(A) && ((isturf(A) || (A.type in ignored_things)) && !can_hit_turf))
		if(!silent)
			owner.visible_message(span_xenowarning("\The [owner] swipes their tail through the air!"), span_xenowarning("We swipe our tail through the air!"))
		add_cooldown(1 SECONDS)
		playsound(owner, "alien_tail_swipe", 50, TRUE)
		if(xeno.blunt_stab)
			owner.do_attack_animation(A, ATTACK_EFFECT_SMASH)
		else if(xeno.fiery_stab)
			owner.do_attack_animation(A, ATTACK_EFFECT_LASERSWORD)
		else
			owner.do_attack_animation(A, ATTACK_EFFECT_REDSTAB)
		return FALSE

	if(isturf(A) && !can_hit_turf)
		add_cooldown(1 SECONDS)
		if(!silent)
			owner.visible_message(span_xenowarning("\The [owner] swipes their tail through the air!"), span_xenowarning("We swipe our tail through the air!"))
		playsound(owner, "alien_tail_swipe", 50, TRUE)
		if(xeno.blunt_stab)
			owner.do_attack_animation(A, ATTACK_EFFECT_SMASH)
		else if(xeno.fiery_stab)
			owner.do_attack_animation(A, ATTACK_EFFECT_LASERSWORD)
		else
			owner.do_attack_animation(A, ATTACK_EFFECT_REDSTAB)
		return FALSE

	if(isliving(A))
		var/mob/living/Livingtarget = A
		if(Livingtarget.stat == DEAD)
			add_cooldown(1 SECONDS)
			if(!silent)
				to_chat(owner, span_xenodanger("We don't care about the dead."))
			return FALSE

/datum/action/ability/activable/xeno/tail_stab/use_ability(atom/A)
	var/mob/living/carbon/xenomorph/xeno = owner
	var/damage = xeno.xeno_caste.melee_damage * xeno.xeno_melee_damage_modifier
	var/target_zone = check_zone(xeno.zone_selected)

	if(!A.tail_stab_act(xeno, damage, target_zone, penetration, structure_damage_multiplier, stab_description, disorientamount, can_hit_turf))
		return fail_activate()
	if(line_of_sight(xeno, A, 1))
		xeno.face_atom(A) //Face the target if adjacent so you dont look dumb.
	else
		xeno.face_away_from_atom(A) //Face away from the target so your tail may reach if not adjacent
	succeed_activate()
	if(istype(A, /obj/machinery/light))
		add_cooldown(1 SECONDS)
	else
		if(istype(A, /obj/machinery/camera))
			add_cooldown(5 SECONDS)
		else
			add_cooldown() // add less cooldowns for smashing lights and cameras, add normal cooldown if none are the target.

/atom/proc/tail_stab_act(mob/living/carbon/xenomorph/xeno, damage, target_zone, penetration, structure_damage_multiplier, stab_description = "swift tail-stab!", disorientamount, can_hit_turf)
	return TRUE

/obj/machinery/tail_stab_act(mob/living/carbon/xenomorph/xeno, damage, target_zone, penetration, structure_damage_multiplier, stab_description = "swift tail-stab!", disorientamount, can_hit_turf) //Break open the machine
	if(!(resistance_flags & XENO_DAMAGEABLE))
		return FALSE
	if(line_of_sight(xeno, src, 1))
		xeno.face_atom(src) //Face the target if adjacent so you dont look dumb.
	else
		xeno.face_away_from_atom(src) //Face away from the target so your tail may reach if not adjacent
	if(!xeno.blunt_stab)
		xeno.do_attack_animation(src, ATTACK_EFFECT_REDSTAB)
		xeno.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
	else
		xeno.do_attack_animation(src, ATTACK_EFFECT_SMASH)
	if(!CHECK_BITFIELD(resistance_flags, UNACIDABLE) || resistance_flags == (UNACIDABLE|XENO_DAMAGEABLE)) //If it's acidable or we can't acid it but it has the xeno damagable flag, we can damage it
		attack_generic(xeno, damage * structure_damage_multiplier, BRUTE, "", FALSE)
	xeno.visible_message(span_xenodanger("\The [xeno] pierces [src] with a [stab_description]"), \
		span_xenodanger("We pierce [src] with a [stab_description]"), visible_message_flags = COMBAT_MESSAGE)
	playsound(src, "alien_tail_swipe", 50, TRUE)
	playsound(src, pick('sound/effects/bang.ogg','sound/effects/metal_crash.ogg','sound/effects/meteorimpact.ogg'), 25, 1)
	Shake(duration = 0.5 SECONDS)

	if(!istype(src, /obj/machinery/power/apc))
		if(!CHECK_BITFIELD(machine_stat, PANEL_OPEN))
			ENABLE_BITFIELD(machine_stat, PANEL_OPEN)

	if(!istype(src, /obj/machinery/power/apc))
		if(wires) //If it has wires, break em except APCs cause they got beenhit count.
			var/allcut = wires.is_all_cut()
			if(!allcut)
				wires.cut_all()
				visible_message(span_danger("\The [src]'s wires snap apart in a rain of sparks!"), null, null, 5)
	update_icon()
	return TRUE

/obj/machinery/computer/tail_stab_act(mob/living/carbon/xenomorph/xeno, damage, target_zone, penetration, structure_damage_multiplier, stab_description = "swift tail-stab!", disorientamount, can_hit_turf) //Break open the machine
	if(!(resistance_flags & XENO_DAMAGEABLE))
		return FALSE
	durability-- //extra durability damage
	attack_alien(xeno)
	return ..()

/obj/machinery/light/tail_stab_act(mob/living/carbon/xenomorph/xeno, damage, target_zone, penetration, structure_damage_multiplier, stab_description = "swift tail-stab!", disorientamount, can_hit_turf)
	. = ..()
	if(!(resistance_flags & XENO_DAMAGEABLE))
		return FALSE
	attack_alien(xeno) //Smash it

/obj/machinery/camera/tail_stab_act(mob/living/carbon/xenomorph/xeno, damage, target_zone, penetration, structure_damage_multiplier, stab_description = "swift tail-stab!", disorientamount, can_hit_turf)
	. = ..()
	if(!(resistance_flags & XENO_DAMAGEABLE))
		return FALSE
	var/datum/effect_system/spark_spread/sparks = new //Avoid the slash text, go direct to sparks
	sparks.set_up(2, 0, src)
	sparks.attach(src)
	sparks.start()

	deactivate()
	visible_message(span_danger("\The [src]'s wires snap apart in a rain of sparks!")) //Smash it

/obj/machinery/power/apc/tail_stab_act(mob/living/carbon/xenomorph/xeno, damage, target_zone, penetration, structure_damage_multiplier,  stab_description = "swift tail-stab!", disorientamount, can_hit_turf)
	. = ..()
	if(!(resistance_flags & XENO_DAMAGEABLE))
		return FALSE
	var/allcut = wires.is_all_cut()
	if(beenhit >= pick(3, 4)) //wow it is actually be a challenge to kill apcs from afar with a tail, compared to woyer.
		if(!CHECK_BITFIELD(machine_stat, PANEL_OPEN))
			ENABLE_BITFIELD(machine_stat, PANEL_OPEN)
			update_icon()
			visible_message(span_danger("\The [src]'s cover swings open, exposing the wires!"), null, null, 5)
			if(prob(50))
				electrocute_mob(xeno, get_area(src), src, 0.7, FALSE) //sticking your tail thoughtlessly inside an APC may not be a good idea.
				xeno.Knockdown(1 SECONDS)
				xeno.visible_message(span_danger("\The [xeno] gets shocked by \the [src]!"), \
					span_danger("You get shocked by \the [src]!"), null, 5)
				var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
				s.set_up(5, 1, src)
				s.start()
		else if(CHECK_BITFIELD(machine_stat, PANEL_OPEN) && !allcut)
			wires.cut_all()
			visible_message(span_danger("\The [src]'s wires snap apart in a rain of sparks!"), null, null, 5)
			if(xeno.client)
				var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[xeno.ckey]
				personal_statistics.apcs_slashed++
	else
		beenhit += structure_damage_multiplier
	xeno.changeNext_move(CLICK_CD_MELEE)
	update_icon()

/obj/machinery/vending/tail_stab_act(mob/living/carbon/xenomorph/xeno, damage, target_zone, penetration, structure_damage_multiplier,  stab_description = "swift tail-stab!", disorientamount, can_hit_turf)
	. = ..()
	if(!(resistance_flags & XENO_DAMAGEABLE))
		return FALSE
	if(tipped_level < 2) //Knock it down if it isn't
		xeno.visible_message(span_danger("\The [xeno] pulls \the [src] down while retracting it's tail!"), \
			span_danger("You pull \the [src] down with your tail!"), null, 5)
		tip_over()

/obj/structure/tail_stab_act(mob/living/carbon/xenomorph/xeno, damage, target_zone, penetration, structure_damage_multiplier,  stab_description = "devastating tail-jab!", disorientamount, can_hit_turf) //Smash structures
	. = ..()
	if(!(resistance_flags & XENO_DAMAGEABLE))
		return FALSE
	if(line_of_sight(xeno, src, 1))
		xeno.face_atom(src) //Face the target if adjacent so you dont look dumb.
	else
		xeno.face_away_from_atom(src) //Face away from the target so your tail may reach if not adjacent
	if(!xeno.blunt_stab)
		xeno.do_attack_animation(src, ATTACK_EFFECT_REDSTAB)
		xeno.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
	else
		xeno.do_attack_animation(src, ATTACK_EFFECT_SMASH)
	attack_alien(xeno, damage * structure_damage_multiplier, BRUTE, "", FALSE)
	xeno.visible_message(span_xenodanger("\The [xeno] stab [src] with a [stab_description]"), \
		span_xenodanger("We stab [src] with a [stab_description]"), visible_message_flags = COMBAT_MESSAGE)
	playsound(src, "alien_tail_swipe", 50, TRUE)
	playsound(src, pick('sound/effects/bang.ogg','sound/effects/metal_crash.ogg','sound/effects/meteorimpact.ogg'), 25, 1)
	Shake(duration = 0.5 SECONDS)

/obj/vehicle/tail_stab_act(mob/living/carbon/xenomorph/xeno, damage, target_zone, penetration, structure_damage_multiplier, stab_description = "devastating tail-jab!", disorientamount, can_hit_turf)
	. = ..()
	if(!(resistance_flags & XENO_DAMAGEABLE))
		return FALSE
	if(line_of_sight(xeno, src, 1))
		xeno.face_atom(src) //Face the target if adjacent so you dont look dumb.
	else
		xeno.face_away_from_atom(src) //Face away from the target so your tail may reach if not adjacent
	if(!xeno.blunt_stab)
		xeno.do_attack_animation(src, ATTACK_EFFECT_REDSTAB)
		xeno.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
	else
		xeno.do_attack_animation(src, ATTACK_EFFECT_SMASH)
	attack_generic(xeno, damage * structure_damage_multiplier, BRUTE, "", FALSE)
	xeno.visible_message(span_xenodanger("\The [xeno] stabs [src] with a [stab_description]"), \
		span_xenodanger("We stab [src] with a [stab_description]"), visible_message_flags = COMBAT_MESSAGE)
	playsound(src, "alien_tail_swipe", 50, TRUE)
	playsound(src, pick('sound/effects/bang.ogg','sound/effects/metal_crash.ogg','sound/effects/meteorimpact.ogg'), 25, 1)
	Shake(duration = 0.5 SECONDS)
	return TRUE

/mob/living/tail_stab_act(mob/living/carbon/xenomorph/xeno, damage, target_zone, penetration, structure_damage_multiplier, stab_description = "swift tail-stab!", disorientamount, can_hit_turf)
	. = ..()
	if(status_flags & (GODMODE|INCORPOREAL))
		return FALSE

	if(pulledby == xeno) //If we're being grappled
		if(length(xeno.do_actions))
			xeno.balloon_alert(xeno, "busy!")
			return FALSE
		if(!do_mob(xeno, src, 0.5 SECONDS, BUSY_ICON_DANGER, BUSY_ICON_DANGER, PROGRESS_GENERIC, IGNORE_HELD_ITEM|IGNORE_USER_LOC_CHANGE))
			to_chat(xeno, span_warning("We need to hold [src] in place longer for a precise stab!"))
			return FALSE
		var/datum/action/ability/activable/xeno/tail_stab/tail_stab_action = xeno.actions_by_path[/datum/action/ability/activable/xeno/tail_stab]
		if(!tail_stab_action || !tail_stab_action.can_use_ability(src))
			return FALSE
		damage *= 1.5
		disorientamount *= 2
		penetration *= 2
		ParalyzeNoChain(0.5 SECONDS)
		xeno.stop_pulling()
		stab_description = "devastating tail-jab!"

	if(iscarbon(src))
		var/mob/living/carbon/carbon_victim = src
		var/datum/limb/selectedlimb = carbon_victim.get_limb(target_zone)

		if (!selectedlimb || (selectedlimb.limb_status & LIMB_DESTROYED))
			selectedlimb = carbon_victim.get_limb(BODY_ZONE_CHEST)
		if(xeno.blunt_stab)
			//not as sharp but macey penetration.
			penetration *= 1.2
			damage *= 0.8
			apply_damage(damage, BRUTE, selectedlimb, MELEE, IS_NOT_SHARP_ITEM, FALSE, TRUE, penetration)
		else
			if(xeno.fiery_stab)
				//fire tail burns but not much penetration
				penetration *= 0.6
				var/datum/status_effect/stacking/melting_fire/debuff = carbon_victim.has_status_effect(STATUS_EFFECT_MELTING_FIRE)
				if(debuff)
					debuff.add_stacks(PYROGEN_TORNADO_MELTING_FIRE_STACKS)
				else
					carbon_victim.apply_status_effect(STATUS_EFFECT_MELTING_FIRE, PYROGEN_TORNADO_MELTING_FIRE_STACKS)
				apply_damage(damage, BURN, selectedlimb, MELEE, IS_NOT_SHARP_ITEM, TRUE, TRUE, penetration)
			else
				//basic bitch stab
				apply_damage(damage, BRUTE, selectedlimb, MELEE, IS_SHARP_ITEM_ACCURATE, TRUE, TRUE, penetration)
	else
		apply_damage(damage, BRUTE, blocked = MELEE)

	var/target_location_feedback = get_living_limb_descriptive_name(target_zone)
	if(xeno.blunt_stab)
		stab_description = "heavy tail-jab!"
		xeno.visible_message(span_xenodanger("\The [xeno] smacks [src] in the [target_location_feedback] with a [stab_description]"), \
			span_xenodanger("We hit [src] in the [target_location_feedback] with a [stab_description]"), visible_message_flags = COMBAT_MESSAGE)
		playsound(src, "alien_tail_swipe", 50, TRUE)
		playsound(src, "punch", 25, TRUE)
		src.add_splatter_floor(loc)
	else
		if(xeno.fiery_stab)
			stab_description = "fiery tail-jab!"
			xeno.visible_message(span_xenodanger("\The [xeno] flares [src] in the [target_location_feedback] with a [stab_description]"), \
				span_xenodanger("We burn [src] in the [target_location_feedback] with a [stab_description]"), visible_message_flags = COMBAT_MESSAGE)
			playsound(src, "alien_tail_swipe", 25, TRUE)
			playsound(src, 'sound/effects/firetail.ogg', 50, TRUE)
		else
			xeno.visible_message(span_xenodanger("\The [xeno] stabs [src] in the [target_location_feedback] with a [stab_description]"), \
				span_xenodanger("We stab [src] in the [target_location_feedback] with a [stab_description]"), visible_message_flags = COMBAT_MESSAGE)
			playsound(src, "alien_tail_swipe", 50, TRUE)
			playsound(src,"alien_bite", 25, TRUE)
			src.add_splatter_floor(loc)
	if(line_of_sight(xeno, src, 1))
		xeno.face_atom(src) //Face the target if adjacent so you dont look dumb.
	else
		xeno.face_away_from_atom(src) //Face away from the target so your tail may reach if not adjacent
	if(!xeno.blunt_stab)
		xeno.do_attack_animation(src, ATTACK_EFFECT_REDSTAB)
		xeno.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
	else
		xeno.do_attack_animation(src, ATTACK_EFFECT_SMASH)

	adjust_stagger(disorientamount SECONDS)
	add_slowdown(disorientamount)
	adjust_blurriness(disorientamount) //Cosmetic eye blur SFX

	shake_camera(src, 2, 1)
	Shake(duration = 0.5 SECONDS)

	if(xeno.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[xeno.ckey]
		personal_statistics.tail_stabs++
		GLOB.round_statistics.tail_stabs++
		SSblackbox.record_feedback("tally", "round_statistics", 1, "tail_stabs")

/datum/action/ability/activable/xeno/tail_stab/ai_should_start_consider()
	return TRUE

/datum/action/ability/activable/xeno/tail_stab/ai_should_use(atom/A)
	if(!iscarbon(A))
		return FALSE
	if(!(get_dist(owner,A) <= range))
		return FALSE
	if(!can_use_ability(A, override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(A.get_xeno_hivenumber() == owner.get_xeno_hivenumber())
		return FALSE
	return TRUE
