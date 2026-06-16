GLOBAL_LIST_EMPTY(body_markings)
GLOBAL_LIST_EMPTY_TYPED(body_markings_per_limb, /list)
GLOBAL_LIST_INIT(marking_zones, list("head", "chest", "l_arm", "r_arm", "l_hand", "r_hand", "l_leg", "r_leg"))
GLOBAL_LIST_INIT(marking_zone_labels, list(
	"head" = "Head",
	"chest" = "Chest",
	"l_arm" = "Left Arm",
	"r_arm" = "Right Arm",
	"l_hand" = "Left Hand",
	"r_hand" = "Right Hand",
	"l_leg" = "Left Leg",
	"r_leg" = "Right Leg",
))
GLOBAL_LIST_INIT(marking_zone_to_bitflag, list(
	"head" = HEAD,
	"chest" = CHEST,
	"l_arm" = ARM_LEFT,
	"r_arm" = ARM_RIGHT,
	"l_hand" = HAND_LEFT,
	"r_hand" = HAND_RIGHT,
	"l_leg" = LEG_LEFT,
	"r_leg" = LEG_RIGHT,
))

#define MARKING_DEFAULT_PRIMARY "primary"
#define MARKING_DEFAULT_SECONDARY "secondary"
#define MARKING_DEFAULT_TERTIARY "tertiary"

/proc/ensure_body_marking_references()
	if(length(GLOB.body_markings))
		return

	for(var/path in subtypesof(/datum/body_marking))
		var/datum/body_marking/marking = path
		if(!initial(marking.name))
			continue
		marking = new path()
		GLOB.body_markings[marking.name] = marking

		for(var/zone in GLOB.marking_zones)
			var/bitflag = GLOB.marking_zone_to_bitflag[zone]
			if(!(marking.affected_bodyparts & bitflag))
				continue
			if(!GLOB.body_markings_per_limb[zone])
				GLOB.body_markings_per_limb[zone] = list()
			GLOB.body_markings_per_limb[zone] += marking.name

	for(var/zone in GLOB.marking_zones)
		if(!GLOB.body_markings_per_limb[zone])
			GLOB.body_markings_per_limb[zone] = list()
		sortTim(GLOB.body_markings_per_limb[zone], GLOBAL_PROC_REF(cmp_text_asc))

/proc/body_marking_state_for_limb(datum/body_marking/marking, limb_zone, gender, digitigrade_legs)
	var/base_state = marking.icon_state
	switch(limb_zone)
		if("chest")
			if(marking.gendered)
				return "[base_state]_chest_[gender == FEMALE ? "f" : "m"]"
			return "[base_state]_chest"
		if("l_leg")
			if(digitigrade_legs == "Digitigrade")
				return "[base_state]_digitigrade_1_l_leg"
			if(digitigrade_legs == "Digitigrade 2")
				return "[base_state]_digitigrade_2_l_leg"
			return "[base_state]_l_leg"
		if("r_leg")
			if(digitigrade_legs == "Digitigrade")
				return "[base_state]_digitigrade_1_r_leg"
			if(digitigrade_legs == "Digitigrade 2")
				return "[base_state]_digitigrade_2_r_leg"
			return "[base_state]_r_leg"
	return "[base_state]_[limb_zone]"

/proc/body_marking_entry_color(list/entry)
	if(!islist(entry))
		return "#FFFFFF"
	return sanitize_hexcolor(entry[1], 6, TRUE, "#FFFFFF")

/proc/body_marking_entry_emissive(list/entry)
	if(!islist(entry) || length(entry) < 2)
		return FALSE
	return !!entry[2]

/mob/living/carbon/human/proc/update_body_marking_emissives()
	remove_overlay(BODY_MARKINGS_EMISSIVE_LAYER)
	if(!ntf_should_render_emissives() || !islist(body_markings))
		return
	ensure_body_marking_references()

	var/list/emissive_layers = list()
	for(var/zone in GLOB.marking_zones)
		var/list/zone_markings = body_markings[zone]
		if(!length(zone_markings))
			continue

		for(var/marking_name in zone_markings)
			if(!body_marking_entry_emissive(zone_markings[marking_name]))
				continue
			var/datum/body_marking/marking = GLOB.body_markings[marking_name]
			if(!marking)
				continue

			var/state = body_marking_state_for_limb(marking, zone, physique, digitigrade_legs)
			if(!(state in icon_states(marking.icon)))
				continue

			var/mutable_appearance/marking_emissive = emissive_appearance(marking.icon, state, src, layer = -BODYPARTS_LAYER)
			if(!marking_emissive)
				continue
			marking_emissive.dir = dir
			emissive_layers += marking_emissive

	if(length(emissive_layers))
		overlays_standing[BODY_MARKINGS_EMISSIVE_LAYER] = emissive_layers
		apply_overlay(BODY_MARKINGS_EMISSIVE_LAYER)

