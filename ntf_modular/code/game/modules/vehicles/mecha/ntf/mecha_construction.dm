// Adding/Removing parts

/obj/vehicle/sealed/mecha/ntf/attackby(obj/item/W, mob/user, params)
	.=..()
	if(istype(W, /obj/item/mecha_parts/mecha_pieces))
		if(construction_state == MECHA_OPEN_HATCH)
			var/obj/item/mecha_parts/mecha_pieces/piece_to_add = W

			switch(piece_to_add.type_of_piece)
				if(MECHA_ARMS)
					if(arms)
						to_chat(user, span_warning("The exosuit already has that type of component installed!"))
						return
				if(MECHA_LEGS)
					if(legs)
						to_chat(user, span_warning("The exosuit already has that type of component installed!"))
						return
				if(MECHA_BODY)
					if(body)
						to_chat(user, span_warning("The exosuit already has that type of component installed!"))
						return
				if(MECHA_HEAD)
					if(head)
						to_chat(user, span_warning("The exosuit already has that type of component installed!"))
						return
				else
					return

			to_chat(user, span_notice("You start installing the [piece_to_add] into [src]."))
			visible_message(span_notice("[user] starts installing the [piece_to_add] into [src]."))

			if(!do_after(user, 5))
				user.balloon_alert(user, "interrupted!")
				return

			if(!user.transferItemToLoc(W, src))
				return

			switch(piece_to_add.type_of_piece)
				if(MECHA_ARMS)
					arms = piece_to_add
				if(MECHA_LEGS)
					legs = piece_to_add
				if(MECHA_BODY)
					body = piece_to_add
				if(MECHA_HEAD)
					head = piece_to_add

			mecha_update_components()

			to_chat(user, span_notice("You install the [piece_to_add] into [src]."))

	return ..()

#define ARMS "arms"
#define LEGS "legs"
#define HEAD "head"
#define BODY "body"

/obj/vehicle/sealed/mecha/ntf/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		balloon_alert(user, "dot referenced!")
		return
	if(construction_state != MECHA_OPEN_HATCH)
		balloon_alert(user, "hatch not open!")
		return
	var/thing_to_remove
	switch(user.zone_selected)
		if(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
			thing_to_remove = ARMS
		if(BODY_ZONE_CHEST)
			thing_to_remove = BODY
		if(BODY_ZONE_HEAD)
			thing_to_remove = HEAD
		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			thing_to_remove = LEGS
	if(!thing_to_remove)
		balloon_alert(user, "no thing to remove!")
		return

	var/obj/item/mecha_parts/mecha_pieces/piece = get_mecha_part(thing_to_remove)
	if(!piece)
		balloon_alert(user, "nothing there!")
		return

	balloon_alert(user, "removing [thing_to_remove]...")
	if(!do_after(user, 7 SECONDS, target = src))
		balloon_alert(user, "interrupted!")
		return

	// re-check everything after the delay; state may have changed
	if(construction_state != MECHA_OPEN_HATCH)
		return
	piece = get_mecha_part(thing_to_remove)
	if(!piece)
		return
	if(!user.Adjacent(src))
		return

	set_mecha_part(thing_to_remove, null)
	user.put_in_hands(piece)
	mecha_update_components()
	to_chat(user, span_notice("You remove the [thing_to_remove] from [src]."))
	return TRUE

/obj/vehicle/sealed/mecha/ntf/proc/get_mecha_part(slot)
	switch(slot)
		if(ARMS)
			return arms
		if(LEGS)
			return legs
		if(HEAD)
			return head
		if(BODY)
			return body

/obj/vehicle/sealed/mecha/ntf/proc/set_mecha_part(slot, obj/item/mecha_parts/mecha_pieces/piece)
	switch(slot)
		if(ARMS)
			arms = piece
		if(LEGS)
			legs = piece
		if(HEAD)
			head = piece
		if(BODY)
			body = piece

#undef ARMS
#undef BODY
#undef LEGS
#undef HEAD

/obj/vehicle/sealed/mecha/ntf/proc/mecha_update_components()
	update_icon()
	if(body)
		update_body_values()
//	if(head)
//		update_head_values()
	if(legs)
		update_legs_values()
	if(arms)
		update_arms_values()
	return

/obj/vehicle/sealed/mecha/ntf/proc/update_body_values()
	if(!body)
		return

//	var/obj/item/mecha_parts/mecha_pieces/mecha_body/the_body

	max_integrity = body.max_integrity
	obj_integrity = max_integrity
	max_drivers = body.occupants_allowed[DRIVER]
	max_occupants = body.occupants_allowed[PASSENGER]
	exit_delay = body.exit_delay
	enter_delay = body.enter_delay
	cockpit_armor = body.cockpit_armor
	soft_armor = body.soft_armor

/obj/vehicle/sealed/mecha/ntf/proc/update_arms_values()
	if(!arms)
		return

	force = arms.melee_damage
//	melee_delay = the_arms.action_delay

/obj/vehicle/sealed/mecha/ntf/proc/update_legs_values()
	if(!legs)
		return

	move_delay = legs.movement_delay
	pivot_step = legs.pivot_step
	tank_turns = legs.tank_turns
	allow_diagonal_movement = legs.can_move_diagonally
	stepsound = legs.step_sound
	turnsound = legs.turn_sound
//	can_strafe = legs.can_strafe
