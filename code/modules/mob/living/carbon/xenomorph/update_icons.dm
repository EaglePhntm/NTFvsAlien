/mob/living/carbon/xenomorph/apply_overlay(cache_index)
	var/image/I = overlays_standing[cache_index]
	if(I)
		//TODO THIS SHOULD USE THE API!
		overlays += I

/mob/living/carbon/xenomorph/remove_overlay(cache_index)
	if(overlays_standing[cache_index])
		overlays -= overlays_standing[cache_index]
		overlays_standing[cache_index] = null

/mob/living/carbon/xenomorph/proc/handle_special_state()
	return FALSE

/mob/living/carbon/xenomorph/proc/handle_special_wound_states()
	return FALSE

/mob/living/carbon/xenomorph/toggle_move_intent(new_intent)
	. = ..()
	update_icons()

/mob/living/carbon/xenomorph/update_icons(state_change = TRUE)
	SEND_SIGNAL(src, COMSIG_XENOMORPH_UPDATE_ICONS, state_change)
	if(state_change)
		if(stat == DEAD)
			icon_state = "[xeno_caste.caste_name][is_a_rouny ? " rouny" : ""] Dead"
		else if(HAS_TRAIT(src, TRAIT_BURROWED))
			icon_state = "[xeno_caste.caste_name][is_a_rouny ? " rouny" : ""] Burrowed"
		else if(lying_angle)
			if((resting || IsSleeping()) && (!IsParalyzed() && !IsUnconscious() && health > 0))
				icon_state = "[xeno_caste.caste_name][is_a_rouny ? " rouny" : ""] Sleeping"
			else
				icon_state = "[xeno_caste.caste_name][is_a_rouny ? " rouny" : ""] Knocked Down"
		else if(!handle_special_state())
			if(m_intent == MOVE_INTENT_RUN)
				icon_state = "[xeno_caste.caste_name][is_a_rouny ? " rouny" : ""] Running"
			else
				icon_state = "[xeno_caste.caste_name][is_a_rouny ? " rouny" : ""] Walking"
	update_fire() //the fire overlay depends on the xeno's stance, so we must update it.
	update_wounds()
	update_xeno_gender()
	update_snowflake_overlays()

	hud_set_sunder()
	hud_set_firestacks()

/mob/living/carbon/xenomorph/regenerate_icons()
	..()

	update_inv_r_hand()
	update_inv_l_hand()
	update_icons()

/mob/living/carbon/xenomorph/update_inv_r_hand()
	remove_overlay(R_HAND_LAYER)
	if(r_hand)
		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			r_hand.screen_loc = ui_rhand
			client.screen += r_hand

		overlays_standing[R_HAND_LAYER] = r_hand.make_worn_icon(inhands = TRUE, slot_name = slot_r_hand_str, default_icon = 'icons/mob/inhands/items/items_right.dmi', default_layer = R_HAND_LAYER)
		apply_overlay(R_HAND_LAYER)

/mob/living/carbon/xenomorph/update_inv_l_hand()
	remove_overlay(L_HAND_LAYER)
	if(l_hand)
		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			l_hand.screen_loc = ui_lhand
			client.screen += l_hand

		overlays_standing[L_HAND_LAYER] = l_hand.make_worn_icon(inhands = TRUE, slot_name = slot_l_hand_str, default_icon = 'icons/mob/inhands/items/items_left.dmi', default_layer = L_HAND_LAYER)
		apply_overlay(L_HAND_LAYER)

/mob/living/carbon/xenomorph/proc/create_shriekwave()
	overlays_standing[SUIT_LAYER] = image("icon"='icons/Xeno/64x64_Xeno_overlays.dmi', "icon_state" = "shriek_waves") //Ehh, suit layer's not being used.
	apply_temp_overlay(SUIT_LAYER, 3 SECONDS)
	INVOKE_ASYNC(src, PROC_REF(shriek_burst))
	//decrease range cus they'll be probably mvoing around
	addtimer(CALLBACK(src, PROC_REF(shriek_burst), -2), 8)
	addtimer(CALLBACK(src, PROC_REF(shriek_burst), -4), 16)

