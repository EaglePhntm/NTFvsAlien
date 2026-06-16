/proc/get_gender_name(gender)
	var/g = "m"
	if (gender == FEMALE)
		g = "f"
	return g

/mob/living/carbon/human/proc/get_visual_species()
	if(species?.species_flags & IS_SYNTHETIC)
		var/datum/species/appearance_species = GLOB.all_species[synthetic_appearance_species]
		if(appearance_species && !(appearance_species.species_flags & IS_SYNTHETIC))
			return appearance_species
	return species

/proc/get_limb_icon_name(datum/species/S, gender, limb_name, ethnicity, digitigrade_legs = "Normal", synthetic_body_base = "Human", robot_body_base = "Combat Robot", robot_head_base = "Combat Robot", custom_supersoldier_parts = FALSE, supersoldier_body_base = "Human", supersoldier_head_base = "Human")
	if(istype(S, /datum/species/robot))
		var/robot_base = get_effective_robot_body_base(limb_name == "head" ? robot_head_base : robot_body_base)
		if(is_old_robot_body_base(robot_base))
			return get_generic_limb_icon_name(gender, limb_name, null)
		return get_robot_limb_icon_name(robot_base, gender, limb_name, digitigrade_legs)
	if(istype(S, /datum/species/human/prototype_supersoldier) && custom_supersoldier_parts)
		var/supersoldier_base = limb_name == "head" ? supersoldier_head_base : supersoldier_body_base
		return get_splurt_limb_icon_name(get_supersoldier_limb_prefix(supersoldier_base), gender, limb_name, digitigrade_legs)
	if(S.limb_type == SPECIES_LIMB_HUMAN) // todo this section is fucking stupid and can be way more generic easily
		switch(limb_name)
			if ("torso", "chest")
				return "[ethnicity]_torso_[get_gender_name(gender)]"

			if ("head")
				return "[ethnicity]_head_[get_gender_name(gender)]"

			if ("groin")
				return "[ethnicity]_groin_[get_gender_name(gender)]"

			if ("r_arm", "right arm")
				return "[ethnicity]_right_arm_[get_gender_name(gender)]"

			if ("l_arm", "left arm")
				return "[ethnicity]_left_arm_[get_gender_name(gender)]"

			if ("r_leg", "right leg")
				return "[ethnicity]_right_leg_[get_gender_name(gender)]"

			if ("l_leg", "left leg")
				return "[ethnicity]_left_leg_[get_gender_name(gender)]"

			if ("r_hand", "right hand")
				return "[ethnicity]_right_hand_[get_gender_name(gender)]"

			if ("l_hand", "left hand")
				return "[ethnicity]_left_hand_[get_gender_name(gender)]"

			if ("r_foot", "right foot")
				return "[ethnicity]_right_foot_[get_gender_name(gender)]"

			if ("l_foot", "left foot")
				return "[ethnicity]_left_foot_[get_gender_name(gender)]"

			else
				return null
	else if(S.limb_type == SPECIES_LIMB_CLONE)
		switch(limb_name)
			if ("torso", "chest")
				return "torso_[get_gender_name(gender)]"

			if ("head")
				return "head_[get_gender_name(gender)]"

			if ("groin")
				return "groin_[get_gender_name(gender)]"

			if ("r_arm", "right arm")
				return "right_arm_[get_gender_name(gender)]"

			if ("l_arm", "left arm")
				return "left_arm_[get_gender_name(gender)]"

			if ("r_leg", "right leg")
				return "right_leg_[get_gender_name(gender)]"

			if ("l_leg", "left leg")
				return "left_leg_[get_gender_name(gender)]"

			if ("r_hand", "right hand")
				return "right_hand_[get_gender_name(gender)]"

			if ("l_hand", "left hand")
				return "left_hand_[get_gender_name(gender)]"

			if ("r_foot", "right foot")
				return "right_foot_[get_gender_name(gender)]"

			if ("l_foot", "left foot")
				return "left_foot_[get_gender_name(gender)]"
	else if(S.limb_type == SPECIES_LIMB_SPLURT)
		return get_splurt_limb_icon_name(S.splurt_limb_prefix, gender, limb_name, digitigrade_legs)
	else
		var/digitigrade_prefix = S.digitigrade_limb_prefixes[digitigrade_legs]
		return get_generic_limb_icon_name(gender, limb_name, digitigrade_prefix)

