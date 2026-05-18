/// Character creator modernization helpers.
/// These procs keep the newer cosmetic accessory controls in one place while the
/// older preference UI continues to host the rest of the character setup.

/proc/character_creator_hidden_tail_options()
	return list(
		"Wagging Smooth",
		"Wagging Short",
		"Wagging Spikes",
		"Wagging Dark Tiger",
		"Wagging Light Tiger",
	)

/proc/character_creator_tail_options()
	return GLOB.lizard_tails_list - character_creator_hidden_tail_options()

/proc/character_creator_accessory_list(accessory)
	switch(accessory)
		if("tail")
			return character_creator_tail_options()
		if("snout")
			return GLOB.snouts_list
		if("ears")
			return GLOB.ears_list
		if("horns")
			return GLOB.horns_list
		if("wings")
			return GLOB.wings_list
		if("synth_antenna")
			return GLOB.synth_antennas_list
		if("fluff")
			return GLOB.fluffs_list
	return list()

/datum/preferences/proc/character_creator_part_definition(id)
	switch(id)
		if("digitigrade_legs")
			return list("label" = "Legs", "pref" = "digitigrade_legs", "values" = character_creator_name_options(digitigrade_leg_options()), "fallback" = "Normal")
		if("moth_wings")
			return list("label" = "Moth wings", "pref" = "moth_wings", "values" = character_creator_name_options(GLOB.moth_wings_list), "fallback" = "Plain")
		if("tail")
			return list("label" = "Tail", "pref" = "tail", "values" = character_creator_name_options(character_creator_tail_options()), "fallback" = "None", "colors" = 3)
		if("snout")
			return list("label" = "Snout", "pref" = "snout", "values" = character_creator_name_options(GLOB.snouts_list), "fallback" = "None", "colors" = 3)
		if("ears")
			return list("label" = "Ears", "pref" = "ears", "values" = character_creator_name_options(GLOB.ears_list), "fallback" = "None", "colors" = 3)
		if("horns")
			return list("label" = "Horns", "pref" = "horns", "values" = character_creator_name_options(GLOB.horns_list), "fallback" = "None", "colors" = 3)
		if("wings")
			return list("label" = "Wings", "pref" = "wings", "values" = character_creator_name_options(GLOB.wings_list), "fallback" = "None", "colors" = 3)
		if("synth_antenna")
			return list("label" = "Synth antenna", "pref" = "synth_antenna", "values" = character_creator_name_options(GLOB.synth_antennas_list), "fallback" = "None", "colors" = 3)
		if("fluff")
			return list("label" = "Fluff", "pref" = "fluff", "values" = character_creator_name_options(GLOB.fluffs_list), "fallback" = "None", "colors" = 3)
	return null

/datum/preferences/proc/character_creator_part_ids()
	return list("digitigrade_legs", "moth_wings", "tail", "snout", "ears", "horns", "synth_antenna", "wings")

/datum/preferences/proc/character_creator_name_options(options)
	var/list/named_options = list()
	if(!islist(options))
		return named_options
	for(var/entry in options)
		named_options["[entry]"] = "[entry]"
	return named_options

/datum/preferences/proc/character_creator_accessory_color_label(accessory, color_index)
	var/list/part_definition = character_creator_part_definition(accessory)
	var/accessory_name = part_definition?["label"] || accessory
	switch(color_index)
		if(1)
			return "[accessory_name] Color"
		if(2)
			return "[accessory_name] Color 2"
		if(3)
			return "[accessory_name] Color 3"
	return "[accessory_name] Color"

/datum/preferences/proc/character_creator_color_var(accessory, color_index)
	switch(color_index)
		if(1)
			return "[accessory]_color"
		if(2)
			return "[accessory]_color_secondary"
		if(3)
			return "[accessory]_color_tertiary"

/datum/preferences/proc/character_creator_emissive_var(accessory)
	return "[accessory]_emissive"

/datum/preferences/proc/sanitize_character_creator_emissive_list(list/emissive_list)
	var/list/sanitized = list(FALSE, FALSE, FALSE)
	if(!islist(emissive_list))
		return sanitized
	for(var/index in 1 to min(length(emissive_list), 3))
		sanitized[index] = !!emissive_list[index]
	return sanitized

