GLOBAL_LIST_INIT(possible_cock_sprites, list(
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
))

GLOBAL_LIST_INIT(possible_cock_sprite_names, list(
	null = "Default",
	"human" = "Human",
	"knotted" = "Knotted",
	"flared" = "Flared",
	"barbknot" = "Barbed Knot",
	"tapered" = "Tapered",
	"tentacle" = "Tentacle",
	"hemi" = "Hemi",
	"hemiknot" = "Knotted Hemi",
	"nondescript" = "Nondescript",
))

/proc/cock_style_supports_storage(cock_style)
	return cock_style && cock_style != "human"

GLOBAL_LIST_INIT(possible_ass_sprites, list(
	"None" = null,
	"Pair" = "pair",
))

GLOBAL_LIST_INIT(possible_ass_sprite_names, list(
	null = "None",
	"pair" = "Pair",
))

GLOBAL_LIST_INIT(possible_boob_sprites, list(
	"None" = null,
	"Pair" = "pair",
	"Quad" = "quad",
	"Sextuple" = "sextuple",
))

GLOBAL_LIST_INIT(possible_boob_sprite_names, list(
	null = "None",
	"pair" = "Pair",
	"quad" = "Quad",
	"sextuple" = "Sextuple",
))

GLOBAL_LIST_INIT(possible_vagina_sprites, list(
	"Default" = null,
	"Human" = "human",
	"Gaping" = "gaping",
	"Tentacle" = "tentacle",
	"Dentata" = "dentata",
	"Hairy" = "hairy",
	"Extra Hairy" = "extrahairy",
	"Furred" = "furred",
	"Spade" = "spade",
	"Cloaca" = "cloaca",
	"Taur" = "taur",
))

GLOBAL_LIST_INIT(possible_vagina_sprite_names, list(
	null = "Default",
	"human" = "Human",
	"gaping" = "Gaping",
	"tentacle" = "Tentacle",
	"dentata" = "Dentata",
	"hairy" = "Hairy",
	"extrahairy" = "Extra Hairy",
	"furred" = "Furred",
	"spade" = "Spade",
	"cloaca" = "Cloaca",
	"taur" = "Taur",
))

GLOBAL_LIST_INIT(possible_belly_sprites, list(
	"None" = null,
	"Belly" = "pair",
))

GLOBAL_LIST_INIT(possible_belly_sprite_names, list(
	null = "None",
	"pair" = "Belly",
))

GLOBAL_LIST_INIT(possible_testicle_sprites, list(
	"None" = null,
	"Pair" = "pair",
	"Internal" = "internal",
	"Sheathed Pair" = "sheath",
))

GLOBAL_LIST_INIT(possible_testicle_sprite_names, list(
	null = "None",
	"pair" = "Pair",
	"internal" = "Internal",
	"sheath" = "Sheathed Pair",
))

GLOBAL_LIST_INIT(possible_cock_storage, list(
	"None" = null,
	"Sheath" = COCK_STORAGE_SHEATH,
	"Slit" = COCK_STORAGE_SLIT,
))

GLOBAL_LIST_INIT(possible_cock_storage_names, list(
	null = "None",
	COCK_STORAGE_SHEATH = "Sheath",
	COCK_STORAGE_SLIT = "Slit",
))

GLOBAL_LIST_INIT(possible_cock_states, list(
	"Stored" = COCK_STATE_STORED,
	"Flaccid" = COCK_STATE_FLACCID,
	"Partial" = COCK_STATE_PARTIAL,
	"Erect" = COCK_STATE_ERECT,
))

GLOBAL_LIST_INIT(possible_cock_state_names, list(
	COCK_STATE_STORED = "Stored",
	COCK_STATE_FLACCID = "Flaccid",
	COCK_STATE_PARTIAL = "Partial",
	COCK_STATE_ERECT = "Erect",
))

GLOBAL_LIST_INIT(breast_size_to_number, list(
	"Flat" = 0,
	"A" = 1,
	"B" = 2,
	"C" = 3,
	"D" = 4,
	"E" = 5,
	"F" = 6,
	"G" = 7,
	"H" = 8,
	"I" = 9,
	"J" = 10,
	"K" = 11,
	"L" = 12,
	"M" = 13,
	"N" = 14,
	"O" = 15,
	"P" = 16,
	"R" = 17,
	"S" = 18,
	"T" = 19,
))

