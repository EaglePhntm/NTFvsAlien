GLOBAL_LIST_EMPTY(human_genitals_cache)

#define GENITAL_REAR_NORTH_LAYER -(BODYPARTS_LAYER - 1.5)
#define GENITAL_LAYER_BIAS 1

#define GENITAL_POSITION_FRONT "front"
#define GENITAL_POSITION_REAR "rear"

#define GENITAL_VISIBILITY_TOP "top"
#define GENITAL_VISIBILITY_BOTTOM "bottom"
#define GENITAL_VISIBILITY_REAR "rear"

/datum/genital_visual
	var/style_var
	var/size_var
	var/list/color_vars = list()
	var/emissive_var
	var/icon_file
	var/icon_prefix
	var/list/render_layers = list(BODY_OVERLAY_LAYER_FRONT)
	var/position = GENITAL_POSITION_FRONT
	var/visibility = GENITAL_VISIBILITY_BOTTOM
	var/layer_offset = 0
	var/min_size = 0
	var/max_size = 0
	var/default_size = 0
	var/needs_size = FALSE
	var/old_suffix = FALSE
	var/static_suffix
	var/secondary_color = null
	var/required_var
	var/storage_var
	var/state_var
	var/plain_sprite = FALSE
	var/hide_underwear = FALSE
	var/hide_bra = FALSE

/datum/genital_visual/ass
	style_var = "ass"
	size_var = "ass_size"
	color_vars = list("ass_color")
	emissive_var = "ass_emissive"
	icon_file = 'ntf_modular/icons/mob/human/genitals/butt.dmi'
	icon_prefix = "m_butt"
	render_layers = list(BODY_OVERLAY_LAYER_ADJ, BODY_OVERLAY_LAYER_FRONT)
	position = GENITAL_POSITION_REAR
	visibility = GENITAL_VISIBILITY_REAR
	layer_offset = 0.8
	min_size = 1
	max_size = 8
	default_size = 1
	old_suffix = TRUE
	hide_underwear = TRUE

/datum/genital_visual/breasts
	style_var = "boobs"
	size_var = "boobs_size"
	color_vars = list("boobs_color", "boobs_color_secondary")
	emissive_var = "boobs_emissive"
	icon_file = 'ntf_modular/icons/mob/human/genitals/breasts_onmob.dmi'
	icon_prefix = "m_breasts"
	render_layers = list(BODY_OVERLAY_LAYER_BEHIND, BODY_OVERLAY_LAYER_FRONT)
	visibility = GENITAL_VISIBILITY_TOP
	layer_offset = 0.1
	max_size = 19
	default_size = 3
	old_suffix = TRUE
	plain_sprite = TRUE
	secondary_color = "#d98fa3"
	hide_bra = TRUE

/datum/genital_visual/penis
	style_var = "cock"
	size_var = "cock_size"
	color_vars = list("cock_color", "cock_color_secondary")
	emissive_var = "cock_emissive"
	storage_var = "cock_storage"
	state_var = "cock_state"
	icon_file = 'ntf_modular/icons/mob/human/genitals/penis_onmob.dmi'
	icon_prefix = "m_penis"
	layer_offset = 0.3
	min_size = 1
	max_size = 7
	default_size = 1
	static_suffix = "0"
	plain_sprite = TRUE
	hide_underwear = TRUE

/datum/genital_visual/testicles
	style_var = "testicles"
	size_var = "testicles_size"
	color_vars = list("testicles_color", "testicles_color_secondary")
	emissive_var = "testicles_emissive"
	icon_file = 'ntf_modular/icons/mob/human/genitals/testicles_onmob.dmi'
	icon_prefix = "m_testicles"
	render_layers = list(BODY_OVERLAY_LAYER_BEHIND, BODY_OVERLAY_LAYER_ADJ)
	layer_offset = 0.5
	max_size = 8
	default_size = 1
	old_suffix = TRUE
	plain_sprite = TRUE
	secondary_color = "#d98fa3"
	hide_underwear = TRUE

/datum/genital_visual/vagina
	style_var = "vagina"
	color_vars = list("vagina_color")
	emissive_var = "vagina_emissive"
	icon_file = 'ntf_modular/icons/mob/human/genitals/vagina_onmob.dmi'
	icon_prefix = "m_vagina"
	layer_offset = 0.6
	static_suffix = "0"
	hide_underwear = TRUE

/datum/genital_visual/belly
	style_var = "belly"
	size_var = "belly_size"
	color_vars = list("belly_color")
	emissive_var = "belly_emissive"
	icon_file = 'ntf_modular/icons/mob/human/genitals/belly.dmi'
	icon_prefix = "m_belly"
	render_layers = list(BODY_OVERLAY_LAYER_BEHIND, BODY_OVERLAY_LAYER_FRONT)
	visibility = GENITAL_VISIBILITY_TOP
	layer_offset = 0.2
	max_size = 10
	needs_size = TRUE
	old_suffix = TRUE

/proc/genital_visuals()
	var/static/list/defs
	if(!defs)
		defs = list(
			new /datum/genital_visual/breasts,
			new /datum/genital_visual/belly,
			new /datum/genital_visual/ass,
			new /datum/genital_visual/vagina,
			new /datum/genital_visual/testicles,
			new /datum/genital_visual/penis
		)
	return defs

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

/proc/genital_draw_layer(datum/genital_visual/def, render_layer, direction)
	var/base_layer
	if(def.position == GENITAL_POSITION_REAR)
		if(direction == NORTH)
			base_layer = GENITAL_REAR_NORTH_LAYER
		else
			base_layer = visual_overlay_draw_layer(render_layer)
	else if(direction == NORTH)
		base_layer = visual_overlay_draw_layer(BODY_OVERLAY_LAYER_BEHIND)
	else
		base_layer = visual_overlay_draw_layer(render_layer)
	return base_layer + GENITAL_LAYER_BIAS - def.layer_offset

