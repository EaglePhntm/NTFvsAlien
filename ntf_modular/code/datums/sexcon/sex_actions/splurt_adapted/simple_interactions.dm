/proc/sexcon_interaction_message(message, mob/living/user, mob/living/target)
	if(!message)
		return null
	. = replacetext(message, "%USER%", "[user]")
	. = replacetext(., "%TARGET%", "[target]")
	. = replacetext(., "%USER_THEIR%", "[user.p_their()]")
	. = replacetext(., "%TARGET_THEIR%", "[target.p_their()]")

/mob/living/proc/sexcon_has_knotted_penis(require_exposed = FALSE)
	if(isxeno(src))
		return sexcon_has_penis(require_exposed)
	if(!ishuman(src))
		return FALSE
	var/mob/living/carbon/human/human = src
	return (human.cock in list("knotted", "barbknot", "hemiknot")) && (!require_exposed || human.sexcon_part_exposed("cock"))

/mob/living/proc/sexcon_flared(require_exposed = FALSE)
	if(isxeno(src))
		return sexcon_has_penis(require_exposed)
	if(!ishuman(src))
		return FALSE
	var/mob/living/carbon/human/human = src
	return human.cock == "flared" && (!require_exposed || human.sexcon_part_exposed("cock"))

#define SEXCON_CUTE_INTERACTION_COLOR "blue"
#define SEXCON_CUTE_INTERACTION_PRIORITY 0
#define SEXCON_TOUCH_INTERACTION_SOUNDS list('sound/weapons/tap.ogg', 'sound/effects/rustle1.ogg', 'sound/effects/rustle2.ogg')
#define SEXCON_SLAP_INTERACTION_SOUNDS list('sound/weapons/banjoslap.ogg', 'sound/weapons/punchmiss.ogg')
#define SEXCON_WET_INTERACTION_SOUNDS list('ntf_modular/sound/misc/mat/fingering.ogg', 'ntf_modular/sound/misc/mat/segso.ogg')
#define SEXCON_HAND_INTERACTION_SOUNDS list('ntf_modular/sound/misc/mat/fingering.ogg')

/datum/sex_action/simple_interaction
	abstract_type = /datum/sex_action/simple_interaction
	continous = FALSE
	stamina_cost = 0.1
	check_incapacitated = FALSE
	heal_sex = TRUE
	var/start_message
	var/perform_message
	var/finish_message
	var/user_arousal = 0
	var/target_arousal = 0
	var/user_pain = 0
	var/target_pain = 0
	var/allow_self = FALSE
	var/self_only = FALSE
	var/require_user_knot = FALSE
	var/require_target_knot = FALSE
	var/require_user_flare = FALSE
	var/require_target_flare = FALSE
	var/require_user_knot_exposed = TRUE
	var/require_target_knot_exposed = TRUE
	var/require_user_flare_exposed = TRUE
	var/require_target_flare_exposed = TRUE
	var/perform_sound = TRUE
	var/perform_sucking_noise = FALSE
	var/message_signature_effects = TRUE
	var/list/perform_sounds
	var/perform_sound_volume = 20
	var/replaced_by_base_action = FALSE
	var/quick_heal_requires_target_pref = TRUE
	var/penetrative = FALSE
	var/user_penetrative = FALSE
	var/target_hole = null

/datum/sex_action/simple_interaction/shows_on_menu(mob/living/carbon/user, mob/living/carbon/target)
	if(replaced_by_base_action)
		return FALSE
	if(self_only)
		return user == target
	if(!allow_self && user == target)
		return FALSE
	return TRUE

/datum/sex_action/simple_interaction/can_perform(mob/living/carbon/user, mob/living/carbon/target)
	if(self_only && user != target)
		return FALSE
	if(!allow_self && user == target)
		return FALSE
	if(require_user_knot && !user.sexcon_has_knotted_penis(require_user_knot_exposed))
		return FALSE
	if(require_target_knot && !target.sexcon_has_knotted_penis(require_target_knot_exposed))
		return FALSE
	if(require_user_flare && !user.sexcon_flared(require_user_flare_exposed))
		return FALSE
	if(require_target_flare && !target.sexcon_flared(require_target_flare_exposed))
		return FALSE
	return TRUE

