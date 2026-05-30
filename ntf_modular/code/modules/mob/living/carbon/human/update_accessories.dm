// Central entry point for character accessory overlays.
// Keep individual accessory renderers here so update_icons.dm stays focused on body assembly.
#define ACCESSORY_BODY_FRONT_LAYER -6
#define ACCESSORY_BODY_ADJ_LAYER -46
#define ACCESSORY_BODY_BEHIND_LAYER -49
#define ACCESSORY_TAIL_NORTH_LAYER (ACCESSORY_FACE_TOP_LAYER + 0.5)
#define ACCESSORY_WING_NORTH_LAYER -(BODYPARTS_LAYER - 1)
#define ACCESSORY_WING_SOUTH_BEHIND_LAYER -48
#define ACCESSORY_WING_FRONT_LAYER -7
#define ACCESSORY_WING_TOP_LAYER -6.2

#define ACCESSORY_FACE_TOP_LAYER -(FACEMASK_LAYER + 1)
#define ACCESSORY_FACE_FRONT_LAYER -(HAIR_LAYER + 1)
#define ACCESSORY_FACE_ADJ_LAYER -(HAIR_LAYER + 1)
#define ACCESSORY_FACE_BEHIND_LAYER -(HAIR_LAYER + 2)
#define ACCESSORY_FACE_UNDER_LAYER -(HAIR_LAYER + 3)
#define ACCESSORY_EARS_OVER_HAIR_LAYER (-(HAIR_LAYER) + 0.5)

#define ACCESSORY_KIND_TAIL "tail"
#define ACCESSORY_KIND_WINGS "wings"
#define ACCESSORY_KIND_EARS "ears"

/mob/living/carbon/human/proc/update_accessories()
	update_tail_and_wings()
	update_snout()
	update_ears()
	update_horns()
	update_fluff()
	update_synth_antenna()

/proc/accessory_has_top_tag(datum/sprite_accessory/accessory_data)
	return findtext(accessory_data?.name, "(Top")

/proc/accessory_body_draw_layer(render_layer)
	switch(render_layer)
		if("BEHIND")
			return ACCESSORY_BODY_BEHIND_LAYER
		if("ADJ", "ADJs")
			return ACCESSORY_BODY_ADJ_LAYER
		if("FRONT")
			return ACCESSORY_BODY_FRONT_LAYER
	return ACCESSORY_BODY_FRONT_LAYER

/proc/accessory_face_draw_layer(render_layer)
	switch(render_layer)
		if("BEHIND")
			return ACCESSORY_FACE_BEHIND_LAYER
		if("ADJ", "ADJs")
			return ACCESSORY_FACE_ADJ_LAYER
		if("FRONT")
			return ACCESSORY_FACE_FRONT_LAYER
	return ACCESSORY_FACE_ADJ_LAYER

/proc/accessory_snout_draw_layer(datum/sprite_accessory/accessory_data, render_layer)
	if(accessory_has_top_tag(accessory_data))
		return ACCESSORY_FACE_TOP_LAYER
	return accessory_face_draw_layer(render_layer)

/proc/accessory_fluff_draw_layer(datum/sprite_accessory/accessory_data, render_layer)
	if(accessory_has_top_tag(accessory_data))
		return ACCESSORY_FACE_TOP_LAYER
	if(render_layer == "FRONT")
		return ACCESSORY_FACE_FRONT_LAYER
	return accessory_body_draw_layer(render_layer)

/proc/accessory_horns_draw_layer(render_layer, direction)
	if(direction == NORTH)
		return ACCESSORY_FACE_TOP_LAYER
	return ACCESSORY_FACE_UNDER_LAYER

/proc/accessory_antenna_draw_layer(render_layer, direction)
	if(direction == NORTH)
		return ACCESSORY_FACE_TOP_LAYER
	return ACCESSORY_FACE_BEHIND_LAYER

/proc/accessory_ears_draw_layer(render_layer, direction)
	return ACCESSORY_EARS_OVER_HAIR_LAYER

