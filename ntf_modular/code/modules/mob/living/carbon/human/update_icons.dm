GLOBAL_LIST_EMPTY(human_genitals_cache)

#define GENITAL_BODY_FRONT_LAYER -6
#define GENITAL_BODY_ADJ_LAYER -46
#define GENITAL_BODY_BEHIND_LAYER -49
#define GENITAL_REAR_NORTH_LAYER -(BODYPARTS_LAYER - 1.5)

#define BUTT_LAYER_OFFSET 0.8
#define VAGINA_LAYER_OFFSET 0.6
#define TESTICLES_LAYER_OFFSET 0.5
#define PENIS_LAYER_OFFSET 0.3
#define BELLY_LAYER_OFFSET 0.2
#define BREASTS_LAYER_OFFSET 0.1

#define GENITAL_POSITION_FRONT "front"
#define GENITAL_POSITION_REAR "rear"

/proc/genital_overlay(icon_file, icon_state, draw_color, draw_layer)
	var/mutable_appearance/overlay = mutable_appearance(icon_file, icon_state, draw_layer)
	overlay.color = draw_color ? sanitize_character_recolor(draw_color) : null
	return overlay

/proc/cached_genital_overlay(icon_file, icon_state, draw_color, draw_layer)
	var/cache_key = "[icon_file]_[icon_state]_[draw_color]_[draw_layer]"
	if(!GLOB.human_genitals_cache[cache_key])
		GLOB.human_genitals_cache[cache_key] = genital_overlay(icon_file, icon_state, draw_color, draw_layer)
	return GLOB.human_genitals_cache[cache_key]

/proc/genital_state_style(style)
	if(!style)
		return null
	if(findtext(style, "_s") == length(style) - 1)
		return copytext(style, 1, length(style) - 1)
	return style

/proc/genital_state_old_suffix(style)
	if(!style)
		return ""
	if(findtext(style, "_s") == length(style) - 1)
		return "_s"
	return ""

/proc/add_genital_emissive_overlay(list/genital_layers, mutable_appearance/overlay, mob/living/carbon/human/owner, list/emissive_list, color_index, emissive_visible = TRUE)
	if(!emissive_visible || !owner || !owner.ntf_should_render_emissives() || !islist(emissive_list) || !emissive_list[color_index])
		return
	var/mutable_appearance/emissive_overlay = ntf_emissive_appearance_copy(overlay, owner)
	if(emissive_overlay)
		genital_layers += emissive_overlay

/proc/add_genital_overlay_if_exists(list/genital_layers, icon_file, icon_state, draw_color, draw_layer, mob/living/carbon/human/owner = null, list/emissive_list = null, color_index = 1, emissive_visible = TRUE)
	if(!icon_exists(icon_file, icon_state))
		return
	var/mutable_appearance/overlay = cached_genital_overlay(icon_file, icon_state, draw_color, draw_layer)
	genital_layers += overlay
	add_genital_emissive_overlay(genital_layers, overlay, owner, emissive_list, color_index, emissive_visible)

/proc/add_genital_colored_overlay_if_exists(list/genital_layers, icon_file, icon_state, draw_color, draw_layer, secondary_color = null, mob/living/carbon/human/owner = null, list/emissive_list = null, emissive_visible = TRUE)
	var/primary_state = "[icon_state]_primary"
	if(icon_exists(icon_file, primary_state))
		var/mutable_appearance/primary_overlay = cached_genital_overlay(icon_file, primary_state, draw_color, draw_layer)
		genital_layers += primary_overlay
		add_genital_emissive_overlay(genital_layers, primary_overlay, owner, emissive_list, 1, emissive_visible)
		var/secondary_state = "[icon_state]_secondary"
		if(secondary_color && icon_exists(icon_file, secondary_state))
			var/mutable_appearance/secondary_overlay = cached_genital_overlay(icon_file, secondary_state, secondary_color, draw_layer)
			genital_layers += secondary_overlay
			add_genital_emissive_overlay(genital_layers, secondary_overlay, owner, emissive_list, 2, emissive_visible)
		return

	add_genital_overlay_if_exists(genital_layers, icon_file, icon_state, draw_color, draw_layer, owner, emissive_list, 1, emissive_visible)

/proc/genital_draw_layer(position, render_layer, direction)
	if(position == GENITAL_POSITION_REAR)
		if(direction == NORTH)
			return GENITAL_REAR_NORTH_LAYER
		return GENITAL_BODY_BEHIND_LAYER

	if(direction == NORTH)
		return GENITAL_BODY_BEHIND_LAYER
	if(render_layer == "ADJ")
		return GENITAL_BODY_FRONT_LAYER
	return GENITAL_BODY_FRONT_LAYER