// Keep number keys as text, matching SPLURT's translation tables. BYOND lists
// are 1-indexed internally, so a numeric 0 key can runtime during global init.
GLOBAL_LIST_INIT(breast_number_to_size, list(
	"0" = "Flat",
	"1" = "A",
	"2" = "B",
	"3" = "C",
	"4" = "D",
	"5" = "E",
	"6" = "F",
	"7" = "G",
	"8" = "H",
	"9" = "I",
	"10" = "J",
	"11" = "K",
	"12" = "L",
	"13" = "M",
	"14" = "N",
	"15" = "O",
	"16" = "P",
	"17" = "R",
	"18" = "S",
	"19" = "T",
))

/datum/genital_menu
	/// The human we are attached to
	var/mob/living/carbon/human/human

/datum/genital_menu/New(mob/living/carbon/human/human)
	. = ..()
	src.human = human

/datum/genital_menu/Destroy(force, ...)
	human = null
	return ..()

/datum/genital_menu/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "GenitalMenu")
		ui.open()

/datum/genital_menu/ui_state(mob/user)
	return GLOB.genital_menu_state

/datum/genital_menu/ui_data(mob/user)
	var/list/data = list(
		"cockState" = GLOB.possible_cock_sprite_names[human.cock],
		"cockStorage" = GLOB.possible_cock_storage_names[human.cock_storage],
		"cockDisplayState" = GLOB.possible_cock_state_names[human.cock_state],
		"assState" = GLOB.possible_ass_sprite_names[human.ass],
		"boobState" = GLOB.possible_boob_sprite_names[human.boobs],
		"vaginaState" = GLOB.possible_vagina_sprite_names[human.vagina],
		"bellyState" = GLOB.possible_belly_sprite_names[human.belly],
		"testicleState" = GLOB.possible_testicle_sprite_names[human.testicles],
		"assSize" = human.ass_size,
		"boobSize" = GLOB.breast_number_to_size["[human.boobs_size]"] || GLOB.breast_number_to_size["3"],
		"cockSize" = human.cock_size,
		"bellySize" = human.belly_size,
		"testicleSize" = human.testicles_size,
	)
	data["possibleCockStates"] = list()
	for(var/entry in GLOB.possible_cock_sprites)
		data["possibleCockStates"] += entry

	data["possibleCockStorage"] = list()
	for(var/entry in GLOB.possible_cock_storage)
		data["possibleCockStorage"] += entry

	data["possibleCockDisplayStates"] = list()
	for(var/entry in GLOB.possible_cock_states)
		data["possibleCockDisplayStates"] += entry

	data["possibleAssStates"] = list()
	for(var/entry in GLOB.possible_ass_sprites)
		data["possibleAssStates"] += entry

	data["possibleBoobStates"] = list()
	for(var/entry in GLOB.possible_boob_sprites)
		data["possibleBoobStates"] += entry

	data["possibleVaginaStates"] = list()
	for(var/entry in GLOB.possible_vagina_sprites)
		data["possibleVaginaStates"] += entry

	data["possibleBellyStates"] = list()
	for(var/entry in GLOB.possible_belly_sprites)
		data["possibleBellyStates"] += entry

	data["possibleTesticleStates"] = list()
	for(var/entry in GLOB.possible_testicle_sprites)
		data["possibleTesticleStates"] += entry

	data["possibleBoobSizes"] = list()
	for(var/entry in GLOB.breast_size_to_number)
		data["possibleBoobSizes"] += entry

	return data

