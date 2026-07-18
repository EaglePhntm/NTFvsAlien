/obj/vehicle/sealed/mecha/ntf/bullet_act(atom/movable/projectile/proj, def_zone, piercing_hit)
	var/actual_zone = def_zone || proj.def_zone
	var/armor_rating = soft_armor.getRating(proj.armor_type)
	var/pen_quality = clamp((proj.penetration - (armor_rating * cockpit_armor)) / max(armor_rating, 1), 0, 1)
	if(LAZYLEN(occupants))
		var/mob/living/occupant = pick(occupants)
		if(pen_quality && LAZYLEN(occupants) && !(mecha_flags & SILICON_PILOT) && !(mecha_flags & CANNOT_OVERPENETRATE) && (actual_zone == BODY_ZONE_HEAD || actual_zone == BODY_ZONE_CHEST))
			var/original_damage = proj.damage
			var/pilot_damage = round(proj.damage * pen_quality * 0.90)
			proj.damage -= pilot_damage
			. = ..()
			proj.damage = pilot_damage
			if(proj.armor_type == BOMB || proj.damage >= 300 || proj.penetration >= 90)
				var/occupant_count = length(occupants)
				proj.damage /= occupant_count
				for(var/mob/living/hitee in occupants)
					hitee.bullet_act(proj, actual_zone, piercing_hit)
				proj.damage = original_damage
				return
			occupant.bullet_act(proj, actual_zone, piercing_hit)
			proj.damage = original_damage
			return
	return ..()

/// tries to damage mech equipment depending on damage and where is being targetted
/obj/vehicle/sealed/mecha/ntf/try_damage_component(damage, def_zone, armor_type)
	var/list/gear = list()
	switch(def_zone)
		if(BODY_ZONE_L_ARM)
			gear = equip_by_category[MECHA_L_ARM]
		if(BODY_ZONE_R_ARM)
			gear = equip_by_category[MECHA_R_ARM]
		if(BODY_ZONE_HEAD)
			gear = head
		if(BODY_ZONE_CHEST || BODY_ZONE_PRECISE_GROIN)
			gear = body
		if(BODY_ZONE_R_LEG || BODY_ZONE_L_LEG)
			gear = legs
	if(armor_type == BOMB)
		gear = flat_equipment.Copy()
	if(!gear)
		return

	for(var/obj/item/mecha_parts/mecha_equipment/gear2 as anything in gear)
	// always leave at least 1 health
		var/damage_to_deal = min(gear2.obj_integrity - 1, damage)
		if(damage_to_deal <= 0)
			return
		gear2.take_damage(damage_to_deal)
		if(gear2.obj_integrity <= 1)
			to_chat(occupants, "[icon2html(src, occupants)][span_danger("[gear2] is critically damaged!")]")
			playsound(src, gear2.destroy_sound, 50)

/obj/vehicle/sealed/mecha/ntf/ex_act(severity)
	log_message("Affected by explosion of severity: [severity].", LOG_MECHA, color="red")
	if(CHECK_BITFIELD(resistance_flags, INDESTRUCTIBLE))
		return
	if(!(atom_flags & PREVENT_CONTENTS_EXPLOSION))
		contents_explosion(severity)
	if(QDELETED(src))
		return
	var/stagger_duration
	switch(severity)
		if(EXPLODE_DEVASTATE)
			take_damage(rand(600, 1200), BRUTE, BOMB, 0)
			stagger_duration = 7 SECONDS
		if(EXPLODE_HEAVY)
			take_damage(rand(100, 200), BRUTE, BOMB, 0)
			stagger_duration = 5 SECONDS
		if(EXPLODE_LIGHT)
			take_damage(rand(60, 120), BRUTE, BOMB, 0)
			stagger_duration = 2 SECONDS
		if(EXPLODE_WEAK)
			take_damage(rand(10, 35), BRUTE, BOMB, 0)

	if(!stagger_duration)
		return
	for(var/mob/living/living_occupant AS in occupants)
		living_occupant.Stagger(stagger_duration)



/obj/vehicle/sealed/mecha/ntf/proc/attempt_flip(chance = 50, push_back, violent = FALSE, direction_fallen = 1)
	if(!is_flipped && !obj_integrity <= 0)
		if(prob(chance))
			animate(src, transform = matrix().Turn(90 * direction_fallen), time = 3, easing = SINE_EASING)
			is_flipped = TRUE
		else
			visible_message(span_warning("[src] wobbles, but stays upright!"))
		if(!violent) // take_damage proc will shake it if there's enough damage
			Shake(1, 0.1, 0.2 SECONDS)

