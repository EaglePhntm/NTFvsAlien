/client/proc/ntf_handle_ctrl_face_movement(movement)
	if(!keys_held["Ctrl"])
		return FALSE

	intended_direction = NONE
	next_move_dir_add = NONE
	next_move_dir_sub = NONE

	var/atom/movable/focus = mob.focus
	if(focus && !(SEND_SIGNAL(focus, COMSIG_MOVABLE_KEYBIND_FACE_DIR, movement) & COMSIG_IGNORE_MOVEMENT_LOCK))
		focus.keybind_face_direction(movement)

	return TRUE