/proc/accessory_wing_draw_layer(datum/sprite_accessory/accessory_data, render_layer, direction)
	if(direction == NORTH)
		return ACCESSORY_WING_NORTH_LAYER
	if(render_layer == "BEHIND")
		return ACCESSORY_WING_SOUTH_BEHIND_LAYER
	if(accessory_has_top_tag(accessory_data) || accessory_data:top_only)
		return ACCESSORY_WING_TOP_LAYER
	if(render_layer == "ADJ" || render_layer == "ADJs")
		return ACCESSORY_BODY_ADJ_LAYER
	return ACCESSORY_WING_FRONT_LAYER

/proc/accessory_uses_underlay(accessory_kind, datum/sprite_accessory/accessory_data, render_layer, direction)
	switch(accessory_kind)
		if(ACCESSORY_KIND_TAIL)
			return direction != NORTH
		if(ACCESSORY_KIND_WINGS)
			if(accessory_has_top_tag(accessory_data) || accessory_data:top_only)
				return FALSE
			if(direction == NORTH)
				return FALSE
			if(direction == SOUTH)
				return TRUE
			if(render_layer == "BEHIND")
				return TRUE
			return FALSE
		if(ACCESSORY_KIND_EARS)
			return FALSE
	return FALSE

/proc/apply_accessory_image_layer(list/accessory_layers, draw_layer)
	for(var/image/accessory_image in accessory_layers)
		accessory_image.layer = draw_layer

/proc/ntf_emissive_appearance_copy(image/to_use, atom/offset_spokesman = null)
	if(!to_use)
		return null
	var/mutable_appearance/emissive = emissive_appearance(to_use.icon, to_use.icon_state, offset_spokesman, layer = to_use.layer, alpha = to_use.alpha, appearance_flags = to_use.appearance_flags)
	emissive.dir = to_use.dir
	emissive.pixel_x = to_use.pixel_x
	emissive.pixel_y = to_use.pixel_y
	emissive.pixel_w = to_use.pixel_w
	emissive.pixel_z = to_use.pixel_z
	return emissive

/mob/living/carbon/human/proc/ntf_should_render_emissives()
	// Preference previews flatten planes, which makes emissive masks draw as red sprites.
	return allow_emissives && !istype(src, /mob/living/carbon/human/dummy)

/mob/living/carbon/human/proc/accessory_emissive_enabled(list/emissive_list, color_index)
	return ntf_should_render_emissives() && islist(emissive_list) && emissive_list[color_index]

/mob/living/carbon/human/proc/add_tail_layer(list/accessory_layers, image/tail_image, color_index)
	if(!tail_image)
		return
	accessory_layers += tail_image
	if(accessory_emissive_enabled(tail_emissive, color_index))
		var/mutable_appearance/emissive_tail = ntf_emissive_appearance_copy(tail_image, src)
		if(emissive_tail)
			accessory_layers += emissive_tail

/mob/living/carbon/human/proc/update_horns()
	remove_overlay(ACCESSORY_HORNS_LAYER)

	if(!horns || horns == "None")
		return

	var/datum/sprite_accessory/horns/horns_data = GLOB.horns_list[horns]
	if(!horns_data || !horns_data.icon_state)
		return

	var/horns_render_color = horns_color
	switch(horns_data.color_src)
		if(ACCESSORY_COLOR_BODY)
			horns_render_color = body_color
		if(ACCESSORY_COLOR_HAIR)
			horns_render_color = get_render_hair_color()

	var/list/horns_layers = list()
	for(var/render_layer in horns_data.render_layers)
		var/draw_layer = accessory_horns_draw_layer(render_layer, dir)
		add_accessory_layer(horns_layers, horns_data, render_layer, null, horns_render_color, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(horns_emissive, 1))
		if(horns_data.color_count >= 2)
			add_accessory_layer(horns_layers, horns_data, render_layer, "secondary", horns_color_secondary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(horns_emissive, 2))
		if(horns_data.color_count >= 3)
			add_accessory_layer(horns_layers, horns_data, render_layer, "tertiary", horns_color_tertiary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(horns_emissive, 3))

	if(!length(horns_layers))
		return

	overlays_standing[ACCESSORY_HORNS_LAYER] = horns_layers
	apply_overlay(ACCESSORY_HORNS_LAYER)

