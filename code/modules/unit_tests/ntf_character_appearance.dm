/datum/unit_test/ntf_character_appearance_stress
	var/list/test_species

/datum/unit_test/ntf_character_appearance_stress/Destroy()
	fdel("data/ntf_character_appearance_legacy.sav")
	return ..()

/datum/unit_test/ntf_character_appearance_stress/Run()
	ensure_body_marking_references()

	test_species = build_species_sample()
	TEST_ASSERT(length(test_species), "No species were available for NTF character appearance stress testing.")

	var/datum/preferences/corrupt_preferences = build_base_preferences()
	var/mob/living/carbon/human/corrupt_human = allocate(/mob/living/carbon/human)
	poison_preferences(corrupt_preferences)
	if(!try_character_rebuild(corrupt_preferences, corrupt_human, "corrupt saved preference repair"))
		return

	for(var/species_name in test_species)
		var/datum/preferences/preferences = build_base_preferences(species_name)
		var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human)
		if(!try_character_rebuild(preferences, human, "baseline species [species_name]"))
			return

		for(var/accessory_id in preferences.character_creator_part_ids())
			var/list/part_definition = preferences.character_creator_part_definition(accessory_id)
			if(!part_definition)
				continue
			var/pref_name = part_definition["pref"]
			if(!pref_name)
				continue
			for(var/option_value in sample_option_values(part_definition["values"], part_definition["fallback"]))
				preferences.vars[pref_name] = option_value
				apply_accessory_stress_values(preferences, accessory_id, part_definition)
				if(!try_character_rebuild(preferences, human, "[species_name] [accessory_id] option [option_value || "null"]"))
					return

	if(!try_legacy_save_load())
		return
	if(!try_character_creator_ui_smoke())
		return
	if(!try_deferred_rebuild_smoke())
		return

/datum/unit_test/ntf_character_appearance_stress/proc/build_species_sample()
	var/list/species_sample = list()
	var/list/preferred_species = list(
		"Human",
		"Combat Robot",
		"Teshari",
		"Vulpkanin",
		"Anthro",
		"Akula",
	)

	for(var/species_name in preferred_species)
		if(species_name in GLOB.all_species)
			species_sample[species_name] = GLOB.all_species[species_name]

	if(length(species_sample))
		return species_sample

	var/list/fallback_species = length(GLOB.roundstart_species) ? GLOB.roundstart_species : GLOB.all_species
	for(var/species_name in fallback_species)
		species_sample[species_name] = fallback_species[species_name]
		if(length(species_sample) >= 5)
			break
	return species_sample

/datum/unit_test/ntf_character_appearance_stress/proc/build_base_preferences(species_name = "Human")
	var/datum/preferences/preferences = new
	preferences.random_name = TRUE
	preferences.gender = MALE
	preferences.real_name = "NTF Test"
	preferences.species = species_name
	preferences.body_color = "#FFFFFF"
	preferences.blood_color = "#A10808"
	preferences.allow_emissives = TRUE
	return preferences

/datum/unit_test/ntf_character_appearance_stress/proc/build_savefile_preferences(path = "data/ntf_character_appearance_legacy.sav", species_name = "Human")
	var/datum/preferences/preferences = build_base_preferences(species_name)
	preferences.path = path
	preferences.default_slot = 1
	var/savefile/S = new /savefile(path)
	S.cd = "/"
	S["version"] << SAVEFILE_VERSION_MAX
	S["default_slot"] << 1
	S.cd = "/character1"
	S["real_name"] << "Legacy Tester"
	return preferences