/datum/sex_action/simple_interaction/is_unavailable_due_to_parts(mob/living/carbon/user, mob/living/carbon/target)
	if(!meets_anatomy_requirements(user, target))
		return TRUE
	if(require_user_knot && !user.sexcon_has_knotted_penis(require_user_knot_exposed))
		return TRUE
	if(require_target_knot && !target.sexcon_has_knotted_penis(require_target_knot_exposed))
		return TRUE
	if(require_user_flare && !user.sexcon_flared(require_user_flare_exposed))
		return TRUE
	if(require_target_flare && !target.sexcon_flared(require_target_flare_exposed))
		return TRUE
	return FALSE

/datum/sex_action/simple_interaction/proc/get_perform_sounds()
	if(length(perform_sounds))
		return perform_sounds
	if(continous || user_arousal >= 4 || target_arousal >= 4)
		return SEXCON_WET_INTERACTION_SOUNDS
	return SEXCON_TOUCH_INTERACTION_SOUNDS

/datum/sex_action/simple_interaction/proc/play_perform_sound(mob/living/carbon/user)
	if(!perform_sound)
		return
	if(perform_sucking_noise)
		user.make_sucking_noise()
		return
	var/list/sounds = get_perform_sounds()
	if(!length(sounds))
		return
	playsound(user, pick(sounds), perform_sound_volume, TRUE, 5, ignore_walls = FALSE)

/datum/sex_action/simple_interaction/on_start(mob/living/carbon/user, mob/living/carbon/target)
	var/message = sexcon_interaction_message(start_message, user, target)
	if(message)
		user.visible_message(span_warning(message))

/datum/sex_action/simple_interaction/on_perform(mob/living/carbon/user, mob/living/carbon/target)
	var/message = sexcon_interaction_message(perform_message, user, target)
	if(message && user.sexcon.do_message_signature("[type]", message_signature_effects))
		user.visible_message(user.sexcon.spanify_force(message))
	play_perform_sound(user)
	if(user_arousal || user_pain)
		user.sexcon.perform_sex_action(user, user_arousal, user_pain, TRUE)
		user.sexcon.handle_passive_ejaculation(user)
	if((target_arousal || target_pain) && target != user)
		user.sexcon.perform_sex_action(target, target_arousal, target_pain, FALSE)
		target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/simple_interaction/on_finish(mob/living/carbon/user, mob/living/carbon/target)
	var/message = sexcon_interaction_message(finish_message, user, target)
	if(message)
		user.visible_message(span_warning(message))
	if(isxeno(user) && penetrative) //assumed male xeno -> human
		var/mob/living/carbon/xenomorph/X = user
		X.impregify(target, target_hole)
	if(isxeno(user) && user_penetrative) //rider xeno -> human
		var/mob/living/carbon/xenomorph/X = user
		X.xenoimpregify(target)
	if(isxeno(target) && penetrative) //human male -> xeno
		var/mob/living/carbon/xenomorph/X = target
		X.xenoimpregify(target)
	if(isxeno(target) && user_penetrative) //human female -> xeno
		var/mob/living/carbon/xenomorph/X = user
		X.impregify(user, target_hole)

/datum/sex_action/simple_interaction/can_heal(mob/living/carbon/user, mob/living/carbon/target, mob/living/action_target)
	if(quick_heal_requires_target_pref \
		&& user?.sexcon?.drain_style == SEX_DRAIN_STYLE_HEAL_TARGET \
		&& action_target?.mind \
		&& !(action_target.client?.prefs.sex_pref_flags & SEXPREF_QUICK_SEX_HEAL))
		return FALSE
	return ..()

/datum/sex_action/simple_interaction/cheer
	name = "Cheer"
	check_proximity = FALSE
	menu_color = SEXCON_CUTE_INTERACTION_COLOR
	menu_priority = SEXCON_CUTE_INTERACTION_PRIORITY
	perform_sound = FALSE
	perform_message = "%USER% cheers %TARGET% on."

/datum/sex_action/simple_interaction/beckon
	name = "Beckon"
	check_proximity = FALSE
	menu_color = SEXCON_CUTE_INTERACTION_COLOR
	menu_priority = SEXCON_CUTE_INTERACTION_PRIORITY
	perform_sound = FALSE
	perform_message = "%USER% beckons %TARGET% closer."