/datum/preferences/proc/character_creator_genital_color_count(id)
	switch(id)
		if("genitalia_boobs")
			return 2
		if("genitalia_ass")
			return 1
		if("genitalia_cock")
			return 1
		if("genitalia_vagina")
			return 1
		if("genitalia_belly")
			return 1
		if("genitalia_testicles")
			return 2
	return 0

/datum/preferences/proc/character_creator_genital_color_var(id, color_index)
	switch(id)
		if("genitalia_boobs")
			return color_index == 2 ? "genitalia_boobs_color_secondary" : "genitalia_boobs_color"
		if("genitalia_ass")
			return "genitalia_ass_color"
		if("genitalia_cock")
			return "genitalia_cock_color"
		if("genitalia_vagina")
			return "genitalia_vagina_color"
		if("genitalia_belly")
			return "genitalia_belly_color"
		if("genitalia_testicles")
			return color_index == 2 ? "genitalia_testicles_color_secondary" : "genitalia_testicles_color"
	return null

/datum/preferences/proc/character_creator_genital_emissive_var(id)
	return "[id]_emissive"

/datum/preferences/proc/character_creator_genital_color_action(id, color_index)
	return character_creator_genital_color_var(id, color_index)

/datum/preferences/proc/character_creator_genital_color_label(id, color_index)
	var/list/genital_names = list(
		"genitalia_ass" = "Butt",
		"genitalia_boobs" = "Breast",
		"genitalia_cock" = "Penis",
		"genitalia_vagina" = "Vagina",
		"genitalia_belly" = "Belly",
		"genitalia_testicles" = "Testicle",
	)
	var/genital_name = genital_names[id] || "Feature"
	return color_index == 2 ? "[genital_name] Color 2" : "[genital_name] Color"

/datum/preferences/proc/character_creator_breast_sizes()
	return list("Flat", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "R", "S", "T")

/datum/preferences/proc/character_creator_breast_size_label(size_number)
	var/list/sizes = character_creator_breast_sizes()
	var/size_index = sanitize_integer(size_number, 0, length(sizes) - 1, initial(genitalia_boobs_size)) + 1
	return sizes[size_index] || "C"

/datum/preferences/proc/character_creator_breast_size_number(size_label)
	var/list/sizes = character_creator_breast_sizes()
	var/size_index = sizes.Find(size_label)
	if(!size_index)
		return initial(genitalia_boobs_size)
	return size_index - 1

/datum/preferences/proc/character_creator_genital_options(id)
	switch(id)
		if("genitalia_boobs")
			return list(
				"None" = null,
				"Pair" = "pair",
				"Quad" = "quad",
				"Sextuple" = "sextuple",
			)
		if("genitalia_ass")
			return list(
				"None" = null,
				"Pair" = "pair",
			)
		if("genitalia_cock")
			return list(
				"Default" = null,
				"Human" = "human",
				"Knotted" = "knotted",
				"Flared" = "flared",
				"Barbed Knot" = "barbknot",
				"Tapered" = "tapered",
				"Tentacle" = "tentacle",
				"Hemi" = "hemi",
				"Knotted Hemi" = "hemiknot",
				"Nondescript" = "nondescript",
			)
		if("genitalia_testicles")
			return list(
				"None" = null,
				"Pair" = "pair",
				"Sheath" = "sheath",
			)
		if("genitalia_vagina")
			return list(
				"Default" = null,
				"Human" = "human",
				"Slit" = "slit",
				"Gaping" = "gaping",
				"Tentacle" = "tentacle",
				"Dentata" = "dentata",
				"Hairy" = "hairy",
				"Furred" = "furred",
				"Spade" = "spade",
				"Cloaca" = "cloaca",
				"Taur" = "taur",
			)
		if("genitalia_belly")
			return list(
				"None" = null,
				"Belly" = "pair",
			)
	return list()

