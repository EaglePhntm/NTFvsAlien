/datum/species/robot
	name = "Combat Robot"
	species_type = SPECIES_COMBAT_ROBOT
	icobase = 'icons/mob/human_races/r_robot.dmi'
	damage_mask_icon = 'icons/mob/dam_mask_robot.dmi'
	brute_damage_icon_state = "robot_brute"
	burn_damage_icon_state = "robot_burn"
	eyes = "blank_eyes"
	default_language_holder = /datum/language_holder/robot
	namepool = /datum/namepool/robotic

	unarmed_type = /datum/unarmed_attack/punch/strong
	total_health = 150

	cold_level_1 = -1
	cold_level_2 = -1
	cold_level_3 = -1

	heat_level_1 = 500
	heat_level_2 = 1000
	heat_level_3 = 2000

	body_temperature = 350

	inherent_traits = list(TRAIT_IMMEDIATE_DEFIB)
	species_flags = NO_BREATHE|NO_BLOOD|NO_POISON|NO_PAIN|NO_CHEM_METABOLIZATION|DETACHABLE_HEAD|ROBOTIC_LIMBS|IS_INSULATED
	stamina_mod = 0.75
	max_stamina = 0

	no_equip = list(
//		SLOT_W_UNIFORM,
//		SLOT_HEAD,
//		SLOT_WEAR_MASK,
//		SLOT_WEAR_SUIT,
//		SLOT_SHOES,
//		SLOT_GLOVES,
//		SLOT_GLASSES,
	)
	blood_color = "#2d2055" //an oil-like color - a little note, robots cannot shed blood in any way, due to their flags
	has_organ = list()
	screams = list(MALE = SFX_ROBOT_SCREAM, FEMALE = SFX_ROBOT_SCREAM, PLURAL = SFX_ROBOT_SCREAM, NEUTER = SFX_ROBOT_SCREAM)
	paincries = list(MALE = SFX_ROBOT_PAIN, FEMALE = SFX_ROBOT_PAIN, PLURAL = SFX_ROBOT_PAIN, NEUTER = SFX_ROBOT_PAIN)
	goredcries = list(MALE = SFX_ROBOT_SCREAM, FEMALE = SFX_ROBOT_SCREAM, PLURAL = SFX_ROBOT_SCREAM, NEUTER = SFX_ROBOT_SCREAM)
	warcries = list(MALE = SFX_ROBOT_WARCRY, FEMALE = SFX_ROBOT_WARCRY, PLURAL = SFX_ROBOT_WARCRY, NEUTER = SFX_ROBOT_WARCRY)
	robotnoises = list(MALE = SFX_ROBOT_NOISES, FEMALE = SFX_ROBOT_NOISES, PLURAL = SFX_ROBOT_NOISES, NEUTER = SFX_ROBOT_NOISES)
	robotthreaten = list(MALE = SFX_ROBOT_THREATEN, FEMALE = SFX_ROBOT_THREATEN, PLURAL = SFX_ROBOT_THREATEN, NEUTER = SFX_ROBOT_THREATEN)
	death_message = "shudders violently whilst spitting out error text before collapsing, their visual sensor darkening..."
	special_death_message = "You have been shut down.<br><small>But it is not the end of you yet... if you still have your body, wait until somebody can resurrect you...</small>"
	joinable_roundstart = TRUE

	inherent_actions = list(/datum/action/repair_self)

/datum/species/robot/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	H.speaking_noise = SFX_ROBOT_NOISES
	H.speech_span = SPAN_ROBOT
	H.voice_filter = "afftfilt=real='hypot(re,im)*sin(0)':imag='hypot(re,im)*cos(0)':win_size=512:overlap=1,rubberband=pitch=0.8"
	H.health_threshold_crit = -100

/datum/species/robot/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	H.speaking_noise = initial(H.speaking_noise)
	H.speech_span = initial(H.speech_span)
	H.voice_filter = initial(H.voice_filter)
	H.health_threshold_crit = -50