/proc/get_supersoldier_limb_prefix(body_base)
	switch(body_base)
		if("Lizard")
			return "lizard"
		if("Anthro")
			return "mammal"
		if("Akula")
			return "akula"
		if("Aquatic")
			return "aquatic"
		if("Insectoid")
			return "insect"
		if("Skrell")
			return "skrell"
		if("Resurgentis")
			return "resurgentis"
	return "human"

/proc/get_supersoldier_body_icon(body_base)
	switch(body_base)
		if("Lizard")
			return BODYPART_ICON_LIZARD
		if("Anthro")
			return BODYPART_ICON_MAMMAL
		if("Akula")
			return BODYPART_ICON_AKULA
		if("Aquatic")
			return BODYPART_ICON_AQUATIC
		if("Insectoid")
			return BODYPART_ICON_INSECT
		if("Skrell")
			return BODYPART_ICON_SKRELL
	return BODYPART_ICON_HUMAN

/proc/get_robot_part_prefix(robot_base)
	switch(robot_base)
		if("Android")
			return "ipc"
		if("Dark Android")
			return "synth"
		if("Human")
			return "human"
		if("Lizard")
			return "synthliz"
		if("Anthro")
			return "synthmammal"
		if("Morpheus Cyberkinetics")
			return "mcgipc"
		if("Bishop Cyberkinetics")
			return "bshipc"
		if("Bishop Cyberkinetics 2.0")
			return "bs2ipc"
		if("Hephaestus Industries")
			return "hsiipc"
		if("Hephaestus Industries 2.0")
			return "hi2ipc"
		if("Shellguard Munitions")
			return "sgmipc"
		if("Ward-Takahashi Manufacturing")
			return "wtmipc"
		if("Xion Manufacturing Group")
			return "xmgipc"
		if("Xion Manufacturing Group 2.0")
			return "xm2ipc"
		if("Zeng-Hu Pharmaceuticals")
			return "zhpipc"
		if("E3N AI")
			return "e3n"
	return "ipc"

/proc/robot_part_uses_dimorphic_states(robot_base)
	return robot_base in list("Human", "Lizard", "Anthro")

/proc/robot_part_uses_split_hand_states(robot_base)
	return robot_base in list("Human", "Android", "Dark Android")

/proc/robot_head_uses_human_eyes(robot_base)
	return robot_base in list("Human", "Lizard", "Anthro")

/proc/get_robot_part_body_icon(robot_base)
	switch(robot_base)
		if("Human")
			return BODYPART_ICON_HUMAN
		if("Lizard")
			return BODYPART_ICON_SYNTHLIZARD
		if("Anthro")
			return BODYPART_ICON_SYNTHMAMMAL
	return BODYPART_ICON_IPC

/proc/is_old_robot_body_base(robot_base)
	return robot_base in list("Combat Robot", "Hammerhead", "Chilvaris", "Ratcher", "Sterling", "Synskin")

/proc/get_old_robot_body_icon(robot_base)
	switch(robot_base)
		if("Hammerhead")
			return 'icons/mob/human_races/r_robot_alpharii.dmi'
		if("Chilvaris")
			return 'icons/mob/human_races/r_robot_charlit.dmi'
		if("Ratcher")
			return 'icons/mob/human_races/r_robot_deltad.dmi'
		if("Sterling")
			return 'icons/mob/human_races/r_robot_bravada.dmi'
		if("Synskin")
			return 'ntf_modular/icons/mob/human_races/r_synthetic.dmi'
	return 'icons/mob/human_races/r_robot.dmi'

/proc/get_splurt_robot_body_icon(robot_base)
	if(is_old_robot_body_base(robot_base))
		return get_old_robot_body_icon(robot_base)
	return get_robot_part_body_icon(robot_base)

