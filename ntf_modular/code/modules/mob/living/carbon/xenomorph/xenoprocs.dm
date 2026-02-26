/mob/living/carbon/xenomorph/proc/apply_melee_stat_buff()
	xeno_melee_damage_modifier += (hive.melee_multiplier - melee_multiplier_from_hive)
	melee_multiplier_from_hive = hive.melee_multiplier

/mob/living/carbon/xenomorph/verb/toggle_bump_attack_allies()
	set name = "Toggle Bump Attack Allies"
	set desc = "Toggles the ability to bump attack your allies."
	set category = "Alien"

	xeno_flags ^= XENO_ALLIES_BUMP
	to_chat(src, span_notice("You have [(xeno_flags & XENO_ALLIES_BUMP) ? "enabled" : "disabled"] the Bump Attack Allies Toggle."))

/mob/living/carbon/xenomorph/verb/toggle_destroy_own_structures()
	set name = "Toggle Destroy Own Structures"
	set desc = "Toggles the ability to destroy your own structures."
	set category = "Alien"

	xeno_flags ^= XENO_DESTROY_OWN_STRUCTURES
	to_chat(src, span_notice("You have [(xeno_flags & XENO_DESTROY_OWN_STRUCTURES) ? "enabled" : "disabled"] the Destroy Own Structures Toggle."))

/mob/living/carbon/xenomorph/verb/toggle_destroy_weeds()
	set name = "Toggle Destroy Weeds"
	set desc = "Toggles the ability to destroy weeds."
	set category = "Alien"

	xeno_flags ^= XENO_DESTROY_WEEDS
	to_chat(src, span_notice("You have [(xeno_flags & XENO_DESTROY_WEEDS) ? "enabled" : "disabled"] the Destroy Weeds Toggle."))

/mob/living/carbon/xenomorph/verb/swapgender()
	set name = "Swap Gender"
	set desc = "Swap between xeno genders in an instant, nothing compared to evolving. Some may not have textures, PR it yourself."
	set category = "Alien"

	update_xeno_gender(src, TRUE)

/mob/living/carbon/xenomorph/proc/update_xeno_gender(mob/living/carbon/xenomorph/user = src, swapping = FALSE)
	remove_overlay(GENITAL_LAYER)
	if(QDELETED(user)||QDELETED(src))
		return
	var/xgen = client?.prefs?.xenogender
	if(swapping)
		if(!COOLDOWN_FINISHED(src, gender_swap_cooldown))
			to_chat(src, span_xenonotice("You need to wait [DisplayTimeText(COOLDOWN_TIMELEFT(src, gender_swap_cooldown))] more."))
			return
		var/gchoice = tgui_input_list(src, "Select a new role to take.", "Gender Selection", list(
			NEUTER,
			FEMALE,
			MALE,
			"Futa",
			"cancel",
		), "cancel")
		if(xgen == gchoice)
			return
		if(gchoice == "cancel")
			return
		do_jitter_animation()
		xgen = gchoice
		if(!(SSticker.mode.round_type_flags & MODE_CHILL_RULES))
			COOLDOWN_START(src, gender_swap_cooldown, 5 MINUTES)
	switch(xgen) //convert string to number
		if(NEUTER)
			xgen = 1
		if(FEMALE)
			xgen = 2
		if(MALE)
			xgen = 3
		if("Futa")
			xgen = 4
	genital_overlay.layer = layer + 0.3
	genital_overlay.vis_flags |= VIS_HIDE
	genital_overlay.icon = src.icon
	genital_overlay.icon_state = "none"
	//updates the overlays
	switch(xgen)
		if(1) //blank
			genital_overlay.icon_state = null
			gender=NEUTER
			if(swapping)
				user.balloon_alert(user, "None")
		if(2)
			genital_overlay.icon_state = "[icon_state]_female"
			gender=FEMALE
			if(swapping)
				user.balloon_alert(user, "Female")
		if(3)
			genital_overlay.icon_state = "[icon_state]_male"
			gender=MALE
			if(swapping)
				user.balloon_alert(user, "Male")
		if(4)
			genital_overlay.icon_state = "[icon_state]_futa"
			gender=FEMALE
			if(swapping)
				user.balloon_alert(user, "Futa")
	user.client?.prefs?.xenogender = xgen
	if(swapping)
		user.client.prefs.save_character()
		user.client.prefs.save_preferences()

	if(xeno_caste.caste_flags & CASTE_HAS_WOUND_MASK && !HAS_TRAIT(src, TRAIT_XENOMORPH_INVISIBLE_BLOOD)) //ig if u cant see wounds u shouldnt see tiddies too maybe for things like being ethereal
		apply_overlay(GENITAL_LAYER)
	genital_overlay.vis_flags &= ~VIS_HIDE // Show the overlay

