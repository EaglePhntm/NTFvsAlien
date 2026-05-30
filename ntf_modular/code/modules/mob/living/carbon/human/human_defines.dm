/**
 * All variables *should* be treated as text variables,
 * Although only `var/boobs` is as a text key to generate icons.
 * Why? It will be easier in the future if we decide to make more than one icon for ass/cock overlays
 */

/// Defines whether we are using an ass overlay
/mob/living/carbon/human
	var/ass = null
	var/ass_size = 2
	var/ass_color = "#FFFFFF"
	var/list/ass_emissive = list(FALSE, FALSE, FALSE)
/// Defines whether we are using boob overlay
	var/boobs = null
	var/boobs_size = 3
	var/boobs_color = "#FFFFFF"
	var/boobs_color_secondary = "#d98fa3"
	var/list/boobs_emissive = list(FALSE, FALSE, FALSE)
/// Defines whether we are using ass overlay
	var/cock = null
	var/cock_size = 3
	var/cock_color = "#FFFFFF"
	var/list/cock_emissive = list(FALSE, FALSE, FALSE)
/// Defines whether we are using vagina overlay
	var/vagina = null
	var/vagina_color = "#FFFFFF"
	var/list/vagina_emissive = list(FALSE, FALSE, FALSE)
/// Defines whether we are using belly overlay
	var/belly = null
	var/belly_size = 0
	var/belly_color = "#FFFFFF"
	var/list/belly_emissive = list(FALSE, FALSE, FALSE)
/// Defines whether we are using testicles overlay
	var/testicles = null
	var/testicles_size = 2
	var/testicles_color = "#FFFFFF"
	var/testicles_color_secondary = "#d98fa3"
	var/list/testicles_emissive = list(FALSE, FALSE, FALSE)
///For xeno healing bone repair
	var/xeno_heals = 0
	// Xenomorph that is hauling us if we are hauled
	var/mob/living/carbon/xenomorph/devouring_mob
	// Haul resist cooldown
	var/next_haul_resist
	var/last_directional_overlay_dir = NONE
	speaking_noise = 'ntf_modular/sound/voice/talk.ogg'