/proc/genital_emissive_visible(position, direction)
	if(position == GENITAL_POSITION_FRONT && direction == NORTH)
		return FALSE
	if(position == GENITAL_POSITION_REAR && direction == SOUTH)
		return FALSE
	return TRUE

/mob/living/carbon/human/proc/update_genitals(save_character = TRUE)
	remove_overlay(GENITAL_LAYER)
	if(!species?.has_genital_selection)
		return
	var/list/genilist = list()
	var/genital_body_color = body_color
	if(species?.name == "Moth" && (!body_color || body_color == "#FFFFFF"))
		genital_body_color = species.flesh_color
	var/front_emissives_visible = genital_emissive_visible(GENITAL_POSITION_FRONT, dir)
	var/rear_emissives_visible = genital_emissive_visible(GENITAL_POSITION_REAR, dir)

	var/obj/item/clothing/worn_suit
	if(wear_suit && istype(wear_suit, /obj/item/clothing))
		worn_suit = wear_suit

	if((!w_uniform || w_uniform.shows_top_genital) && (!worn_suit || worn_suit.shows_top_genital))
		if(boobs)
			var/boob_style = genital_state_style(boobs)
			var/boob_suffix = genital_state_old_suffix(boobs)
			var/boob_size = clamp(boobs_size, 0, 19)
			var/boob_primary_color = boobs_color || genital_body_color
			var/boob_secondary_color = boobs_color_secondary || "#d98fa3"
			add_genital_colored_overlay_if_exists(genilist, 'ntf_modular/icons/mob/human/genitals/breasts_onmob.dmi', "m_breasts_[boob_style]_[boob_size][boob_suffix]_BEHIND", boob_primary_color, genital_draw_layer(GENITAL_POSITION_FRONT, "BEHIND", dir) - BREASTS_LAYER_OFFSET, boob_secondary_color, src, boobs_emissive, front_emissives_visible)

			add_genital_colored_overlay_if_exists(genilist, 'ntf_modular/icons/mob/human/genitals/breasts_onmob.dmi', "m_breasts_[boob_style]_[boob_size][boob_suffix]_FRONT", boob_primary_color, genital_draw_layer(GENITAL_POSITION_FRONT, "FRONT", dir) - BREASTS_LAYER_OFFSET, boob_secondary_color, src, boobs_emissive, front_emissives_visible)

		if(belly && belly_size)
			var/belly_style = genital_state_style(belly)
			var/belly_suffix = genital_state_old_suffix(belly)
			var/clamped_belly_size = clamp(belly_size, 1, 10)
			var/belly_render_color = belly_color || genital_body_color
			add_genital_colored_overlay_if_exists(genilist, 'ntf_modular/icons/mob/human/genitals/belly.dmi', "m_belly_[belly_style]_[clamped_belly_size][belly_suffix]_BEHIND", belly_render_color, genital_draw_layer(GENITAL_POSITION_FRONT, "BEHIND", dir) - BELLY_LAYER_OFFSET, owner = src, emissive_list = belly_emissive, emissive_visible = front_emissives_visible)
			add_genital_colored_overlay_if_exists(genilist, 'ntf_modular/icons/mob/human/genitals/belly.dmi', "m_belly_[belly_style]_[clamped_belly_size][belly_suffix]_FRONT", belly_render_color, genital_draw_layer(GENITAL_POSITION_FRONT, "FRONT", dir) - BELLY_LAYER_OFFSET, owner = src, emissive_list = belly_emissive, emissive_visible = front_emissives_visible)

	if((!w_uniform || w_uniform.shows_butt) && (!worn_suit || worn_suit.shows_butt))
		if(ass)
			var/ass_style = genital_state_style(ass)
			var/ass_suffix = genital_state_old_suffix(ass)
			var/clamped_ass_size = clamp(ass_size, 1, 8)
			var/ass_render_color = ass_color || genital_body_color
			add_genital_colored_overlay_if_exists(genilist, 'ntf_modular/icons/mob/human/genitals/butt.dmi', "m_butt_[ass_style]_[clamped_ass_size][ass_suffix]_ADJ", ass_render_color, genital_draw_layer(GENITAL_POSITION_REAR, "ADJ", dir) - BUTT_LAYER_OFFSET, owner = src, emissive_list = ass_emissive, emissive_visible = rear_emissives_visible)
			add_genital_colored_overlay_if_exists(genilist, 'ntf_modular/icons/mob/human/genitals/butt.dmi', "m_butt_[ass_style]_[clamped_ass_size][ass_suffix]_FRONT", ass_render_color, genital_draw_layer(GENITAL_POSITION_REAR, "FRONT", dir) - BUTT_LAYER_OFFSET, owner = src, emissive_list = ass_emissive, emissive_visible = rear_emissives_visible)
	if((!w_uniform || w_uniform.shows_bottom_genital) && (!worn_suit || worn_suit.shows_bottom_genital))
		if(vagina)
			var/vaginaicon = "m_vagina_[vagina]_0_FRONT"
			add_genital_colored_overlay_if_exists(genilist, 'ntf_modular/icons/mob/human/genitals/vagina_onmob.dmi', vaginaicon, vagina_color || genital_body_color, genital_draw_layer(GENITAL_POSITION_FRONT, "FRONT", dir) - VAGINA_LAYER_OFFSET, owner = src, emissive_list = vagina_emissive, emissive_visible = front_emissives_visible)
		if(cock && testicles)
			var/testicles_style = genital_state_style(testicles)
			var/testicles_suffix = genital_state_old_suffix(testicles)
			var/clamped_testicles_size = clamp(testicles_size, 0, 8)
			var/testicles_primary_color = testicles_color || genital_body_color
			var/testicles_secondary_color = testicles_color_secondary || "#d98fa3"
			add_genital_colored_overlay_if_exists(genilist, 'ntf_modular/icons/mob/human/genitals/testicles_onmob.dmi', "m_testicles_[testicles_style]_[clamped_testicles_size][testicles_suffix]_BEHIND", testicles_primary_color, genital_draw_layer(GENITAL_POSITION_FRONT, "BEHIND", dir) - TESTICLES_LAYER_OFFSET, testicles_secondary_color, src, testicles_emissive, front_emissives_visible)
			add_genital_colored_overlay_if_exists(genilist, 'ntf_modular/icons/mob/human/genitals/testicles_onmob.dmi', "m_testicles_[testicles_style]_[clamped_testicles_size][testicles_suffix]_ADJ", testicles_primary_color, genital_draw_layer(GENITAL_POSITION_FRONT, "ADJ", dir) - TESTICLES_LAYER_OFFSET, testicles_secondary_color, src, testicles_emissive, front_emissives_visible)
		if(cock)
			var/clamped_cock_size = clamp(cock_size, 1, 7)
			var/cockicon = "m_penis_[cock]_[clamped_cock_size]_0_FRONT"
			add_genital_colored_overlay_if_exists(genilist, 'ntf_modular/icons/mob/human/genitals/penis_onmob.dmi', cockicon, cock_color || genital_body_color, genital_draw_layer(GENITAL_POSITION_FRONT, "FRONT", dir) - PENIS_LAYER_OFFSET, owner = src, emissive_list = cock_emissive, emissive_visible = front_emissives_visible)

	overlays_standing[GENITAL_LAYER] = genilist
	apply_overlay(GENITAL_LAYER)
	if(save_character)
		client?.prefs.save_character()

