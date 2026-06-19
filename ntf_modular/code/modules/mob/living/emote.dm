/datum/emote/living/carbon/human/choke
	key = "choke"
	key_third_person = "chokes"
	message = "chokes!"
	emote_type = EMOTE_TYPE_AUDIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/carbon/human/choke/get_sound(mob/living/carbon/human/user)
	if(!user.species)
		return
	if(user.species.chokes[user.gender])
		return user.species.chokes[user.gender]
	if(user.species.chokes[NEUTER])
		return user.species.chokes[NEUTER]

/mob/living/carbon/human
	var/tail_wagging = FALSE

/proc/tail_wagging_name(tail_name)
	switch(tail_name)
		if("Smooth")
			return "Wagging Smooth"
		if("Short")
			return "Wagging Short"
		if("Spikes")
			return "Wagging Spikes"
		if("Dark Tiger")
			return "Wagging Dark Tiger"
		if("Light Tiger")
			return "Wagging Light Tiger"
	return null

/proc/tail_wagging_prefix(datum/sprite_accessory/lizard_tail/tail_data)
	if(!tail_data?.icon_state)
		return null
	var/wagging_prefix = "m_waggingtail"
	if(icon_exists(tail_data.icon, "[wagging_prefix]_[tail_data.icon_state]_FRONT_primary") || icon_exists(tail_data.icon, "[wagging_prefix]_[tail_data.icon_state]_FRONT"))
		return wagging_prefix
	return null

/mob/living/carbon/human/proc/start_tail_wag()
	if(tail_wagging)
		return FALSE
	if(!tail || tail == "None")
		return FALSE
	var/wagging_tail = tail_wagging_name(tail)
	var/datum/sprite_accessory/lizard_tail/tail_data = GLOB.lizard_tails_list[tail]
	if((!wagging_tail || !GLOB.lizard_tails_list[wagging_tail]) && !tail_wagging_prefix(tail_data))
		return FALSE
	tail_wagging = TRUE
	update_tail()
	return TRUE

/mob/living/carbon/human/proc/stop_tail_wag()
	if(!tail_wagging)
		return FALSE
	tail_wagging = FALSE
	update_tail()
	return TRUE

/mob/living/carbon/human/proc/can_tail_wag()
	if(!tail || tail == "None")
		return FALSE
	var/wagging_tail = tail_wagging_name(tail)
	var/datum/sprite_accessory/lizard_tail/tail_data = GLOB.lizard_tails_list[tail]
	return (wagging_tail && GLOB.lizard_tails_list[wagging_tail]) || tail_wagging_prefix(tail_data)

/mob/living/carbon/human/proc/toggle_tail_wag()
	if(tail_wagging)
		return stop_tail_wag()
	return start_tail_wag()

/datum/emote/living/carbon/human/tailwag
	key = "wag"
	key_third_person = "wags"
	message = "wags their tail."

/datum/emote/living/carbon/human/tailwag/select_message_type(mob/living/carbon/human/user)
	return user.tail_wagging ? "stops wagging their tail." : message

/datum/emote/living/carbon/human/tailwag/run_emote(mob/living/carbon/human/user, params, type_override, intentional = FALSE, prefix)
	if(!user.can_tail_wag())
		user.balloon_alert(user, "no tail to wag!")
		return FALSE
	. = ..()
	if(!.)
		return
	user.toggle_tail_wag()

/datum/emote/living/carbon/human/sexmoanlight
	key = "sexmoanlight"
	emote_type = EMOTE_TYPE_AUDIBLE

/datum/emote/living/carbon/human/sexmoanhvy
	key = "sexmoanhvy"
	emote_type = EMOTE_TYPE_AUDIBLE

/datum/emote/living/groan
	key = "groan"
	key_third_person = "groans"
	message = "groans."
	emote_type = EMOTE_TYPE_AUDIBLE

/datum/emote/living/carbon/xenomorph/xurrender
    key = "xurrender"
    key_third_person = "xurrenders"
    message = "puts their hands on their head and falls to the ground, they xurrender!"
    emote_type = EMOTE_TYPE_IMPORTANT
    cooldown = 0
    stat_allowed = UNCONSCIOUS
    sound = 'sound/machines/beepalert.ogg'