/proc/get_effective_robot_body_base(robot_base)
	return robot_base || "Combat Robot"

/proc/get_robot_limb_icon_name(robot_base, gender, limb_name, digitigrade_legs)
	var/robot_prefix = get_robot_part_prefix(robot_base)
	if(robot_base == "Lizard" || robot_base == "Anthro")
		return get_splurt_limb_icon_name(robot_prefix, gender, limb_name, digitigrade_legs)
	var/dimorphic = robot_part_uses_dimorphic_states(robot_base)
	switch(limb_name)
		if("torso", "chest", "groin")
			if(dimorphic)
				return "[robot_prefix]_chest_[get_gender_name(gender)]"
			return "[robot_prefix]_chest"
		if("head")
			if(dimorphic)
				return "[robot_prefix]_head_[get_gender_name(gender)]"
			return "[robot_prefix]_head"
		if("r_arm", "right arm")
			return "[robot_prefix]_r_arm"
		if("l_arm", "left arm")
			return "[robot_prefix]_l_arm"
		if("r_hand", "right hand")
			if(robot_part_uses_split_hand_states(robot_base))
				return "[robot_prefix]_r_hand"
			return "[robot_prefix]_r_arm"
		if("l_hand", "left hand")
			if(robot_part_uses_split_hand_states(robot_base))
				return "[robot_prefix]_l_hand"
			return "[robot_prefix]_l_arm"
		if("r_leg", "right leg", "r_foot", "right foot")
			return "[robot_prefix]_r_leg"
		if("l_leg", "left leg", "l_foot", "left foot")
			return "[robot_prefix]_l_leg"
	return null

/proc/get_splurt_limb_icon_name(prefix, gender, limb_name, digitigrade_legs)
	switch(limb_name)
		if("torso", "chest", "groin")
			return "[prefix]_chest_[get_gender_name(gender)]"
		if("head")
			return "[prefix]_head_[get_gender_name(gender)]"
		if("r_arm", "right arm")
			return "[prefix]_r_arm"
		if("l_arm", "left arm")
			return "[prefix]_l_arm"
		if("r_hand", "right hand")
			return "[prefix]_r_hand"
		if("l_hand", "left hand")
			return "[prefix]_l_hand"
		if("r_leg", "right leg", "r_foot", "right foot")
			if(digitigrade_legs == "Tallboy")
				return "tallboy_r_leg"
			if(digitigrade_legs == "Digitigrade")
				return "digitigrade_1_r_leg"
			if(digitigrade_legs == "Digitigrade 2")
				return "digitigrade_2_r_leg"
			return "[prefix]_r_leg"
		if("l_leg", "left leg", "l_foot", "left foot")
			if(digitigrade_legs == "Tallboy")
				return "tallboy_l_leg"
			if(digitigrade_legs == "Digitigrade")
				return "digitigrade_1_l_leg"
			if(digitigrade_legs == "Digitigrade 2")
				return "digitigrade_2_l_leg"
			return "[prefix]_l_leg"
	return null

/proc/get_generic_limb_icon_name(gender, limb_name, digitigrade_prefix)
	switch(limb_name)
		if ("torso")
			return "[limb_name]_[get_gender_name(gender)]"
		if ("chest")
			return "torso_[get_gender_name(gender)]"
		if ("head")
			return "head_[get_gender_name(gender)]"
		if ("groin")
			return "[limb_name]_[get_gender_name(gender)]"
		if ("r_arm", "right arm")
			return "r_arm"
		if ("l_arm", "left arm")
			return "l_arm"
		if ("r_leg", "right leg")
			if(digitigrade_prefix)
				return "[digitigrade_prefix]_r_leg"
			return "r_leg"
		if ("l_leg", "left leg")
			if(digitigrade_prefix)
				return "[digitigrade_prefix]_l_leg"
			return "l_leg"
		if ("r_hand", "right hand")
			return "r_hand"
		if ("l_hand", "left hand")
			return "l_hand"
		if ("r_foot", "right foot")
			if(digitigrade_prefix)
				return "[digitigrade_prefix]_r_leg"
			return "r_foot"
		if ("l_foot", "left foot")
			if(digitigrade_prefix)
				return "[digitigrade_prefix]_l_leg"
			return "l_foot"
		else
			return null