/mob/living/carbon/human/update_inv_w_uniform(update_dependent_overlays = TRUE)
	. = ..()
	if(update_dependent_overlays)
		update_genitals()
		update_body_marking_emissives()

/mob/living/carbon/human/update_inv_wear_suit(update_dependent_overlays = TRUE)
	. = ..()
	if(update_dependent_overlays)
		update_genitals()
		update_body_marking_emissives()

/mob/living/carbon/human/update_inv_gloves(update_dependent_overlays = TRUE)
	. = ..()
	if(update_dependent_overlays)
		update_body_marking_emissives()

/mob/living/carbon/human/update_inv_shoes(update_dependent_overlays = TRUE)
	. = ..()
	if(update_dependent_overlays)
		update_body_marking_emissives()

/mob/living/carbon/human/update_inv_head()
	. = ..()
	update_body_marking_emissives()

/mob/living/carbon/human/update_inv_wear_mask()
	. = ..()
	update_body_marking_emissives()

/mob/living/carbon/human/update_body(update_icons, force_cache_update)
	. = ..()
	update_genitals()
	update_body_marking_emissives()

#undef GENITAL_BODY_FRONT_LAYER
#undef GENITAL_BODY_ADJ_LAYER
#undef GENITAL_BODY_BEHIND_LAYER
#undef GENITAL_REAR_NORTH_LAYER

#undef BUTT_LAYER_OFFSET
#undef VAGINA_LAYER_OFFSET
#undef TESTICLES_LAYER_OFFSET
#undef PENIS_LAYER_OFFSET
#undef BELLY_LAYER_OFFSET
#undef BREASTS_LAYER_OFFSET

#undef GENITAL_POSITION_FRONT
#undef GENITAL_POSITION_REAR