/// Adds one modernized character-creator row as flat top-level TGUI data.
///
/// BYOND serializes nested lists differently across older TGUI paths, so the
/// modern creator island intentionally avoids nested row objects for discovery.
/// `character_creator_genital_row_ids` lists the row ids, and each row stores
/// its data under `character_creator_<id>_*`.
/datum/preferences/proc/add_character_creator_flat_row(list/data, list/row_ids, id, label, values, names, selected_value, fallback = "None", size_id = null, size_value = null, size_kind = null, size_min = null, size_max = null)
	if(!islist(values))
		return

	row_ids += list(id)

	var/list/option_labels = list()
	var/list/option_values = list()
	var/display_value = fallback
	for(var/entry in values)
		var/stored_value = values[entry]
		option_labels += list(entry)
		option_values += list(isnull(stored_value) ? "" : stored_value)
		if(stored_value == selected_value)
			display_value = entry

	data["character_creator_[id]_label"] = label
	data["character_creator_[id]_value"] = isnull(selected_value) ? "" : selected_value
	data["character_creator_[id]_display"] = display_value
	data["character_creator_[id]_option_labels"] = option_labels
	data["character_creator_[id]_option_values"] = option_values

	if(size_id)
		data["character_creator_[id]_size_id"] = size_id
		data["character_creator_[id]_size_value"] = size_value
		data["character_creator_[id]_size_kind"] = size_kind
		data["character_creator_[id]_size_min"] = size_min
		data["character_creator_[id]_size_max"] = size_max

/datum/preferences/proc/write_character_creator_genital_data(list/data)
	var/list/row_ids = list()
	data["character_creator_genital_row_ids"] = row_ids
	data["character_creator_genital_row_count"] = 0

	add_character_creator_flat_row(data, row_ids, "genitalia_boobs", "Breasts", character_creator_genital_options("genitalia_boobs"), null, genitalia_boobs, "None", "genitalia_boobs_size", character_creator_breast_size_label(genitalia_boobs_size), "breast")
	add_character_creator_flat_row(data, row_ids, "genitalia_ass", "Butt", character_creator_genital_options("genitalia_ass"), null, genitalia_ass, "None", "genitalia_ass_size", genitalia_ass_size || initial(genitalia_ass_size), "number", 1, 8)
	add_character_creator_flat_row(data, row_ids, "genitalia_cock", "Penis", character_creator_genital_options("genitalia_cock"), null, genitalia_cock, "Default", "genitalia_cock_size", genitalia_cock_size || initial(genitalia_cock_size), "penis_range")
	add_character_creator_flat_row(data, row_ids, "genitalia_testicles", "Testicles", character_creator_genital_options("genitalia_testicles"), null, genitalia_testicles, "None", "genitalia_testicles_size", genitalia_testicles_size || initial(genitalia_testicles_size), "number", 0, 8)
	add_character_creator_flat_row(data, row_ids, "genitalia_vagina", "Vagina", character_creator_genital_options("genitalia_vagina"), null, genitalia_vagina, "Default")
	add_character_creator_flat_row(data, row_ids, "genitalia_belly", "Belly", character_creator_genital_options("genitalia_belly"), null, genitalia_belly, "None", "genitalia_belly_size", genitalia_belly_size || initial(genitalia_belly_size), "number", 0, 10)
	for(var/id in row_ids)
		var/color_count = character_creator_genital_color_count(id)
		data["character_creator_[id]_color_count"] = color_count
		for(var/color_index in 1 to color_count)
			var/color_var = character_creator_genital_color_var(id, color_index)
			data["character_creator_[id]_color_[color_index]"] = vars[color_var]
			data["character_creator_[id]_color_action_[color_index]"] = character_creator_genital_color_action(id, color_index)
			var/list/emissive_list = vars[character_creator_genital_emissive_var(id)]
			data["character_creator_[id]_emissive_[color_index]"] = allow_emissives && islist(emissive_list) && emissive_list[color_index]
			data["character_creator_[id]_emissive_action_[color_index]"] = "toggle_character_creator_emissive"
	data["character_creator_genital_row_ids"] = row_ids
	data["character_creator_genital_row_count"] = length(row_ids)

