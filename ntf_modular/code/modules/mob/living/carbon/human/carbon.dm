/mob/living/carbon/human/proc/handle_haul_resist()
	if(world.time <= next_haul_resist)
		return

	if(incapacitated())
		return

	var/mob/living/carbon/xenomorph/xeno = devouring_mob
	if(!devouring_mob)
		return
	next_haul_resist = world.time + 1.4 SECONDS
	if(istype(get_active_held_item(), /obj/item))
		var/obj/item/item = get_active_held_item()
		if(item?.force)
			var/damage_of_item = item.force
			xeno.apply_damage(damage_of_item, BRUTE, zone_selected, MELEE, updating_health = TRUE, attacker = src)
			visible_message(span_danger("<B>[src] attacks [xeno]'s carapace with the [item.name]!"))
			if(item.sharp)
				playsound(loc, 'sound/weapons/slice.ogg', 25, 1)
			else
				var/hit_sound = pick('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit3.ogg')
				playsound(loc, hit_sound, 25, 1)
			if(prob(max(4*(100*xeno.getBruteLoss()/xeno.maxHealth - 75),0))) //4% at 24% health, 80% at 5% health
				xeno.gib()
	return

// Adding traits, etc after xeno restrains and hauls us
/mob/living/carbon/human/proc/handle_haul(mob/living/carbon/xenomorph/xeno)
	ADD_TRAIT(src, TRAIT_IMMOBILE, "t_s_xeno_haul")
	ADD_TRAIT(src, TRAIT_HAULED, "t_s_xeno_haul")

	devouring_mob = xeno
	layer = ABOVE_MOB_LAYER
	// add_filter("hauled_shadow", 1, color_matrix_filter(rgb(95, 95, 95)))
	pixel_y = 6
	next_haul_resist = 0

/mob/living/carbon/human/death(gibbing, deathmessage, silent, special_death_message)
	if(devouring_mob && !(SSticker.mode.round_type_flags & MODE_XENO_GRAB_DEAD_ALLOWED))
		to_chat(devouring_mob, span_xenowarning("[src] is dead. No more use for them now."))
		handle_unhaul()
	. = ..()

/mob/living/carbon/xenomorph/death(gibbing, deathmessage, silent)
	if(eaten_mob)
		eaten_mob.handle_unhaul()
	. = ..()

/mob/living/carbon/human/proc/haul_dir_check()
	if(!devouring_mob)
		return
	switch(closest_cardinal_dir(devouring_mob.dir))
		if(NORTH)
			layer = BELOW_MOB_LAYER
			pixel_y = 12
			pixel_x = 0
			setDir(SOUTH)
		if(EAST)
			layer = ABOVE_MOB_LAYER
			pixel_y = 6
			pixel_x = 12
			setDir(WEST)
		if(WEST)
			layer = ABOVE_MOB_LAYER
			pixel_y = 6
			pixel_x = -12
			setDir(EAST)
		if(SOUTH)
			layer = ABOVE_MOB_LAYER
			pixel_y = -12
			pixel_x =  0
			setDir(NORTH)

// Removing traits and other stuff after xeno releases us from haul, works to drop devoured people too.
/mob/living/carbon/human/proc/handle_unhaul()
	if(!devouring_mob) //we are in a belly
		return
	var/location = get_turf(devouring_mob.loc)
	remove_traits(list(TRAIT_HAULED, TRAIT_IMMOBILE), "t_s_xeno_haul")
	devouring_mob.remove_movespeed_modifier("hauler", TRUE)
	pixel_y = 0
	pixel_x = 0
	forceMove(location)
	devouring_mob.eaten_mob = null
	devouring_mob = null
	layer = initial(layer)
	//remove_filter("hauled_shadow")
	next_haul_resist = 0

/mob/living/carbon/help_shake_act(mob/living/carbon/shaker)
	if(HAS_TRAIT(src, TRAIT_SURRENDERING))
		if(status_flags & GODMODE)
			status_flags &= ~GODMODE
			REMOVE_TRAIT(src, TRAIT_SURRENDERING, "surrender")
	. = ..()