/datum/body_marking
	var/icon
	var/icon_state
	var/name
	var/default_color = "#FFFFFF"
	var/affected_bodyparts
	var/gendered = TRUE

/datum/body_marking/proc/get_default_color(mob/living/carbon/human/human)
	switch(default_color)
		if(MARKING_DEFAULT_PRIMARY)
			return sanitize_hexcolor(human?.tail_color, 6, TRUE, "#FFFFFF")
		if(MARKING_DEFAULT_SECONDARY)
			return sanitize_hexcolor(human?.tail_color_secondary, 6, TRUE, "#FFFFFF")
		if(MARKING_DEFAULT_TERTIARY)
			return sanitize_hexcolor(human?.tail_color_tertiary, 6, TRUE, "#FFFFFF")
	return sanitize_hexcolor(default_color, 6, TRUE, "#FFFFFF")

/datum/body_marking/other
	icon = 'modular_skyrat/master_files/icons/mob/body_markings/other_markings.dmi'

/datum/body_marking/other/flushed_cheeks
	name = "Flushed Cheeks"
	icon_state = "flushed_cheeks"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD

/datum/body_marking/other/monster_mouth
	name = "Monster Mouth"
	icon_state = "monster"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD

/datum/body_marking/other/drake_bone
	name = "Drake Bone"
	icon_state = "drakebone"
	default_color = "#CCCCCC"
	affected_bodyparts = CHEST | HAND_LEFT | HAND_RIGHT
	gendered = FALSE

/datum/body_marking/other/bands
	name = "Color Bands"
	icon_state = "bands"
	default_color = MARKING_DEFAULT_PRIMARY
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_LEFT | LEG_RIGHT

/datum/body_marking/other/bands_foot
	name = "Color Bands (Foot)"
	icon_state = "bands_foot"
	default_color = MARKING_DEFAULT_PRIMARY
	affected_bodyparts = LEG_LEFT | LEG_RIGHT

/datum/body_marking/other/anklet
	name = "Anklet"
	icon_state = "anklet"
	default_color = MARKING_DEFAULT_PRIMARY
	affected_bodyparts = LEG_LEFT | LEG_RIGHT

/datum/body_marking/other/pilot
	name = "Pilot"
	icon_state = "pilot"
	default_color = "#CCCCCC"
	affected_bodyparts = HEAD | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT

/datum/body_marking/secondary
	icon = 'modular_skyrat/master_files/icons/mob/body_markings/secondary_markings.dmi'
	default_color = MARKING_DEFAULT_SECONDARY

/datum/body_marking/secondary/fennec
	name = "Fennec"
	icon_state = "fennec"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_LEFT | LEG_RIGHT

/datum/body_marking/secondary/redpanda
	name = "Red Panda"
	icon_state = "redpanda"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_LEFT | LEG_RIGHT

/datum/body_marking/secondary/shepherd
	name = "Shepherd"
	icon_state = "shepherd"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | LEG_LEFT | LEG_RIGHT

/datum/body_marking/secondary/wolf
	name = "Wolf"
	icon_state = "wolf"
	affected_bodyparts = HEAD | CHEST

/datum/body_marking/secondary/fox
	name = "Fox"
	icon_state = "fox"
	affected_bodyparts = HEAD | CHEST | LEG_LEFT | LEG_RIGHT

/datum/body_marking/secondary/tiger
	name = "Tiger"
	icon_state = "tiger"
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | LEG_LEFT | LEG_RIGHT

/datum/body_marking/secondary/shark
	name = "Shark"
	icon_state = "shark"
	affected_bodyparts = HEAD | CHEST | LEG_LEFT | LEG_RIGHT

/datum/body_marking/secondary/belly
	name = "Belly"
	icon_state = "belly"
	affected_bodyparts = CHEST

/datum/body_marking/secondary/handsfeet
	name = "Hands and Feet"
	icon_state = "handsfeet"
	affected_bodyparts = HAND_LEFT | HAND_RIGHT | LEG_LEFT | LEG_RIGHT