/mob/living/carbon/xenomorph/update_cloak()
	return

/mob/living/carbon/xenomorph/get_iff_signal()
	return xeno_iff_check()


/mob/living/carbon/xenomorph/adjustToxLoss(amount)
	return FALSE


/mob/living/carbon/xenomorph/setToxLoss(amount)
	return FALSE


/mob/living/carbon/xenomorph/adjustCloneLoss(amount)
	return FALSE


/mob/living/carbon/xenomorph/setCloneLoss(amount)
	return FALSE

/mob/living/carbon/xenomorph/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(eaten_mob)
		return
	. = ..()

/mob/living/carbon/xenomorph/Move(atom/newloc, direction, glide_size_override)
	. = ..()
	var/mob/living/carbon/human/user = eaten_mob
	if(user && HAS_TRAIT(user, TRAIT_HAULED)) //this trait lets us know if they are devoured or carried in a real lazy shitcode way, it just works.
		user.forceMove(loc)
		user.haul_dir_check()

/mob/living/carbon/xenomorph/forceMove(atom/destination)
	. = ..()
	var/mob/user = eaten_mob
	if(user && HAS_TRAIT(user, TRAIT_HAULED))
		if(!isturf(destination))
			user.forceMove(src)
		else
			user.forceMove(loc)

/mob/living/carbon/xenomorph/proc/get_tier_bonus()
	if(tier == XENO_TIER_ONE)
		return 1
	if(tier == XENO_TIER_TWO)
		return 2
	if(tier == XENO_TIER_THREE)
		return 3
	if(tier == XENO_TIER_FOUR)
		return 4
	return 0

/mob/living/carbon/xenomorph/proc/claim_hive_target_reward(mob/living/carbon/human/target)
	if(!istype(target) || !HAS_TRAIT(target, TRAIT_HIVE_TARGET))
		return
	var/rewardness = 4
	if(HAS_TRAIT_FROM(target, TRAIT_HIVE_TARGET, SUPERSOLDIER_TRAIT))
		rewardness = 0.5 //ass self given target, weaponized sex?
	var/psy_points_reward = PSY_DRAIN_REWARD_MIN + ((HIGH_PLAYER_POP - SSmonitor.maximum_connected_players_count) / HIGH_PLAYER_POP * (PSY_DRAIN_REWARD_MAX - PSY_DRAIN_REWARD_MIN))
	psy_points_reward = clamp(psy_points_reward, PSY_DRAIN_REWARD_MIN, PSY_DRAIN_REWARD_MAX)
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_HIVE_TARGET_DRAINED, src, target)
	psy_points_reward = psy_points_reward * rewardness
	SSpoints.add_strategic_psy_points(hivenumber, psy_points_reward)
	SSpoints.add_tactical_psy_points(hivenumber, psy_points_reward*0.25)
	GLOB.round_statistics.strategic_psypoints_from_hive_target_rewards += psy_points_reward
	GLOB.round_statistics.hive_target_rewards++
	GLOB.round_statistics.biomass_from_hive_target_rewards += MUTATION_BIOMASS_PER_HIVE_TARGET_REWARD
	SSpoints.add_biomass_points(hivenumber, MUTATION_BIOMASS_PER_HIVE_TARGET_REWARD)
	var/datum/job/xeno_job = SSjob.GetJobType(GLOB.hivenumber_to_job_type[hivenumber])
	xeno_job.add_job_points(rewardness)
	GLOB.round_statistics.larva_from_hive_target_rewards += rewardness/xeno_job.job_points_needed
	hive.update_tier_limits()
	for(var/obj/item/alien_embryo/embryo in target)
		embryo.hive_target_bonus = TRUE
	return TRUE

/mob/living/carbon/xenomorrph/relaymove()
