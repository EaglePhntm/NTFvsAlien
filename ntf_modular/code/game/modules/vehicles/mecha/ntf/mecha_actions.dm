// Phazon's armor

/datum/action/vehicle/sealed/mecha/pulsearmor/weak
	name = "Electro-Pulse Armor"
	power_cost = 500
	block_max = 150
	block_remaining
	decay_per_second = 7.5
	movespeed_mod = 2
	cooldown_time = 30 SECONDS

//Night vision
/datum/action/vehicle/sealed/mecha/light_amplification
	name = "Light Amplification"
	action_icon = 'ntf_modular/icons/mob/actions/actions_mecha.dmi'
	action_icon_state = "mech_nightvision_off"
	var/required_power_level = IGNITION_AUX
	var/list/amplification_traits = list(TRAIT_EXOSUIT_NV)
	var/power_cost = 25

/datum/action/vehicle/sealed/mecha/light_amplification/action_activate(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return
	if(!ismob(owner))
		to_chat(owner, "The [src] activates, but you appear to be a mere object!")
		return
	if(!chassis.check_power())
		chassis.balloon_alert(owner, "no power!")
		return
	var/mob/user = owner
	chassis.light_amplification = !chassis.light_amplification
	action_icon_state = "mech_nightvision_[chassis.light_amplification ? "on" : "off"]"
	update_button_icon()
	if(chassis.light_amplification)
		for(var/trait in amplification_traits)
			ADD_TRAIT(user, trait, VEHICLE_TRAIT)
		owner.playsound_local(src, 'ntf_modular/sound/effects/light_amp.ogg', 50)
		user.update_sight()
		START_PROCESSING(SSobj, src)
	else
		stop_nightvision(user)
	chassis.balloon_alert(owner, "toggled light amplification [chassis.light_amplification ? "on" : "off"]")

/datum/action/vehicle/sealed/mecha/light_amplification/remove_action(mob/M)
	if(ismob(owner) && chassis && (owner in chassis.occupants))
		stop_nightvision(owner)
	return ..()

/datum/action/vehicle/sealed/mecha/light_amplification/proc/stop_nightvision(mob/user)
	if(ismob(user))
		for(var/trait in amplification_traits)
			REMOVE_TRAIT(user, trait, VEHICLE_TRAIT)
		user.update_sight()
	if(chassis)
		chassis.light_amplification = FALSE
	action_icon_state = "mech_nightvision_off"
	update_button_icon()
	STOP_PROCESSING(SSobj, src)

/datum/action/vehicle/sealed/mecha/light_amplification/process(seconds_per_tick)
	if(!owner || !(owner in chassis.occupants) || !chassis.use_power(seconds_per_tick * power_cost))
		stop_nightvision(owner)

// Smoke

/datum/action/vehicle/sealed/mecha/mech_smoke/exosuit
	var/power_cost = 1000
	var/cooldown = 15 SECONDS

/datum/action/vehicle/sealed/mecha/mech_smoke/exosuit/action_activate(trigger_flags)
	if(!owner?.client || !chassis || !(owner in chassis.occupants))
		return
	if(owner.do_actions)
		return
	if(TIMER_COOLDOWN_RUNNING(chassis, COOLDOWN_MECHA_EQUIPMENT(type)))
		chassis.balloon_alert(owner, "Cooldown")
		return
	if(!chassis.use_power(power_cost))
		chassis.balloon_alert(owner, "No power")
		return
	if(!chassis.check_power())
		chassis.balloon_alert(owner, "No power")
		return
	TIMER_COOLDOWN_START(chassis, COOLDOWN_MECHA_EQUIPMENT(type), cooldown)
	chassis.smoke_system.start()

// Lights, now uses power toggle

/datum/action/vehicle/sealed/mecha/mech_toggle_lights/exosuit
	name = "Toggle Lights"
	action_icon_state = "mech_lights_off"
	var/required_power_level = IGNITION_AUX

/datum/action/vehicle/sealed/mecha/mech_toggle_lights/exosuit/action_activate(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return

	if(!(chassis.mecha_flags & HAS_HEADLIGHTS))
		chassis.balloon_alert(owner, "the mech lights are broken!")
		return
	if(!chassis.power_status < required_power_level)
		chassis.balloon_alert(owner, "Insufficent power!")
		return
	chassis.mecha_flags ^= LIGHTS_ON
	if(chassis.mecha_flags & LIGHTS_ON)
		action_icon_state = "mech_lights_on"
	else
		action_icon_state = "mech_lights_off"
	chassis.set_light_on(chassis.mecha_flags & LIGHTS_ON)
	chassis.balloon_alert(owner, "toggled lights [chassis.mecha_flags & LIGHTS_ON ? "on":"off"]")
	playsound(chassis,'sound/mecha/brass_skewer.ogg', 40, TRUE)
	chassis.log_message("Toggled lights [(chassis.mecha_flags & LIGHTS_ON)?"on":"off"].", LOG_MECHA)
	update_button_icon()

// Jumping

/datum/component/jump/exosuit
	jump_height = 8
	jumper_allow_pass_flags = 0

/datum/component/jump/exosuit/do_jump(atom/movable/jumper)
    jumper_allow_pass_flags = 0
    return ..()

// Power toggling

/datum/action/vehicle/sealed/mecha/toggle_power
	name = "Toggle Power"
	action_icon_state = "toggle_power"
	delay

/datum/action/vehicle/sealed/mecha/toggle_power/action_activate(trigger_flags)
	if(!owner?.client || !chassis || !(owner in chassis.occupants))
		return
	if(owner.do_actions)
		return

	var/obj/vehicle/sealed/mecha/ntf/ntf_chassis = chassis

	owner.playsound_local(src, 'sound/mecha/engine/key_turn.ogg', 50)

	if(!ntf_chassis.body)
		for(var/mob/occupant in ntf_chassis.occupants)
			ntf_chassis.balloon_alert(occupant, "no body")
		return

	var/obj/item/mecha_parts/exosuit_engine/engine = ntf_chassis.body.engine
	if(!engine)
		for(var/mob/occupant in ntf_chassis.occupants)
			ntf_chassis.balloon_alert(occupant, "no engine")
		return

	switch(ntf_chassis.power_status)

		if(IGNITION_OFF)
			ntf_chassis.check_power(power_status = IGNITION_AUX)
			ntf_chassis.power_status = IGNITION_AUX
			for(var/occupant in chassis.occupants)
				ntf_chassis.balloon_alert(occupant, "aux power on")

		if(IGNITION_AUX)
			if(ntf_chassis.body.engine.attempt_engine_start())
				ntf_chassis.check_power(power_status = IGNITION_ENGINE)
				ntf_chassis.power_status = IGNITION_ENGINE
				for(var/occupant in chassis.occupants)
					ntf_chassis.balloon_alert(occupant, "engine starts!")

		if(IGNITION_ENGINE)
			ntf_chassis.body.engine.engine_stop()
			ntf_chassis.power_status = IGNITION_OFF
			for(var/occupant in chassis.occupants)
				ntf_chassis.balloon_alert(occupant, "power off")

// Increase revs

/datum/action/vehicle/sealed/mecha/increase_revs
	name = "Increase revs"
	action_icon_state = "increase_revs"
	delay

/datum/action/vehicle/sealed/mecha/increase_revs/action_activate(trigger_flags)
	if(!owner?.client || !chassis || !(owner in chassis.occupants))
		return
	if(owner.do_actions)
		return

	var/obj/vehicle/sealed/mecha/ntf/ntf_chassis = chassis

	owner.playsound_local(src, 'sound/mecha/engine/key_turn.ogg', 50)

	if(!ntf_chassis.body)
		for(var/mob/occupant in ntf_chassis.occupants)
			ntf_chassis.balloon_alert(occupant, "no body")
		return

	var/obj/item/mecha_parts/exosuit_engine/engine = ntf_chassis.body.engine
	if(!engine)
		for(var/mob/occupant in ntf_chassis.occupants)
			ntf_chassis.balloon_alert(occupant, "no engine")
		return

	if(ntf_chassis.power_status == IGNITION_ENGINE)
		switch(engine.revs_selection)
			if(REVS_LOW)
				engine.revs_selection = REVS_MID
				for(var/occupant in chassis.occupants)
					ntf_chassis.balloon_alert(occupant, "mid")
			if(REVS_MID)
				engine.revs_selection = REVS_HIGH
				for(var/occupant in chassis.occupants)
					ntf_chassis.balloon_alert(occupant, "high")
	else
		return
	engine.handle_revs()

// Decrease revs (why not have it loop around?)

/datum/action/vehicle/sealed/mecha/decrease_revs
	name = "Decrease revs"
	action_icon_state = "decrease_revs"
	delay

/datum/action/vehicle/sealed/mecha/decrease_revs/action_activate(trigger_flags)
	if(!owner?.client || !chassis || !(owner in chassis.occupants))
		return
	if(owner.do_actions)
		return

	var/obj/vehicle/sealed/mecha/ntf/ntf_chassis = chassis

	owner.playsound_local(src, 'sound/mecha/engine/key_turn.ogg', 50)

	if(!ntf_chassis.body)
		for(var/mob/occupant in ntf_chassis.occupants)
			ntf_chassis.balloon_alert(occupant, "no body")
		return

	var/obj/item/mecha_parts/exosuit_engine/engine = ntf_chassis.body.engine
	if(!engine)
		for(var/mob/occupant in ntf_chassis.occupants)
			ntf_chassis.balloon_alert(occupant, "no engine")
		return

	if(ntf_chassis.power_status == IGNITION_ENGINE)
		switch(engine.revs_selection)
			if(REVS_HIGH)
				engine.revs_selection = REVS_MID
				for(var/occupant in chassis.occupants)
					ntf_chassis.balloon_alert(occupant, "mid")
			if(REVS_MID)
				engine.revs_selection = REVS_LOW
				for(var/occupant in chassis.occupants)
					ntf_chassis.balloon_alert(occupant, "low")
	else
		return
	engine.handle_revs()