/datum/emote/living/carbon/xenomorph/xurrender/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Paralyze(450 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(surrender_end), user), 90 SECONDS, TIMER_STOPPABLE)
		if(SSticker.mode.round_type_flags2 & MODE_2_CHILL_RULES)
			return
		L.ExtinguishMob()
		L.status_flags |= GODMODE
		ADD_TRAIT(L, TRAIT_SURRENDERING, "surrender")

/datum/emote/living/carbon/xenomorph/xurrender/run_emote(mob/user, params, type_override, intentional = TRUE, prefix)
	if(!isxeno(user))
		return
	if(isxenolarva(user) || isxenofacehugger(user))
		return //Because larva replace the emote
	. = ..()
	var/image/surrendering = image('icons/mob/effects/talk.dmi', user, icon_state = "surrendering")
	user.add_emote_overlay(surrendering, 90 SECONDS) // Xenos got para resist, dont change this

/datum/emote/living/carbon/xenomorph/xurrender/proc/surrender_end(mob/living/user)
	user.ExtinguishMob()
	user.status_flags &= ~GODMODE
	REMOVE_TRAIT(user, TRAIT_SURRENDERING, "surrender")

// And the sexy version here
/datum/emote/living/carbon/xenomorph/xubmit
    key = "xubmit"
    key_third_person = "xubmits"
    message = "falls to the ground and submits, offering their body for mercy!"
    emote_type = EMOTE_TYPE_IMPORTANT
    cooldown = 0
    stat_allowed = UNCONSCIOUS
    sound = 'ntf_modular/sound/misc/mat/end.ogg'

/datum/emote/living/carbon/xenomorph/xubmit/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Paralyze(450 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(surrender_end), user), 90 SECONDS, TIMER_STOPPABLE)
		if(SSticker.mode.round_type_flags2 & MODE_2_CHILL_RULES)
			return
		L.ExtinguishMob()
		L.status_flags |= GODMODE
		ADD_TRAIT(L, TRAIT_SURRENDERING, "surrender")

/datum/emote/living/carbon/xenomorph/xubmit/run_emote(mob/user, params, type_override, intentional = TRUE, prefix)
	if(!isxeno(user))
		return
	if(isxenolarva(user) || isxenofacehugger(user))
		return //Because larva replace the emote
	. = ..()
	var/image/submitting = image('icons/mob/effects/talk.dmi', user, icon_state = "submit")
	user.add_emote_overlay(submitting, 90 SECONDS) //Xenos need to be stunned for longer, dont change this

/datum/emote/living/carbon/xenomorph/xubmit/proc/surrender_end(mob/living/user)
	user.ExtinguishMob()
	user.status_flags &= ~GODMODE
	REMOVE_TRAIT(user, TRAIT_SURRENDERING, "surrender")

/datum/emote/living/carbon/human/surrender
    key = "surrender"
    key_third_person = "surrenders"
    message = "puts their hands on their head and falls to the ground, they surrender!"
    emote_type = EMOTE_TYPE_IMPORTANT
    cooldown = 0
    stat_allowed = UNCONSCIOUS
    sound = 'sound/machines/beepalert.ogg'

/datum/emote/living/carbon/human/surrender/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Paralyze(90 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(surrender_end), user), 90 SECONDS, TIMER_STOPPABLE)
		if(SSticker.mode.round_type_flags2 & MODE_2_CHILL_RULES)
			return
		L.ExtinguishMob()
		L.status_flags |= GODMODE
		ADD_TRAIT(L, TRAIT_SURRENDERING, "surrender")

/datum/emote/living/carbon/human/surrender/proc/surrender_end(mob/living/user)
	user.ExtinguishMob()
	user.status_flags &= ~GODMODE
	REMOVE_TRAIT(user, TRAIT_SURRENDERING, "surrender")

/datum/emote/living/carbon/human/surrender/run_emote(mob/user, params, type_override, intentional = TRUE, prefix)
	if(!ishuman(user))
		return
	. = ..()
	var/image/surrendering = image('icons/mob/effects/talk.dmi', user, icon_state = "surrendering")
	user.add_emote_overlay(surrendering, 90 SECONDS)
// And now for the sexy varient

