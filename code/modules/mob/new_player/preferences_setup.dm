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
	screen_main?.update_body()


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


/datum/preferences/proc/copy_to(mob/living/carbon/human/character, safety = FALSE)
	if(species && GLOB.all_species[species])
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

	character.update_body()
	character.update_hair()

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
