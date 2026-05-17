/datum/sprite_accessory/wings
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/wings.dmi'
	var/color_count = 3
	var/color_src = ACCESSORY_COLOR_NONE
	var/icon_prefix = "m_wings"
	var/uses_color_suffixes = TRUE
	var/list/render_layers = list("BEHIND", "ADJ", "FRONT")
	var/top_icon_state = null
	var/top_only = FALSE
	center = TRUE
	dimension_x = 46
	dimension_y = 34

/datum/sprite_accessory/wings/none
	name = "None"
	icon_state = null
	render_layers = list()

/datum/sprite_accessory/wings/mammal_bat
	name = "Bat"
	icon_state = "bat"

/datum/sprite_accessory/wings/mammal_bee
	name = "Bee"
	icon_state = "bee"

/datum/sprite_accessory/wings/mammal_beetle
	name = "Beetle"
	icon_state = "beetle"

/datum/sprite_accessory/wings/mammal_dragon_alt1
	name = "Dragon (Alt 1)"
	icon_state = "dragonalt1"

/datum/sprite_accessory/wings/mammal_dragon_alt2
	name = "Dragon (Alt 2)"
	icon_state = "dragonalt2"

/datum/sprite_accessory/wings/mammal_dragon_synth
	name = "Dragon (Synthetic)"
	icon_state = "dragonsynth"

/datum/sprite_accessory/wings/mammal_dragon_mechanical
	name = "Dragon (Mechanical)"
	icon_state = "robowing"

/datum/sprite_accessory/wings/mammal_fairy
	name = "Fairy"
	icon_state = "fairy"

/datum/sprite_accessory/wings/mammal_feathery
	name = "Feathery"
	icon_state = "feathery"

/datum/sprite_accessory/wings/mammal_feathery_alt1
	name = "Feathery (Alt 1)"
	icon_state = "featheryalt1"

/datum/sprite_accessory/wings/mammal_feathery_alt2
	name = "Feathery (Alt 2)"
	icon_state = "featheryalt2"

/datum/sprite_accessory/wings/mammal_harpy
	name = "Harpy"
	icon_state = "harpy"
	top_icon_state = "harpy_top"

/datum/sprite_accessory/wings/mammal_top_harpy
	name = "Harpy (Top)"
	icon_state = "harpy_top"
	top_only = TRUE

/datum/sprite_accessory/wings/mammal_harpy_alt
	name = "Harpy (Alt)"
	icon_state = "harpyalt"
	top_icon_state = "harpyalt_top"

/datum/sprite_accessory/wings/mammal_harpy_alt_fluffless
	name = "Harpy (Alt - Fluffless)"
	icon_state = "harpyalt_fluffless"
	top_icon_state = "harpyalt_fluffless_top"

/datum/sprite_accessory/wings/mammal_harpy_bat
	name = "Harpy (Bat)"
	icon_state = "harpybat"
	top_icon_state = "harpybat_top"

/datum/sprite_accessory/wings/mammal_harpy_bat_fluffless
	name = "Harpy (Bat - Fluffless)"
	icon_state = "harpybat_fluffless"
	top_icon_state = "harpybat_fluffless_top"

/datum/sprite_accessory/wings/mammal_top_harpy_alt
	name = "Harpy (Top - Alt)"
	icon_state = "harpyalt_top"
	top_only = TRUE

/datum/sprite_accessory/wings/mammal_top_harpy_alt_fluffless
	name = "Harpy (Top - Alt - Fluffless)"
	icon_state = "harpyalt_fluffless_top"
	top_only = TRUE

/datum/sprite_accessory/wings/mammal_top_harpy_bat
	name = "Harpy (Top - Bat)"
	icon_state = "harpybat_top"
	top_only = TRUE

/datum/sprite_accessory/wings/mammal_top_harpy_bat_fluffless
	name = "Harpy (Top - Bat - Fluffless)"
	icon_state = "harpybat_fluffless_top"
	top_only = TRUE

/datum/sprite_accessory/wings/mammal_pterodactyl
	name = "Pterodactyl"
	icon_state = "pterodactyl"

/datum/sprite_accessory/wings/mammal_insect
	name = "Insectoid"
	icon_state = "insect"

/datum/sprite_accessory/wings/mammal_mini_bat
	name = "Mini-Bat"
	icon_state = "minibat"

/datum/sprite_accessory/wings/mammal_mini_feather
	name = "Mini-Feathery"
	icon_state = "minifeather"

/datum/sprite_accessory/wings/mammal_spider
	name = "Spider Legs"
	icon_state = "spider_legs"

/datum/sprite_accessory/wings/mammal_succubus
	name = "Succubus"
	icon_state = "succubus"

/datum/sprite_accessory/wings/mammal_tiny_bat
	name = "Tiny-Bat"
	icon_state = "tinybat"

/datum/sprite_accessory/wings/mammal_tiny_feather
	name = "Tiny-Feathery"
	icon_state = "tinyfeather"

/datum/sprite_accessory/wings/low_wings
	name = "Low wings"
	icon_state = "low"

/datum/sprite_accessory/wings/low_wings_top
	name = "Low Wings (Top)"
	icon_state = "low_top"

/datum/sprite_accessory/wings/low_wings_tri
	name = "Low Wings (Tri-Tone)"
	icon_state = "low_tri"

/datum/sprite_accessory/wings/low_wings_tri_top
	name = "Low Wings (Tri-Tone - Top)"
	icon_state = "low_tri_top"

/datum/sprite_accessory/wings/low_wings_jewel
	name = "Low Wings Jeweled"
	icon_state = "low_jewel"

/datum/sprite_accessory/wings/low_wings_jewel_top
	name = "Low Wings Jeweled (Top)"
	icon_state = "low_jewel_top"

/datum/sprite_accessory/wings/low_wings_renamon
	name = "Cyvian"
	icon_state = "renamon"

/datum/sprite_accessory/wings/mammal_top_arfel_harpy
	name = "Arfel Harpy"
	icon_state = "arfelharpy_top"
	top_only = TRUE