/mob/living/carbon/human/proc/update_fluff()
	remove_overlay(ACCESSORY_FLUFF_LAYER)
	return // Disabled until fluff can be anchored through an organ/bodypart overlay, like SPLURT.
	/*
	if(!fluff || fluff == "None")
		return

	var/datum/sprite_accessory/fluff/fluff_data = GLOB.fluffs_list[fluff]
	if(!fluff_data || !fluff_data.icon_state)
		return

	var/fluff_render_color = fluff_color
	switch(fluff_data.color_src)
		if(ACCESSORY_COLOR_BODY)
			fluff_render_color = body_color
		if(ACCESSORY_COLOR_HAIR)
			fluff_render_color = get_render_hair_color()

	var/list/fluff_layers = list()
	for(var/render_layer in fluff_data.render_layers)
		var/draw_layer = accessory_fluff_draw_layer(fluff_data, render_layer)
		add_accessory_layer(fluff_layers, fluff_data, render_layer, null, fluff_render_color, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(fluff_emissive, 1))
		if(fluff_data.color_count >= 2)
			add_accessory_layer(fluff_layers, fluff_data, render_layer, "secondary", fluff_color_secondary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(fluff_emissive, 2))
		if(fluff_data.color_count >= 3)
			add_accessory_layer(fluff_layers, fluff_data, render_layer, "tertiary", fluff_color_tertiary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(fluff_emissive, 3))

	if(!length(fluff_layers))
		return

	overlays_standing[ACCESSORY_FLUFF_LAYER] = fluff_layers
	apply_overlay(ACCESSORY_FLUFF_LAYER)
	*/

/mob/living/carbon/human/proc/update_synth_antenna()
	remove_overlay(ACCESSORY_ANTENNA_LAYER)

	if(!synth_antenna || synth_antenna == "None")
		return

	var/datum/sprite_accessory/synth_antenna/antenna_data = GLOB.synth_antennas_list[synth_antenna]
	if(!antenna_data || !antenna_data.icon_state)
		return

	var/antenna_render_color = synth_antenna_color
	switch(antenna_data.color_src)
		if(ACCESSORY_COLOR_BODY)
			antenna_render_color = body_color
		if(ACCESSORY_COLOR_HAIR)
			antenna_render_color = get_render_hair_color()

	var/list/antenna_layers = list()
	for(var/render_layer in antenna_data.render_layers)
		var/draw_layer = accessory_antenna_draw_layer(render_layer, dir)
		add_accessory_layer(antenna_layers, antenna_data, render_layer, null, antenna_render_color, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(synth_antenna_emissive, 1))
		if(antenna_data.color_count >= 2)
			add_accessory_layer(antenna_layers, antenna_data, render_layer, "secondary", synth_antenna_color_secondary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(synth_antenna_emissive, 2))
		if(antenna_data.color_count >= 3)
			add_accessory_layer(antenna_layers, antenna_data, render_layer, "tertiary", synth_antenna_color_tertiary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(synth_antenna_emissive, 3))

	if(!length(antenna_layers))
		return

	overlays_standing[ACCESSORY_ANTENNA_LAYER] = antenna_layers
	apply_overlay(ACCESSORY_ANTENNA_LAYER)

/mob/living/carbon/human/proc/update_tail_and_wings()
	if(dir == NORTH || dir == SOUTH)
		update_wings()
		update_tail()
	else
		update_tail()
		update_wings()

