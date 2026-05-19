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
	burn_mod = 0.85
	slowdown = -0.95
	taste_sensitivity = TASTE_SENSITIVE

	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	The Akula are a species of humanoids that were created by the Syndicate in some old Novamed slums laboratory as a failed attempt to create a inter-continental shock troop or infiltrator.<br /><br /> \
	First Akulas escaped their captors and fled to the wilderness and to oceans, where they lived in small packs as hunters and scavengers, until they were eventually found by Novamed marine researchers and brought into society as proper citizens in turn for loyalty.<br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	Akulas have a layer of blubber under their skin that makes them more resistant to cold and heat, They also have sharper claws and teeth than normal humans, They are also very sensitive to taste, able to distinguish between different flavors with great precision.<br /><br /> \
	They have shark-like features, which lets them swim efficiently in water.<br /><br /><br /><br /> \
	<b>Psychology</b>:<br /><br /> \
	Akulas are a proud and fierce species, they have a strong sense of loyalty to their pack and to those they consider family. They can be aggressive and territorial, but they are also capable of great compassion and empathy towards those they care about.<br /><br />"
	liquid_slowdown = 0.95 //faster than xenos

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
	stamina_mod = 0.9
	slowdown = -1.1
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	Anthros is a general term for all animallike humanoids, they are not a specific species but rather a collection of different species that share similar traits, they can be found in all parts of the world and have a wide range of cultures and societies.<br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	Anthros have a wide range of physical traits, depending on their specific species, but they all share some common traits such as fur, tails, and animal-like ears. They are generally similiar to humans, not as enduring but slightly more agile.<br /><br /> \
	<b>Psychology</b>:<br /><br /> \
	Anthros are a diverse group of species, with a wide range of cultures and societies.<br /><br />"

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
	burn_mod = 0.9
	liquid_slowdown = 0.95 //faster than xenos
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
	brute_mod = 0.9
	burn_mod = 0.9
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	Insectoids are a fascinating species known for their insect-like characteristics and unique biology. They possess exoskeletons, multiple limbs, and often have specialized appendages for various tasks.<br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	Insectoids have a hard exoskeleton that provides protection and support for their bodies for both brute and burn damage. Their sensory organs are often highly developed, allowing them to navigate their environment with precision.<br /><br /> \
	<b>Psychology</b>:<br /><br /> \
	Insectoids are often highly social creatures, living in colonies or hives with complex hierarchies and division of labor. They communicate through a variety of methods, including pheromones, sounds, and body language. They are sometimes subject to a hive mind...<br /><br />"

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
