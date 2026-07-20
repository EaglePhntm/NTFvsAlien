/datum/sprite_accessory/lizard_tail/skyrat/xeno
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/xeno_parts.dmi'
	name = "Xenomorph Tail"
	icon_state = "xeno"
	color_count = 1

/datum/sprite_accessory/xenodorsal
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/xeno_parts.dmi'
	var/color_count = 1
	var/color_src = ACCESSORY_COLOR_NONE
	var/icon_prefix = "m_xenodorsal"
	var/uses_color_suffixes = FALSE
	var/list/render_layers = list(BODY_OVERLAY_LAYER_BEHIND, BODY_OVERLAY_LAYER_FRONT)

/datum/sprite_accessory/xenodorsal/none
	name = "None"
	icon_state = "none"
	render_layers = list()

/datum/sprite_accessory/xenodorsal/standard
	name = "Standard"
	icon_state = "standard"

/datum/sprite_accessory/xenodorsal/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/xenodorsal/down
	name = "Dorsal Down"
	icon_state = "down"

/datum/sprite_accessory/xenohead
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/xeno_parts.dmi'
	var/color_count = 1
	var/color_src = ACCESSORY_COLOR_NONE
	var/icon_prefix = "m_xenohead"
	var/uses_color_suffixes = FALSE
	var/list/render_layers = list(BODY_OVERLAY_LAYER_ADJ)

/datum/sprite_accessory/xenohead/none
	name = "None"
	icon_state = "none"
	render_layers = list()

/datum/sprite_accessory/xenohead/standard
	name = "Standard"
	icon_state = "standard"

/datum/sprite_accessory/xenohead/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/xenohead/net
	name = "Nethead"
	icon_state = "net"

/datum/sprite_accessory/xenohead/warrior
	name = "Warrior"
	icon_state = "warrior"
