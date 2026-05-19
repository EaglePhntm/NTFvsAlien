/datum/sprite_accessory/ears
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/ears.dmi'
	var/color_count = 3
	var/color_src = ACCESSORY_COLOR_NONE
	var/icon_prefix = "m_ears"
	var/uses_color_suffixes = TRUE
	var/list/render_layers = list("BEHIND", "ADJ", "ADJs", "FRONT")

/datum/sprite_accessory/ears/none
	name = "None"
	icon_state = null
	render_layers = list()

/datum/sprite_accessory/ears/mutant_axolotl
	name = "Axolotl"
	icon_state = "axolotl"

/datum/sprite_accessory/ears/mutant_bat
	name = "Bat"
	icon_state = "bat"

/datum/sprite_accessory/ears/mutant_bear
	name = "Bear"
	icon_state = "bear"

/datum/sprite_accessory/ears/mutant_bigwolf
	name = "Big Wolf"
	icon_state = "bigwolf"

/datum/sprite_accessory/ears/mutant_bigwolfinner
	// Disabled for now: these states use SPLURT's matrixed bodypart overlay coloring, not the current split-layer accessory renderer.
	name = null
	icon_state = null
	has_inner = TRUE

/datum/sprite_accessory/ears/mutant_bigwolfdark
	name = "Dark Big Wolf"
	icon_state = "bigwolfdark"

/datum/sprite_accessory/ears/mutant_bigwolfinnerdark
	// Disabled for now: these states use SPLURT's matrixed bodypart overlay coloring, not the current split-layer accessory renderer.
	name = null
	icon_state = null
	has_inner = TRUE

/datum/sprite_accessory/ears/mutant_bunny
	name = "Bunny"
	icon_state = "bunny"

/datum/sprite_accessory/ears/mutant_tajaran_catbig
	name = "Cat, Big"
	icon_state = "catbig"

/datum/sprite_accessory/ears/mutant_tajaran_catnormal
	name = "Cat, normal"
	icon_state = "catnormal"

/datum/sprite_accessory/ears/mutant_cow
	name = "Cow"
	icon_state = "cow"

/datum/sprite_accessory/ears/mutant_curled
	name = "Curled Horn"
	icon_state = "horn1"

/datum/sprite_accessory/ears/mutant_deer
	name = "Deer (Antler)"
	icon_state = "deer"

/datum/sprite_accessory/ears/mutant_eevee
	name = "Eevee"
	icon_state = "eevee"

/datum/sprite_accessory/ears/mutant_eevee_alt
	name = "Eevee ALT"
	icon_state = "eevee_alt"

/datum/sprite_accessory/ears/mutant_elf
	name = "Elf"
	icon_state = "elf"

/datum/sprite_accessory/ears/mutant_elf_wide
	name = "Wide Elf"
	icon_state = "elfwide"

/datum/sprite_accessory/ears/mutant_elf_broad
	name = "Broad Elf"
	icon_state = "elfbroad"

/datum/sprite_accessory/ears/mutant_elf_longer
	name = "Longer Elf"
	icon_state = "elflonger"

/datum/sprite_accessory/ears/mutant_elephant
	name = "Elephant"
	icon_state = "elephant"

/datum/sprite_accessory/ears/mutant_fennec
	name = "Fennec"
	icon_state = "fennec"

/datum/sprite_accessory/ears/mutant_fish
	name = "Fish"
	icon_state = "fish"

/datum/sprite_accessory/ears/mutant_vulpkanin_fox
	name = "Fox"
	icon_state = "fox"

/datum/sprite_accessory/ears/mutant_akula_hammerhead
	name = "Hammerhead"
	icon_state = "hammerhead"

/datum/sprite_accessory/ears/mutant_husky
	name = "Husky"
	icon_state = "wolf"

/datum/sprite_accessory/ears/mutant_jellyfish
	name = "Jellyfish"
	icon_state = "jellyfish"

