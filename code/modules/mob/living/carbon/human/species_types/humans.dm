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
	stamina_mod = 0.9
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

	inherent_actions = list(/datum/action/ability/indominable)

/datum/species/human/prefs_name(datum/preferences/prefs)
	. = ..()
	if(CONFIG_GET(flag/humans_need_surnames))
		var/firstspace = findtext(., " ")
		if(!firstspace || firstspace == length(.))
			. += " " + pick(SSstrings.get_list_from_file("names/last_name"))

/datum/action/ability/indominable
	name = "Indominable Spirit"
	action_icon_state = "warding"
	desc = "Using your indominable human spirit, you are able to ignore pain, stagger and regenerate stamina faster."
	cooldown_duration = 2.5 MINUTES
	use_state_flags = ABILITY_USE_BUCKLED|ABILITY_USE_BUSY|ABILITY_USE_STAGGERED|ABILITY_USE_NOTTURF

/datum/action/ability/indominable/can_use_action(silent, override_flags, selecting)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner)		return FALSE

/datum/action/ability/indominable/action_activate()
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner)		return FALSE
	carbon_owner.reagents.add_reagent(/datum/reagent/medicine/oxycodone, 5, no_overdose = TRUE)
	playsound(carbon_owner.loc, 'ntf_modular/sound/effects/ut-boost.ogg', 50)
	carbon_owner.emote("me", 1, "takes a deep breath between gritted teeth.")
	carbon_owner.do_jitter_animation(1000)

	ADD_TRAIT(carbon_owner, TRAIT_PAIN_IMMUNE, "[type]")
	ADD_TRAIT(carbon_owner, TRAIT_STAGGERIMMUNE, "[type]")

	carbon_owner.add_stamina_regen_modifier("indominable", 0.8)
	carbon_owner.add_filter("indominable_outline", 5, outline_filter(1, COLOR_CYAN)) //Set our cool aura; also confirmation we have the buff
	addtimer(CALLBACK(src, PROC_REF(indominable_deactivate)), 15 SECONDS)

	succeed_activate()
	add_cooldown()

/datum/action/ability/indominable/proc/indominable_deactivate()
	if(QDELETED(owner))
		return
	var/mob/living/carbon/carbon_owner = owner
	carbon_owner.do_jitter_animation(1000)
	carbon_owner.remove_stamina_regen_modifier("indominable")
	owner.remove_filter("indominable_outline")
	REMOVE_TRAIT(owner, TRAIT_PAIN_IMMUNE, "[type]")
	REMOVE_TRAIT(owner, TRAIT_STAGGERIMMUNE, "[type]")