/datum/sex_action/simple_interaction/salute
	name = "Salute"
	check_proximity = FALSE
	menu_color = SEXCON_CUTE_INTERACTION_COLOR
	menu_priority = SEXCON_CUTE_INTERACTION_PRIORITY
	perform_sound = FALSE
	perform_message = "%USER% salutes %TARGET%."

/datum/sex_action/simple_interaction/tail_hug
	name = "Tail Hug"
	require_user_tail = TRUE
	menu_color = SEXCON_CUTE_INTERACTION_COLOR
	menu_priority = SEXCON_CUTE_INTERACTION_PRIORITY
	perform_sound = FALSE
	perform_message = "%USER% wraps %USER_THEIR% tail around %TARGET% in a gentle hug."

/datum/sex_action/simple_interaction/tail_pet
	name = "Tail Pet"
	require_user_tail = TRUE
	menu_color = SEXCON_CUTE_INTERACTION_COLOR
	menu_priority = SEXCON_CUTE_INTERACTION_PRIORITY
	perform_sound = FALSE
	perform_message = "%USER% gently pets %TARGET% with %USER_THEIR% tail."

/datum/sex_action/simple_interaction/tail_intertwine
	name = "Tail Intertwine"
	require_user_tail = TRUE
	require_target_tail = TRUE
	menu_color = SEXCON_CUTE_INTERACTION_COLOR
	menu_priority = SEXCON_CUTE_INTERACTION_PRIORITY
	perform_sound = FALSE
	perform_message = "%USER% intertwines %USER_THEIR% tail with %TARGET%'s tail."

/datum/sex_action/simple_interaction/self_tail_hug
	name = "Self-Tail Hug"
	require_user_tail = TRUE
	allow_self = TRUE
	self_only = TRUE
	menu_color = SEXCON_CUTE_INTERACTION_COLOR
	menu_priority = SEXCON_CUTE_INTERACTION_PRIORITY
	perform_sound = FALSE
	perform_message = "%USER% curls up and hugs %USER_THEIR% own tail."

/datum/sex_action/simple_interaction/kiss
	name = "Kiss"
	continous = TRUE
	perform_sound = FALSE
	heal_sex = FALSE

/datum/sex_action/simple_interaction/kiss/on_start(mob/living/carbon/user, mob/living/carbon/target)
	user.visible_message(span_warning("[user] leans in close to [target]..."))

/datum/sex_action/simple_interaction/kiss/on_perform(mob/living/carbon/user, mob/living/carbon/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] kisses [target]."))
	user.make_sucking_noise()

	user.sexcon.perform_sex_action(user, 0.5, 0, TRUE)
	user.sexcon.handle_passive_ejaculation(user)
	user.sexcon.perform_sex_action(target, 0.5, 0, TRUE)
	target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/simple_interaction/kiss/on_finish(mob/living/carbon/user, mob/living/carbon/target)
	user.visible_message(span_warning("[user] stops kissing [target]."))