/datum/unit_test/ntf_character_appearance_stress/proc/poison_preferences(datum/preferences/preferences)
	preferences.species = "Broken Species"
	preferences.body_color = "definitely not a color"
	preferences.blood_color = "also bad"
	preferences.moth_wings = "Broken Wings"
	preferences.digitigrade_legs = "Too Many Knees"
	preferences.body_markings = list("broken" = list("not", "a", "marking"))

	for(var/accessory_id in preferences.character_creator_part_ids())
		var/list/part_definition = preferences.character_creator_part_definition(accessory_id)
		if(!part_definition)
			continue
		var/pref_name = part_definition["pref"]
		if(pref_name)
			preferences.vars[pref_name] = "Missing [accessory_id]"
		for(var/color_index in 1 to (part_definition["colors"] || 0))
			var/color_var = preferences.character_creator_color_var(accessory_id, color_index)
			if(color_var)
				preferences.vars[color_var] = "bad-color"
		if(part_definition["colors"])
			var/emissive_var = preferences.character_creator_emissive_var(accessory_id)
			if(emissive_var)
				preferences.vars[emissive_var] = list("yes", 99, null, FALSE)

	poison_genitals(preferences)

/datum/unit_test/ntf_character_appearance_stress/proc/poison_genitals(datum/preferences/preferences)
	preferences.genitalia_ass = "pair_999"
	preferences.genitalia_ass_color = "bad-color"
	preferences.genitalia_ass_emissive = list("yes", 2, null)
	preferences.genitalia_boobs = "pair_999"
	preferences.genitalia_boobs_color = "bad-color"
	preferences.genitalia_boobs_color_secondary = "bad-color"
	preferences.genitalia_boobs_emissive = list("yes", 2, null)
	preferences.genitalia_cock = "knotted_999"
	preferences.genitalia_cock_color = "bad-color"
	preferences.genitalia_cock_emissive = list("yes", 2, null)
	preferences.genitalia_testicles = "pair_999"
	preferences.genitalia_testicles_color = "bad-color"
	preferences.genitalia_testicles_color_secondary = "bad-color"
	preferences.genitalia_testicles_emissive = list("yes", 2, null)
	preferences.genitalia_vagina = "Missing Vagina"
	preferences.genitalia_vagina_color = "bad-color"
	preferences.genitalia_vagina_emissive = list("yes", 2, null)
	preferences.genitalia_belly = "999"
	preferences.genitalia_belly_color = "bad-color"
	preferences.genitalia_belly_emissive = list("yes", 2, null)

/datum/unit_test/ntf_character_appearance_stress/proc/poison_savefile(path = "data/ntf_character_appearance_legacy.sav")
	fdel(path)
	var/savefile/S = new /savefile(path)
	S.cd = "/"
	S["version"] << SAVEFILE_VERSION_MAX
	S["default_slot"] << 1
	S.cd = "/character1"
	S["real_name"] << "Legacy Tester"
	S["species"] << "Broken Species"
	S["body_color"] << "not-a-color"
	S["blood_color"] << "not-blood"
	S["tail"] << "Missing Tail"
	S["snout"] << "Missing Snout"
	S["ears"] << "Missing Ears"
	S["horns"] << "Missing Horns"
	S["wings"] << "Missing Wings"
	S["fluff"] << "Missing Fluff"
	S["digitigrade_legs"] << "Broken Legs"
	S["body_markings"] << list("broken" = list("not", "a", "marking"))
	S["tail_emissive"] << list("bad", 99, null)
	S["genitalia_ass"] << "pair_999"
	S["genitalia_boobs"] << "pair_999"
	S["genitalia_cock"] << "knotted_999"
	S["genitalia_testicles"] << "pair_999"
	S["genitalia_vagina"] << "Missing Vagina"
	S["genitalia_belly"] << "999"
	S["genitalia_ass_color"] << "bad-color"
	S["genitalia_boobs_color"] << "bad-color"
	S["genitalia_cock_color"] << "bad-color"
	S["genitalia_vagina_color"] << "bad-color"
	S["genitalia_belly_color"] << "bad-color"
	S["genitalia_testicles_color"] << "bad-color"
	S["genitalia_cock_emissive"] << list("yes", 2, null)

/datum/unit_test/ntf_character_appearance_stress/proc/sample_option_values(list/options, fallback)
	var/list/option_values = list()
	for(var/option_name in options)
		var/option_value = options[option_name]
		if(!(option_value in option_values))
			option_values += option_value

	var/list/samples = list()
	if(null in option_values)
		samples += null
	if(fallback && !(fallback in samples))
		samples += fallback
	if(length(option_values))
		var/list/indexes = list(1, round(length(option_values) / 2), length(option_values))
		for(var/index in indexes)
			var/option_value = option_values[clamp(index, 1, length(option_values))]
			if(!(option_value in samples))
				samples += option_value
	return samples

