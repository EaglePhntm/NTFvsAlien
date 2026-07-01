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
	var/list/amplification_traits = list(TRAIT_EXOSUIT_NV)
	var/power_cost = 25

/datum/action/vehicle/sealed/mecha/light_amplification/action_activate(trigger_flags)
	if(!owner || !chassis || !(owner in chassis.occupants))
		return
	if(!ismob(owner))
		to_chat(owner, "The [src] activates, but you appear to be a mere object!")
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
	TIMER_COOLDOWN_START(chassis, COOLDOWN_MECHA_EQUIPMENT(type), cooldown)
	chassis.smoke_system.start()

// Jumping

/datum/component/jump/exosuit
	jump_height = 8
	jumper_allow_pass_flags = 0

/datum/component/jump/exosuit/do_jump(atom/movable/jumper)
    jumper_allow_pass_flags = 0
    return ..()