/datum/preferences/proc/write_character_creator_part_data(list/data)
	var/list/row_ids = list()
	data["character_creator_part_row_ids"] = row_ids
	for(var/id in character_creator_part_ids())
		var/list/part_definition = character_creator_part_definition(id)
		if(!part_definition)
			continue
		var/pref = part_definition["pref"]
		var/fallback = part_definition["fallback"] || "None"
		add_character_creator_flat_row(data, row_ids, id, part_definition["label"], part_definition["values"], null, vars[pref], fallback)
		var/color_count = part_definition["colors"] || 0
		data["character_creator_[id]_color_count"] = color_count
		for(var/color_index in 1 to color_count)
			var/color_var = character_creator_color_var(id, color_index)
			data["character_creator_[id]_color_[color_index]"] = vars[color_var]
			data["character_creator_[id]_color_action_[color_index]"] = character_creator_color_action(id, color_index)
			var/list/emissive_list = vars[character_creator_emissive_var(id)]
			data["character_creator_[id]_emissive_[color_index]"] = allow_emissives && islist(emissive_list) && emissive_list[color_index]
			data["character_creator_[id]_emissive_action_[color_index]"] = "toggle_character_creator_emissive"
	data["character_creator_part_row_ids"] = row_ids
	data["character_creator_part_row_count"] = length(row_ids)

/datum/preferences/proc/body_marking_row_id(zone, index)
	return "[zone]_[index]"

/datum/preferences/proc/sanitize_body_markings()
	ensure_body_marking_references()
	if(!islist(body_markings))
		body_markings = list()

	var/list/sanitized_markings = list()
	for(var/zone in GLOB.marking_zones)
		var/list/zone_markings = body_markings[zone]
		if(!islist(zone_markings))
			continue

		var/list/sanitized_zone = list()
		var/marking_count = 0
		for(var/marking_name in zone_markings)
			if(marking_count >= MAXIMUM_MARKINGS_PER_LIMB)
				break
			if(!(marking_name in GLOB.body_markings_per_limb[zone]))
				continue

			var/list/entry = zone_markings[marking_name]
			sanitized_zone[marking_name] = list(body_marking_entry_color(entry), body_marking_entry_emissive(entry))
			marking_count++

		if(length(sanitized_zone))
			sanitized_markings[zone] = sanitized_zone

	body_markings = sanitized_markings

/datum/preferences/proc/write_character_creator_marking_data(list/data)
	ensure_body_marking_references()
	sanitize_body_markings()

	var/list/zone_ids = list()
	for(var/zone in GLOB.marking_zones)
		zone_ids += zone
		data["character_creator_marking_[zone]_label"] = GLOB.marking_zone_labels[zone]
		data["character_creator_marking_[zone]_choices"] = GLOB.body_markings_per_limb[zone]

		var/list/row_ids = list()
		var/list/zone_markings = body_markings[zone]
		var/marking_index = 0
		if(length(zone_markings))
			for(var/marking_name in zone_markings)
				marking_index++
				var/row_id = body_marking_row_id(zone, marking_index)
				row_ids += row_id
				data["character_creator_marking_[row_id]_name"] = marking_name
				data["character_creator_marking_[row_id]_color"] = body_marking_entry_color(zone_markings[marking_name])
				data["character_creator_marking_[row_id]_emissive"] = allow_emissives && body_marking_entry_emissive(zone_markings[marking_name])

		data["character_creator_marking_[zone]_row_ids"] = row_ids

	data["character_creator_marking_zone_ids"] = zone_ids

/datum/preferences/proc/write_character_creator_accessory_data(list/data)
	write_character_creator_genital_data(data)
	write_character_creator_part_data(data)
	write_character_creator_marking_data(data)

/datum/preferences/proc/character_creator_color_action(accessory, color_index)
	switch(color_index)
		if(1)
			return "[accessory]color"
		if(2)
			return "[accessory]color_secondary"
		if(3)
			return "[accessory]color_tertiary"

/datum/preferences/proc/rotate_character_creator_preview(clockwise = TRUE)
	preference_preview_dir = turn(preference_preview_dir, clockwise ? -90 : 90)
	update_preview_icon()

/datum/preferences/proc/reset_character_creator_preview()
	preference_preview_dir = SOUTH
	update_preview_icon()