///executes a burst of shockwaves. quad ease out so it does dash too fast and insta dissapear. maybe should use it on explosions too
/mob/living/carbon/xenomorph/proc/shriek_burst(range_diff=0)
	new /obj/effect/temp_visual/shockwave(loc, (WORLD_VIEW_NUM*2)+range_diff, null, 0.5, QUAD_EASING|EASE_OUT)
	sleep(2) // yes I use sleep and yes I think this tiny tick timers are a not worth it here
	new /obj/effect/temp_visual/shockwave(loc, (WORLD_VIEW_NUM*2)+range_diff, null, 0.5, QUAD_EASING|EASE_OUT)
	sleep(2)
	new /obj/effect/temp_visual/shockwave(loc, (WORLD_VIEW_NUM*2)+range_diff, null, 0.5, QUAD_EASING|EASE_OUT)

/mob/living/carbon/xenomorph/proc/create_stomp()
	overlays_standing[SUIT_LAYER] = image("icon"='icons/Xeno/64x64_Xeno_overlays.dmi', "icon_state" = "stomp") //Ehh, suit layer's not being used.
	apply_temp_overlay(SUIT_LAYER, 1.2 SECONDS)

/mob/living/carbon/xenomorph/update_fire()
	if(!fire_overlay)
		return
	var/fire_light = min(fire_stacks * 0.2 , 3)
	if(!on_fire)
		fire_light = 0
	if(fire_light == fire_luminosity)
		return
	fire_luminosity = fire_light
	fire_overlay.update_appearance(UPDATE_ICON)

///Updates the wound overlays on the xeno
/mob/living/carbon/xenomorph/proc/update_wounds()
	if(QDELETED(src))
		return

	remove_overlay(WOUND_LAYER)
	remove_filter("wounded_filter")

	var/health_thresholds
	wound_overlay.layer = layer + 0.3
	wound_overlay.icon = src.icon
	wound_overlay.vis_flags |= VIS_HIDE
	if(HAS_TRAIT(src, TRAIT_XENOMORPH_INVISIBLE_BLOOD))
		wound_overlay.icon_state = "none"
		return
	if(health > health_threshold_crit)
		health_thresholds = CEILING((health * 4) / (maxHealth), 1) //From 1 to 4, in 25% chunks
		if(health_thresholds > 3)
			wound_overlay.icon_state = "none"
			return //Injuries appear at less than 75% health
	else if(health_threshold_dead)
		switch(CEILING((health * 3) / health_threshold_dead, 1)) //Negative health divided by a negative threshold, positive result.
			if(0 to 1)
				health_thresholds = 1
			if(2)
				health_thresholds = 2
			if(3 to INFINITY)
				health_thresholds = 3
	var/overlay_to_show
	if(lying_angle)
		if((resting || IsSleeping()) && (!IsParalyzed() && !IsUnconscious() && health > 0))
			overlay_to_show = "wounded_resting_[health_thresholds]"
		else
			overlay_to_show = "wounded_stunned_[health_thresholds]"
	else if(!handle_special_state())
		overlay_to_show = "wounded_[health_thresholds]"
	else
		overlay_to_show = handle_special_wound_states(health_thresholds)

	wound_overlay.icon_state = "[xeno_caste.wound_type]_[overlay_to_show]"

	if(xeno_caste.caste_flags & CASTE_HAS_WOUND_MASK)
		var/image/wounded_mask = image(icon, null, "alpha_[overlay_to_show]")
		wounded_mask.render_target = "*wound[REF(src)]"
		overlays_standing[WOUND_LAYER] = wounded_mask
		apply_overlay(WOUND_LAYER)
		add_filter("wounded_filter", 1, alpha_mask_filter(0, 0, null, "*wound[REF(src)]", MASK_INVERSE))

	wound_overlay.vis_flags &= ~VIS_HIDE // Show the overlay

