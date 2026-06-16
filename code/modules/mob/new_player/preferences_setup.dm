/datum/preferences/proc/randomize_appearance_for(mob/living/carbon/human/H)
	gender = pick(MALE, FEMALE)
	species = pick(get_playable_species())
	synthetic_type = pick(SYNTH_TYPES)
	synthetic_body_base = pick(SYNTHETIC_BODY_BASES)
	robot_type = pick(ROBOT_TYPES)
	robot_body_base = pick(ROBOT_BODY_BASES)
	robot_head_base = pick(ROBOT_HEAD_BASES)
	supersoldier_body_base = pick(SUPERSOLDIER_BODY_BASES)
	supersoldier_head_base = pick(SUPERSOLDIER_HEAD_BASES)
	ethnicity = initial(ethnicity)
	moth_wings = pick(GLOB.moth_wings_list)
	tail = pick(GLOB.lizard_tails_list)
	snout = pick(GLOB.snouts_list)
	ears = pick(GLOB.ears_list)
	horns = pick(GLOB.horns_list)
	wings = pick(GLOB.wings_list)
	synth_antenna = pick(GLOB.synth_antennas_list)
	digitigrade_legs = "Normal"

	h_style = random_hair_style(gender, species)
	f_style = random_facial_hair_style(gender, species)
	grad_style = pick(GLOB.hair_gradients_list)
	good_eyesight = pick(list(FALSE, TRUE))
	citizenship = pick(CITIZENSHIP_CHOICES)
	blood_type = pick(7;"O-", 38;"O+", 6;"A-", 34;"A+", 2;"B-", 9;"B+", 1;"AB-", 3;"AB+")
	religion = pick(RELIGION_CHOICES)
	tts_voice = random_tts_voice()
	randomize_hair_color("hair")
	randomize_hair_color("grad")
	randomize_hair_color("facial")
	randomize_eyes_color()
	randomize_species_specific()
	/*NTF removal
	underwear = rand(1, length(GLOB.underwear_m))
	undershirt = rand(1, length(GLOB.undershirt_f))
	*/
	backpack = rand(BACK_NOTHING, BACK_SATCHEL)
	age = rand(AGE_MIN,AGE_MAX)
	if(H)
		copy_to(H, TRUE)


/datum/preferences/proc/randomize_hair_color(target = "hair")
	if(prob (75) && target == "facial")
		r_facial = r_hair
		g_facial = g_hair
		b_facial = b_hair
		return

	var/red
	var/green
	var/blue

	switch(pick(15;"black", 15;"grey", 15;"brown", 15;"lightbrown", 5;"white", 15;"blonde", 10;"red"))
		if("black")
			red = 10
			green = 10
			blue = 10
		if("grey")
			red = 50
			green = 50
			blue = 50
		if("brown")
			red = 70
			green = 35
			blue = 0
		if("lightbrown")
			red = 100
			green = 50
			blue = 0
		if("white")
			red = 235
			green = 235
			blue = 235
		if("blonde")
			red = 240
			green = 240
			blue = 0
		if("red")
			red = 128
			green = 0
			blue = 0

	red = clamp(red + rand(-25, 25), 0, 255)
	green = clamp(green + rand(-25, 25), 0, 255)
	blue = clamp(blue + rand(-25, 25), 0, 255)

	switch(target)
		if("hair")
			r_hair = red
			g_hair = green
			b_hair = blue
		if("facial")
			r_facial = red
			g_facial = green
			b_facial = blue
		if("grad")
			r_grad = red
			g_grad = green
			b_grad = blue

/datum/preferences/proc/randomize_eyes_color()
	var/red
	var/green
	var/blue

	switch(pick(15;"black", 15;"green", 15;"brown", 15;"blue", 15;"lightblue", 5;"red"))
		if("black")
			red = 10
			green = 10
			blue = 10
		if("green")
			red = 200
			green = 0
			blue = 0
		if("brown")
			red = 100
			green = 50
			blue = 0
		if("blue")
			red = 0
			green = 0
			blue = 200
		if("lightblue")
			red = 0
			green = 150
			blue = 255
		if("red")
			red = 220
			green = 0
			blue = 0

	red = clamp(red + rand(-25, 25), 0, 255)
	green = clamp(green + rand(-25, 25), 0, 255)
	blue = clamp(blue + rand(-25, 25), 0, 255)

	r_eyes = red
	g_eyes = green
	b_eyes = blue


