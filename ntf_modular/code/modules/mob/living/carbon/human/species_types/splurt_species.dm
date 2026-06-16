/datum/species/human/vatborn
	joinable_roundstart = FALSE

/datum/species/human/prototype_supersoldier
	joinable_roundstart = TRUE

// Roundstart SPLURT species below are not purely visual.
// Their claw unarmed attack uses slash sounds, claw VFX, and sharp/edge damage.

/datum/species/akula
	name = "Akula"
	icobase = BODYPART_ICON_AKULA
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = TRUE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "akula"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)
	burn_mod = 0.9
	taste_sensitivity = TASTE_SENSITIVE

	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	The Akula are a species of humanoids that were created by the Syndicate in some old Novamed slums laboratory as a failed attempt to create a inter-continental shock troop or infiltrator.<br /><br /> \
	First Akulas escaped their captors and fled to the wilderness and to oceans, where they lived in small packs as hunters and scavengers, until they were eventually found by Novamed marine researchers and brought into society as proper citizens in turn for loyalty.<br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	Akulas have a layer of blubber under their skin that makes them more resistant to cold and heat, They also have sharper claws and teeth than normal humans, They are also very sensitive to taste, able to distinguish between different flavors with great precision.<br /><br /> \
	They have shark-like features, which lets them swim efficiently in water.<br /><br /><br /><br /> \
	<b>Psychology</b>:<br /><br /> \
	Akulas are a proud and fierce species, they have a strong sense of loyalty to their pack and to those they consider family. They can be aggressive and territorial, but they are also capable of great compassion and empathy towards those they care about.<br /><br />"
	liquid_slowdown = 0.7 //faster than xenos

/datum/species/anthro
	name = "Anthro"
	icobase = BODYPART_ICON_MAMMAL
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = TRUE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "mammal"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)
	stamina_mod = 0.95
	slowdown = -1.05
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	Anthros is a general term for all animallike humanoids, they are not a specific species but rather a collection of different species that share similar traits, they can be found in all parts of the world and have a wide range of cultures and societies.<br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	Anthros have a wide range of physical traits, depending on their specific species, but they all share some common traits such as fur, tails, and animal-like ears. They are generally similiar to humans, not as enduring but slightly more agile.<br /><br /> \
	<b>Psychology</b>:<br /><br /> \
	Anthros are a diverse group of species, with a wide range of cultures and societies.<br /><br />"
	inherent_actions = list(/datum/action/ability/predator_stance)

/datum/action/ability/predator_stance
	name = "Predator Stance"
	action_icon = 'icons/Xeno/actions/queen.dmi'
	action_icon_state = "screech"
	desc = "You will listen in and start noticing motion in the distance for about 2 minutes. this gives you adrenaline and extra movement speed."
	cooldown_duration = 4 MINUTES
	use_state_flags = ABILITY_USE_BUCKLED|ABILITY_USE_BUSY|ABILITY_USE_LYING|ABILITY_USE_NOTTURF
	var/obj/item/attachable/motiondetector/natural/sensor

/datum/action/ability/predator_stance/can_use_action(silent, override_flags, selecting)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner)		return FALSE

/datum/action/ability/predator_stance/action_activate()
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner)		return FALSE

	sensor = new /obj/item/attachable/motiondetector/natural(owner.contents)
	sensor.activate(carbon_owner)
	carbon_owner.reagents.add_reagent(/datum/reagent/medicine/adrenaline, 6, no_overdose = TRUE)
	carbon_owner.reagents.add_reagent(/datum/reagent/medicine/regen, 5, no_overdose = TRUE)
	playsound(carbon_owner.loc, 'ntf_modular/sound/effects/dt-sonar.ogg', 50)
	carbon_owner.emote("me", 1, "enters a focused state.")
	owner.add_movespeed_modifier("[type]", TRUE, 0, NONE, TRUE, -0.2)
	addtimer(CALLBACK(src, PROC_REF(predator_stance_deactivate)), 120 SECONDS)
	succeed_activate()
	add_cooldown()

/datum/action/ability/predator_stance/proc/predator_stance_deactivate()
	if(QDELETED(owner))
		return
	var/mob/living/carbon/carbon_owner = owner
	sensor.clean_blips()
	qdel(sensor)
	carbon_owner.remove_movespeed_modifier("[type]", TRUE)
	to_chat(carbon_owner, span_danger("You lose your focus."))

/datum/species/aquatic
	name = "Aquatic"
	icobase = BODYPART_ICON_AQUATIC
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = TRUE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "aquatic"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)
	burn_mod = 0.95
	liquid_slowdown = 0.7 //faster than xenos
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	Like Anthros, this is a general term for all water-dwelling humanoids, they are not a specific species but rather a collection of different species that share similar traits, they can be found in all parts of the world and have a wide range of cultures and societies.<br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	Aquatics have a wide range of physical traits, depending on their specific species, but they all share some common traits such as gills, webbed hands and feet, and fish-like tails. They are generally similar to humans, not as enduring but slightly more agile in water.<br /><br /> \
	<b>Psychology</b>:<br /><br /> \
	Aquatics are a diverse group of species, with a wide range of cultures and societies.<br /><br />"

/datum/species/insectoid
	name = "Insectoid"
	icobase = BODYPART_ICON_INSECT
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = TRUE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "insect"
	brute_mod = 0.95
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	Insectoids are a fascinating species known for their insect-like characteristics and unique biology. They possess exoskeletons, multiple limbs, and often have specialized appendages for various tasks.<br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	Insectoids have a hard exoskeleton that provides protection and support for their bodies from brute damage. Their sensory organs are often highly developed, allowing them to navigate their environment with precision.<br /><br /> \
	<b>Psychology</b>:<br /><br /> \
	Insectoids are often highly social creatures, living in colonies or hives with complex hierarchies and division of labor. They communicate through a variety of methods, including pheromones, sounds, and body language. They are sometimes subject to a hive mind...<br /><br />"
	inherent_actions = list(/datum/action/ability/pheromones)