/datum/preferences/proc/render_character_creator_preview_body(mob/living/carbon/human/dummy/mannequin)
	var/datum/job/previewJob
	var/highest_pref = JOBS_PRIORITY_NEVER
	if(LAZYLEN(SSjob.occupations))
		for(var/job in job_preferences)
			if(job_preferences[job] > highest_pref)
				previewJob = SSjob.GetJob(job)
				highest_pref = job_preferences[job]

	copy_to(mannequin)
	mannequin.set_species(species)

	if(previewJob)
		mannequin.job = previewJob
		previewJob.equip_dummy(mannequin, preference_source = parent)

	return mannequin

/datum/preferences/proc/is_synthetic_species()
	return species == "Synthetic" || species == "Early Synthetic"

/datum/preferences/proc/is_combat_robot_species()
	return species == "Combat Robot"

/datum/preferences/proc/is_prototype_supersoldier_species()
	return species == "Prototype Supersoldier"

/datum/preferences/proc/sync_synthetic_type_to_species()
	if(species == "Early Synthetic")
		synthetic_type = "Early Synthetic"
	else if(species == "Combat Robot")
		synthetic_type = "Combat Robot"
	else if(species == "Synthetic")
		synthetic_type = "Synthetic"

/datum/preferences/proc/synthetic_digitigrade_leg_options()
	if(!is_synthetic_species())
		return list("Normal")
	if(synthetic_body_base == "Lizard" || synthetic_body_base == "Anthro")
		return DIGITIGRADE_LEG_TYPES
	return list("Normal")

/datum/preferences/proc/combat_robot_digitigrade_leg_options()
	if(!is_combat_robot_species())
		return list("Normal")
	if(!allow_mismatched_parts)
		return list("Normal")
	if(robot_body_base == "Lizard" || robot_body_base == "Anthro")
		return DIGITIGRADE_LEG_TYPES
	return list("Normal")

/datum/preferences/proc/supersoldier_digitigrade_leg_options()
	if(!is_prototype_supersoldier_species())
		return list("Normal")
	if(!custom_supersoldier_parts)
		return list("Normal")
	if(supersoldier_body_base in list("Lizard", "Anthro", "Akula", "Aquatic"))
		return DIGITIGRADE_LEG_TYPES
	return list("Normal")

/datum/preferences/proc/digitigrade_leg_options()
	if(is_synthetic_species())
		return synthetic_digitigrade_leg_options()
	if(is_combat_robot_species())
		return combat_robot_digitigrade_leg_options()
	if(is_prototype_supersoldier_species())
		return supersoldier_digitigrade_leg_options()
	var/datum/species/current_species = GLOB.all_species[species]
	return current_species?.digitigrade_leg_options || list("Normal")

/datum/preferences/proc/should_refresh_species_body_color(datum/species/old_species, datum/species/new_species)
	if(!new_species || new_species.name != "Moth")
		return FALSE
	if(!body_color || body_color == initial(body_color))
		return TRUE
	return old_species?.flesh_color && body_color == old_species.flesh_color

