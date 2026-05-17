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
	splurt_limb_prefix = "akula"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)

/datum/species/anthro
	name = "Anthro"
	icobase = BODYPART_ICON_MAMMAL
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = TRUE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
	splurt_limb_prefix = "mammal"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)

/datum/species/aquatic
	name = "Aquatic"
	icobase = BODYPART_ICON_AQUATIC
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = TRUE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
	splurt_limb_prefix = "aquatic"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)

/datum/species/insectoid
	name = "Insectoid"
	icobase = BODYPART_ICON_INSECT
	unarmed_type = /datum/unarmed_attack/claws
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = TRUE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
	splurt_limb_prefix = "insect"

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
	splurt_limb_prefix = "vox"
	digitigrade_leg_options = list("Normal", "Digitigrade", "Digitigrade 2")
	digitigrade_limb_prefixes = list(
		"Digitigrade" = "digitigrade_1",
		"Digitigrade 2" = "digitigrade_2",
	)
