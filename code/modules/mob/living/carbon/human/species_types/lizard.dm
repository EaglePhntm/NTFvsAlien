/datum/species/lizard
	name = "Reptilian"
	icobase = BODYPART_ICON_LIZARD
	// Lizards intentionally use claw unarmed attacks: slash sounds, claw VFX,
	// and sharp/edge damage instead of the human punch.
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR
	count_human = TRUE
	limb_type = SPECIES_LIMB_SPLURT
	splurt_limb_prefix = "lizard"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")

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
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	Reptilians are much like any other humanoid species, but with scaly skin, tails, and a variety of other reptilian features.<br /><br /> \
	They are a diverse and adaptable species, found in a wide range of environments across the planet.<br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	Reptilians have scaly skin that can come in a variety of colors and patterns, often used for camouflage.<br /><br /> \
	They have tails that can be used for balance, communication, and in some cases, as a defense mechanism.<br /><br /> \
	They have a unique circulatory system that allows them to regulate their body temperature and survive in extreme environments.<br /><br /> \
	<b>Psychology</b>:<br /><br /> \
	Reptilians are often solitary and territorial, preferring to live alone or in small family groups.<br /><br />"

/datum/species/lizard/prefs_name(datum/preferences/prefs)
	. = ..()
	if(CONFIG_GET(flag/humans_need_surnames))
		var/firstspace = findtext(., " ")
		if(!firstspace || firstspace == length(.))
			. += " " + pick(SSstrings.get_list_from_file("names/last_name"))