/datum/preferences/proc/handle_character_creator_accessory_action(action, mob/user, list/params = list())
	var/list/genital_actions = list(
		"genitalia_ass" = list("label" = "Butt", "pref" = "genitalia_ass"),
		"genitalia_boobs" = list("label" = "Breasts", "pref" = "genitalia_boobs"),
		"genitalia_cock" = list("label" = "Penis", "pref" = "genitalia_cock"),
		"genitalia_vagina" = list("label" = "Vagina", "pref" = "genitalia_vagina"),
		"genitalia_belly" = list("label" = "Belly", "pref" = "genitalia_belly"),
		"genitalia_testicles" = list("label" = "Testicles", "pref" = "genitalia_testicles"),
	)
	if(action == "set_character_creator_value")
		var/field = params["field"]
		var/chosen_value = params["value"]
		if(!(field in genital_actions))
			return FALSE
		var/list/genital_data = genital_actions[field]
		var/list/values = character_creator_genital_options(field)
		if(chosen_value == "")
			chosen_value = null
		var/found_value = FALSE
		for(var/entry in values)
			if(values[entry] == chosen_value)
				found_value = TRUE
				break
		if(!found_value)
			return TRUE
		vars[genital_data["pref"]] = chosen_value
		update_preview_icon()
		return TRUE

	if(action == "set_character_creator_part_value")
		var/field = params["field"]
		var/chosen_value = params["value"]
		var/list/part_definition = character_creator_part_definition(field)
		if(!part_definition)
			return FALSE
		var/list/values = part_definition["values"]
		var/found_value = FALSE
		for(var/entry in values)
			if(values[entry] == chosen_value)
				found_value = TRUE
				break
		if(!found_value)
			return TRUE
		vars[part_definition["pref"]] = chosen_value
		update_preview_icon()
		return TRUE

	if(action == "toggle_character_creator_emissive")
		var/field = params["field"]
		var/color_index = sanitize_integer(params["color_index"], 1, 3, 1)
		var/emissive_var
		if(field in genital_actions)
			emissive_var = character_creator_genital_emissive_var(field)
		else if(character_creator_part_definition(field))
			emissive_var = character_creator_emissive_var(field)
		if(!emissive_var)
			return FALSE
		var/list/emissive_list = sanitize_character_creator_emissive_list(vars[emissive_var])
		emissive_list[color_index] = !emissive_list[color_index]
		vars[emissive_var] = emissive_list
		update_preview_icon()
		return TRUE

	if(action == "add_character_creator_marking")
		ensure_body_marking_references()
		sanitize_body_markings()
		var/zone = params["zone"]
		if(!(zone in GLOB.marking_zones))
			return TRUE
		var/list/choices = GLOB.body_markings_per_limb[zone]
		if(!length(choices))
			return TRUE
		if(!body_markings[zone])
			body_markings[zone] = list()
		if(length(body_markings[zone]) >= MAXIMUM_MARKINGS_PER_LIMB)
			return TRUE
		var/marking_name = choices[1]
		var/datum/body_marking/marking = GLOB.body_markings[marking_name]
		body_markings[zone][marking_name] = list(marking.get_default_color(null), FALSE)
		update_preview_icon()
		return TRUE

	if(action == "remove_character_creator_marking")
		sanitize_body_markings()
		var/zone = params["zone"]
		var/row_id = params["row_id"]
		if(!(zone in GLOB.marking_zones) || !islist(body_markings[zone]))
			return TRUE
		var/list/new_markings = list()
		var/marking_index = 0
		for(var/marking_name in body_markings[zone])
			marking_index++
			if(row_id == body_marking_row_id(zone, marking_index))
				continue
			new_markings[marking_name] = body_markings[zone][marking_name]
		if(length(new_markings))
			body_markings[zone] = new_markings
		else
			body_markings -= zone
		update_preview_icon()
		return TRUE

	if(action == "set_character_creator_marking")
		ensure_body_marking_references()
		sanitize_body_markings()
		var/zone = params["zone"]
		var/row_id = params["row_id"]
		var/new_marking_name = params["marking_name"]
		if(!(zone in GLOB.marking_zones) || !(new_marking_name in GLOB.body_markings_per_limb[zone]) || !islist(body_markings[zone]))
			return TRUE
		var/list/new_markings = list()
		var/marking_index = 0
		for(var/marking_name in body_markings[zone])
			marking_index++
			if(row_id == body_marking_row_id(zone, marking_index))
				new_markings[new_marking_name] = body_markings[zone][marking_name]
				continue
			new_markings[marking_name] = body_markings[zone][marking_name]
		body_markings[zone] = new_markings
		update_preview_icon()
		return TRUE

	if(action == "color_character_creator_marking")
		sanitize_body_markings()
		var/zone = params["zone"]
		var/row_id = params["row_id"]
		if(!(zone in GLOB.marking_zones) || !islist(body_markings[zone]))
			return TRUE
		var/marking_index = 0
		for(var/marking_name in body_markings[zone])
			marking_index++
			if(row_id != body_marking_row_id(zone, marking_index))
				continue
			var/new_color = input(user, "Choose your marking color:", "Marking Color") as null|color
			if(new_color)
				body_markings[zone][marking_name][1] = sanitize_hexcolor(new_color, 6, TRUE, "#FFFFFF")
				update_preview_icon()
			return TRUE

	if(action == "toggle_character_creator_marking_emissive")
		sanitize_body_markings()
		var/zone = params["zone"]
		var/row_id = params["row_id"]
		if(!(zone in GLOB.marking_zones) || !islist(body_markings[zone]))
			return TRUE
		var/marking_index = 0
		for(var/marking_name in body_markings[zone])
			marking_index++
			if(row_id != body_marking_row_id(zone, marking_index))
				continue
			body_markings[zone][marking_name][2] = !body_marking_entry_emissive(body_markings[zone][marking_name])
			update_preview_icon()
			return TRUE

	if(action in genital_actions)
		var/list/genital_data = genital_actions[action]
		var/list/values = character_creator_genital_options(action)
		var/choice = params["newValue"]
		if(choice && !(choice in values))
			return TRUE
		if(!choice)
			choice = tgui_input_list(user, "Choose your [lowertext(genital_data["label"])].", genital_data["label"], values)
		if(!choice)
			return TRUE
		vars[genital_data["pref"]] = values[choice]
		update_preview_icon()
		return TRUE

	switch(action)
		if("genitalia_ass_size")
			genitalia_ass_size = sanitize_integer(params["newValue"], 1, 8, initial(genitalia_ass_size))
			update_preview_icon()
			return TRUE
		if("genitalia_boobs_size")
			var/choice = params["newValue"]
			if(!choice)
				choice = tgui_input_list(user, "Choose your breast size.", "Breast Size", character_creator_breast_sizes())
			if(!choice)
				return TRUE
			if(!(choice in character_creator_breast_sizes()))
				return TRUE
			genitalia_boobs_size = character_creator_breast_size_number(choice)
			update_preview_icon()
			return TRUE
		if("genitalia_cock_size")
			genitalia_cock_size = sanitize_integer(params["newValue"], 1, 7, initial(genitalia_cock_size))
			update_preview_icon()
			return TRUE
		if("genitalia_belly_size")
			genitalia_belly_size = sanitize_integer(params["newValue"], 0, 10, initial(genitalia_belly_size))
			update_preview_icon()
			return TRUE
		if("genitalia_testicles_size")
			genitalia_testicles_size = sanitize_integer(params["newValue"], 0, 8, initial(genitalia_testicles_size))
			update_preview_icon()
			return TRUE

	for(var/genital_id in genital_actions)
		var/color_count = character_creator_genital_color_count(genital_id)
		for(var/color_index in 1 to color_count)
			var/color_action = character_creator_genital_color_action(genital_id, color_index)
			if(action != color_action)
				continue

			var/color_var = character_creator_genital_color_var(genital_id, color_index)
			var/new_color = input(user, "Choose your [lowertext(character_creator_genital_color_label(genital_id, color_index))]:", character_creator_genital_color_label(genital_id, color_index)) as null|color
			if(!new_color)
				return TRUE
			vars[color_var] = new_color
			update_preview_icon()
			return TRUE

	for(var/part_id in character_creator_part_ids())
		var/list/part_definition = character_creator_part_definition(part_id)
		if(action == part_id)
			var/part_name = part_definition["label"]
			var/choice = tgui_input_list(user, "Choose your [lowertext(part_name)].", part_name, part_definition["values"])
			if(!choice)
				return TRUE
			vars[part_definition["pref"]] = choice
			update_preview_icon()
			return TRUE

		var/color_count = part_definition["colors"] || 0
		for(var/color_index in 1 to color_count)
			var/color_action = character_creator_color_action(part_id, color_index)
			if(action != color_action)
				continue

			var/color_var = character_creator_color_var(part_id, color_index)
			var/new_color = input(user, "Choose your [lowertext(character_creator_accessory_color_label(part_id, color_index))]:", character_creator_accessory_color_label(part_id, color_index)) as null|color
			if(!new_color)
				return TRUE
			vars[color_var] = new_color
			update_preview_icon()
			return TRUE

	return FALSE
