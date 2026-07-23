/obj/vehicle/sealed/mecha/ntf/vehicle_move(mob/living/user, direction, forcerotate = FALSE)
	. = ..()
	if(!.)
		return
	if(is_flipped) // NTF Edit
		return FALSE

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