/datum/sex_action/simple_interaction/kiss/is_finished(mob/living/carbon/user, mob/living/carbon/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE

/datum/sex_action/simple_interaction/grope_ass
	name = "Grope Ass"
	perform_message = "%USER% gropes %TARGET%'s ass."
	user_arousal = 3
	target_arousal = 3
	heal_sex = FALSE

/datum/sex_action/simple_interaction/slap_ass
	name = "Slap Ass"
	perform_sound = FALSE
	perform_message = "%USER% slaps %TARGET%'s ass."
	user_arousal = 2
	target_pain = 10
	heal_sex = FALSE

/datum/sex_action/simple_interaction/handjob
	name = "Handjob"
	require_target_penis = TRUE
	continous = TRUE
	replaced_by_base_action = TRUE
	start_message = "%USER% reaches for %TARGET%'s cock."
	perform_message = "%USER% strokes %TARGET%'s cock with %USER_THEIR% hand."
	finish_message = "%USER% stops stroking %TARGET%."
	user_arousal = 3
	target_arousal = 8

/datum/sex_action/simple_interaction/mount_vagina
	name = "Mount (Vagina)"
	require_user_vagina = TRUE
	require_target_penis = TRUE
	continous = TRUE
	replaced_by_base_action = TRUE
	start_message = "%USER% lowers %USER_THEIR% hips over %TARGET%."
	perform_message = "%USER% rides %TARGET%'s cock."
	finish_message = "%USER% climbs off %TARGET%."
	user_arousal = 10
	target_arousal = 10
	user_penetrative = TRUE
	target_hole = HOLE_VAGINA

/datum/sex_action/simple_interaction/mount_anus
	name = "Mount (Anus)"
	require_target_penis = TRUE
	continous = TRUE
	replaced_by_base_action = TRUE
	start_message = "%USER% lowers %USER_THEIR% ass over %TARGET%."
	perform_message = "%USER% rides %TARGET%'s cock anally."
	finish_message = "%USER% climbs off %TARGET%."
	user_arousal = 8
	target_arousal = 10
	user_pain = 3
	user_penetrative = TRUE
	target_hole = HOLE_ASS

/datum/sex_action/simple_interaction/mount_face
	name = "Mount Face"
	continous = TRUE
	start_message = "%USER% lowers %USER_THEIR% hips over %TARGET%'s face."
	perform_message = "%USER% grinds against %TARGET%'s face."
	finish_message = "%USER% climbs off %TARGET%'s face."
	user_arousal = 5
	target_arousal = 3

/datum/sex_action/simple_interaction/armpit_sex
	name = "Armpit Fuck"
	require_user_penis = TRUE
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% cock against %TARGET%'s armpit."
	perform_message = "%USER% fucks %TARGET%'s armpit."
	finish_message = "%USER% pulls away from %TARGET%'s armpit."
	user_arousal = 8
	target_arousal = 3

/datum/sex_action/simple_interaction/lick_armpit
	name = "Lick Armpit"
	perform_sucking_noise = TRUE
	perform_message = "%USER% licks %TARGET%'s armpit."
	user_arousal = 2
	target_arousal = 3
	heal_sex = FALSE

/datum/sex_action/simple_interaction/belly_sex
	name = "Bellyfuck"
	require_user_penis = TRUE
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% cock against %TARGET%'s belly."
	perform_message = "%USER% fucks against %TARGET%'s belly."
	finish_message = "%USER% pulls away from %TARGET%'s belly."
	user_arousal = 8
	target_arousal = 3
	penetrative = TRUE
	target_hole = HOLE_BELLY

/datum/sex_action/simple_interaction/nuzzle_belly
	name = "Nuzzle Belly"
	perform_sound = FALSE
	message_signature_effects = FALSE
	perform_message = "%USER% nuzzles %TARGET%'s belly."
	user_arousal = 1
	target_arousal = 2
	heal_sex = FALSE

/datum/sex_action/simple_interaction/grope_breasts
	name = "Grope Breasts"
	require_target_breasts = TRUE
	replaced_by_base_action = TRUE
	perform_message = "%USER% gropes %TARGET%'s breasts."
	user_arousal = 3
	target_arousal = 6

/datum/sex_action/simple_interaction/breast_smother
	name = "Breast Smother"
	require_user_breasts = TRUE
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% breasts against %TARGET%'s face."
	perform_message = "%USER% smothers %TARGET% with %USER_THEIR% breasts."
	finish_message = "%USER% pulls away from %TARGET%'s face."
	user_arousal = 5
	target_arousal = 4

/datum/sex_action/simple_interaction/butt_smother
	name = "Butt Smother"
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% ass against %TARGET%'s face."
	perform_message = "%USER% smothers %TARGET% with %USER_THEIR% ass."
	finish_message = "%USER% pulls away from %TARGET%'s face."
	user_arousal = 4
	target_arousal = 3

/datum/sex_action/simple_interaction/stroke_ears
	name = "Stroke Ears"
	menu_color = SEXCON_CUTE_INTERACTION_COLOR
	menu_priority = SEXCON_CUTE_INTERACTION_PRIORITY
	perform_sound = FALSE
	perform_message = "%USER% strokes %TARGET%'s ears."
	target_arousal = 1

/datum/sex_action/simple_interaction/ear_lick
	name = "Ear Lick"
	perform_sucking_noise = TRUE
	perform_message = "%USER% licks %TARGET%'s ear."
	user_arousal = 2
	target_arousal = 3
	heal_sex = FALSE

/datum/sex_action/simple_interaction/facefuck_vagina
	name = "Facefuck (Vagina)"
	require_user_vagina = TRUE
	continous = TRUE
	start_message = "%USER% pushes %USER_THEIR% pussy against %TARGET%'s mouth."
	perform_message = "%USER% grinds %USER_THEIR% pussy against %TARGET%'s mouth."
	finish_message = "%USER% pulls away from %TARGET%'s mouth."
	user_arousal = 8
	target_arousal = 2

/datum/sex_action/simple_interaction/grind_face
	name = "Grind Face"
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% foot against %TARGET%'s face."
	perform_message = "%USER% grinds %USER_THEIR% foot against %TARGET%'s face."
	finish_message = "%USER% pulls %USER_THEIR% foot back from %TARGET%."
	user_arousal = 2
	target_arousal = 3

/datum/sex_action/simple_interaction/double_footjob
	name = "Double Footjob"
	require_target_penis = TRUE
	continous = TRUE
	start_message = "%USER% places both feet around %TARGET%'s cock."
	perform_message = "%USER% strokes %TARGET%'s cock between %USER_THEIR% feet."
	finish_message = "%USER% pulls %USER_THEIR% feet away from %TARGET%."
	user_arousal = 4
	target_arousal = 8

/datum/sex_action/simple_interaction/finger_vagina
	name = "Finger Pussy"
	require_target_vagina = TRUE
	continous = TRUE
	replaced_by_base_action = TRUE
	start_message = "%USER% slides %USER_THEIR% fingers against %TARGET%'s pussy."
	perform_message = "%USER% fingers %TARGET%'s pussy."
	finish_message = "%USER% pulls %USER_THEIR% fingers away from %TARGET%."
	user_arousal = 3
	target_arousal = 7

/datum/sex_action/simple_interaction/finger_ass
	name = "Finger Ass"
	continous = TRUE
	replaced_by_base_action = TRUE
	start_message = "%USER% slides %USER_THEIR% fingers against %TARGET%'s ass."
	perform_message = "%USER% fingers %TARGET%'s ass."
	finish_message = "%USER% pulls %USER_THEIR% fingers away from %TARGET%."
	user_arousal = 3
	target_arousal = 6
	target_pain = 1

/datum/sex_action/simple_interaction/nuts_to_face
	name = "Nuts to Face"
	require_user_testicles = TRUE
	perform_message = "%USER% presses %USER_THEIR% balls against %TARGET%'s face."
	user_arousal = 4
	target_arousal = 2

/datum/sex_action/simple_interaction/ball_smother
	name = "Ball Smother"
	require_user_testicles = TRUE
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% balls against %TARGET%'s face."
	perform_message = "%USER% smothers %TARGET% with %USER_THEIR% balls."
	finish_message = "%USER% pulls away from %TARGET%'s face."
	user_arousal = 5
	target_arousal = 3

/datum/sex_action/simple_interaction/thigh_smother_penis
	name = "Thigh Smother (Penis)"
	require_target_penis = TRUE
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% thighs around %TARGET%'s cock."
	perform_message = "%USER% squeezes %TARGET%'s cock between %USER_THEIR% thighs."
	finish_message = "%USER% pulls %USER_THEIR% thighs away from %TARGET%."
	user_arousal = 4
	target_arousal = 8

/datum/sex_action/simple_interaction/tail_handjob
	name = "Tail. Jerk Cock"
	require_user_tail = TRUE
	require_target_penis = TRUE
	continous = TRUE
	perform_sounds = SEXCON_HAND_INTERACTION_SOUNDS
	perform_sound_volume = 30
	start_message = "%USER% curls %USER_THEIR% tail around %TARGET%'s cock."
	perform_message = "%USER% strokes %TARGET%'s cock with %USER_THEIR% tail."
	finish_message = "%USER% uncurls %USER_THEIR% tail from %TARGET%."
	target_arousal = 2

/datum/sex_action/simple_interaction/tail_rub_vagina
	name = "Tail. Rub Pussy"
	require_user_tail = TRUE
	require_target_vagina = TRUE
	continous = TRUE
	perform_sounds = SEXCON_HAND_INTERACTION_SOUNDS
	perform_sound_volume = 30
	start_message = "%USER% curls %USER_THEIR% tail against %TARGET%'s pussy."
	perform_message = "%USER% rubs %TARGET%'s pussy with %USER_THEIR% tail."
	finish_message = "%USER% pulls %USER_THEIR% tail away from %TARGET%."
	target_arousal = 2

/datum/sex_action/simple_interaction/self_grope_breasts
	name = "Grope Breasts (self)"
	require_user_breasts = TRUE
	allow_self = TRUE
	self_only = TRUE
	replaced_by_base_action = TRUE
	perform_message = "%USER% gropes %USER_THEIR% own breasts."
	user_arousal = 5

/datum/sex_action/simple_interaction/self_jack_off
	name = "Jack Off (self)"
	require_user_penis = TRUE
	allow_self = TRUE
	self_only = TRUE
	continous = TRUE
	replaced_by_base_action = TRUE
	start_message = "%USER% wraps a hand around %USER_THEIR% cock."
	perform_message = "%USER% strokes %USER_THEIR% cock."
	finish_message = "%USER% stops stroking %USER_THEIR% cock."
	user_arousal = 8

/datum/sex_action/simple_interaction/self_finger_vagina
	name = "Finger Pussy (self)"
	require_user_vagina = TRUE
	allow_self = TRUE
	self_only = TRUE
	continous = TRUE
	replaced_by_base_action = TRUE
	start_message = "%USER% slides %USER_THEIR% fingers against %USER_THEIR% pussy."
	perform_message = "%USER% fingers %USER_THEIR% own pussy."
	finish_message = "%USER% pulls %USER_THEIR% fingers away."
	user_arousal = 8

/datum/sex_action/simple_interaction/self_tail_handjob
	name = "Tail. Jerk Cock (self)"
	require_user_tail = TRUE
	require_user_penis = TRUE
	allow_self = TRUE
	self_only = TRUE
	continous = TRUE
	perform_sounds = SEXCON_HAND_INTERACTION_SOUNDS
	perform_sound_volume = 30
	start_message = "%USER% curls %USER_THEIR% tail around %USER_THEIR% cock."
	perform_message = "%USER% strokes %USER_THEIR% cock with %USER_THEIR% tail."
	finish_message = "%USER% uncurls %USER_THEIR% tail."
	user_arousal = 2

/datum/sex_action/simple_interaction/self_tail_rub_vagina
	name = "Tail. Rub Pussy (self)"
	require_user_tail = TRUE
	require_user_vagina = TRUE
	allow_self = TRUE
	self_only = TRUE
	continous = TRUE
	perform_sounds = SEXCON_HAND_INTERACTION_SOUNDS
	perform_sound_volume = 30
	start_message = "%USER% curls %USER_THEIR% tail against %USER_THEIR% pussy."
	perform_message = "%USER% rubs %USER_THEIR% pussy with %USER_THEIR% tail."
	finish_message = "%USER% pulls %USER_THEIR% tail away."
	user_arousal = 2

/datum/sex_action/simple_interaction/self_tail_penetrate_vagina
	name = "Tail. Penetrate Pussy (self)"
	require_user_tail = TRUE
	require_user_vagina = TRUE
	allow_self = TRUE
	self_only = TRUE
	continous = TRUE
	perform_sounds = SEXCON_HAND_INTERACTION_SOUNDS
	perform_sound_volume = 30
	start_message = "%USER% guides %USER_THEIR% tail against %USER_THEIR% pussy."
	perform_message = "%USER% works %USER_THEIR% tail into %USER_THEIR% own pussy."
	finish_message = "%USER% pulls %USER_THEIR% tail away."
	user_arousal = 9
	user_pain = 1

/datum/sex_action/simple_interaction/self_tail_penetrate_ass
	name = "Tail. Penetrate Ass (self)"
	require_user_tail = TRUE
	allow_self = TRUE
	self_only = TRUE
	continous = TRUE
	perform_sounds = SEXCON_HAND_INTERACTION_SOUNDS
	perform_sound_volume = 30
	start_message = "%USER% guides %USER_THEIR% tail behind %USER_THEIR% hips."
	perform_message = "%USER% works %USER_THEIR% tail into %USER_THEIR% own ass."
	finish_message = "%USER% pulls %USER_THEIR% tail away."
	user_arousal = 8
	user_pain = 3

/datum/sex_action/simple_interaction/self_tail_slide_ass
	name = "Tail. Slide Between Cheeks (self)"
	require_user_tail = TRUE
	allow_self = TRUE
	self_only = TRUE
	continous = TRUE
	perform_sounds = SEXCON_HAND_INTERACTION_SOUNDS
	perform_sound_volume = 30
	start_message = "%USER% curls %USER_THEIR% tail behind %USER_THEIR% hips."
	perform_message = "%USER% slides %USER_THEIR% tail between %USER_THEIR% cheeks."
	finish_message = "%USER% pulls %USER_THEIR% tail away."
	user_arousal = 6
	user_pain = 1

/datum/sex_action/simple_interaction/self_tail_urethra
	name = "Tail. Penetrate Urethra (self)"
	require_user_tail = TRUE
	require_user_penis = TRUE
	allow_self = TRUE
	self_only = TRUE
	continous = TRUE
	perform_sounds = SEXCON_HAND_INTERACTION_SOUNDS
	perform_sound_volume = 30
	start_message = "%USER% guides %USER_THEIR% tail against %USER_THEIR% cock."
	perform_message = "%USER% carefully works %USER_THEIR% tail into %USER_THEIR% own urethra."
	finish_message = "%USER% pulls %USER_THEIR% tail away."
	user_arousal = 7
	user_pain = 5

/datum/sex_action/simple_interaction/self_tail_breasts
	name = "Tail. Slide Between Breasts (self)"
	require_user_tail = TRUE
	require_user_breasts = TRUE
	allow_self = TRUE
	self_only = TRUE
	continous = TRUE
	perform_sounds = SEXCON_HAND_INTERACTION_SOUNDS
	perform_sound_volume = 30
	start_message = "%USER% curls %USER_THEIR% tail against %USER_THEIR% breasts."
	perform_message = "%USER% slides %USER_THEIR% tail between %USER_THEIR% own breasts."
	finish_message = "%USER% pulls %USER_THEIR% tail away."
	user_arousal = 6

/datum/sex_action/simple_interaction/self_tail_lick
	name = "Mouth. Lick Tail (self)"
	require_user_tail = TRUE
	allow_self = TRUE
	self_only = TRUE
	perform_sucking_noise = TRUE
	perform_message = "%USER% licks the tip of %USER_THEIR% own tail."
	user_arousal = 2

/datum/sex_action/simple_interaction/knot_vagina
	name = "Knotfuck"
	require_user_knot = TRUE
	require_target_vagina = TRUE
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% knot against %TARGET%'s pussy."
	perform_message = "%USER% fucks %TARGET%'s pussy with %USER_THEIR% knot."
	finish_message = "%USER% pulls away from %TARGET%."
	user_arousal = 10
	target_arousal = 12
	target_pain = 2
	penetrative = TRUE
	target_hole = HOLE_VAGINA

/datum/sex_action/simple_interaction/knot_anal
	name = "Anal Knotfuck"
	require_user_knot = TRUE
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% knot against %TARGET%'s ass."
	perform_message = "%USER% fucks %TARGET%'s ass with %USER_THEIR% knot."
	finish_message = "%USER% pulls away from %TARGET%."
	user_arousal = 10
	target_arousal = 10
	target_pain = 5
	penetrative = TRUE
	target_hole = HOLE_ASS

/datum/sex_action/simple_interaction/knot_oral
	name = "Oral Knotfuck"
	require_user_knot = TRUE
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% knot against %TARGET%'s mouth."
	perform_message = "%USER% fucks %TARGET%'s mouth with %USER_THEIR% knot."
	finish_message = "%USER% pulls away from %TARGET%'s mouth."
	user_arousal = 10
	target_arousal = 4
	target_pain = 3
	penetrative = TRUE
	target_hole = HOLE_MOUTH

/datum/sex_action/simple_interaction/knotride_vagina
	name = "Knotride (Vagina)"
	require_user_vagina = TRUE
	require_target_knot = TRUE
	continous = TRUE
	start_message = "%USER% lowers %USER_THEIR% pussy over %TARGET%'s knot."
	perform_message = "%USER% rides %TARGET%'s knot."
	finish_message = "%USER% climbs off %TARGET%."
	user_arousal = 12
	target_arousal = 10
	user_pain = 2
	user_penetrative = TRUE
	target_hole = HOLE_VAGINA

/datum/sex_action/simple_interaction/knotride_anal
	name = "Knotride (Anus)"
	require_target_knot = TRUE
	continous = TRUE
	start_message = "%USER% lowers %USER_THEIR% ass over %TARGET%'s knot."
	perform_message = "%USER% rides %TARGET%'s knot anally."
	finish_message = "%USER% climbs off %TARGET%."
	user_arousal = 10
	target_arousal = 10
	user_pain = 5
	user_penetrative = TRUE
	target_hole = HOLE_ASS

/datum/sex_action/simple_interaction/flare_vagina
	name = "Flarefuck"
	require_user_flare = TRUE
	require_target_vagina = TRUE
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% flared cock against %TARGET%'s pussy."
	perform_message = "%USER% fucks %TARGET%'s pussy with %USER_THEIR% flared cock."
	finish_message = "%USER% pulls away from %TARGET%."
	user_arousal = 9
	target_arousal = 10
	target_pain = 1
	penetrative = TRUE
	target_hole = HOLE_VAGINA

/datum/sex_action/simple_interaction/flare_anal
	name = "Anal Flarefuck"
	require_user_flare = TRUE
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% flared cock against %TARGET%'s ass."
	perform_message = "%USER% fucks %TARGET%'s ass with %USER_THEIR% flared cock."
	finish_message = "%USER% pulls away from %TARGET%."
	user_arousal = 9
	target_arousal = 9
	target_pain = 3
	penetrative = TRUE
	target_hole = HOLE_ASS

/datum/sex_action/simple_interaction/flare_oral
	name = "Oral Flarefuck"
	require_user_flare = TRUE
	continous = TRUE
	start_message = "%USER% presses %USER_THEIR% flared cock against %TARGET%'s mouth."
	perform_message = "%USER% fucks %TARGET%'s mouth with %USER_THEIR% flared cock."
	finish_message = "%USER% pulls away from %TARGET%'s mouth."
	user_arousal = 9
	target_arousal = 4
	target_pain = 1
	penetrative = TRUE
	target_hole = HOLE_MOUTH

/datum/sex_action/simple_interaction/flareride_vagina
	name = "Flareride (Vagina)"
	require_user_vagina = TRUE
	require_target_flare = TRUE
	continous = TRUE
	start_message = "%USER% lowers %USER_THEIR% pussy over %TARGET%'s flared cock."
	perform_message = "%USER% rides %TARGET%'s flared cock."
	finish_message = "%USER% climbs off %TARGET%."
	user_arousal = 10
	target_arousal = 9
	user_pain = 1
	user_penetrative = TRUE
	target_hole = HOLE_VAGINA

/datum/sex_action/simple_interaction/flareride_anal
	name = "Flareride (Anus)"
	require_target_flare = TRUE
	continous = TRUE
	start_message = "%USER% lowers %USER_THEIR% ass over %TARGET%'s flared cock."
	perform_message = "%USER% rides %TARGET%'s flared cock anally."
	finish_message = "%USER% climbs off %TARGET%."
	user_arousal = 9
	target_arousal = 9
	user_pain = 3
	user_penetrative = TRUE
	target_hole = HOLE_ASS

#undef SEXCON_CUTE_INTERACTION_COLOR
#undef SEXCON_CUTE_INTERACTION_PRIORITY
#undef SEXCON_TOUCH_INTERACTION_SOUNDS
#undef SEXCON_SLAP_INTERACTION_SOUNDS
#undef SEXCON_WET_INTERACTION_SOUNDS
#undef SEXCON_HAND_INTERACTION_SOUNDS
