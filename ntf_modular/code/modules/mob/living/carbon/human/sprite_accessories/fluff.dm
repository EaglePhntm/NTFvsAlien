/datum/sprite_accessory/fluff
	// Future work: re-enable these after porting an organ/bodypart overlay anchor for chest fluff.
	// Drawing these as direct mob overlays misaligns the larger SPLURT moth fluff sprites.
	icon = 'ntf_modular/icons/mob/sprite_accessories/neck_fluff.dmi'
	var/icon_prefix = "m_fluff"
	var/color_src = ACCESSORY_COLOR_NONE
	var/color_count = 3
	var/pixel_x_offset = 0
	var/pixel_y_offset = 0
	var/list/render_layers = list("FRONT")
	center = TRUE
	dimension_x = 45
	dimension_y = 34

/datum/sprite_accessory/fluff/none
	name = "None"
	icon_state = null
	render_layers = list()

/datum/sprite_accessory/fluff/hyena
	name = "Hyena (Splurt)"
	icon_state = "hyena"

/datum/sprite_accessory/fluff/hyena_stripes
	name = "Hyena Stripes (Splurt)"
	icon_state = "hyenastripes"

/datum/sprite_accessory/fluff/soft
	name = "Soft (Splurt)"
	icon_state = "soft"

/datum/sprite_accessory/fluff/flat
	name = "Flat (Splurt)"
	icon_state = "flat"

/datum/sprite_accessory/fluff/renamon
	name = "Renamon (Splurt)"
	icon_state = "renamon"

/datum/sprite_accessory/fluff/cryptid
	name = "Cryptid Neck Fur"
	icon_state = "cryptid"
	color_count = 1
	render_layers = list("ADJ", "FRONT")

/datum/sprite_accessory/fluff/moth
	icon = 'ntf_modular/icons/mob/sprite_accessories/moth_fluff.dmi'
	color_count = 1
	center = FALSE
	pixel_x_offset = 0
	render_layers = list("ADJ")

/datum/sprite_accessory/fluff/moth/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/fluff/moth/monarch
	name = "Monarch"
	icon_state = "monarch"

/datum/sprite_accessory/fluff/moth/luna
	name = "Luna"
	icon_state = "luna"

/datum/sprite_accessory/fluff/moth/atlas
	name = "Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/fluff/moth/reddish
	name = "Reddish"
	icon_state = "redish"

/datum/sprite_accessory/fluff/moth/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/fluff/moth/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/fluff/moth/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/fluff/moth/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/fluff/moth/burnt_off
	name = "Burnt Off"
	icon_state = "burnt_off"

/datum/sprite_accessory/fluff/moth/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/fluff/moth/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/fluff/moth/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/fluff/moth/ragged
	name = "Ragged"
	icon_state = "ragged"

/datum/sprite_accessory/fluff/moth/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/fluff/moth/snow
	name = "Snow"
	icon_state = "snow"

/datum/sprite_accessory/fluff/moth/oakworm
	name = "Oak Worm"
	icon_state = "oakworm"

/datum/sprite_accessory/fluff/moth/jungle
	name = "Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/fluff/moth/witchwing
	name = "Witch Wing"
	icon_state = "witchwing"

/datum/sprite_accessory/fluff/moth/insect_male
	name = "Insect Male"
	icon_state = "insectm"

/datum/sprite_accessory/fluff/moth/insect_female
	name = "Insect Female"
	icon_state = "insectf"

/datum/sprite_accessory/fluff/moth/snow_top
	name = "Snow (Top)"
	icon_state = "fsnow"
	render_layers = list("FRONT")

/datum/sprite_accessory/fluff/moth/snow_dual
	name = "Snow (Dual-Color)"
	icon_state = "snowdual"
	color_count = 2

/datum/sprite_accessory/fluff/moth/teshari_mane
	name = "Teshari Mane"
	icon_state = "teshmane"

/datum/sprite_accessory/fluff/moth/teshari_mane_top
	name = "Teshari Mane (Top)"
	icon_state = "teshmane_top"
	render_layers = list("FRONT")