/mob/living/carbon/human/proc/update_ears()
	remove_overlay(ACCESSORY_EARS_LAYER)
	remove_underlay(ACCESSORY_EARS_BEHIND_LAYER)

	if(!ears || ears == "None")
		return

	var/datum/sprite_accessory/ears/ears_data = GLOB.ears_list[ears]
	if(!ears_data || !ears_data.icon_state)
		return

	var/ears_render_color = ears_color
	switch(ears_data.color_src)
		if(ACCESSORY_COLOR_BODY)
			ears_render_color = body_color
		if(ACCESSORY_COLOR_HAIR)
			ears_render_color = get_render_hair_color()

	var/list/front_layers = list()
	var/list/behind_layers = list()
	for(var/render_layer in ears_data.render_layers)
		var/list/target_layers = accessory_uses_underlay(ACCESSORY_KIND_EARS, ears_data, render_layer, dir) ? behind_layers : front_layers
		var/draw_layer = accessory_ears_draw_layer(render_layer, dir)
		add_accessory_layer(target_layers, ears_data, render_layer, null, ears_render_color, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(ears_emissive, 1))
		if(ears_data.color_count >= 2)
			add_accessory_layer(target_layers, ears_data, render_layer, "secondary", ears_color_secondary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(ears_emissive, 2))
		if(ears_data.color_count >= 3)
			add_accessory_layer(target_layers, ears_data, render_layer, "tertiary", ears_color_tertiary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(ears_emissive, 3))
		if(ears_data.has_inner)
			add_accessory_layer(target_layers, ears_data, render_layer, null, ears_color_secondary, "m_earsinner", draw_layer = draw_layer)

	if(length(front_layers))
		overlays_standing[ACCESSORY_EARS_LAYER] = front_layers
		apply_overlay(ACCESSORY_EARS_LAYER)
	if(length(behind_layers))
		underlays_standing[ACCESSORY_EARS_BEHIND_LAYER] = behind_layers
		apply_underlay(ACCESSORY_EARS_BEHIND_LAYER)

/mob/living/carbon/human/proc/update_wings()
	remove_overlay(ACCESSORY_WINGS_LAYER)
	remove_underlay(ACCESSORY_WINGS_BEHIND_LAYER)

	if(!wings || wings == "None")
		return

	var/datum/sprite_accessory/wings/wings_data = GLOB.wings_list[wings]
	if(!wings_data || !wings_data.icon_state)
		return

	var/wings_render_color = wings_color
	switch(wings_data.color_src)
		if(ACCESSORY_COLOR_BODY)
			wings_render_color = body_color
		if(ACCESSORY_COLOR_HAIR)
			wings_render_color = get_render_hair_color()

	var/list/front_layers = list()
	var/list/behind_layers = list()
	for(var/render_layer in wings_data.render_layers)
		var/list/target_layers = accessory_uses_underlay(ACCESSORY_KIND_WINGS, wings_data, render_layer, dir) ? behind_layers : front_layers
		var/draw_layer = accessory_wing_draw_layer(wings_data, render_layer, dir)
		add_accessory_layer(target_layers, wings_data, render_layer, null, wings_render_color, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(wings_emissive, 1))
		if(wings_data.color_count >= 2)
			add_accessory_layer(target_layers, wings_data, render_layer, "secondary", wings_color_secondary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(wings_emissive, 2))
		if(wings_data.color_count >= 3)
			add_accessory_layer(target_layers, wings_data, render_layer, "tertiary", wings_color_tertiary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(wings_emissive, 3))

	if(wings_data.top_icon_state)
		var/top_draw_layer = accessory_wing_draw_layer(wings_data, "FRONT", dir)
		add_accessory_layer(front_layers, wings_data, "FRONT", null, wings_render_color, null, wings_data.top_icon_state, top_draw_layer, accessory_emissive_enabled(wings_emissive, 1))
		if(wings_data.color_count >= 2)
			add_accessory_layer(front_layers, wings_data, "FRONT", "secondary", wings_color_secondary, null, wings_data.top_icon_state, top_draw_layer, accessory_emissive_enabled(wings_emissive, 2))
		if(wings_data.color_count >= 3)
			add_accessory_layer(front_layers, wings_data, "FRONT", "tertiary", wings_color_tertiary, null, wings_data.top_icon_state, top_draw_layer, accessory_emissive_enabled(wings_emissive, 3))

	if(length(front_layers))
		overlays_standing[ACCESSORY_WINGS_LAYER] = front_layers
		apply_overlay(ACCESSORY_WINGS_LAYER)
	if(length(behind_layers))
		underlays_standing[ACCESSORY_WINGS_BEHIND_LAYER] = behind_layers
		apply_underlay(ACCESSORY_WINGS_BEHIND_LAYER)