/mob/living/carbon/human/proc/set_limb_icons()
	var/datum/ethnicity/E = GLOB.ethnicities_list[ethnicity]

	var/e_icon

	if (!E)
		e_icon = "western"
	else
		e_icon = E.icon_name

	for(var/datum/limb/L in limbs)
		L.icon_name = get_limb_icon_name(get_visual_species(), physique, L.display_name, e_icon, digitigrade_legs, synthetic_body_base, robot_body_base, robot_head_base, custom_supersoldier_parts, supersoldier_body_base, supersoldier_head_base)

/mob/living/carbon/human/proc/get_body_icon()
	var/datum/species/visual_species = get_visual_species()
	if(istype(visual_species, /datum/species/robot))
		return get_splurt_robot_body_icon(get_effective_robot_body_base(robot_body_base))
	if(istype(visual_species, /datum/species/human/prototype_supersoldier) && custom_supersoldier_parts)
		return get_supersoldier_body_icon(supersoldier_body_base)
	return visual_species.icobase

/mob/living/carbon/human/proc/get_body_icon_for_limb(limb_name)
	var/datum/species/visual_species = get_visual_species()
	if(istype(visual_species, /datum/species/robot))
		var/robot_base = get_effective_robot_body_base(limb_name == "head" ? robot_head_base : robot_body_base)
		return get_splurt_robot_body_icon(robot_base)
	if(istype(visual_species, /datum/species/human/prototype_supersoldier) && custom_supersoldier_parts)
		var/supersoldier_base = limb_name == "head" ? supersoldier_head_base : supersoldier_body_base
		return get_supersoldier_body_icon(supersoldier_base)
	return get_body_icon()

/mob/living/carbon/human/proc/get_eye_icon_state()
	var/datum/species/visual_species = get_visual_species()
	if(istype(visual_species, /datum/species/robot))
		var/robot_base = get_effective_robot_body_base(robot_head_base)
		if(robot_head_uses_human_eyes(robot_base))
			return "eyes_s"
		return "blank_eyes"
	return visual_species.eyes

/mob/living/carbon/human/proc/get_render_body_color()
	if(species?.name == "Moth" && (!body_color || body_color == "#FFFFFF"))
		return sanitize_character_recolor(species.flesh_color)
	return sanitize_character_recolor(body_color)

/mob/living/carbon/human/proc/get_render_hair_color()
	return sanitize_hair_recolor(rgb(r_hair, g_hair, b_hair))

/mob/living/carbon/human/proc/get_render_gradient_color()
	return sanitize_hair_recolor(rgb(r_grad, g_grad, b_grad))

/mob/living/carbon/human/proc/get_render_facial_hair_color()
	return sanitize_hair_recolor(rgb(r_facial, g_facial, b_facial))

/mob/living/carbon/human/get_reagent_tags()
	. = ..()
	return .|IS_HUMAN

/mob/living/carbon/human/can_inject(mob/user, error_msg, target_zone, penetrate_thick = FALSE)
	. = reagents

	if(!.) //yikes
		return

	if(!user)
		target_zone = pick("chest","chest","chest","left leg","right leg","left arm", "right arm", "head")
	else if(!target_zone)
		target_zone = user.zone_selected

	if(!penetrate_thick)
		switch(target_zone)
			if("head")
				if(head?.inventory_flags & BLOCKSHARPOBJ)
					. = FALSE
			else
				if(wear_suit?.inventory_flags & BLOCKSHARPOBJ)
					. = FALSE
	if(!. && error_msg && user)
		// Might need re-wording.
		to_chat(user, span_alert("There is no exposed flesh or thin material [target_zone == "head" ? "on their head" : "on their body"] to inject into."))


