/datum/sprite_accessory/taur
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/taur.dmi'
	var/color_count = 3
	var/color_src = ACCESSORY_COLOR_NONE
	var/icon_prefix = "m_taur"
	var/list/render_layers = list(BODY_OVERLAY_LAYER_ADJ, BODY_OVERLAY_LAYER_FRONT_UNDER, BODY_OVERLAY_LAYER_FRONT_OVER)
	var/list/step_sounds = null
	var/step_volume = 55
	var/clothing_type = TAUR_CLOTHING_PAW
	center = TRUE
	dimension_x = 64
	dimension_y = 32

/datum/sprite_accessory/taur/none
	name = "None"
	icon_state = null
	render_layers = list()
	center = FALSE
	dimension_x = 32

/datum/sprite_accessory/taur/cow
	name = "Cow"
	icon_state = "cow"
	color_src = ACCESSORY_COLOR_TAIL
	color_count = 1
	clothing_type = TAUR_CLOTHING_HOOF

/datum/sprite_accessory/taur/cow/spotted
	name = "Cow (Spotted)"
	icon_state = "cow_spotted"

/datum/sprite_accessory/taur/deer
	name = "Deer"
	icon_state = "deer"
	clothing_type = TAUR_CLOTHING_HOOF

/datum/sprite_accessory/taur/drake
	name = "Drake"
	icon_state = "drake"

/datum/sprite_accessory/taur/drake/old
	name = "Drake (Old)"
	icon_state = "drake_old"

/datum/sprite_accessory/taur/tarantula
	name = "Tarantula"
	icon_state = "tarantula"

/datum/sprite_accessory/taur/drider
	name = "Drider"
	icon_state = "drider"

/datum/sprite_accessory/taur/eevee
	name = "Eevee"
	icon_state = "eevee"

/datum/sprite_accessory/taur/horse
	name = "Horse"
	icon_state = "horse"
	clothing_type = TAUR_CLOTHING_HOOF

/datum/sprite_accessory/taur/naga
	name = "Naga"
	icon_state = "naga"
	step_sounds = list('sound/effects/footstep/crawl1.ogg')
	clothing_type = TAUR_CLOTHING_SNAKE

/datum/sprite_accessory/taur/naga/striped
	name = "Naga, Striped"
	icon_state = "nagastriped"
	step_sounds = list('sound/effects/footstep/crawl1.ogg')
	clothing_type = TAUR_CLOTHING_SNAKE

/datum/sprite_accessory/taur/naga/rattle
	name = "Naga, Rattle"
	icon_state = "nagarattle"
	step_sounds = list('sound/effects/footstep/crawl1.ogg')
	clothing_type = TAUR_CLOTHING_SNAKE

/datum/sprite_accessory/taur/otie
	name = "Otie"
	icon_state = "otie"

/datum/sprite_accessory/taur/pede
	name = "Scolipede"
	icon_state = "pede"

/datum/sprite_accessory/taur/tentacle
	name = "Tentacle"
	icon_state = "tentacle"
	color_src = ACCESSORY_COLOR_TAIL
	color_count = 1

/datum/sprite_accessory/taur/tentacle/alt
	name = "Tentacle, Alt"
	icon_state = "tentaclealt"
	color_src = ACCESSORY_COLOR_TAIL
	color_count = 1

/datum/sprite_accessory/taur/canine
	name = "Canine"
	icon_state = "canine"

/datum/sprite_accessory/taur/feline
	name = "Feline"
	icon_state = "feline"

/datum/sprite_accessory/taur/goop
	name = "Goop"
	icon_state = "goop"
	color_src = ACCESSORY_COLOR_TAIL
	color_count = 1

/datum/sprite_accessory/taur/slime
	name = "Slime"
	icon_state = "slime"
	color_src = ACCESSORY_COLOR_TAIL
	color_count = 1

/datum/sprite_accessory/taur/biglegs
	name = "Big Legs"
	icon_state = "biglegs"
	clothing_type = TAUR_CLOTHING_BIG

/datum/sprite_accessory/taur/biglegs/stanced
	name = "Big Legs, Stanced"
	icon_state = "biglegs_stanced"

/datum/sprite_accessory/taur/biglegs/bird
	name = "Big Legs, Bird"
	icon_state = "biglegs_bird"

/datum/sprite_accessory/taur/biglegs/stanced/bird
	name = "Big Legs, Stanced Bird"
	icon_state = "biglegs_bird_stanced"

/datum/sprite_accessory/taur/synthetic
	name = "Cybernetic Lizard"
	icon_state = "synthlizard"

/datum/sprite_accessory/taur/synthetic/inverted
	name = "Cybernetic Lizard (Inverted)"
	icon_state = "synthlizardinv"

/datum/sprite_accessory/taur/synthetic/feline
	name = "Cybernetic Feline"
	icon_state = "synthfeline"

/datum/sprite_accessory/taur/synthetic/feline/inverted
	name = "Cybernetic Feline (Inverted)"
	icon_state = "synthfelineinv"

/datum/sprite_accessory/taur/synthetic/horse
	name = "Cybernetic Horse"
	icon_state = "synthhorse"
	clothing_type = TAUR_CLOTHING_HOOF

/datum/sprite_accessory/taur/synthetic/horse/inverted
	name = "Cybernetic Horse (Inverted)"
	icon_state = "synthhorseinv"

/datum/sprite_accessory/taur/synthetic/wolf
	name = "Cybernetic Wolf"
	icon_state = "synthwolf"

/datum/sprite_accessory/taur/synthetic/wolf/inverted
	name = "Cybernetic Wolf (Inverted)"
	icon_state = "synthwolfinv"

/datum/sprite_accessory/taur/synthetic/naga
	name = "Cybernetic Naga"
	icon_state = "synthnaga"
	step_sounds = list('sound/effects/footstep/crawl1.ogg')
	clothing_type = TAUR_CLOTHING_SNAKE