/datum/body_marking/secondary/gradient
	name = "Gradient"
	icon_state = "gradient"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_LEFT | LEG_RIGHT

/datum/body_marking/tertiary
	icon = 'modular_skyrat/master_files/icons/mob/body_markings/tertiary_markings.dmi'
	default_color = MARKING_DEFAULT_TERTIARY

/datum/body_marking/tertiary/redpanda
	name = "Red Panda Tertiary"
	icon_state = "redpanda"
	affected_bodyparts = HEAD | CHEST | LEG_LEFT | LEG_RIGHT

/datum/body_marking/tertiary/wolf
	name = "Wolf Tertiary"
	icon_state = "wolf"
	affected_bodyparts = HEAD | CHEST | LEG_LEFT | LEG_RIGHT

/datum/body_marking/tertiary/fox
	name = "Fox Tertiary"
	icon_state = "fox"
	affected_bodyparts = HEAD | CHEST | LEG_LEFT | LEG_RIGHT

/datum/body_marking/tertiary/tiger
	name = "Tiger Tertiary"
	icon_state = "tiger"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_LEFT | LEG_RIGHT

/datum/body_marking/tertiary/lbelly
	name = "Light Belly"
	icon_state = "lbelly"
	affected_bodyparts = CHEST

/datum/body_marking/akula
	icon = 'modular_skyrat/master_files/icons/mob/body_markings/akula_markings.dmi'

/datum/body_marking/akula/secondary
	name = "Akula Secondary"
	icon_state = "akula"
	default_color = MARKING_DEFAULT_SECONDARY
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT | HAND_LEFT | HAND_RIGHT | LEG_LEFT | LEG_RIGHT

/datum/body_marking/akula/tertiary
	name = "Akula Highlight"
	icon_state = "akula_highlight"
	default_color = MARKING_DEFAULT_TERTIARY
	affected_bodyparts = HEAD | CHEST | ARM_LEFT | ARM_RIGHT | LEG_LEFT | LEG_RIGHT

/datum/body_marking/synthliz_secondary
	icon = 'modular_skyrat/master_files/icons/mob/body_markings/synthliz_secondary.dmi'
	default_color = MARKING_DEFAULT_SECONDARY

/datum/body_marking/synthliz_secondary/scutes
	name = "Synth Scutes"
	icon_state = "synthlizscutes"
	affected_bodyparts = CHEST

/datum/body_marking/synthliz_secondary/lights
	name = "Synth Lights"
	icon_state = "synthlizlights"
	default_color = "#00FFFF"
	affected_bodyparts = CHEST

/datum/body_marking/synthliz_secondary/pecs
	name = "Synth Pecs"
	icon_state = "synthlizpecs"
	affected_bodyparts = CHEST

/datum/body_marking/synthliz_tertiary
	icon = 'modular_skyrat/master_files/icons/mob/body_markings/synthliz_tertiary.dmi'
	default_color = MARKING_DEFAULT_TERTIARY

/datum/body_marking/synthliz_tertiary/plates
	name = "Synth Plates"
	icon_state = "synthlizsplates"
	affected_bodyparts = CHEST

/datum/body_marking/synthliz_tertiary/chest_lights
	name = "Synth Chest Lights"
	icon_state = "synthlizlights"
	default_color = "#00FFFF"
	affected_bodyparts = CHEST

/datum/body_marking/synthliz_tertiary/collar_lights
	name = "Synth Collar Lights"
	icon_state = "synthlizpecslight"
	default_color = "#00FFFF"
	affected_bodyparts = CHEST | ARM_LEFT | ARM_RIGHT

/mob/living/carbon/human/proc/apply_body_markings()
	if(!islist(body_markings))
		update_body_marking_emissives()
		return
	ensure_body_marking_references()

	for(var/zone in GLOB.marking_zones)
		var/list/zone_markings = body_markings[zone]
		if(!length(zone_markings))
			continue

		for(var/marking_name in zone_markings)
			var/datum/body_marking/marking = GLOB.body_markings[marking_name]
			if(!marking)
				continue

			var/state = body_marking_state_for_limb(marking, zone, physique, digitigrade_legs)
			if(!(state in icon_states(marking.icon)))
				continue

			var/icon/marking_icon = new/icon(marking.icon, state)
			marking_icon.Blend(body_marking_entry_color(zone_markings[marking_name]), ICON_MULTIPLY)
			stand_icon.Blend(marking_icon, ICON_OVERLAY)

	update_body_marking_emissives()