/mob/living/carbon/human/has_brain()
	var/datum/internal_organ/brain = get_organ_slot(ORGAN_SLOT_BRAIN)
	if(!istype(brain))
		return FALSE
	var/datum/limb/braincase = get_limb(brain.parent_limb)
	if(braincase.limb_status & LIMB_DESTROYED)
		return FALSE
	return TRUE

/mob/living/carbon/human/has_eyes()
	if(get_organ_slot(ORGAN_SLOT_EYES))
		var/datum/internal_organ/eyes = get_organ_slot(ORGAN_SLOT_EYES)
		if(eyes && istype(eyes))
			return 1
	return 0

/mob/living/carbon/human/has_vision()
	if(disabilities & BLIND)
		return FALSE
	if(!species.has_organ["eyes"]) //can see through other means
		return TRUE
	if(!has_eyes())
		return FALSE
	if(tinttotal >= TINT_BLIND)
		return FALSE
	return TRUE


/mob/living/carbon/human/has_legs()
	. = 0
	if(has_limb(FOOT_RIGHT) && has_limb(LEG_RIGHT))
		.++
	if(has_limb(FOOT_LEFT) && has_limb(LEG_LEFT))
		.++

/mob/living/carbon/human/get_permeability_protection()
	// hands = 1 | chest = 2 | groin = 3 | legs = 4 | feet = 5 | arms = 6 | head = 7
	var/list/prot = list(0,0,0,0,0,0,0)
	for(var/obj/item/I in get_equipped_items())
		if(I.armor_protection_flags & HANDS)
			prot[1] = max(1 - I.permeability_coefficient, prot[1])
		if(I.armor_protection_flags & CHEST)
			prot[2] = max(1 - I.permeability_coefficient, prot[2])
		if(I.armor_protection_flags & GROIN)
			prot[3] = max(1 - I.permeability_coefficient, prot[3])
		if(I.armor_protection_flags & LEGS)
			prot[4] = max(1 - I.permeability_coefficient, prot[4])
		if(I.armor_protection_flags & FEET)
			prot[5] = max(1 - I.permeability_coefficient, prot[5])
		if(I.armor_protection_flags & ARMS)
			prot[6] = max(1 - I.permeability_coefficient, prot[6])
		if(I.armor_protection_flags & HEAD)
			prot[7] = max(1 - I.permeability_coefficient, prot[7])
	var/protection = (prot[7] + prot[6] + prot[5] + prot[4] + prot[3] + prot[2] + prot[1])/7
	return protection

/mob/living/carbon/human/get_soft_acid_protection()
	var/protection = 0
	for(var/def_zone in GLOB.human_body_parts)
		protection += get_soft_armor(ACID, def_zone)
	// adds arms and feet twice since precise.(acid armor goes from 0 to 100)
	return protection/1100

/mob/living/carbon/human/get_hard_acid_protection()
	var/protection = 0
	for(var/def_zone in GLOB.human_body_parts)
		protection += get_hard_armor(ACID, def_zone)
	// adds arms and feet twice since precise.
	return protection/11

/mob/living/carbon/human/get_standard_bodytemperature()
	return species.body_temperature

/mob/living/carbon/human/get_policy_keywords()
	. = ..()
	if(species.name)
		. += species.name

///wrapper for a signal to handle opening the squad selector ui just before drop
/mob/living/carbon/human/proc/suggest_squad_assign()
	SIGNAL_HANDLER
	UnregisterSignal(SSdcs, COMSIG_GLOB_DEPLOY_TIMELOCK_ENDED)
	GLOB.squad_selector.interact(src)

/**
 * Proc to check if a carbon human has the required organs to sustain life.
 *
 * Returns false if `has_brain` returns false, this human is missing a heart, or their current heart is broken
 *
 * Returns true otherwise
 */
/mob/living/carbon/human/proc/has_working_organs()
	var/datum/internal_organ/heart/heart = get_organ_slot(ORGAN_SLOT_HEART)

	if(species.species_flags & ROBOTIC_LIMBS)
		return TRUE // combat robots and synthetics don't have any of these for some reason
	if(!has_brain())
		return FALSE
	if(!heart || heart.organ_status == ORGAN_BROKEN)
		return FALSE
	return TRUE