///Updates the niche overlays of a xenomorph, like the backpack overlay
/mob/living/carbon/xenomorph/proc/update_snowflake_overlays()
	if(!backpack_overlay)
		return
	if(!istype(back,/obj/item/storage/backpack/marine/duffelbag/xenosaddle))
		backpack_overlay.icon_state = ""
		return
	var/obj/item/storage/backpack/marine/duffelbag/xenosaddle/saddle = back
	if(stat == DEAD)
		backpack_overlay.icon_state = "[saddle.style][is_a_rouny ? " rouny" : ""] Dead"
		return
	if(lying_angle)
		if((resting || IsSleeping()) && (!IsParalyzed() && !IsUnconscious() && health > 0))
			backpack_overlay.icon_state = "[saddle.style][is_a_rouny ? " rouny" : ""] Sleeping"
			return
		backpack_overlay.icon_state = "[saddle.style][is_a_rouny ? " rouny" : ""] Knocked Down"
		return
	backpack_overlay.icon_state = "[saddle.style][is_a_rouny ? " rouny" : ""]"

/mob/living/carbon/xenomorph/update_transform()
	..()
	return update_icons()

///Used to display xeno wounds & equipment without rapidly switching overlays

/atom/movable/vis_obj/xeno_wounds/backpack_overlay
	layer = ABOVE_MOB_LAYER
	icon = 'icons/Xeno/saddles/runnersaddle.dmi' //this should probally be something more generic if saddles r ever added to anything other than rounies
	///The xeno this overlay belongs to
	var/mob/living/carbon/xenomorph/owner

/atom/movable/vis_obj/xeno_wounds/genital_overlay
	layer = ABOVE_MOB_LAYER
	icon = null
	var/mob/living/carbon/xenomorph/owner

/atom/movable/vis_obj/xeno_wounds/genital_overlay/Initialize(mapload, new_owner)
	owner = new_owner
	if(!owner)
		return INITIALIZE_HINT_QDEL
	return ..()

/atom/movable/vis_obj/xeno_wounds
	vis_flags = VIS_INHERIT_DIR|VIS_INHERIT_ID|VIS_INHERIT_PLANE

/atom/movable/vis_obj/xeno_wounds/backpack_overlay/Initialize(mapload, new_owner)
	owner = new_owner
	if(!owner)
		return INITIALIZE_HINT_QDEL
	return ..()

/atom/movable/vis_obj/xeno_wounds/fire_overlay
	light_system = MOVABLE_LIGHT
	layer = ABOVE_MOB_LAYER
	///The xeno this belongs to
	var/mob/living/carbon/xenomorph/owner

/atom/movable/vis_obj/xeno_wounds/fire_overlay/Initialize(mapload, new_owner)
	owner = new_owner
	if(!owner)
		return INITIALIZE_HINT_QDEL
	icon = owner.icon
	light_pixel_x = owner.light_pixel_x
	light_pixel_y = owner.light_pixel_y
	. = ..()
	update_appearance(UPDATE_ICON)

/atom/movable/vis_obj/xeno_wounds/fire_overlay/Destroy()
	owner = null
	return ..()

/atom/movable/vis_obj/xeno_wounds/fire_overlay/update_icon()
	. = ..()
	if(!owner.on_fire || HAS_TRAIT(owner, TRAIT_BURROWED))
		update_flame_light(0)
	else
		update_flame_light(owner.fire_luminosity)

/atom/movable/vis_obj/xeno_wounds/fire_overlay/update_icon_state()
	. = ..()
	if(!owner.on_fire)
		icon_state = ""
		return
	if(HAS_TRAIT(owner, TRAIT_BURROWED))
		icon_state = ""
		return
	if((!owner.lying_angle && !owner.resting && !owner.IsSleeping()))
		icon_state = "alien_fire"
	else
		icon_state = "alien_fire_lying"

/atom/movable/vis_obj/xeno_wounds/fire_overlay/update_overlays()
	. = ..()
	if(!owner.on_fire || HAS_TRAIT(owner, TRAIT_BURROWED))
		return
	. += emissive_appearance(icon, icon_state, src)

///Adjusts the light emitted by the flame
/atom/movable/vis_obj/xeno_wounds/fire_overlay/proc/update_flame_light(intensity)
	if(!intensity)
		set_light_on(FALSE)
	else
		set_light_range_power_color(intensity, 0.5, LIGHT_COLOR_FIRE)
		set_light_on(TRUE)
