/datum/species/lizard
	name = "Lizard"
	icobase = 'icons/mob/species/lizard/bodyparts.dmi'
	unarmed_type = /datum/unarmed_attack/punch
	species_flags = HAS_LIPS|HAS_UNDERWEAR
	count_human = TRUE
	limb_type = SPECIES_LIMB_LIZARD

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

/datum/species/lizard/prefs_name(datum/preferences/prefs)
	. = ..()
	if(CONFIG_GET(flag/humans_need_surnames))
		var/firstspace = findtext(., " ")
		if(!firstspace || firstspace == length(.))
			. += " " + pick(SSstrings.get_list_from_file("names/last_name"))

/datum/species/lizard/proc/update_lizard_tail(mob/living/carbon/human/H)
	H.remove_overlay(LIZARD_TAIL_LAYER)
	H.remove_underlay(LIZARD_TAIL_BEHIND_LAYER)

	if(!(H.species.name == "Lizard" || H.allow_mismatched_parts))
		return

	var/datum/sprite_accessory/lizard_tail/tail = GLOB.lizard_tails_list[H.lizard_tail]
	if(!tail || !tail.icon_state)
		return

	H.overlays_standing[LIZARD_TAIL_LAYER] = image(
		tail.icon,
		icon_state = "m_tail_lizard_[tail.icon_state]_FRONT"
	)

	H.underlays_standing[LIZARD_TAIL_BEHIND_LAYER] = image(
		tail.icon,
		icon_state = "m_tail_lizard_[tail.icon_state]_BEHIND"
	)

	H.apply_overlay(LIZARD_TAIL_LAYER)
	H.apply_underlay(LIZARD_TAIL_BEHIND_LAYER)

/datum/species/lizard/update_body(mob/living/carbon/human/H)
	update_lizard_tail(H)
