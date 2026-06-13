/datum/species/moth
	name = "Moth"
	icobase = BODYPART_ICON_MOTH
	limb_type = SPECIES_LIMB_SPLURT
	splurt_limb_prefix = "moth"
	default_language_holder = /datum/language_holder/moth
	eyes = "eyes_s"
	count_human = TRUE
	species_flags = HAS_LIPS|HAS_NO_HAIR
	screams = list("neuter" = 'sound/voice/moth_scream.ogg')
	paincries = list("neuter" = 'sound/voice/human/male/pain_3.ogg')
	goredcries = list("neuter" = 'sound/voice/moth_scream.ogg')
	burstscreams = list("neuter" = 'sound/voice/moth_scream.ogg')
	warcries = list("neuter" = 'sound/voice/moth_scream.ogg')
	joinable_roundstart = TRUE
	flesh_color = "#E5CD99"

	reagent_tag = IS_MOTH

	namepool = /datum/namepool/moth
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	Mothmen are a species of humanoid moth-like creatures that are known for their large, feathery wings and their nocturnal habits.<br /><br /> \
	They are often found in dark, secluded areas such as forests, caves, and abandoned buildings. They worship .. Some lamp usually.<br /><br /><br /><br />  \
	<b>Physiology</b>:<br /><br /> \
	Mothmen have a unique physiology that allows them to navigate through dark environments with ease.<br /><br /><br /><br />  \
	<b>Psychology</b>:<br /><br /> \
	Mothmen are generally solitary creatures that prefer to avoid confrontation.<br /><br />"


/datum/species/moth/handle_fire(mob/living/carbon/human/H)
	if(H.moth_wings != "Burnt Off" && H.bodytemperature >= 400 && H.fire_stacks > 0)
		to_chat(H, span_danger("Your precious wings burn to a crisp!"))
		H.moth_wings = "Burnt Off"
		H.update_body()

/datum/species/moth/proc/update_moth_wings(mob/living/carbon/human/H)
	H.remove_overlay(MOTH_WINGS_LAYER)
	H.remove_underlay(MOTH_WINGS_BEHIND_LAYER)

	var/datum/sprite_accessory/moth_wings/wings = GLOB.moth_wings_list[H.moth_wings]

	if(wings)
		var/image/front_wings = image(wings.icon, icon_state = "[wings.icon_prefix]_[wings.icon_state]_FRONT")
		var/image/behind_wings = image(wings.icon, icon_state = "[wings.icon_prefix]_[wings.icon_state]_BEHIND")
		front_wings.layer = -7
		behind_wings.layer = -49
		if(wings.center)
			center_image(front_wings, wings.dimension_x, wings.dimension_y)
			center_image(behind_wings, wings.dimension_x, wings.dimension_y)
		front_wings.pixel_w += wings.pixel_w_offset
		front_wings.pixel_z += wings.pixel_z_offset
		behind_wings.pixel_w += wings.pixel_w_offset
		behind_wings.pixel_z += wings.pixel_z_offset
		H.overlays_standing[MOTH_WINGS_LAYER] = front_wings
		H.underlays_standing[MOTH_WINGS_BEHIND_LAYER] = behind_wings
		H.apply_overlay(MOTH_WINGS_LAYER)
		H.apply_underlay(MOTH_WINGS_BEHIND_LAYER)

/datum/species/moth/update_body(mob/living/carbon/human/H)
	update_moth_wings(H)

/datum/species/moth/update_inv_head(mob/living/carbon/human/H)
	update_moth_wings(H)

/datum/species/moth/update_inv_w_uniform(mob/living/carbon/human/H)
	update_moth_wings(H)

/datum/species/moth/update_inv_wear_suit(mob/living/carbon/human/H)
	update_moth_wings(H)

/datum/species/moth/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	H.remove_overlay(MOTH_WINGS_LAYER)
	H.remove_underlay(MOTH_WINGS_BEHIND_LAYER)
