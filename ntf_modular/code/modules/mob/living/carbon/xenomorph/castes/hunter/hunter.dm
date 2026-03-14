/mob/living/carbon/xenomorph/hunter
	icon = 'ntf_modular/icons/Xeno/castes/hunter.dmi'
	pixel_x = -12

/mob/living/carbon/xenomorph/hunter/assassin
	icon_state = "Assassin Hunter Running"
	caste_base_type = /datum/xeno_caste/hunter/assassin
	COOLDOWN_DECLARE(disp_warning_cd)

/mob/living/carbon/xenomorph/hunter/assassin/Life(seconds_per_tick, times_fired)
	. = ..()
	if(status_flags & INCORPOREAL)
		if(!loc_weeds_type)
			use_plasma(4, TRUE)
		if(plasma_stored < xeno_caste.plasma_max/3 && COOLDOWN_FINISHED(src, disp_warning_cd))
			COOLDOWN_START(src, disp_warning_cd, 5 SECONDS)
			SEND_SOUND(src, sound('sound/voice/alien/help1.ogg', volume = 20))
			to_chat(src, span_xenodanger("We are running low on plasma, we must get out of displacement or we will die soon!"))
		if(plasma_stored <= 0)
			var/datum/action/ability/xeno_action/displacement/displacement = actions_by_path[/datum/action/ability/xeno_action/displacement]
			displacement.do_change_form(src)
			emote("roar3")
			death(TRUE)

/mob/living/carbon/xenomorph/hunter/assassin/death(gibbing, deathmessage, silent)
	if(status_flags & INCORPOREAL)
		var/datum/action/ability/xeno_action/displacement/displacement = actions_by_path[/datum/action/ability/xeno_action/displacement]
		displacement.do_change_form(src)
		death(FALSE)
	. = ..()
