/datum/sex_action/ear_sex
	name = "Fuck their Ear"
	stamina_cost = 1.0

/datum/sex_action/ear_sex/shows_on_menu(mob/living/carbon/user, mob/living/carbon/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/ear_sex/can_perform(mob/living/carbon/user, mob/living/carbon/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/ear_sex/on_start(mob/living/carbon/user, mob/living/carbon/target)
	user.visible_message(span_warning("[user] slides [user.p_their()] cock into [target]'s ear!"))
	playsound(target, pick(list('ntf_modular/sound/misc/mat/insert (1).ogg','ntf_modular/sound/misc/mat/insert (2).ogg')), 20, TRUE)

/datum/sex_action/ear_sex/on_perform(mob/living/carbon/user, mob/living/carbon/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fucks [target]'s ear."))
	playsound(target, 'ntf_modular/sound/misc/mat/segso.ogg', 50, TRUE, 5)

	user.sexcon.perform_sex_action(user, 2, 0, TRUE)
	if(user.sexcon.check_active_ejaculation())
		user.visible_message(span_love("[user] cums into [target]'s ear!"))
		user.sexcon.cum_into()
		if(isxeno(user))
			var/mob/living/carbon/xenomorph/X = user
			X.impregify(target, "ear")

	var/datum/sex_controller/sc = user.sexcon


	if(user.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 1.2, 3, FALSE)
	else
		user.sexcon.perform_sex_action(target, 2.4, 7, FALSE)
		if(sc.force > SEX_FORCE_HIGH)
			user.adjust_ear_damage(0.2)
		if(sc.force > SEX_FORCE_HIGH)
			if(prob(15))
				to_chat(user, span_warning("I feel something squish against my tip..."))
			target.adjustBrainLoss(0.2)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/ear_sex/on_finish(mob/living/carbon/user, mob/living/carbon/target)
	user.visible_message(span_warning("[user] pulls [user.p_their()] cock out of [target]'s ear."))

/datum/sex_action/ear_sex/is_finished(mob/living/carbon/user, mob/living/carbon/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