/obj/vehicle/sealed/mecha/ntf/proc/attempt_unflip()
	if(!is_flipped && !obj_integrity <= 0)
		animate(src, transform = matrix(), pixel_y = initial(pixel_y), time = 5, easing = SINE_EASING)
		is_flipped = FALSE

///obj/vehicle/sealed/mecha/ntf

#warn move later

/datum/looping_sound/exosuit_engine/fuel
	start_sound = null
	start_length = 0
	mid_sounds = list('sound/machines/generator/generator_mid1.ogg'=1, 'sound/machines/generator/generator_mid2.ogg'=1, 'sound/machines/generator/generator_mid3.ogg'=1)
	mid_length = 4
	end_sound = null
	volume = 15

/datum/looping_sound/exosuit_engine/electric
	start_sound = null
	start_length = 0
	mid_sounds = list('sound/machines/generator/generator_mid1.ogg'=1, 'sound/machines/generator/generator_mid2.ogg'=1, 'sound/machines/generator/generator_mid3.ogg'=1)
	mid_length = 4
	end_sound = null
	volume = 15

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

/obj/vehicle/sealed/mecha/ntf/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_HARM)
		user.changeNext_move(CLICK_CD_MELEE) // Ugh. Ideally we shouldn't be setting cooldowns outside of click code.
		user.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
		playsound(loc, 'sound/weapons/tap.ogg', 40, TRUE, -1)
		user.visible_message(span_danger("[user] hits [src]. Nothing happens."), null, null, COMBAT_MESSAGE_RANGE)
		log_message("Attack by hand/paw (no damage). Attacker - [user].", LOG_MECHA, color="red")
		return
	toggle_hatch(user, FALSE)

/obj/vehicle/sealed/mecha/ntf/RightClick(mob/living/user)
	if(!(user in occupants))
		return
	toggle_hatch(user, TRUE)

/obj/vehicle/sealed/mecha/ntf/proc/toggle_hatch(mob/living/user, toggling_lock = FALSE)
	if(hatch_status == HATCH_BROKEN)
		balloon_alert(user, "hatch is broken!")
		return

	if(toggling_lock)
		if(hatch_status == HATCH_OPEN)
			balloon_alert(user, "close it first!")
			return
		hatch_status = (hatch_status == HATCH_LOCKED) ? HATCH_CLOSED : HATCH_LOCKED
		balloon_alert(user, hatch_status == HATCH_LOCKED ? "locked!" : "unlocked!")
	else
		if(hatch_status == HATCH_LOCKED)
			balloon_alert(user, "unlock first!")
			return
		hatch_status = (hatch_status == HATCH_OPEN) ? HATCH_CLOSED : HATCH_OPEN
		balloon_alert(user, hatch_status == HATCH_OPEN ? "opened!" : "closed!")
	update_icon()

/obj/vehicle/sealed/mecha/ntf/on_mouseclick(mob/user, atom/target, turf/location, control, list/modifiers)
	.=..()
	if(src == target)
		toggle_hatch(user)

/obj/vehicle/sealed/mecha/ntf/update_icon()
	.=..()
	var/list/overlays_to_make = list()
	for(var/obj/item/mecha_parts/mecha_pieces/pieces as anything in list(body, head, legs, arms))
		if(pieces)
			overlays_to_make += pieces

	if(body)
		var/image/cabin_overlay = image(icon = body.icon, icon_state = "[body.icon_state]")
		overlays_to_make += cabin_overlay

		if(hatch_status == HATCH_OPEN || HATCH_BROKEN)
			var/image/door_overlay = image(icon = body.icon, icon_state = "[body.icon_state]_overlay_open")
			door_overlay.layer = MECH_COCKPIT_LAYER
			overlays_to_make += door_overlay

		if(body.extra_overlays && hatch_status == HATCH_CLOSED || HATCH_LOCKED)
			var/image/extra_overlays = image(icon = body.icon, icon_state = "[body.icon_state]_overlay")
			extra_overlays.layer = MECH_COCKPIT_LAYER+0.01
			overlays_to_make += extra_overlays

	overlays = overlays_to_make

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