/mob/living/carbon/human/proc/update_snout()
	remove_overlay(SNOUT_LAYER)

	if(!snout || snout == "None")
		return

	var/datum/sprite_accessory/snout/snout_data = GLOB.snouts_list[snout]
	if(!snout_data || !snout_data.icon_state)
		return

	var/snout_render_color = snout_color
	switch(snout_data.color_src)
		if(ACCESSORY_COLOR_BODY)
			snout_render_color = body_color
		if(ACCESSORY_COLOR_HAIR)
			snout_render_color = get_render_hair_color()

	var/list/snout_layers = list()
	for(var/render_layer in snout_data.render_layers)
		var/draw_layer = accessory_snout_draw_layer(snout_data, render_layer)
		add_accessory_layer(snout_layers, snout_data, render_layer, null, snout_render_color, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(snout_emissive, 1))
		if(snout_data.color_count >= 2)
			add_accessory_layer(snout_layers, snout_data, render_layer, "secondary", snout_color_secondary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(snout_emissive, 2))
		if(snout_data.color_count >= 3)
			add_accessory_layer(snout_layers, snout_data, render_layer, "tertiary", snout_color_tertiary, draw_layer = draw_layer, emissive_enabled = accessory_emissive_enabled(snout_emissive, 3))

	if(snout_data.restore_body_eyes)
		var/eye_icon_state = get_eye_icon_state()
		if(eye_icon_state && eye_icon_state != "blank_eyes")
			var/icon/restored_eye_icon = new/icon('icons/mob/human_face.dmi', eye_icon_state)
			restored_eye_icon.Blend(rgb(r_eyes, g_eyes, b_eyes), ICON_ADD)
			var/image/restored_eyes = image(icon = restored_eye_icon)
			restored_eyes.layer = ACCESSORY_FACE_TOP_LAYER
			snout_layers += restored_eyes
			if(eye_emissive && ntf_should_render_emissives())
				var/mutable_appearance/restored_eye_glow = ntf_emissive_appearance_copy(restored_eyes, src)
				if(restored_eye_glow)
					snout_layers += restored_eye_glow

	if(!length(snout_layers))
		return

	overlays_standing[SNOUT_LAYER] = snout_layers
	apply_overlay(SNOUT_LAYER)

/mob/living/carbon/human/proc/add_accessory_layer(list/accessory_layers, datum/sprite_accessory/accessory_data, render_layer, color_layer, render_color, icon_prefix_override, icon_state_override, draw_layer, emissive_enabled = FALSE)
	var/accessory_icon_state = icon_state_override || accessory_data.icon_state
	var/accessory_icon_prefix = icon_prefix_override || accessory_data:icon_prefix
	var/prefixed_state = accessory_icon_prefix ? "[accessory_icon_prefix]_[accessory_icon_state]_[render_layer]" : null
	var/direct_layer_state = "[accessory_icon_state]_[render_layer]"
	var/direct_state = "[accessory_icon_state]"
	var/icon_state = null
	var/list/icon_state_candidates = list()

	if(color_layer)
		if(prefixed_state)
			icon_state_candidates += "[prefixed_state]_[color_layer]"
		icon_state_candidates += "[direct_layer_state]_[color_layer]"
		icon_state_candidates += "[direct_state]_[color_layer]"
	else
		if(prefixed_state)
			icon_state_candidates += "[prefixed_state]_primary"
			icon_state_candidates += prefixed_state
		icon_state_candidates += "[direct_layer_state]_primary"
		icon_state_candidates += direct_layer_state
		icon_state_candidates += "[direct_state]_primary"
		icon_state_candidates += direct_state

	for(var/candidate_state in icon_state_candidates)
		if(candidate_state && icon_exists(accessory_data.icon, candidate_state))
			icon_state = candidate_state
			break

	if(!icon_state)
		return

	var/image/accessory_image = image(accessory_data.icon, icon_state = icon_state)
	if(!isnull(draw_layer))
		accessory_image.layer = draw_layer
	accessory_image.color = render_color ? sanitize_character_recolor(render_color) : null
	if(accessory_data.center)
		center_image(accessory_image, accessory_data.dimension_x, accessory_data.dimension_y)
	if(istype(accessory_data, /datum/sprite_accessory/fluff))
		var/datum/sprite_accessory/fluff/fluff_data = accessory_data
		accessory_image.pixel_w += fluff_data.pixel_x_offset
		accessory_image.pixel_z += fluff_data.pixel_y_offset
	accessory_layers += accessory_image
	if(emissive_enabled)
		var/mutable_appearance/emissive_accessory = ntf_emissive_appearance_copy(accessory_image, src)
		if(emissive_accessory)
			accessory_layers += emissive_accessory