/datum/action/ability/pheromones
	name = "Pheromones"
	action_icon_state = "recovery"
	desc = "You will release selected pheromones to nearby allies and yourself, recovery applies medicine, warding applies hold order, frenzy applies move orders and restores stamina. right click to choose type."
	cooldown_duration = 4 MINUTES
	use_state_flags = ABILITY_USE_BUCKLED|ABILITY_USE_BUSY|ABILITY_USE_HANDCUFFED|ABILITY_USE_STAGGERED|ABILITY_USE_NOTTURF

/datum/action/ability/pheromones/can_use_action(silent, override_flags, selecting)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner)		return FALSE

/datum/action/ability/pheromones/action_activate()
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner)		return FALSE

	var/phero_choice = show_radial_menu(owner, owner, GLOB.pheromone_images_list, radius = 35)
	if(!phero_choice)
		return fail_activate()

	to_chat(carbon_owner, span_notice("You start to emit pheromones!"))
	carbon_owner.do_jitter_animation(1000)

	carbon_owner.emote("me", 1, "vibrates for a moment.")
	playsound(carbon_owner.loc, 'ntf_modular/sound/effects/dt-pendant.ogg', 50)

	switch(phero_choice)
		if(AURA_XENO_WARDING)
			carbon_owner.add_emitted_auras(src, AURA_HUMAN_HOLD)
			addtimer(CALLBACK(src, PROC_REF(end_auras)), 20 SECONDS)
		if(AURA_XENO_FRENZY)
			carbon_owner.add_emitted_auras(src, AURA_HUMAN_MOVE)
			addtimer(CALLBACK(src, PROC_REF(end_auras)), 20 SECONDS)

	for(var/mob/living/affected_mob in cheap_get_living_near(carbon_owner, 4))
		if(carbon_owner.get_iff_signal() != affected_mob.get_iff_signal())
			continue
		if(affected_mob.stat || affected_mob == carbon_owner) //We don't care about the dead/unconsious
			continue
		to_chat(affected_mob, span_notice("You are affected by [carbon_owner]'s [phero_choice] pheromones."))
		switch(phero_choice)
			if(AURA_XENO_RECOVERY)
				affected_mob.reagents.add_reagent(/datum/reagent/medicine/regen, 15, no_overdose = TRUE)
				affected_mob.adjustBruteLoss(-affected_mob.getBruteLoss(TRUE) * 0.30)
				affected_mob.adjustFireLoss(-affected_mob.getFireLoss(TRUE) * 0.30)
			if(AURA_XENO_WARDING)
				affected_mob.reagents.add_reagent(/datum/reagent/medicine/tramadol, 5, no_overdose = TRUE)
				affected_mob.reagents.add_reagent(/datum/reagent/medicine/oxycodone, 5, no_overdose = TRUE)
			if(AURA_XENO_FRENZY)
				affected_mob.reagents.add_reagent(/datum/reagent/medicine/adrenaline, 5, no_overdose = TRUE)
				affected_mob.setStaminaLoss(-affected_mob.max_stamina)

	succeed_activate()
	add_cooldown()

/datum/action/ability/pheromones/proc/end_auras()
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner)		return FALSE
	carbon_owner.remove_emitted_auras(src, AURA_HUMAN_HOLD)
	carbon_owner.remove_emitted_auras(src, AURA_HUMAN_MOVE)
	to_chat(carbon_owner, span_notice("You stop emitting pheromones."))

/datum/species/skrell
	name = "Skrell"
	icobase = BODYPART_ICON_SKRELL
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = TRUE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "skrell"
	stamina_mod = 0.9
	burn_mod = 0.9
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	<b>Psychology</b>:<br /><br />"
	liquid_slowdown = 0.8
	taste_sensitivity = TASTE_SENSITIVE


// Disabled SPLURT species placeholders keep the type paths and sprite wiring ready for later ports.
// Do not enable these until their body sprites, mechanics, and preference defaults are finished.

/datum/species/humanoid
	name = "Humanoid"
	icobase = BODYPART_ICON_HUMAN
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = FALSE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "human"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)

/datum/species/podperson
	name = "Podperson"
	icobase = BODYPART_ICON_HUMAN
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = FALSE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "human"
	flesh_color = "#7cc969"
	base_color = "#7cc969"

/datum/species/mushperson
	name = "Mushperson"
	icobase = BODYPART_ICON_HUMAN
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = FALSE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "human"
	flesh_color = "#d2c5bd"

/datum/species/xenohybrid
	name = "Xenomorph Hybrid"
	icobase = BODYPART_ICON_XENO
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = FALSE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "xenohybrid"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)

/datum/species/tajaran
	name = "Tajaran"
	icobase = BODYPART_ICON_MAMMAL
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = FALSE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "mammal"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)

/datum/species/vulpkanin
	name = "Vulpkanin"
	icobase = BODYPART_ICON_MAMMAL
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = FALSE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "mammal"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)


/datum/species/teshari
	name = "Teshari"
	icobase = BODYPART_ICON_TESHARI
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = FALSE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "teshari"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)

/datum/species/vox
	name = "Vox Primalis"
	icobase = BODYPART_ICON_VOX
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = FALSE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
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
	splurt_limb_prefix = "vox"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)