/**
 * Proc that brings a carbon human back to life. Only works if their health is higher than their death threshold and they are dead in the first place.
 *
 * Intended to be called by defibrillators or anything that brings a carbon human back to life
 */
/mob/living/carbon/human/proc/resuscitate()
	if(stat != DEAD || health <= get_death_threshold())
		return
	set_stat(UNCONSCIOUS)
	chestburst = CARBON_NO_CHEST_BURST
	regenerate_icons()
	reload_fullscreens()
	handle_regular_hud_updates()
	updatehealth() //One more time, so it doesn't show the target as dead on HUDs
	dead_ticks = 0 //We reset the DNR timer
	REMOVE_TRAIT(src, TRAIT_PSY_DRAINED, TRAIT_PSY_DRAINED)
	clear_fullscreen("death")

/**
 * Proc for checking parameters of a human for defibrillation.
 *
 * Checks decapitation, DNR status, organ damage and health status (in that order) for defibrillation.
 *
 * See defines in `__DEFINES/defibrillator.dm` for bitflags.
 *
 * `additional_health_increase` can be used to add additional health when calculating health for situations like grabbing ghost.
 */
/mob/living/carbon/human/proc/check_defib(additional_health_increase = 0)

	var/datum/limb/head/head = get_limb("head")
	if(head.limb_status & LIMB_DESTROYED)
		return DEFIB_FAIL_DECAPITATED

	if(HAS_TRAIT(src, TRAIT_UNDEFIBBABLE))
		return DEFIB_FAIL_BRAINDEAD

	if(!has_working_organs())
		return DEFIB_FAIL_BAD_ORGANS

	if((health + getOxyLoss() + additional_health_increase <= get_death_threshold()) && !HAS_TRAIT(src, TRAIT_IMMEDIATE_DEFIB))
		return DEFIB_FAIL_TOO_MUCH_DAMAGE

	return DEFIB_POSSIBLE

/**
 * Setter for mob height
 *
 * Exists so that the update is done immediately
 *
 * Returns TRUE if changed, FALSE otherwise
 */
/mob/living/carbon/human/proc/set_mob_height(new_height)
	if(mob_height == new_height)
		return FALSE
	if(new_height == HUMAN_HEIGHT_DWARF || new_height == MONKEY_HEIGHT_DWARF)
		CRASH("Don't set height to dwarf height directly, use dwarf trait instead.")
	if(new_height == MONKEY_HEIGHT_MEDIUM)
		CRASH("Don't set height to monkey height directly, use monkified gene/species instead.")

	mob_height = new_height
	regenerate_icons()
	return TRUE

/**
 * Getter for mob height
 *
 * Mainly so that dwarfism can adjust height without needing to override existing height
 *
 * Returns a mob height num
 */
/mob/living/carbon/human/proc/get_mob_height()
	if(HAS_TRAIT(src, TRAIT_DWARF))
		if(ismonkey(src))
			return MONKEY_HEIGHT_DWARF
		else
			return HUMAN_HEIGHT_DWARF
	if(HAS_TRAIT(src, TRAIT_TOO_TALL))
		if(ismonkey(src))
			return MONKEY_HEIGHT_TALL
		else
			return HUMAN_HEIGHT_TALLEST

	else if(ismonkey(src))
		return MONKEY_HEIGHT_MEDIUM

	return mob_height

///Gets organ by name
/mob/living/carbon/human/proc/get_organ_slot(string)
	return internal_organs_by_name[string]

///Removes organ by name
/mob/living/carbon/human/proc/remove_organ_slot(string)
	var/datum/internal_organ/organ = get_organ_slot(string)
	internal_organs_by_name -= string
	internal_organs -= organ

/// Current active hand will interact with the other hand. Uses attackby and attack_hand.
/mob/living/carbon/human/proc/interact_other_hand()
	var/atom/active_hand = get_active_held_item()
	var/atom/inactive_hand = get_inactive_held_item()

	if(!inactive_hand)
		return
	if(!active_hand)
		inactive_hand.attack_hand(src)
		return
	inactive_hand.attackby(active_hand, src)

