/datum/sex_action/eye_sex
	name = "Fuck their Eye"
	stamina_cost = 1.0
	menu_color = "red"

/datum/sex_action/eye_sex/shows_on_menu(mob/living/carbon/user, mob/living/carbon/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/eye_sex/can_perform(mob/living/carbon/user, mob/living/carbon/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/eye_sex/on_start(mob/living/carbon/user, mob/living/carbon/target)
	user.visible_message(span_warning("[user] slides [user.p_their()] cock into [target]'s eye!"))
	var/flags = target.client?.prefs.sex_pref_flags
	if(ishuman(target))
		if(flags & SEXPREF_ROUGH_SEX)
			var/mob/living/carbon/human/H = target
			var/datum/internal_organ/eyes/E = H.get_organ_slot(ORGAN_SLOT_EYES)
			E.take_damage(rand(2, 4), TRUE)
			target.emote("scream")
			if(E.damage >= E.min_broken_damage)
				to_chat(H, span_danger("Your eye can't see anything!"))
				target.blur_eyes(1)
			else if (E.damage >= E.min_bruised_damage)
				to_chat(H, span_warning("Your eye is really starting to hurt. This can't be good for you!"))
				H.blur_eyes(5)
			else
				to_chat(H, span_warning("Your eye hurts!"))
	playsound(target, pick(list('ntf_modular/sound/misc/mat/insert (1).ogg','ntf_modular/sound/misc/mat/insert (2).ogg')), 20, TRUE, 7, ignore_walls = FALSE)

/datum/sex_action/eye_sex/on_perform(mob/living/carbon/user, mob/living/carbon/target)
	var/flags = target.client?.prefs.sex_pref_flags
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks [target]'s eye."))
	playsound(target, 'ntf_modular/sound/misc/mat/segso.ogg', 50, TRUE, 5, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 0, TRUE)
	if(user.sexcon.check_active_ejaculation())
		user.visible_message(span_love("[user] cums into [target]'s eye!"))
		if(ishuman(target))
			if(flags & SEXPREF_ROUGH_SEX)
				var/mob/living/carbon/human/H = target
				var/datum/internal_organ/eyes/E = H.get_organ_slot(ORGAN_SLOT_EYES)
				E.take_damage(rand(2, 4), TRUE)

				if(E.damage >= E.min_broken_damage)
					to_chat(H, span_danger("Your eye can't see anything!"))
					target.blur_eyes(1)
				else if (E.damage >= E.min_bruised_damage)
					to_chat(H, span_warning("Your eye is really starting to hurt. This can't be good for you!"))
					H.blur_eyes(5)
				else
					to_chat(H, span_warning("Your eye hurts!"))
		target.reagents.add_reagent(/datum/reagent/medicine/imidazoline, 8, safety = TRUE) //guess cum heals your eye
		user.sexcon.cum_into(FALSE, target)
		if(isxeno(user))
			var/mob/living/carbon/xenomorph/X = user
			X.impregify(target, HOLE_EYE)

	var/datum/sex_controller/sc = user.sexcon
	if(user.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 1.2, 3, FALSE)
	else
		user.sexcon.perform_sex_action(target, 2.4, 7, FALSE)
	if(flags & SEXPREF_ROUGH_SEX)
		if(ishuman(target))
			if(flags & SEXPREF_ROUGH_SEX)
				if(sc.force > SEX_FORCE_HIGH)
					if(ishuman(target))
						if(flags & SEXPREF_ROUGH_SEX)
							var/mob/living/carbon/human/H = target
							var/datum/internal_organ/eyes/E = H.get_organ_slot(ORGAN_SLOT_EYES)
							E.take_damage(1, TRUE)
							if(prob(5))
								if(E.damage >= E.min_broken_damage)
									to_chat(H, span_danger("Your eye can't see anything!"))
									target.blur_eyes(1)
								else if (E.damage >= E.min_bruised_damage)
									to_chat(H, span_warning("Your eye is really starting to hurt. This can't be good for you!"))
									H.blur_eyes(5)
								else
									to_chat(H, span_warning("Your eye hurts!"))
				if(sc.force > SEX_FORCE_HIGH)
					if(prob(15))
						to_chat(user, span_warning("I feel something squish against my tip..."))
						target.adjustBrainLoss(0.2)
	target.sexcon.handle_passive_ejaculation(user)

/datum/sex_action/eye_sex/on_finish(mob/living/carbon/user, mob/living/carbon/target)
	playsound(src, pick(list('ntf_modular/sound/misc/cork_pop.ogg','ntf_modular/sound/misc/cork_pop (2).ogg')), 75, TRUE, 7, ignore_walls = FALSE)
	user.visible_message(span_warning("[user] pulls [user.p_their()] cock out of [target]'s eye."))

/datum/sex_action/eye_sex/is_finished(mob/living/carbon/user, mob/living/carbon/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
