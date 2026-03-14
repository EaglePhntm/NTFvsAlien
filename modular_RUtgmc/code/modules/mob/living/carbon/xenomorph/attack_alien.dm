/mob/living/attack_facehugger(mob/living/carbon/xenomorph/facehugger/F, damage_amount = F.xeno_caste.melee_damage, damage_type = BRUTE, damage_flag = "", effects = TRUE, armor_penetration = 0, isrightclick = FALSE)
	if(F.status_flags & INCORPOREAL)
		return FALSE
	if(!Adjacent(src, F))
		return FALSE
	if(throwing)
		return FALSE
	switch(F.a_intent)
		if(INTENT_HELP, INTENT_GRAB) //Try to hug target if this is a human
			if(ishuman(src))
				F.visible_message(null, span_notice("We're starting to climb on [src]"), null, 5)
				if(!do_after(F, 2 SECONDS, FALSE, src, BUSY_ICON_HOSTILE, BUSY_ICON_HOSTILE))
					F.balloon_alert(F, "Climbing interrupted")
					return FALSE
				F.try_attach(src)
			else if(on_fire)
				F.visible_message(span_danger("[F] stares at [src]."), \
				span_notice("We stare at the roasting [src], toasty."), null, 5)
			else
				F.visible_message(span_notice("[F] stares at [src]."), \
				span_notice("We stare at [src]."), null, 5)
			return FALSE
		if(INTENT_HARM, INTENT_DISARM)
			F.melee_effects(src)
			return attack_alien_harm(F)
	return FALSE