/datum/preferences/proc/update_preview_icon()
	if(!SSticker || SSticker.current_state == GAME_STATE_STARTUP)
		return // if it's too early just skip it, players can trigger another update later
	var/debug_ckey
	if(!sanitize_character_appearance_for_render())
		debug_ckey = parent?.ckey || "unknown ckey"
		log_runtime("sanitize_character_appearance_for_render() failed! Character preview update failed for [debug_ckey] slot [default_slot]. prefs=[character_debug_summary()]")
	if(!istype(screen_main))
		debug_ckey = parent?.ckey || "unknown ckey"
		log_runtime("istype(screen_main) failed! screen_main = [logdetails(screen_main)]. Character preview update failed for [debug_ckey] slot [default_slot]. prefs=[character_debug_summary()]")
	if(!screen_main.update_body())
		debug_ckey = parent?.ckey || "unknown ckey"
		log_runtime("screen_main.update_body() failed! Character preview update failed for [debug_ckey] slot [default_slot]. prefs=[character_debug_summary()]")


/datum/preferences/proc/randomize_species_specific()
	moth_wings = pick(GLOB.moth_wings_list - "Burnt Off")
	tail = pick(character_creator_tail_options() - "None")
	snout = pick(GLOB.snouts_list - "None")
	ears = pick(GLOB.ears_list - "None")
	horns = pick(GLOB.horns_list - "None")
	wings = pick(GLOB.wings_list - "None")
	synth_antenna = pick(GLOB.synth_antennas_list - "None")
	var/list/leg_options = digitigrade_leg_options()
	if(length(leg_options) > 1)
		digitigrade_legs = pick(leg_options)
	else
		digitigrade_legs = "Normal"

/datum/preferences/proc/character_debug_summary()
	var/marking_summary = islist(body_markings) ? length(body_markings) : "invalid"
	return "species=[species]; gender=[gender]; synth=[synthetic_type]/[synthetic_body_base]; robot=[robot_body_base]/[robot_head_base]; tail=[tail]; snout=[snout]; ears=[ears]; horns=[horns]; wings=[wings]; antenna=[synth_antenna]; fluff=[fluff]; legs=[digitigrade_legs]; markings=[marking_summary]"

