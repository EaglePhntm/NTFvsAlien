/obj/machinery/light
	obj_flags = CAN_BE_HIT|PROJ_IGNORE_DENSITY

/obj/machinery/light/projectile_hit(atom/movable/projectile/proj, cardinal_move, uncrossing)
	. = ..()
	broken()

/obj/machinery/light/emp_act(severity)
	. = ..()
	if(has_power())
		set_flicker(severity SECONDS, 1.5, 2.5, rand(1,2))