/datum/unit_test/ntf_character_appearance_stress/proc/apply_accessory_stress_values(datum/preferences/preferences, accessory_id, list/part_definition)
	var/color_count = part_definition["colors"] || 0
	for(var/color_index in 1 to color_count)
		var/color_var = preferences.character_creator_color_var(accessory_id, color_index)
		if(color_var)
			preferences.vars[color_var] = "#7FA66F"
	if(color_count)
		var/emissive_var = preferences.character_creator_emissive_var(accessory_id)
		if(emissive_var)
			preferences.vars[emissive_var] = list(TRUE, FALSE, TRUE)

/datum/unit_test/ntf_character_appearance_stress/proc/try_character_rebuild(datum/preferences/preferences, mob/living/carbon/human/human, context)
	try
		preferences.sanitize_character_appearance_for_render()
		preferences.copy_to(human, TRUE)
		human.update_body()
		human.update_hair()
		human.update_accessories()
	catch(var/exception/error)
		Fail("NTF character appearance stress failed during [context]: [error] at [error.file]:[error.line]")
		return FALSE
	return TRUE

/datum/unit_test/ntf_character_appearance_stress/proc/try_legacy_save_load()
	var/path = "data/ntf_character_appearance_legacy.sav"
	try
		poison_savefile(path)
		var/datum/preferences/preferences = build_base_preferences()
		preferences.path = path
		TEST_ASSERT(preferences.load_character(1), "Legacy character save did not load.")
		var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human)
		if(!try_character_rebuild(preferences, human, "legacy save load"))
			return FALSE
	catch(var/exception/error)
		Fail("NTF character appearance stress failed during legacy save load: [error] at [error.file]:[error.line]")
		return FALSE
	return TRUE

/datum/unit_test/ntf_character_appearance_stress/proc/try_character_creator_ui_smoke()
	try
		var/datum/preferences/preferences = build_savefile_preferences()
		for(var/species_name in test_species)
			preferences.species = species_name
			preferences.sanitize_character_appearance_for_render()

			var/list/flat_data = list()
			preferences.write_character_creator_accessory_data(flat_data)
			TEST_ASSERT(islist(flat_data["character_creator_part_row_ids"]), "Part rows were not generated for [species_name].")
			TEST_ASSERT(islist(flat_data["character_creator_genital_row_ids"]), "Genital rows were not generated for [species_name].")
			TEST_ASSERT(islist(flat_data["character_creator_marking_zone_ids"]), "Marking rows were not generated for [species_name].")

			preferences.tab_index = CHARACTER_CUSTOMIZATION
			var/list/ui_data = preferences.ui_data(null)
			TEST_ASSERT(islist(ui_data), "Character creator ui_data did not return a list for [species_name].")
			TEST_ASSERT("character_creator_part_row_ids" in ui_data, "Character creator ui_data missed part rows for [species_name].")
	catch(var/exception/error)
		Fail("NTF character appearance stress failed during character creator UI smoke: [error] at [error.file]:[error.line]")
		return FALSE
	return TRUE

/datum/unit_test/ntf_character_appearance_stress/proc/try_deferred_rebuild_smoke()
	try
		var/datum/preferences/preferences = build_base_preferences()
		var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human)
		var/old_state = SSticker?.current_state
		SSticker.current_state = GAME_STATE_FINISHED
		TEST_ASSERT(!preferences.character_appearance_rebuild_is_safe(), "Finished ticker state should not be safe for appearance rebuilds.")
		TEST_ASSERT(preferences.rebuild_character_appearance_safely(human, 5), "Deferred character appearance rebuild did not return success.")
		SSticker.current_state = old_state
	catch(var/exception/error)
		Fail("NTF character appearance stress failed during deferred rebuild smoke: [error] at [error.file]:[error.line]")
		return FALSE
	return TRUE
