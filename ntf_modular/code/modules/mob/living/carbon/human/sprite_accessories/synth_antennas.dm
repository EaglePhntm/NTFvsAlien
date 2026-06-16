/datum/sprite_accessory/synth_antenna
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/ipc_antennas.dmi'
	var/color_count = 1
	var/color_src = ACCESSORY_COLOR_NONE
	var/icon_prefix = "m_ipc_antenna"
	var/uses_color_suffixes = FALSE
	var/list/render_layers = list("ADJ")

/datum/sprite_accessory/synth_antenna/none
	name = "None"
	icon_state = null
	render_layers = list()

/datum/sprite_accessory/synth_antenna/antennae
	name = "Angled Antennae"
	icon_state = "antennae"

/datum/sprite_accessory/synth_antenna/tvantennae
	name = "TV Antennae"
	icon_state = "tvantennae"

/datum/sprite_accessory/synth_antenna/cyberhead
	name = "Cyberhead"
	icon_state = "cyberhead"

/datum/sprite_accessory/synth_antenna/antlers
	name = "Antlers"
	icon_state = "antlers"

/datum/sprite_accessory/synth_antenna/crowned
	name = "Crowned"
	icon_state = "crowned"

/datum/sprite_accessory/synth_antenna/splurt
	icon = 'ntf_modular/icons/mob/sprite_accessories/ipc_antennas.dmi'
	color_count = 3

/datum/sprite_accessory/synth_antenna/splurt/synth_antennae
	name = "Angled Antennae (Alt)"
	icon_state = "synth_antennae"

/datum/sprite_accessory/synth_antenna/splurt/synth_antennaelight
	name = "Angled Antennae (Alt) (Light)"
	icon_state = "synth_antennaelight"

/datum/sprite_accessory/synth_antenna/splurt/synth_curled
	name = "Curled Antennae"
	icon_state = "synth_curled"

/datum/sprite_accessory/synth_antenna/splurt/synth_thick
	name = "Thick Antennae"
	icon_state = "synth_thick"

/datum/sprite_accessory/synth_antenna/splurt/synth_thicklight
	name = "Thick Antennae (Light)"
	icon_state = "synth_thicklight"

/datum/sprite_accessory/synth_antenna/splurt/synth_short
	name = "Short Antennae"
	icon_state = "synth_short"

/datum/sprite_accessory/synth_antenna/splurt/synth_sharp
	name = "Sharp Antennae"
	icon_state = "synth_sharp"

/datum/sprite_accessory/synth_antenna/splurt/synth_sharplight
	name = "Sharp Antennae (Light)"
	icon_state = "synth_sharplight"

/datum/sprite_accessory/synth_antenna/splurt/synth_horns
	name = "Horned Antennae"
	icon_state = "synth_horns"

/datum/sprite_accessory/synth_antenna/splurt/synth_hornslight
	name = "Horned Antennae (Light)"
	icon_state = "synth_hornslight"

/datum/sprite_accessory/synth_antenna/splurt/synth_integrator
	name = "Integrator Antennae"
	icon_state = "synth_integrator"

/datum/sprite_accessory/synth_antenna/splurt/synth_antennaquad
	name = "Quad Antennae"
	icon_state = "synth_antennaquad"

/datum/sprite_accessory/synth_antenna/splurt/synth_cobrahood
	name = "Cobra Hood Antennae"
	icon_state = "synth_cobrahood"

/datum/sprite_accessory/synth_antenna/splurt/synth_cobrahood_alt
	name = "Cobra Hood Antennae (Alt)"
	icon_state = "synth_cobrahood_alt"

/datum/sprite_accessory/synth_antenna/splurt/synth_cobraslim
	name = "Cobra Hood Antennae (Slim)"
	icon_state = "synth_cobraslim"
