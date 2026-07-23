/obj/vehicle/sealed/mecha/ntf/proc/attempt_flip(chance = 50, push_back, violent = FALSE, direction_fallen = 1)
	if(!is_flipped && !obj_integrity <= 0)
		if(prob(chance))
			animate(src, transform = matrix().Turn(90 * direction_fallen), time = 3, easing = SINE_EASING)
			is_flipped = TRUE
			playsound(src, 'sound/effects/bang.ogg', 80)
			visible_message(span_warning("[src] tips over on it's [flip_status]!"))
			if(!arms)
				dir = SOUTH
				flip_status = SIDE_POSITION
			else
				flip_status = legs.flip_position
		else
			visible_message(span_warning("[src] wobbles, but stays upright!"))
		if(!violent) // take_damage proc will shake it if there's enough damage
			Shake(1, 0.1, 0.2 SECONDS)

/obj/vehicle/sealed/mecha/ntf/proc/attempt_unflip()
	if(!is_flipped && !obj_integrity <= 0)
		animate(src, transform = matrix(), pixel_y = initial(pixel_y), time = 5, easing = SINE_EASING)
		is_flipped = FALSE
		flip_status = NOT_FLIPPED
