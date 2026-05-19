/datum/species/human
	name = "Human"
	unarmed_type = /datum/unarmed_attack/punch
	species_flags = HAS_LIPS|HAS_UNDERWEAR
	count_human = TRUE
	/// Humans use the shared generic limb states instead of the old
	/// ethnicity-specific body sheets. This keeps the player-facing body color
	/// workflow closer to the SPLURT/Skyrat customization model: identity lives
	/// in preferences and cosmetic features, not in alternate human limb files.
	icobase = BODYPART_ICON_HUMAN
	limb_type = SPECIES_LIMB_SPLURT
	splurt_limb_prefix = "human"

	screams = list(MALE = SFX_MALE_SCREAM, FEMALE = SFX_FEMALE_SCREAM)
	paincries = list(MALE = SFX_MALE_PAIN, FEMALE = SFX_FEMALE_PAIN)
	goredcries = list(MALE = SFX_MALE_GORED, FEMALE = SFX_FEMALE_GORED)
	gasps = list(MALE = SFX_MALE_GASP, FEMALE = SFX_FEMALE_GASP)
	chokes = list(FEMALE = SFX_FEMALE_CHOKE)
	coughs = list(MALE = SFX_MALE_COUGH, FEMALE = SFX_FEMALE_COUGH)
	groans = list(FEMALE = SFX_FEMALE_GROAN)
	chokes = list(FEMALE = SFX_FEMALE_CHOKE)
	sexymoanlights = list(FEMALE = SFX_FEMALE_SEXYMOANLIGHT)
	sexymoanhvys = list(FEMALE = SFX_FEMALE_SEXYMOANHVY)
	burstscreams = list(MALE = SFX_MALE_PREBURST, FEMALE = SFX_FEMALE_PREBURST)
	warcries = list(MALE = SFX_MALE_WARCRY, FEMALE = SFX_FEMALE_WARCRY)
	special_death_message = "<big>You have perished.</big><br><small>But it is not the end of you yet... if you still have your body with your head still attached, wait until somebody can resurrect you...</small>"
	joinable_roundstart = TRUE
	has_genital_selection = TRUE
	stamina_mod = 0.8 //more endurance since they get nothing
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	Humans and all 'humanoids' are the most common species on Earth, and the most common sapient species in the known universe.<br /><br /> \
	Humans have colonized planets and space stations before the great war.<br /><br /> \
	They are a diverse and complex species, with a wide range of cultures, beliefs, and values. They sure shown their differences when destroying the world and each other.<br /><br /><br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	Humans are a bipedal species with a wide range of skin tones, hair colors, and eye colors.<br /><br /> \
	They are known for their adaptability and resilience, as well as their creativity and ingenuity.<br /><br /> \
	They have a complex nervous system and a highly developed brain, which allows them to think, reason, and communicate in sophisticated ways.<br /><br /><br /><br /> \
	They may not be faster, stronger or more durable than other species but humans possess magnificent endurance and stamina, they are able to keep going when others are long exhausted. \
	<b>Psychology</b>:<br /><br /> \
	They are capable of great compassion and empathy, as well as great cruelty and aggression. They are the baseline for most measurement.<br /><br />"

/datum/species/human/prefs_name(datum/preferences/prefs)
	. = ..()
	if(CONFIG_GET(flag/humans_need_surnames))
		var/firstspace = findtext(., " ")
		if(!firstspace || firstspace == length(.))
			. += " " + pick(SSstrings.get_list_from_file("names/last_name"))
