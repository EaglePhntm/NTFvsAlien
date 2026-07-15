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
//					add_arms(type = piece_to_add)
				if(MECHA_LEGS)
					legs = piece_to_add
				if(MECHA_BODY)
					body = piece_to_add
				if(MECHA_HEAD)
					head = piece_to_add

			mecha_update_components()

			to_chat(user, span_notice("You install the [piece_to_add] into [src]."))
	return ..()

/obj/vehicle/sealed/mecha/ntf/update_icon()
	.=..()
	var/list/new_overlays = list()
	for(var/obj/item/mecha_parts/mecha_pieces/pieces as anything in list(body, head, legs, arms))
		if(pieces)
			new_overlays += pieces
	overlays = new_overlays

/obj/vehicle/sealed/mecha/ntf/proc/mecha_update_components()
	update_icon()

///obj/vehicle/sealed/mecha/ntf/proc/add_arms(type)
//