/datum/sprite_accessory/ears/mutant_kangaroo
	name = "Kangaroo"
	icon_state = "kangaroo"

/datum/sprite_accessory/ears/mutant_lab
	name = "Dog, Long"
	icon_state = "lab"

/datum/sprite_accessory/ears/mutant_murid
	name = "Murid"
	icon_state = "murid"

/datum/sprite_accessory/ears/mutant_vulpkanin_otie
	name = "Otusian"
	icon_state = "otie"

/datum/sprite_accessory/ears/mutant_protogen
	name = "Protogen"
	icon_state = "protogen"

/datum/sprite_accessory/ears/mutant_rabbit
	name = "Rabbit"
	icon_state = "rabbit"

/datum/sprite_accessory/ears/mutant_big_hare_large
	name = "Rabbit (Large)"
	icon_state = "bunny_large"

/datum/sprite_accessory/ears/mutant_big_bunny_large
	name = "Curved Rabbit Ears (Large)"
	icon_state = "rabbit_large"

/datum/sprite_accessory/ears/mutant_big_sandfox_large
	name = "Sandfox (Large)"
	icon_state = "sandfox_large"

/datum/sprite_accessory/ears/mutant_pede
	name = "Scolipede"
	icon_state = "pede"

/datum/sprite_accessory/ears/mutant_akula_sergal
	name = "Sergal"
	icon_state = "sergal"

/datum/sprite_accessory/ears/mutant_skunk
	name = "skunk"
	icon_state = "skunk"

/datum/sprite_accessory/ears/mutant_squirrel
	name = "Squirrel"
	icon_state = "squirrel"

/datum/sprite_accessory/ears/mutant_vulpkanin_wolf
	name = "Wolf"
	icon_state = "wolf"

/datum/sprite_accessory/ears/mutant_vulpkanin_perky
	name = "Perky"
	icon_state = "perky"

/datum/sprite_accessory/ears/mutant_antenna_simple1
	name = "Insect antenna (coloring 2)"
	icon_state = "antenna_simple1"

/datum/sprite_accessory/ears/mutant_antenna_simple1_v2
	name = "Insect antenna (coloring 3)"
	icon_state = "antenna_simple1v2"

/datum/sprite_accessory/ears/mutant_antenna_simple2
	name = "Insect antenna 2 (coloring 2)"
	icon_state = "antenna_simple2"

/datum/sprite_accessory/ears/mutant_antenna_simple2_v2
	name = "Insect antenna 2 (coloring 3)"
	icon_state = "antenna_simple2v2"

/datum/sprite_accessory/ears/mutant_antenna_fuzzball
	name = "Fuzzball antenna (coloring 2+3)"
	icon_state = "antenna_fuzzball"

/datum/sprite_accessory/ears/mutant_antenna_fuzzball_v2
	name = "Fuzzball antenna (coloring 3+1)"
	icon_state = "antenna_fuzzballv2"

/datum/sprite_accessory/ears/mutant_cobrahood
	name = "Cobra Hood"
	icon_state = "cobrahood"

/datum/sprite_accessory/ears/mutant_cobrahoodears
	name = "Cobra Hood (Ears)"
	icon_state = "cobraears"

/datum/sprite_accessory/ears/mutant_miqote
	name = "Miqo'te"
	icon_state = "miqote"

/datum/sprite_accessory/ears/mutant_hare
	name = "Hare"
	icon_state = "rabbitalt"

/datum/sprite_accessory/ears/mutant_bunnyalt
	name = "Curved Rabbit Ears"
	icon_state = "bunnyalt"

/datum/sprite_accessory/ears/mutant_deerear
	name = "Deer (ear)"
	icon_state = "deerear"

/datum/sprite_accessory/ears/mutant_teshari_regular
	name = "Teshari Regular"
	icon_state = "teshari_regular"

/datum/sprite_accessory/ears/mutant_teshari_feathers_bushy
	name = "Teshari Feathers Bushy"
	icon_state = "teshari_feathers_bushy"