/proc/genital_emissive_visible(position, direction)
	if(position == GENITAL_POSITION_FRONT && direction == NORTH)
		return FALSE
	if(position == GENITAL_POSITION_REAR && direction == SOUTH)
		return FALSE
	return TRUE

/proc/genital_clothing_allows(datum/genital_visual/def, obj/item/clothing/uniform, obj/item/clothing/suit)
	switch(def.visibility)
		if(GENITAL_VISIBILITY_TOP)
			return (!uniform || uniform.shows_top_genital) && (!suit || suit.shows_top_genital)
		if(GENITAL_VISIBILITY_REAR)
			return (!uniform || uniform.shows_butt) && (!suit || suit.shows_butt)
	return (!uniform || uniform.shows_bottom_genital) && (!suit || suit.shows_bottom_genital)

/proc/genital_underwear_allows(datum/genital_visual/def, mob/living/carbon/human/owner)
	if(def.hide_bra && owner.vars.Find("bra") && owner.vars["bra"])
		return FALSE
	if(def.hide_underwear && owner.vars.Find("w_underwear") && owner.vars["w_underwear"])
		return FALSE
	return TRUE

/proc/genital_static_suffix(datum/genital_visual/def, mob/living/carbon/human/owner)
	if(def.state_var && owner?.vars[def.state_var] == COCK_STATE_ERECT)
		return "1"
	return def.static_suffix

/proc/genital_storage_icon_state(datum/genital_visual/def, mob/living/carbon/human/owner, render_layer)
	if(!def.storage_var || !def.state_var || !owner)
		return null
	var/storage = owner.vars[def.storage_var]
	if(!storage)
		return null
	var/storage_suffix
	switch(owner.vars[def.state_var])
		if(COCK_STATE_STORED)
			storage_suffix = 0
		if(COCK_STATE_PARTIAL)
			storage_suffix = 1
		else
			return null
	return list(def.icon_prefix, storage, "[storage_suffix]", render_layer).Join("_")

/proc/genital_icon_state(datum/genital_visual/def, style, size, render_layer, mob/living/carbon/human/owner)
	var/storage_state = genital_storage_icon_state(def, owner, render_layer)
	if(storage_state)
		return storage_state
	var/render_style = (def.old_suffix || def.plain_sprite) ? genital_state_style(style) : style
	var/style_suffix = (def.old_suffix && !def.plain_sprite) ? genital_state_old_suffix(style) : ""
	var/list/parts = list(def.icon_prefix, render_style)
	if(def.size_var)
		parts += "[size][style_suffix]"
	if(def.static_suffix)
		parts += genital_static_suffix(def, owner)
	parts += render_layer
	return parts.Join("_")

/mob/living/carbon/human/proc/add_genital_visual(list/genital_layers, datum/genital_visual/def, genital_body_color, obj/item/clothing/uniform, obj/item/clothing/suit)
	if(!def || !genital_clothing_allows(def, uniform, suit) || !genital_underwear_allows(def, src))
		return
	if(def.required_var && (!vars.Find(def.required_var) || !vars[def.required_var]))
		return
	if(!vars.Find(def.style_var))
		return
	var/style = vars[def.style_var]
	if(!style)
		return

	var/render_size = def.default_size
	if(def.size_var)
		if(!vars.Find(def.size_var))
			return
		var/raw_size = vars[def.size_var]
		if(def.needs_size && !raw_size)
			return
		render_size = clamp(raw_size || def.default_size, def.min_size, def.max_size)

	var/primary_color = genital_body_color
	var/secondary_color = def.secondary_color
	if(length(def.color_vars))
		var/primary_var = def.color_vars[1]
		if(vars.Find(primary_var) && vars[primary_var])
			primary_color = vars[primary_var]
	if(length(def.color_vars) >= 2)
		var/secondary_var = def.color_vars[2]
		if(vars.Find(secondary_var) && vars[secondary_var])
			secondary_color = vars[secondary_var]

	var/list/emissive_list
	if(def.emissive_var && vars.Find(def.emissive_var))
		emissive_list = vars[def.emissive_var]

	var/emissive_visible = genital_emissive_visible(def.position, dir)
	for(var/render_layer in def.render_layers)
		var/icon_state = genital_icon_state(def, style, render_size, render_layer, src)
		var/draw_layer = genital_draw_layer(def, render_layer, dir)
		add_genital_colored_overlay_if_exists(genital_layers, def.icon_file, icon_state, primary_color, draw_layer, secondary_color, src, emissive_list, emissive_visible)

/mob/living/carbon/human/proc/update_genitals(save_character = TRUE)
	remove_overlay(GENITAL_LAYER)
	if(!species?.has_genital_selection)
		return
	var/list/genilist = list()
	var/genital_body_color = body_color
	if(species?.name == "Moth" && (!body_color || body_color == "#FFFFFF"))
		genital_body_color = species.flesh_color
	var/obj/item/clothing/worn_suit
	if(wear_suit && istype(wear_suit, /obj/item/clothing))
		worn_suit = wear_suit

	for(var/datum/genital_visual/def in genital_visuals())
		add_genital_visual(genilist, def, genital_body_color, w_uniform, worn_suit)

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

#undef GENITAL_REAR_NORTH_LAYER
#undef GENITAL_LAYER_BIAS

#undef GENITAL_POSITION_FRONT
#undef GENITAL_POSITION_REAR

#undef GENITAL_VISIBILITY_TOP
#undef GENITAL_VISIBILITY_BOTTOM
#undef GENITAL_VISIBILITY_REAR