/mob/living/MouseDrop_T(atom/dropping, mob/user)
	. = ..()
	if(dropping != usr)
		return
	if(!isliving(dropping))
		return
	if(!isliving(user))
		return
	if(!user.sexcon || !sexcon)
		return
	if(user.incapacitated(TRUE))
		return
	if(dropping != src)
		user.sexcon.set_target(src)
		if(user.a_intent != INTENT_HELP && !user.sexcon.current_action)
			user.face_atom(src)
			face_atom(user)
			var/action = /datum/sex_action/rimming // neuter things ig
			if(gender == MALE)
				if(user.gender == MALE || (isxeno(user) && user.client?.prefs?.xenogender > 2))
					action = pick(/datum/sex_action/anal_sex, /datum/sex_action/throat_sex, /datum/sex_action/frotting) //funny frot
				else if(user.gender == FEMALE)
					action = pick(/datum/sex_action/vaginal_ride_sex, /datum/sex_action/anal_ride_sex, /datum/sex_action/blowjob)
			else if(gender == FEMALE)
				if(user.gender == MALE || (isxeno(user) && user.client?.prefs?.xenogender <= 2))
					action = pick(/datum/sex_action/vaginal_sex, /datum/sex_action/anal_sex, /datum/sex_action/throat_sex)
				else if(user.gender == FEMALE)
					action = pick(/datum/sex_action/scissoring, /datum/sex_action/facesitting, /datum/sex_action/cunnilingus)
			user.sexcon.speed = SEX_SPEED_HIGH
			if(user.a_intent == INTENT_GRAB) //in place of help cuz that opens regular sexcon
				balloon_alert_to_viewers("QK heal sex")
				if(!buckled)
					user.start_pulling(src)
				user.sexcon.drain_style = SEX_DRAIN_STYLE_HEAL_TARGET
				user.sexcon.force = SEX_FORCE_LOW
			if(user.a_intent == INTENT_HARM)
				balloon_alert_to_viewers("QK health-drain sex")
				user.sexcon.drain_style = SEX_DRAIN_STYLE_DRAIN_BLOOD_FAST
				user.sexcon.force = SEX_FORCE_MAX
			if(user.a_intent == INTENT_DISARM)
				balloon_alert_to_viewers("QK stam-drain sex")
				if(!buckled)
					user.start_pulling(src)
				user.sexcon.drain_style = SEX_DRAIN_STYLE_DRAIN_STAMINA
				user.sexcon.force = SEX_FORCE_MID
			if(lying_angle)
				AdjustParalyzed(2 SECONDS)
				user.forceMove(loc)
				user.sexcon.speed = SEX_SPEED_EXTREME
			else
				AdjustImmobilized(1 SECONDS)
			user.sexcon.try_start_action(action)
			return
	erptime(user, src)

/mob/living/proc/start_quick_fuck(mob/target, sexforce = SEX_FORCE_MID)
	if(!istype(target))
		return
	var/action
	if(gender == MALE)
		if(target.gender == MALE || target.sexcon.can_use_penis())
			action = pick(/datum/sex_action/anal_sex, /datum/sex_action/tailpegging_anal, /datum/sex_action/throat_sex)
		else if(target.gender == FEMALE)
			action = pick(/datum/sex_action/vaginal_ride_sex, /datum/sex_action/anal_ride_sex, /datum/sex_action/throat_sex)
	else if(gender == FEMALE)
		if(target.gender == MALE || target.sexcon.can_use_penis())
			action = pick(/datum/sex_action/vaginal_sex, /datum/sex_action/anal_sex, /datum/sex_action/blowjob)
		else if(target.gender == FEMALE)
			action = pick(/datum/sex_action/scissoring, /datum/sex_action/tailpegging_vaginal, /datum/sex_action/tailpegging_anal, /datum/sex_action/force_cunnilingus)
	sexcon.force = SEX_FORCE_MAX
	sexcon.set_target(target)
	sexcon.try_start_action(action)