/datum/preferences/proc/sanitize_character_appearance_for_render()
	. = FALSE
	species = sanitize_inlist(species, GLOB.all_species, initial(species))
	body_color = sanitize_hexcolor(body_color, 6, TRUE, initial(body_color))
	moth_wings = sanitize_inlist(moth_wings, GLOB.moth_wings_list, initial(moth_wings))
	allow_emissives = sanitize_integer(allow_emissives, FALSE, TRUE, initial(allow_emissives))

	tail = sanitize_inlist(tail, GLOB.lizard_tails_list, initial(tail))
	tail_color = sanitize_hexcolor(tail_color, 6, TRUE, "#6BA36B")
	tail_color_secondary = sanitize_hexcolor(tail_color_secondary, 6, TRUE, "#6BA36B")
	tail_color_tertiary = sanitize_hexcolor(tail_color_tertiary, 6, TRUE, "#6BA36B")
	tail_emissive = sanitize_character_creator_emissive_list(tail_emissive)

	snout = sanitize_inlist(snout, GLOB.snouts_list, initial(snout))
	snout_color = sanitize_hexcolor(snout_color, 6, TRUE, "#6BA36B")
	snout_color_secondary = sanitize_hexcolor(snout_color_secondary, 6, TRUE, "#6BA36B")
	snout_color_tertiary = sanitize_hexcolor(snout_color_tertiary, 6, TRUE, "#6BA36B")
	snout_emissive = sanitize_character_creator_emissive_list(snout_emissive)

	ears = sanitize_inlist(ears, GLOB.ears_list, initial(ears))
	ears_color = sanitize_hexcolor(ears_color, 6, TRUE, "#6BA36B")
	ears_color_secondary = sanitize_hexcolor(ears_color_secondary, 6, TRUE, "#6BA36B")
	ears_color_tertiary = sanitize_hexcolor(ears_color_tertiary, 6, TRUE, "#6BA36B")
	ears_emissive = sanitize_character_creator_emissive_list(ears_emissive)

	horns = sanitize_inlist(horns, GLOB.horns_list, initial(horns))
	horns_color = sanitize_hexcolor(horns_color, 6, TRUE, "#555555")
	horns_color_secondary = sanitize_hexcolor(horns_color_secondary, 6, TRUE, "#555555")
	horns_color_tertiary = sanitize_hexcolor(horns_color_tertiary, 6, TRUE, "#555555")
	horns_emissive = sanitize_character_creator_emissive_list(horns_emissive)

	wings = sanitize_inlist(wings, GLOB.wings_list, initial(wings))
	wings_color = sanitize_hexcolor(wings_color, 6, TRUE, "#6BA36B")
	wings_color_secondary = sanitize_hexcolor(wings_color_secondary, 6, TRUE, "#6BA36B")
	wings_color_tertiary = sanitize_hexcolor(wings_color_tertiary, 6, TRUE, "#6BA36B")
	wings_emissive = sanitize_character_creator_emissive_list(wings_emissive)

	synth_antenna = sanitize_inlist(synth_antenna, GLOB.synth_antennas_list, initial(synth_antenna))
	synth_antenna_color = sanitize_hexcolor(synth_antenna_color, 6, TRUE, "#6BA36B")
	synth_antenna_color_secondary = sanitize_hexcolor(synth_antenna_color_secondary, 6, TRUE, "#6BA36B")
	synth_antenna_color_tertiary = sanitize_hexcolor(synth_antenna_color_tertiary, 6, TRUE, "#6BA36B")
	synth_antenna_emissive = sanitize_character_creator_emissive_list(synth_antenna_emissive)

	fluff = sanitize_inlist(fluff, GLOB.fluffs_list, initial(fluff))
	fluff_color = sanitize_hexcolor(fluff_color, 6, TRUE, "#6BA36B")
	fluff_color_secondary = sanitize_hexcolor(fluff_color_secondary, 6, TRUE, "#6BA36B")
	fluff_color_tertiary = sanitize_hexcolor(fluff_color_tertiary, 6, TRUE, "#6BA36B")
	fluff_emissive = sanitize_character_creator_emissive_list(fluff_emissive)

	digitigrade_legs = sanitize_inlist(digitigrade_legs, DIGITIGRADE_LEG_TYPES, initial(digitigrade_legs))
	if(!(digitigrade_legs in digitigrade_leg_options()))
		digitigrade_legs = initial(digitigrade_legs)
	sanitize_body_markings()

	genitalia_ass = sanitize_inlist_assoc(genitalia_ass, GLOB.possible_ass_sprites, initial(genitalia_ass))
	genitalia_ass_size = sanitize_integer(genitalia_ass_size, 1, 8, initial(genitalia_ass_size))
	genitalia_ass_color = sanitize_hexcolor(genitalia_ass_color, 6, TRUE, initial(genitalia_ass_color))
	genitalia_ass_emissive = sanitize_character_creator_emissive_list(genitalia_ass_emissive)
	genitalia_boobs = sanitize_inlist_assoc(genitalia_boobs, GLOB.possible_boob_sprites, initial(genitalia_boobs))
	genitalia_boobs_size = sanitize_integer(genitalia_boobs_size, 0, 19, initial(genitalia_boobs_size))
	genitalia_boobs_color = sanitize_hexcolor(genitalia_boobs_color, 6, TRUE, initial(genitalia_boobs_color))
	genitalia_boobs_color_secondary = sanitize_hexcolor(genitalia_boobs_color_secondary, 6, TRUE, initial(genitalia_boobs_color_secondary))
	genitalia_boobs_emissive = sanitize_character_creator_emissive_list(genitalia_boobs_emissive)
	genitalia_cock = sanitize_inlist_assoc(genitalia_cock, GLOB.possible_cock_sprites, initial(genitalia_cock))
	genitalia_cock_size = sanitize_integer(genitalia_cock_size, 1, 7, initial(genitalia_cock_size))
	genitalia_cock_color = sanitize_hexcolor(genitalia_cock_color, 6, TRUE, initial(genitalia_cock_color))
	genitalia_cock_emissive = sanitize_character_creator_emissive_list(genitalia_cock_emissive)
	genitalia_vagina = sanitize_inlist_assoc(genitalia_vagina, GLOB.possible_vagina_sprites, initial(genitalia_vagina))
	genitalia_vagina_color = sanitize_hexcolor(genitalia_vagina_color, 6, TRUE, initial(genitalia_vagina_color))
	genitalia_vagina_emissive = sanitize_character_creator_emissive_list(genitalia_vagina_emissive)
	genitalia_belly = sanitize_inlist_assoc(genitalia_belly, GLOB.possible_belly_sprites, initial(genitalia_belly))
	genitalia_belly_size = sanitize_integer(genitalia_belly_size, 0, 10, initial(genitalia_belly_size))
	genitalia_belly_color = sanitize_hexcolor(genitalia_belly_color, 6, TRUE, initial(genitalia_belly_color))
	genitalia_belly_emissive = sanitize_character_creator_emissive_list(genitalia_belly_emissive)
	genitalia_testicles = sanitize_inlist_assoc(genitalia_testicles, GLOB.possible_testicle_sprites, initial(genitalia_testicles))
	genitalia_testicles_size = sanitize_integer(genitalia_testicles_size, 0, 8, initial(genitalia_testicles_size))
	genitalia_testicles_color = sanitize_hexcolor(genitalia_testicles_color, 6, TRUE, initial(genitalia_testicles_color))
	genitalia_testicles_color_secondary = sanitize_hexcolor(genitalia_testicles_color_secondary, 6, TRUE, initial(genitalia_testicles_color_secondary))
	genitalia_testicles_emissive = sanitize_character_creator_emissive_list(genitalia_testicles_emissive)
	return TRUE

