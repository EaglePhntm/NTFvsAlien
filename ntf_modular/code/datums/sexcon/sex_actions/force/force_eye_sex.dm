/datum/sex_action/force_eye_sex
	name = "Force them to fuck eye"
	stamina_cost = 2.0
	menu_color = "red"

/datum/sex_action/force_eye_sex/shows_on_menu(mob/living/carbon/user, mob/living/carbon/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/force_eye_sex/can_perform(mob/living/carbon/user, mob/living/carbon/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/force_eye_sex/on_start(mob/living/carbon/user, mob/living/carbon/target)
	target.visible_message(span_warning("[target] slides [target.p_their()] cock into [user]'s eye!"))
	var/flags = user.client?.prefs.sex_pref_flags
	if(ishuman(user))
		if(flags & SEXPREF_ROUGH_SEX)
			var/mob/living/carbon/human/H = user
			var/datum/internal_organ/eyes/E = H.get_organ_slot(ORGAN_SLOT_EYES)
			E.take_damage(rand(2, 4), TRUE)
			user.emote("scream")
			if(E.damage >= E.min_broken_damage)
				to_chat(H, span_danger("Your eye can't see anything!"))
				user.blur_eyes(1)
			else if (E.damage >= E.min_bruised_damage)
				to_chat(H, span_warning("Your eye is really starting to hurt. This can't be good for you!"))
				H.blur_eyes(5)
			else
				to_chat(H, span_warning("Your eye hurts!"))
	playsound(user, pick(list('ntf_modular/sound/misc/mat/insert (1).ogg','ntf_modular/sound/misc/mat/insert (2).ogg')), 20, TRUE, 7, ignore_walls = FALSE)

/datum/sex_action/force_eye_sex/on_perform(mob/living/carbon/user, mob/living/carbon/target)
	if(target.sexcon.do_message_signature("[type]"))
		target.visible_message(target.sexcon.spanify_force("[target] [target.sexcon.get_generic_force_adjective()] fucks [user]'s eye."))
	playsound(user, 'ntf_modular/sound/misc/mat/segso.ogg', 50, TRUE, 5, ignore_walls = FALSE)

	var/flags = user.client?.prefs.sex_pref_flags
	target.sexcon.perform_sex_action(target, 2, 0, TRUE)
	if(target.sexcon.check_active_ejaculation())
		target.visible_message(span_love("[target] cums into [user]'s eye!"))
		if(ishuman(user))
			if(flags & SEXPREF_ROUGH_SEX)
				var/mob/living/carbon/human/H = user
				var/datum/internal_organ/eyes/E = H.get_organ_slot(ORGAN_SLOT_EYES)
				E.take_damage(rand(2, 4), TRUE)

				if(E.damage >= E.min_broken_damage)
					to_chat(H, span_danger("Your eye can't see anything!"))
					user.blur_eyes(1)
				else if (E.damage >= E.min_bruised_damage)
					to_chat(H, span_warning("Your eye is really starting to hurt. This can't be good for you!"))
					H.blur_eyes(5)
				else
					to_chat(H, span_warning("Your eye hurts!"))
		user.reagents.add_reagent(/datum/reagent/medicine/imidazoline, 8, safety = TRUE) //guess cum heals your eye
		target.sexcon.cum_into(FALSE, user)
		if(isxeno(target))
			var/mob/living/carbon/xenomorph/X = target
			X.impregify(user, HOLE_EYE)

	var/datum/sex_controller/sc = target.sexcon
	if(target.sexcon.considered_limp())
		target.sexcon.perform_sex_action(user, 1.2, 3, FALSE)
	else
		target.sexcon.perform_sex_action(user, 2.4, 7, FALSE)
	if(flags & SEXPREF_ROUGH_SEX)
		if(ishuman(user))
			if(flags & SEXPREF_ROUGH_SEX)
				if(sc.force > SEX_FORCE_HIGH)
					if(ishuman(user))
						if(flags & SEXPREF_ROUGH_SEX)
							var/mob/living/carbon/human/H = user
							var/datum/internal_organ/eyes/E = H.get_organ_slot(ORGAN_SLOT_EYES)
							E.take_damage(1, TRUE)
							if(prob(5))
								if(E.damage >= E.min_broken_damage)
									to_chat(H, span_danger("Your eye can't see anything!"))
									user.blur_eyes(1)
								else if (E.damage >= E.min_bruised_damage)
									to_chat(H, span_warning("Your eye is really starting to hurt. This can't be good for you!"))
									H.blur_eyes(5)
								else
									to_chat(H, span_warning("Your eye hurts!"))
				if(sc.force > SEX_FORCE_HIGH)
					if(prob(15))
						to_chat(target, span_warning("I feel something squish against my tip..."))
						user.adjustBrainLoss(0.2)
	user.sexcon.handle_passive_ejaculation(target)

/datum/sex_action/force_eye_sex/on_finish(mob/living/carbon/user, mob/living/carbon/target)
	playsound(src, pick(list('ntf_modular/sound/misc/cork_pop.ogg','ntf_modular/sound/misc/cork_pop (2).ogg')), 75, TRUE, 7, ignore_walls = FALSE)
	target.visible_message(span_warning("[target] pulls [target.p_their()] cock out of [user]'s eye."))

/datum/sex_action/force_eye_sex/is_finished(mob/living/carbon/user, mob/living/carbon/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
