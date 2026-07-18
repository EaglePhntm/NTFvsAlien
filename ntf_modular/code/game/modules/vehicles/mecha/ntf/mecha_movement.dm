/obj/vehicle/sealed/mecha/ntf/vehicle_move(mob/living/user, direction, forcerotate = FALSE)
	. = ..()
	if(!.)
		return
	if(completely_disabled)
		return FALSE
	if(is_flipped) // NTF Edit
		return FALSE
	if(!direction)
		return FALSE
	if(ismovable(loc)) //Mech is inside an object, tell it we moved
		var/atom/loc_atom = loc
		return loc_atom.relaymove(src, direction)
	if(internal_tank?.connected_port)
		if(TIMER_COOLDOWN_FINISHED(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_warning("Unable to move while connected to the air system port!")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE
	if(construction_state)
		if(TIMER_COOLDOWN_FINISHED(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_danger("Maintenance protocols in effect.")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE

	if(zoom_mode)
		if(TIMER_COOLDOWN_FINISHED(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_warning("Unable to move while in zoom mode!")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE
	if(!cell)
		if(TIMER_COOLDOWN_FINISHED(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_warning("Missing power cell.")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE
	if(!scanmod || !capacitor)
		if(TIMER_COOLDOWN_FINISHED(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_warning("Missing [scanmod? "capacitor" : "scanning module"].")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		return FALSE
	if(step_energy_drain && !use_power(step_energy_drain))
		if(TIMER_COOLDOWN_FINISHED(src, COOLDOWN_MECHA_MESSAGE))
			to_chat(occupants, "[icon2html(src, occupants)][span_warning("Insufficient power to move!")]")
			TIMER_COOLDOWN_START(src, COOLDOWN_MECHA_MESSAGE, 2 SECONDS)
		if(leg_overload_mode)
			for(var/mob/booster AS in occupant_actions)
				var/action_type = /datum/action/vehicle/sealed/mecha/mech_overload_mode
				var/datum/action/vehicle/sealed/mecha/mech_overload_mode/overload = occupant_actions[booster][action_type]
				if(!overload)
					continue
				overload.action_activate(NONE, FALSE)
				break
		return FALSE

	var/olddir = dir

	if(internal_damage & MECHA_INT_CONTROL_LOST)
		direction = pick(GLOB.alldirs)

	//only mechs with diagonal movement may move diagonally
	if(!allow_diagonal_movement && ISDIAGONALDIR(direction))
		return TRUE

	var/keyheld = FALSE
	if(strafe)
		for(var/mob/driver AS in return_drivers())
			if(driver.client?.keys_held["Alt"])
				keyheld = TRUE
				break

	//if we're not facing the way we're going rotate us
	// if we're not strafing or if we are forced to rotate or if we are holding down the key
	if(dir != direction && (!strafe || forcerotate || keyheld))
		// remove diag dirs so it doesnt fuck up any directional stuff
		var/dir_to_set = ISDIAGONALDIR(direction) ? (direction & ~(NORTH|SOUTH)) : direction
		if(!(mecha_flags & QUIET_TURNS))
			playsound(src, turnsound, 40, TRUE)
		if(tank_turns && direction == REVERSE_DIR(dir) && !forcerotate)
			dir_to_set = turn(direction, pick(90, -90))
		setDir(dir_to_set)
		if(keyheld || !pivot_step) //If we pivot step, we don't return here so we don't just come to a stop
			return TRUE

	set_glide_size(DELAY_TO_GLIDE_SIZE(move_delay))
	//Otherwise just walk normally
	. = try_step_multiz(direction)

	if(phasing)
		use_power(phasing_energy_drain)
	if(strafe)
		setDir(olddir)