/datum/preferences/proc/character_appearance_rebuild_is_safe()
	if(!MC_RUNNING())
		return FALSE
	if(SSticker?.current_state == GAME_STATE_STARTUP || SSticker?.current_state == GAME_STATE_FINISHED)
		return FALSE
	return TRUE

/datum/preferences/proc/character_appearance_rebuild_can_defer()
	return SSticker?.current_state != GAME_STATE_FINISHED

/datum/preferences/proc/rebuild_character_appearance_safely(mob/living/carbon/human/character, deferred_attempts = 0)
	if(QDELETED(character))
		return FALSE
	if(!character_appearance_rebuild_is_safe())
		if(character_appearance_rebuild_can_defer() && deferred_attempts < 5)
			addtimer(CALLBACK(src, PROC_REF(rebuild_character_appearance_safely), character, deferred_attempts + 1), 2 SECONDS)
		return TRUE
	try
		character.update_body()
		character.update_hair()
	catch(var/exception/e)
		var/debug_ckey = parent?.ckey || "unknown ckey"
		log_runtime("Character preference icon rebuild failed for [debug_ckey] slot [default_slot] on [character] ([character.type]): [e.name] ([e.file]:[e.line]) prefs=[character_debug_summary()]")
		reset_character_cosmetics_for_fallback(character)
		try
			character.update_body()
			character.update_hair()
		catch(var/exception/fallback_error)
			log_runtime("Fallback character icon rebuild also failed for [debug_ckey] slot [default_slot] on [character] ([character.type]): [fallback_error.name] ([fallback_error.file]:[fallback_error.line])")
	return TRUE

/datum/preferences/proc/reset_character_cosmetics_for_fallback(mob/living/carbon/human/character)
	if(!character)
		return
	character.body_markings = list()
	character.tail = initial(character.tail)
	character.snout = initial(character.snout)
	character.ears = initial(character.ears)
	character.horns = initial(character.horns)
	character.wings = initial(character.wings)
	character.synth_antenna = initial(character.synth_antenna)
	character.fluff = initial(character.fluff)
	character.digitigrade_legs = initial(character.digitigrade_legs)

