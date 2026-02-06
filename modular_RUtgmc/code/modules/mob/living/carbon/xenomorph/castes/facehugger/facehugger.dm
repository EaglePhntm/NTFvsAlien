/mob/living/carbon/xenomorph/facehugger
	caste_base_type = /datum/xeno_caste/facehugger
	name = "Facehugger"
	desc = "This one looks much more active than its fellows. It has some sort of weird alien genital and a strong boney tail."
	icon = 'modular_RUtgmc/icons/Xeno/castes/facehugger.dmi'
	icon_state = "Facehugger Walking"
	speak_emote = list("chitters")

	health = 50
	maxHealth = 50
	plasma_stored = 100

	pixel_x = -8
	pixel_y = -3

	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE
	mob_size = MOB_SIZE_SMALL
	pull_speed = -2
	allow_pass_flags = PASS_MOB|PASS_XENO
	pass_flags = PASS_LOW_STRUCTURE|PASS_MOB|PASS_XENO
	density = FALSE
	hud_type = /datum/hud/larva

	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)

	bubble_icon = "alien"
	speaking_noise = SFX_LARVA_TALK
	var/hugger_type = /obj/item/clothing/mask/facehugger/larval
	var/hug_range = 2

/mob/living/carbon/xenomorph/facehugger/Initialize(mapload, do_not_set_as_ruler, _hivenumber)
	. = ..()
	ADD_TRAIT(src, TRAIT_SILENT_FOOTSTEPS, XENO_TRAIT)
	if(!mind)
		LAZYOR(GLOB.ssd_living_mobs, src)

// ***************************************
// *********** Mob overrides
// ***************************************
	/*
/mob/living/carbon/xenomorph/facehugger/handle_living_health_updates()
	. = ..()
	//We lose health if we go off the weed
	if(!loc_weeds_type && !is_ventcrawling && !(lying_angle || resting) && !(status_flags & GODMODE))
		adjustBruteLoss(2, TRUE)
		return
	*/

/mob/living/carbon/xenomorph/facehugger/update_progression()
	return

/mob/living/carbon/xenomorph/facehugger/on_death()
	///We QDEL them as cleanup and preventing them from being sold
	QDEL_IN(src, 1 MINUTES)
	GLOB.hive_datums[hivenumber].facehuggers -= src
	return ..()

/mob/living/carbon/xenomorph/facehugger/start_pulling(atom/movable/AM, force = move_force, suppress_message = FALSE)
	return FALSE

/mob/living/carbon/xenomorph/facehugger/pull_response(mob/puller)
	return TRUE

/mob/living/carbon/xenomorph/facehugger/death_cry()
	return

/mob/living/carbon/xenomorph/facehugger/get_liquid_slowdown()
	return FACEHUGGER_WATER_SLOWDOWN

///Trying to attach facehagger to face. Returns true on success and false otherwise
/mob/living/carbon/xenomorph/facehugger/proc/try_attach(mob/living/carbon/human/host)
	var/obj/item/clothing/mask/facehugger/larval/mask = new /obj/item/clothing/mask/facehugger/larval(host, src.hivenumber, src)
	if(host.can_be_facehugged(mask, provoked = TRUE))
		if(mask.try_attach(host, no_evade = TRUE)) //Attach hugger-mask
			src.forceMove(host) //Moving sentient hugger inside host
			return TRUE
		else
			qdel(mask)
			return FALSE
	else
		qdel(mask)
		return FALSE