/mob/living/carbon/human
	COOLDOWN_DECLARE(soft_crit_emote_cooldown)
	COOLDOWN_DECLARE(hard_crit_emote_cooldown)

/datum/species/robot/handle_unique_behavior(mob/living/carbon/human/H)
	if(H.health <= -0 && H.health > -90) // Doesn't kill, purely for sex/capture reasons
		H.take_overall_damage(rand(2, 6), BURN, updating_health = TRUE, max_limbs = 1) // Melting!!!
	if(H.health <= 0 && H.health > -50)
		H.clear_fullscreen("robotlow")
		H.overlay_fullscreen("robothalf", /atom/movable/screen/fullscreen/robot/machine/robothalf)
		if(COOLDOWN_FINISHED(H, soft_crit_emote_cooldown))
			COOLDOWN_START(H, soft_crit_emote_cooldown, 40 SECONDS)
			H.emote("damaged")
			to_chat(H, span_warning("Critical damage sustained. Repair damage immediately. <b>Integrity: [round(H.health)]%.</b>"))
		if(prob(25))
			do_sparks(4, TRUE, H)
	else if(H.health <= -50)
		H.clear_fullscreen("robothalf")
		H.overlay_fullscreen("robotlow", /atom/movable/screen/fullscreen/robot/machine/robotlow)
		if(COOLDOWN_FINISHED(H, hard_crit_emote_cooldown))
			COOLDOWN_START(H, hard_crit_emote_cooldown, 40 SECONDS)
			H.emote("critical")
			to_chat(H, span_warning("Critical damage sustained. Total system failure imminent. <b>Integrity: [round(H.health)]%.</b>"))
		if(prob(25))
			do_sparks(4, TRUE, H)
	else
		H.clear_fullscreen("robothalf")
		H.clear_fullscreen("robotlow")
	if(H.health > -25) //Staggerslowed if below crit threshold
		return
	H.apply_effect(4 SECONDS, EFFECT_STUTTER) // Added flavor
	H.Stagger(2 SECONDS)
	H.adjust_slowdown(1)
	if(H.health <= -80) //Paralyzes when near death
		H.Paralyze(6 SECONDS)

///Lets a robot repair itself over time at the cost of being stunned and blind
/datum/action/repair_self
	name = "Activate autorepair"
	action_icon_state = "suit_configure"
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_KB_ROBOT_AUTOREPAIR,
	)

/*/datum/action/repair_self/can_use_action(silent, override_flags, selecting)
	. = ..()
	if(!.)
		return
	return !owner.incapacitated()*/

/datum/action/repair_self/action_activate()
	. = ..()
	if(!. || !ishuman(owner))
		return
	if(owner.stat == DEAD)
		return
	var/mob/living/carbon/human/howner = owner
	if(howner.has_status_effect(STATUS_EFFECT_REPAIR_MODE))
		return
	if(!howner.getBruteLoss() && !howner.getFireLoss())
		return
	howner.apply_status_effect(STATUS_EFFECT_REPAIR_MODE, 10 SECONDS)
	howner.balloon_alert_to_viewers("repairing...")

/datum/species/robot/alpharii
	name = "Hammerhead Combat Robot"
	icobase = 'icons/mob/human_races/r_robot_alpharii.dmi'
	joinable_roundstart = FALSE

/datum/species/robot/charlit
	name = "Chilvaris Combat Robot"
	icobase = 'icons/mob/human_races/r_robot_charlit.dmi'
	joinable_roundstart = FALSE

/datum/species/robot/deltad
	name = "Ratcher Combat Robot"
	icobase = 'icons/mob/human_races/r_robot_deltad.dmi'
	joinable_roundstart = FALSE

/datum/species/robot/bravada
	name = "Sterling Combat Robot"
	icobase = 'icons/mob/human_races/r_robot_bravada.dmi'
	joinable_roundstart = FALSE

/datum/species/robot/synskin
	name = "Synskin Combat Robot"
	icobase = 'ntf_modular/icons/mob/human_races/r_synthetic.dmi'
	joinable_roundstart = FALSE
