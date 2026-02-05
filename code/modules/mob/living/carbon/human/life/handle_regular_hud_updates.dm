//Refer to life.dm for caller

/mob/living/carbon/human/handle_regular_hud_updates()
	. = ..()
	if(!.)
		return FALSE

	update_sight()


	if(HAS_TRAIT(src, TRAIT_PAIN_IMMUNE)) //We can't tell how hurt we are if we can't feel pain
		clear_fullscreen("brute")
		clear_fullscreen("oxy")
		clear_fullscreen("crit")
		return

	if(stat == UNCONSCIOUS && health <= get_crit_threshold())
		var/severity = 0
		switch(health)
			if(-20 to -10)
				severity = 1
			if(-30 to -20)
				severity = 2
			if(-40 to -30)
				severity = 3
			if(-50 to -40)
				severity = 4
			if(-60 to -50)
				severity = 5
			if(-70 to -60)
				severity = 6
			if(-80 to -70)
				severity = 7
			if(-90 to -80)
				severity = 8
			if(-95 to -90)
				severity = 9
			if(-INFINITY to -95)
				severity = 10
		overlay_fullscreen("crit", /atom/movable/screen/fullscreen/impaired/crit, severity)
	else
		clear_fullscreen("crit")
		if(oxyloss)
			var/severity = 0
			switch(oxyloss)
				if(10 to 20)
					severity = 1
				if(20 to 25)
					severity = 2
				if(25 to 30)
					severity = 3
				if(30 to 35)
					severity = 4
				if(35 to 40)
					severity = 5
				if(40 to 45)
					severity = 6
				if(45 to INFINITY)
					severity = 7
			overlay_fullscreen("oxy", /atom/movable/screen/fullscreen/damage/oxy, severity)
		else
			clear_fullscreen("oxy")


		//Fire and Brute damage overlay
		var/hurtdamage = getBruteLoss() + getFireLoss() + damageoverlaytemp
		damageoverlaytemp = 0 // We do this so we can detect if someone hits us or not.
		if(hurtdamage)
			var/severity = 0
			switch(hurtdamage)
				if(5 to 15)
					severity = 1
				if(15 to 30)
					severity = 2
				if(30 to 45)
					severity = 3
				if(45 to 70)
					severity = 4
				if(70 to 85)
					severity = 5
				if(85 to INFINITY)
					severity = 6
			overlay_fullscreen("brute", /atom/movable/screen/fullscreen/damage/brute, severity)
		else
			clear_fullscreen("brute")

	interactee?.check_eye(src)

	if(!hud_used)
		return

/mob/living/carbon/human/handle_healths_hud_updates()
	if(!hud_used?.healths)
		return

	if(stat == DEAD)
		hud_used.healths.icon_state = "health21"
		return

	if(HAS_TRAIT(src, TRAIT_PAIN_IMMUNE)) //We can't tell how hurt we are if we can't feel pain
		hud_used.healths.icon_state = "health0"
		return

	if(analgesic)
		hud_used.healths.icon_state = "health_numb"
		return

	switch(hal_screwyhud)
		if(1)
			hud_used.healths.icon_state = "health19"
			return
		if(2)
			hud_used.healths.icon_state = "health21"
			return

	if(health < get_crit_threshold())
		hud_used.healths.icon_state = "health20"
		return

	var/perceived_health = health / maxHealth * 100
	if(!(species.species_flags & NO_PAIN))
		perceived_health -= traumatic_shock
	if(!(species.species_flags & NO_STAMINA) && staminaloss > 0)
		perceived_health -= staminaloss

	switch(perceived_health)
		if(100 to INFINITY)
			hud_used.healths.icon_state = "health0"
		if(95 to 100)
			hud_used.healths.icon_state = "health1"
		if(90 to 95)
			hud_used.healths.icon_state = "health2"
		if(85 to 90)
			hud_used.healths.icon_state = "health3"
		if(80 to 85)
			hud_used.healths.icon_state = "health4"
		if(75 to 80)
			hud_used.healths.icon_state = "health5"
		if(70 to 75)
			hud_used.healths.icon_state = "health6"
		if(65 to 70)
			hud_used.healths.icon_state = "health7"
		if(60 to 65)
			hud_used.healths.icon_state = "health8"
		if(55 to 60)
			hud_used.healths.icon_state = "health9"
		if(50 to 55)
			hud_used.healths.icon_state = "health10"
		if(45 to 50)
			hud_used.healths.icon_state = "health11"
		if(40 to 45)
			hud_used.healths.icon_state = "health12"
		if(35 to 40)
			hud_used.healths.icon_state = "health13"
		if(30 to 35)
			hud_used.healths.icon_state = "health14"
		if(25 to 30)
			hud_used.healths.icon_state = "health15"
		if(20 to 25)
			hud_used.healths.icon_state = "health16"
		if(15 to 20)
			hud_used.healths.icon_state = "health17"
		if(10 to 15)
			hud_used.healths.icon_state = "health18"
		if(5 to 10)
			hud_used.healths.icon_state = "health19"
		else
			hud_used.healths.icon_state = "health20"