/datum/genital_menu/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	if(!human)
		return

	switch(action)
		if("changeCock")
			var/new_cock = params["newState"]
			if(!(new_cock in GLOB.possible_cock_sprites))
				return TRUE

			human.cock = GLOB.possible_cock_sprites[new_cock]
			if(!cock_style_supports_storage(human.cock))
				human.cock_storage = null
				if(human.cock_state in list(COCK_STATE_STORED, COCK_STATE_PARTIAL))
					human.cock_state = COCK_STATE_FLACCID
			human.client?.prefs?.genitalia_cock = human.cock
			human.client?.prefs?.genitalia_cock_storage = human.cock_storage
			human.update_genitals()
			return TRUE

		if("changeCockStorage")
			if(!cock_style_supports_storage(human.cock))
				return TRUE
			var/new_storage = params["newState"]
			if(!(new_storage in GLOB.possible_cock_storage))
				return TRUE

			human.cock_storage = GLOB.possible_cock_storage[new_storage]
			if(!human.cock_storage && (human.cock_state in list(COCK_STATE_STORED, COCK_STATE_PARTIAL)))
				human.cock_state = COCK_STATE_FLACCID
			human.client?.prefs?.genitalia_cock_storage = human.cock_storage
			human.update_genitals()
			return TRUE

		if("changeCockDisplayState")
			var/new_state = params["newState"]
			if(!(new_state in GLOB.possible_cock_states))
				return TRUE

			human.cock_state = GLOB.possible_cock_states[new_state]
			if((human.cock_state in list(COCK_STATE_STORED, COCK_STATE_PARTIAL)) && !human.cock_storage)
				human.cock_state = COCK_STATE_FLACCID
			human.update_genitals()
			return TRUE

		if("changeAss")
			var/new_ass = params["newState"]
			if(!(new_ass in GLOB.possible_ass_sprites))
				return TRUE

			human.ass = GLOB.possible_ass_sprites[new_ass]
			human.client?.prefs?.genitalia_ass = human.ass
			human.update_genitals()
			return TRUE

		if("changeBoobs")
			var/new_boobs = params["newState"]
			if(!(new_boobs in GLOB.possible_boob_sprites))
				return TRUE

			human.boobs = GLOB.possible_boob_sprites[new_boobs]
			human.client?.prefs?.genitalia_boobs = human.boobs
			human.update_genitals()
			return TRUE

		if("changeVagina")
			var/new_vagina = params["newState"]
			if(!(new_vagina in GLOB.possible_vagina_sprites))
				return TRUE

			human.vagina = GLOB.possible_vagina_sprites[new_vagina]
			human.client?.prefs?.genitalia_vagina = human.vagina
			human.update_genitals()
			return TRUE

		if("changeBelly")
			var/new_belly = params["newState"]
			if(!(new_belly in GLOB.possible_belly_sprites))
				return TRUE

			human.belly = GLOB.possible_belly_sprites[new_belly]
			human.client?.prefs?.genitalia_belly = human.belly
			human.update_genitals()
			return TRUE

		if("changeTesticles")
			var/new_testicles = params["newState"]
			if(!(new_testicles in GLOB.possible_testicle_sprites))
				return TRUE

			human.testicles = GLOB.possible_testicle_sprites[new_testicles]
			human.client?.prefs?.genitalia_testicles = human.testicles
			human.update_genitals()
			return TRUE

		if("changeSize")
			var/size_field = params["field"]
			switch(size_field)
				if("ass")
					human.ass_size = sanitize_integer(params["newSize"], 1, 8, initial(human.ass_size))
					human.client?.prefs?.genitalia_ass_size = human.ass_size
				if("boobs")
					var/new_boob_size = params["newSize"]
					if(!(new_boob_size in GLOB.breast_size_to_number))
						return TRUE
					human.boobs_size = GLOB.breast_size_to_number[new_boob_size]
					human.client?.prefs?.genitalia_boobs_size = human.boobs_size
				if("cock")
					human.cock_size = sanitize_integer(params["newSize"], 1, 7, initial(human.cock_size))
					human.client?.prefs?.genitalia_cock_size = human.cock_size
				if("belly")
					human.belly_size = sanitize_integer(params["newSize"], 0, 10, initial(human.belly_size))
					human.client?.prefs?.genitalia_belly_size = human.belly_size
				if("testicles")
					human.testicles_size = sanitize_integer(params["newSize"], 0, 8, initial(human.testicles_size))
					human.client?.prefs?.genitalia_testicles_size = human.testicles_size
				else
					return TRUE
			human.update_genitals()
			return TRUE

		if("reset")
			human.boobs = null
			human.ass = null
			human.cock = null
			human.cock_storage = null
			human.cock_state = initial(human.cock_state)
			human.vagina = null
			human.belly = null
			human.testicles = null
			human.boobs_size = initial(human.boobs_size)
			human.ass_size = initial(human.ass_size)
			human.cock_size = initial(human.cock_size)
			human.belly_size = initial(human.belly_size)
			human.testicles_size = initial(human.testicles_size)
			human.client?.prefs?.genitalia_boobs = null
			human.client?.prefs?.genitalia_ass = null
			human.client?.prefs?.genitalia_cock = null
			human.client?.prefs?.genitalia_cock_storage = null
			human.client?.prefs?.genitalia_vagina = null
			human.client?.prefs?.genitalia_belly = null
			human.client?.prefs?.genitalia_testicles = null
			human.client?.prefs?.genitalia_boobs_size = human.boobs_size
			human.client?.prefs?.genitalia_ass_size = human.ass_size
			human.client?.prefs?.genitalia_cock_size = human.cock_size
			human.client?.prefs?.genitalia_belly_size = human.belly_size
			human.client?.prefs?.genitalia_testicles_size = human.testicles_size
			human.update_genitals()
			return TRUE