/datum/sprite_accessory/ears/mutant_teshari_feathers_mohawk
	name = "Teshari Feathers Mohawk"
	icon_state = "teshari_feathers_mohawk"

/datum/sprite_accessory/ears/mutant_teshari_feathers_spiky
	name = "Teshari Feathers Spiky"
	icon_state = "teshari_feathers_spiky"

/datum/sprite_accessory/ears/mutant_teshari_feathers_pointy
	name = "Teshari Feathers Pointy"
	icon_state = "teshari_feathers_pointy"

/datum/sprite_accessory/ears/mutant_teshari_feathers_upright
	name = "Teshari Feathers Upright"
	icon_state = "teshari_feathers_upright"

/datum/sprite_accessory/ears/mutant_teshari_feathers_mane
	name = "Teshari Feathers Mane"
	icon_state = "teshari_feathers_mane"

/datum/sprite_accessory/ears/mutant_teshari_feathers_maneless
	name = "Teshari Feathers Mane Fluffless"
	icon_state = "teshari_feathers_maneless"

/datum/sprite_accessory/ears/mutant_teshari_feathers_droopy
	name = "Teshari Feathers Droopy"
	icon_state = "teshari_feathers_droopy"

/datum/sprite_accessory/ears/mutant_teshari_feathers_longway
	name = "Teshari Feathers Longway"
	icon_state = "teshari_feathers_longway"

/datum/sprite_accessory/ears/mutant_teshari_feathers_tree
	name = "Teshari Feathers Tree"
	icon_state = "teshari_feathers_tree"

/datum/sprite_accessory/ears/mutant_teshari_feathers_ponytail
	name = "Teshari Feathers Ponytail"
	icon_state = "teshari_feathers_ponytail"

/datum/sprite_accessory/ears/mutant_teshari_feathers_mushroom
	name = "Teshari Feathers Mushroom"
	icon_state = "teshari_feathers_mushroom"

/datum/sprite_accessory/ears/mutant_teshari_feathers_backstrafe
	name = "Teshari Feathers Backstrafe"
	icon_state = "teshari_feathers_backstrafe"

/datum/sprite_accessory/ears/mutant_teshari_feathers_thinmohawk
	name = "Teshari Feathers Thin Mohawk"
	icon_state = "teshari_feathers_thinmohawk"

/datum/sprite_accessory/ears/mutant_teshari_feathers_thin
	name = "Teshari Feathers Thin"
	icon_state = "teshari_feathers_thin"

/datum/sprite_accessory/ears/mutant_teshari_feathers_thinmane
	name = "Teshari Feathers Thin Mane"
	icon_state = "teshari_feathers_thinmane"

/datum/sprite_accessory/ears/mutant_teshari_feathers_thinmaneless
	name = "Teshari Feathers Thin Mane Fluffless"
	icon_state = "teshari_feathers_thinmaneless"

/datum/sprite_accessory/ears/mutant_deer2
	name = "Deer 2"
	icon_state = "deer2"

/datum/sprite_accessory/ears/mutant_mouse
	name = "Mouse"
	icon_state = "mouse"

/datum/sprite_accessory/ears/mutant_mouse_two
	name = "Mouse II"
	icon_state = "mouse_two"

/datum/sprite_accessory/ears/mutant_big_fourears1
	name = "Four Ears 1"
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/ears_big.dmi'
	icon_state = "four_ears_1"

/datum/sprite_accessory/ears/mutant_fourears2
	name = "Four Ears 2"
	icon_state = "four_ears_2"

/datum/sprite_accessory/ears/mutant_big_fourears3
	name = "Four Ears 3"
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/ears_big.dmi'
	icon_state = "four_ears_3"

/datum/sprite_accessory/ears/acrador_long
	name = "Acrador (Long)"
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/ears_big.dmi'
	icon_state = "acrador_long"

/datum/sprite_accessory/ears/acrador_short
	name = "Acrador (Short)"
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/ears_big.dmi'
	icon_state = "acrador_short"