/datum/preferences/proc/copy_to(mob/living/carbon/human/character, safety = FALSE)
	sanitize_character_appearance_for_render()
	var/datum/species/preference_species = GLOB.all_species[species]
	var/preserve_job_species = character.species?.species_flags & (IS_SYNTHETIC|ROBOTIC_LIMBS)
	var/preserve_synthetic_job_species = character.species?.species_flags & IS_SYNTHETIC
	// Synthetic and robot jobs spawn their exact species before preferences are copied.
	// Preserve that job species so cosmetic species prefs cannot turn one job into the other.
	if(!preserve_job_species)
		if(preference_species)
			character.set_species(species)
		else
			character.set_species("Human")
	sync_synthetic_type_to_species()

	var/new_name
	if(random_name)
		new_name = character.species.random_name(gender)
	else
		new_name = character.species.prefs_name(src)

	if(!good_eyesight)
		ENABLE_BITFIELD(character.disabilities, NEARSIGHTED)

	character.real_name = new_name
	character.name = character.real_name

	character.flavor_text = flavor_text
	character.profile_pic = profile_pic
	character.nsfwprofile_pic = nsfwprofile_pic

	character.med_record = med_record
	character.sec_record = sec_record
	character.gen_record = gen_record
	character.exploit_record = exploit_record

	character.age = age
	character.gender = gender
	character.physique = get_physique()
	character.ethnicity = ethnicity

	character.r_eyes = r_eyes
	character.g_eyes = g_eyes
	character.b_eyes = b_eyes
	character.eye_emissive = eye_emissive

	character.r_hair = r_hair
	character.g_hair = g_hair
	character.b_hair = b_hair
	character.hair_emissive = hair_emissive

	character.r_grad = r_grad
	character.g_grad = g_grad
	character.b_grad = b_grad

	character.r_facial = r_facial
	character.g_facial = g_facial
	character.b_facial = b_facial

	character.h_style = h_style
	character.grad_style= grad_style
	character.f_style = f_style

	character.citizenship = citizenship
	character.blood_type = blood_type
	character.species.blood_color = blood_color
	character.religion = religion

	character.voice = tts_voice
	character.pitch = tts_pitch

	character.moth_wings = moth_wings
	if(preserve_synthetic_job_species && preference_species && !(preference_species.species_flags & IS_SYNTHETIC))
		character.synthetic_appearance_species = preference_species.name
	else
		character.synthetic_appearance_species = initial(character.synthetic_appearance_species)
	character.synthetic_body_base = synthetic_body_base
	character.allow_mismatched_parts = allow_mismatched_parts
	character.allow_emissives = allow_emissives
	character.custom_supersoldier_parts = custom_supersoldier_parts
	character.supersoldier_body_base = supersoldier_body_base
	character.supersoldier_head_base = supersoldier_head_base
	if(species == "Combat Robot" && !allow_mismatched_parts)
		character.robot_body_base = "Combat Robot"
		character.robot_head_base = "Combat Robot"
	else
		character.robot_body_base = robot_body_base
		character.robot_head_base = robot_head_base
	//Tail coloration and accessories
	character.tail = tail
	character.tail_color = tail_color
	character.tail_color_secondary = tail_color_secondary
	character.tail_color_tertiary = tail_color_tertiary
	character.tail_emissive = tail_emissive ? tail_emissive.Copy() : list(FALSE, FALSE, FALSE)
	character.snout = snout
	character.snout_color = snout_color
	character.snout_color_secondary = snout_color_secondary
	character.snout_color_tertiary = snout_color_tertiary
	character.snout_emissive = snout_emissive ? snout_emissive.Copy() : list(FALSE, FALSE, FALSE)
	character.ears = ears
	character.ears_color = ears_color
	character.ears_color_secondary = ears_color_secondary
	character.ears_color_tertiary = ears_color_tertiary
	character.ears_emissive = ears_emissive ? ears_emissive.Copy() : list(FALSE, FALSE, FALSE)
	character.horns = horns
	character.horns_color = horns_color
	character.horns_color_secondary = horns_color_secondary
	character.horns_color_tertiary = horns_color_tertiary
	character.horns_emissive = horns_emissive ? horns_emissive.Copy() : list(FALSE, FALSE, FALSE)
	character.wings = wings
	character.wings_color = wings_color
	character.wings_color_secondary = wings_color_secondary
	character.wings_color_tertiary = wings_color_tertiary
	character.wings_emissive = wings_emissive ? wings_emissive.Copy() : list(FALSE, FALSE, FALSE)
	character.synth_antenna = synth_antenna
	character.synth_antenna_color = synth_antenna_color
	character.synth_antenna_color_secondary = synth_antenna_color_secondary
	character.synth_antenna_color_tertiary = synth_antenna_color_tertiary
	character.synth_antenna_emissive = synth_antenna_emissive ? synth_antenna_emissive.Copy() : list(FALSE, FALSE, FALSE)
	character.fluff = fluff
	character.fluff_color = fluff_color
	character.fluff_color_secondary = fluff_color_secondary
	character.fluff_color_tertiary = fluff_color_tertiary
	character.fluff_emissive = fluff_emissive ? fluff_emissive.Copy() : list(FALSE, FALSE, FALSE)
	character.digitigrade_legs = digitigrade_legs

	character.body_color = body_color
	character.spines = spines
	character.body_markings = body_markings ? body_markings.Copy() : list()

	/*NTF Removal
	character.underwear = underwear
	character.undershirt = undershirt
	*/

	if(character.species.has_genital_selection)
		character.ass = genitalia_ass
		character.ass_size = genitalia_ass_size
		character.ass_color = genitalia_ass_color
		character.ass_emissive = genitalia_ass_emissive ? genitalia_ass_emissive.Copy() : list(FALSE, FALSE, FALSE)
		character.boobs = genitalia_boobs
		character.boobs_size = genitalia_boobs_size
		character.boobs_color = genitalia_boobs_color
		character.boobs_color_secondary = genitalia_boobs_color_secondary
		character.boobs_emissive = genitalia_boobs_emissive ? genitalia_boobs_emissive.Copy() : list(FALSE, FALSE, FALSE)
		character.cock = genitalia_cock
		character.cock_size = genitalia_cock_size
		character.cock_color = genitalia_cock_color
		character.cock_emissive = genitalia_cock_emissive ? genitalia_cock_emissive.Copy() : list(FALSE, FALSE, FALSE)
		character.vagina = genitalia_vagina
		character.vagina_color = genitalia_vagina_color
		character.vagina_emissive = genitalia_vagina_emissive ? genitalia_vagina_emissive.Copy() : list(FALSE, FALSE, FALSE)
		character.belly = genitalia_belly
		character.belly_size = genitalia_belly_size
		character.belly_color = genitalia_belly_color
		character.belly_emissive = genitalia_belly_emissive ? genitalia_belly_emissive.Copy() : list(FALSE, FALSE, FALSE)
		character.testicles = genitalia_testicles
		character.testicles_size = genitalia_testicles_size
		character.testicles_color = genitalia_testicles_color
		character.testicles_color_secondary = genitalia_testicles_color_secondary
		character.testicles_emissive = genitalia_testicles_emissive ? genitalia_testicles_emissive.Copy() : list(FALSE, FALSE, FALSE)

	character.ooc_notes = metadata
	character.ooc_notes_likes = metadata_likes
	character.ooc_notes_dislikes = metadata_dislikes
	character.ooc_notes_maybes = metadata_maybes
	character.ooc_notes_favs = metadata_favs
	character.ooc_notes_style = metadata_ooc_style

	rebuild_character_appearance_safely(character)

///Create a random character. Uses a specified species if set.
/datum/preferences/proc/random_character(datum/species/selected)
	var/datum/species/S
	gender = pick(MALE, FEMALE)
	if(!selected)
		var/speciestype = pick(GLOB.roundstart_species)
		S = GLOB.roundstart_species[speciestype]
	else
		S = GLOB.all_species[selected.name]
	species = S.name
	real_name = S.random_name(gender)
	age = rand(AGE_MIN, AGE_MAX)
	h_style = pick("Crewcut", "Bald", "Short Hair")

///Create a random character of the specified species
/datum/preferences/proc/random_character_set_species(datum/species/selected)
	gender = pick(MALE, FEMALE)
	var/datum/species/S = GLOB.all_species[selected.name]
	species = S.name
	real_name = S.random_name(gender)
	age = rand(AGE_MIN, AGE_MAX)
	h_style = pick("Crewcut", "Bald", "Short Hair")