/datum/emote/living/carbon/human/submit
    key = "submit"
    key_third_person = "submits"
    message = "falls to the ground and submits, offering their body for mercy!"
    emote_type = EMOTE_TYPE_IMPORTANT
    cooldown = 0
    stat_allowed = UNCONSCIOUS
    sound = 'ntf_modular/sound/misc/mat/end.ogg'

/datum/emote/living/carbon/human/submit/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Paralyze(90 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(surrender_end), user), 90 SECONDS, TIMER_STOPPABLE)
		if(SSticker.mode.round_type_flags2 & MODE_2_CHILL_RULES)
			return
		L.ExtinguishMob()
		L.status_flags |= GODMODE
		ADD_TRAIT(L, TRAIT_SURRENDERING, "surrender")

/datum/emote/living/carbon/human/submit/proc/surrender_end(mob/living/user)
	user.ExtinguishMob()
	user.status_flags &= ~GODMODE
	REMOVE_TRAIT(user, TRAIT_SURRENDERING, "surrender")

/datum/emote/living/carbon/human/submit/run_emote(mob/user, params, type_override, intentional = TRUE, prefix)
    if(!ishuman(user))
        return
    . = ..()
    var/image/submitting = image('icons/mob/effects/talk.dmi', user, icon_state = "submit")
    user.add_emote_overlay(submitting, 90 SECONDS)

// Robot specific emotes
/datum/emote/living/carbon/human/species/robot
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/robot, /mob/living/carbon/human/species/early_synthetic, /mob/living/carbon/human/species/synthetic)
	emote_type = EMOTE_TYPE_AUDIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/carbon/human/species/robot/droidnoises
	key = "whirr"
	key_third_person = "whirrs"
	message = "emits a robotic noise."
	cooldown = 1 SECONDS

/datum/emote/living/carbon/human/species/robot/droidnoises/get_sound(mob/living/carbon/human/user)
	if(!user.species)
		return
	if(user.species.robotnoises[user.gender])
		return user.species.robotnoises[user.gender]
	if(user.species.robotnoises[NEUTER])
		return user.species.robotnoises[NEUTER]

/datum/emote/living/carbon/human/species/robot/droidon
	key = "online"
	message = "emits a mechanical rising sound"
	sound = "sound/machines/drone/weapons_engaged.ogg"

/datum/emote/living/carbon/human/species/robot/droidoff
	key = "offline"
	message = "emits a mechanical lowering sound"
	sound = "sound/machines/drone/droneoff.ogg"

/datum/emote/living/carbon/human/species/robot/droidscream
	key = "mechascream"
	message = "emits an unsettling robotic wail"
	sound = "sound/voice/scream_horror1.ogg"
	cooldown = 1 MINUTES

/datum/emote/living/carbon/human/species/robot/droidterminate
	key = "terminate"
	message = "emits a threatening alarm!"

/datum/emote/living/carbon/human/species/robot/droidterminate/get_sound(mob/living/carbon/human/user)
	if(!user.species)
		return
	if(user.species.robotthreaten[user.gender])
		return user.species.robotthreaten[user.gender]
	if(user.species.robotthreaten[NEUTER])
		return user.species.robotthreaten[NEUTER]

/datum/emote/living/carbon/human/species/robot/droiddamaged
	key = "damaged"
	message = "emits a fearful alarm!"
	sound = "sound/mecha/internaldmgalarm.ogg"

/datum/emote/living/carbon/human/species/robot/droidcrit
	key = "critical"
	message = "emits a fearful alarm!"
	sound = "sound/mecha/critdestr.ogg"

/datum/emote/living/carbon/human/species/robot/droidnominal
	key = "nominal"
	message = "reports nominal condition"
	sound = "sound/mecha/nominal.ogg"

/datum/emote/living/carbon/human/species/robot/droid/beep
	key = "beep1"
	message = "beeps"
	sound = "sound/items/defib_SafetyOn.ogg"

/datum/emote/living/carbon/human/species/robot/droid/beep/beep2
	key = "beep2"
	sound = "sound/items/defib_SafetyOff.ogg"

/datum/emote/living/carbon/human/species/robot/droid/beep/beep3
	key = "beep3"
	sound = "sound/items/defib_failed.ogg"