/mob/living/carbon/human/proc/update_tail()
	remove_overlay(LIZARD_TAIL_LAYER)
	remove_underlay(LIZARD_TAIL_BEHIND_LAYER)

	if(!tail || tail == "None")
		return

	var/tail_name = tail_wagging ? tail_wagging_name(tail) : tail
	if(!tail_name)
		tail_name = tail

	var/datum/sprite_accessory/lizard_tail/tail_data = GLOB.lizard_tails_list[tail_name]
	if(!tail_data || !tail_data.icon_state)
		return

	var/tail_icon_prefix = tail_data.icon_prefix
	if(tail_wagging && tail_name == tail)
		tail_icon_prefix = tail_wagging_prefix(tail_data)
		if(!tail_icon_prefix)
			return

	var/tail_render_color = tail_color

	switch(tail_data.color_src)
		if(ACCESSORY_COLOR_BODY)
			tail_render_color = body_color
		if(ACCESSORY_COLOR_TAIL)
			tail_render_color = tail_color
		if(ACCESSORY_COLOR_HAIR)
			tail_render_color = get_render_hair_color()

	var/front_state
	var/behind_state

	if(tail_data.uses_color_suffixes)
		front_state = "[tail_icon_prefix]_[tail_data.icon_state]_FRONT_primary"
		behind_state = "[tail_icon_prefix]_[tail_data.icon_state]_BEHIND_primary"
	else
		front_state = "[tail_icon_prefix]_[tail_data.icon_state]_FRONT"
		behind_state = "[tail_icon_prefix]_[tail_data.icon_state]_BEHIND"

	var/list/front_layers = list()
	var/list/behind_layers = list()

	if(tail_data.uses_color_suffixes)
		if(icon_exists(tail_data.icon, front_state))
			var/image/front_primary = image(tail_data.icon, icon_state = front_state)
			front_primary.color = sanitize_character_recolor(tail_render_color)
			add_tail_layer(front_layers, front_primary, 1)
		else
			var/unsuffixed_front_state = "[tail_icon_prefix]_[tail_data.icon_state]_FRONT"
			if(icon_exists(tail_data.icon, unsuffixed_front_state))
				var/image/front_primary = image(tail_data.icon, icon_state = unsuffixed_front_state)
				front_primary.color = sanitize_character_recolor(tail_render_color)
				add_tail_layer(front_layers, front_primary, 1)

		if(icon_exists(tail_data.icon, behind_state))
			var/image/behind_primary = image(tail_data.icon, icon_state = behind_state)
			behind_primary.color = sanitize_character_recolor(tail_render_color)
			add_tail_layer(behind_layers, behind_primary, 1)
		else
			var/unsuffixed_behind_state = "[tail_icon_prefix]_[tail_data.icon_state]_BEHIND"
			if(icon_exists(tail_data.icon, unsuffixed_behind_state))
				var/image/behind_primary = image(tail_data.icon, icon_state = unsuffixed_behind_state)
				behind_primary.color = sanitize_character_recolor(tail_render_color)
				add_tail_layer(behind_layers, behind_primary, 1)
	else
		if(icon_exists(tail_data.icon, front_state))
			var/image/front_image = image(tail_data.icon, icon_state = front_state)
			front_image.color = sanitize_character_recolor(tail_render_color)
			add_tail_layer(front_layers, front_image, 1)
		else
			var/suffixed_front_state = "[tail_icon_prefix]_[tail_data.icon_state]_FRONT_primary"
			if(icon_exists(tail_data.icon, suffixed_front_state))
				var/image/front_image = image(tail_data.icon, icon_state = suffixed_front_state)
				front_image.color = sanitize_character_recolor(tail_render_color)
				add_tail_layer(front_layers, front_image, 1)

		if(icon_exists(tail_data.icon, behind_state))
			var/image/behind_image = image(tail_data.icon, icon_state = behind_state)
			behind_image.color = sanitize_character_recolor(tail_render_color)
			add_tail_layer(behind_layers, behind_image, 1)
		else
			var/suffixed_behind_state = "[tail_icon_prefix]_[tail_data.icon_state]_BEHIND_primary"
			if(icon_exists(tail_data.icon, suffixed_behind_state))
				var/image/behind_image = image(tail_data.icon, icon_state = suffixed_behind_state)
				behind_image.color = sanitize_character_recolor(tail_render_color)
				add_tail_layer(behind_layers, behind_image, 1)

	if(tail_data.color_count >= 2)
		var/secondary_front_state = "[tail_icon_prefix]_[tail_data.icon_state]_FRONT_secondary"
		if(icon_exists(tail_data.icon, secondary_front_state))
			var/image/front_secondary = image(tail_data.icon, icon_state = secondary_front_state)
			front_secondary.color = sanitize_character_recolor(tail_color_secondary)
			add_tail_layer(front_layers, front_secondary, 2)

		var/secondary_behind_state = "[tail_icon_prefix]_[tail_data.icon_state]_BEHIND_secondary"
		if(icon_exists(tail_data.icon, secondary_behind_state))
			var/image/behind_secondary = image(tail_data.icon, icon_state = secondary_behind_state)
			behind_secondary.color = sanitize_character_recolor(tail_color_secondary)
			add_tail_layer(behind_layers, behind_secondary, 2)

	if(tail_data.color_count >= 3)
		var/tertiary_front_state = "[tail_icon_prefix]_[tail_data.icon_state]_FRONT_tertiary"
		if(icon_exists(tail_data.icon, tertiary_front_state))
			var/image/front_tertiary = image(tail_data.icon, icon_state = tertiary_front_state)
			front_tertiary.color = sanitize_character_recolor(tail_color_tertiary)
			add_tail_layer(front_layers, front_tertiary, 3)

		var/tertiary_behind_state = "[tail_icon_prefix]_[tail_data.icon_state]_BEHIND_tertiary"
		if(icon_exists(tail_data.icon, tertiary_behind_state))
			var/image/behind_tertiary = image(tail_data.icon, icon_state = tertiary_behind_state)
			behind_tertiary.color = sanitize_character_recolor(tail_color_tertiary)
			add_tail_layer(behind_layers, behind_tertiary, 3)

	if(dir == NORTH)
		behind_layers += front_layers
		apply_accessory_image_layer(behind_layers, ACCESSORY_TAIL_NORTH_LAYER)
		overlays_standing[LIZARD_TAIL_LAYER] = behind_layers
	else
		apply_accessory_image_layer(front_layers, ACCESSORY_BODY_BEHIND_LAYER)
		apply_accessory_image_layer(behind_layers, ACCESSORY_BODY_BEHIND_LAYER)
		behind_layers += front_layers

	if(dir != NORTH && length(behind_layers))
		underlays_standing[LIZARD_TAIL_BEHIND_LAYER] = behind_layers
	if(dir == NORTH)
		apply_overlay(LIZARD_TAIL_LAYER)
	if(dir != NORTH && length(behind_layers))
		apply_underlay(LIZARD_TAIL_BEHIND_LAYER)

/mob/living/carbon/human/setDir(newdir)
	var/old_dir = dir
	. = ..()
	if(old_dir == dir)
		return
	if(ISDIAGONALDIR(old_dir) || ISDIAGONALDIR(dir))
		queue_directional_overlay_update()
	else
		update_directional_overlays()

/mob/living/carbon/human/proc/queue_directional_overlay_update()
	addtimer(CALLBACK(src, PROC_REF(update_directional_overlays)), 1, TIMER_UNIQUE | TIMER_OVERRIDE)

/mob/living/carbon/human/proc/update_directional_overlays()
	if(ISDIAGONALDIR(dir))
		return
	if(last_directional_overlay_dir == dir)
		return
	last_directional_overlay_dir = dir
	update_accessories()
	update_genitals(FALSE)
	update_inv_w_uniform(FALSE)
	update_inv_gloves(FALSE)
	update_inv_belt()
	update_inv_shoes(FALSE)
	update_inv_wear_suit(FALSE)
	update_inv_socks()
	update_inv_underwear()
	update_inv_undershirt()
	update_inv_bra()
	update_body_marking_emissives()
