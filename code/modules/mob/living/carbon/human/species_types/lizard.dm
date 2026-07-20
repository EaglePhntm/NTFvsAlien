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
	burn_mod = 0.9 //weak ass ability so get 0.9 than 0.95
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	Reptilians are much like any other humanoid species, but with scaly skin, tails, and a variety of other reptilian features.<br /><br /> \
	They are a diverse and adaptable species, found in a wide range of environments across the planet.<br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	Reptilians have scaly skin that can come in a variety of colors and patterns, often used for camouflage.<br /><br /> \
	They have tails that can be used for balance, communication, and in some cases, as a defense mechanism.<br /><br /> \
	They have a unique circulatory system that allows them to regulate their body temperature and survive in extreme environments.<br /><br /> \
	<b>Psychology</b>:<br /><br /> \
	Reptilians are often solitary and territorial, preferring to live alone or in small family groups.<br /><br />"
	inherent_actions = list(/datum/action/ability/tailsweep)

/datum/species/lizard/prefs_name(datum/preferences/prefs)
	. = ..()
	if(CONFIG_GET(flag/humans_need_surnames))
		var/firstspace = findtext(., " ")
		if(!firstspace || firstspace == length(.))
			. += " " + pick(SSstrings.get_list_from_file("names/last_name"))

/datum/action/ability/tailsweep
	name = "Tailsweep"
	desc = "Spin around, knocking everything next to you to the ground briefly."
	action_icon_state = "tail_sweep"
	action_icon = 'icons/Xeno/actions/defender.dmi'
	cooldown_duration = 1.5 MINUTES
	use_state_flags = ABILITY_USE_STAGGERED

/datum/action/ability/tailsweep/can_use_action(silent, override_flags, selecting)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner)		return FALSE

/datum/action/ability/tailsweep/action_activate()
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner)		return FALSE
	carbon_owner.visible_message(span_xenowarning("\The [carbon_owner] sweeps [carbon_owner.p_their()] tail in a wide circle!"), \
	span_xenowarning("You sweep your tail in a wide circle!"))
	playsound(carbon_owner.loc, 'ntf_modular/sound/effects/dt-spin.ogg', 25)

	carbon_owner.add_filter("defender_tail_sweep", 2, gauss_blur_filter(1)) //Add cool SFX
	carbon_owner.spin(4, 1)
	carbon_owner.AddComponent(/datum/component/throw_parry, DEFENDER_REFLECT_TIME)
	playsound(carbon_owner,pick('sound/effects/alien/tail_swipe1.ogg','sound/effects/alien/tail_swipe2.ogg','sound/effects/alien/tail_swipe3.ogg'), 25, 1) //Sound effects

	var/sweep_range = 1
	var/list/L = orange(sweep_range, carbon_owner)		// Not actually the fruit

	for (var/mob/living/carbon/H in L)
		if(H == carbon_owner)
			continue
		if(H.stat == DEAD || !carbon_owner.Adjacent(H))
			continue
		if(HAS_TRAIT(H, TRAIT_HAULED) || (H.status_flags & (INCORPOREAL|GODMODE)))
			continue
		H.add_filter("defender_tail_sweep", 2, gauss_blur_filter(1)) //Add cool SFX; motion blur
		addtimer(CALLBACK(H, TYPE_PROC_REF(/datum, remove_filter), "defender_tail_sweep"), 0.5 SECONDS) //Remove cool SFX
		H.Paralyze(0.5 SECONDS)
		shake_camera(H, 2, 1)

		to_chat(H, span_warning("You are struck by [carbon_owner]'s tail sweep!"))
		playsound(H,'sound/weapons/alien_claw_block.ogg', 50, 1)

	addtimer(CALLBACK(carbon_owner, TYPE_PROC_REF(/datum, remove_filter), "defender_tail_sweep"), 0.5 SECONDS) //Remove cool SFX
	succeed_activate()
	add_cooldown()
