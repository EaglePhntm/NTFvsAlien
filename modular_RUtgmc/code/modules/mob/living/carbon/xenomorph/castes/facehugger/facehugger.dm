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

	inherent_verbs = list(
		/mob/living/carbon/xenomorph/proc/vent_crawl,
	)

	bubble_icon = "alien"
	speaking_noise = SFX_LARVA_TALK
	var/obj/item/clothing/mask/facehugger/latching/hugger_type = /obj/item/clothing/mask/facehugger/latching
	var/hug_range = 4
	var/filtercolor
	var/obj/item/clothing/mask/facehugger/mask

/mob/living/carbon/xenomorph/facehugger/proc/special_pounce(mob/living/carbon/human/host)

/mob/living/carbon/xenomorph/facehugger/proc/melee_effects(mob/living/carbon/human/host)

/mob/living/carbon/xenomorph/facehugger/Initialize(mapload, do_not_set_as_ruler, _hivenumber)
	. = ..()
	ADD_TRAIT(src, TRAIT_SILENT_FOOTSTEPS, XENO_TRAIT)
	if(!mind)
		LAZYOR(GLOB.ssd_living_mobs, src)
	if(hive.color)
		color = hive.color
	if(hugger_type.filter_color)
		add_filter("base_color", -10, color_matrix_filter(hugger_type.filter_color))

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
	mask = new hugger_type(host, src.hivenumber, src)
	if(host.can_be_facehugged(mask, provoked = TRUE))
		if(mask.try_attach(host, no_evade = TRUE)) //Attach hugger-mask
			if(!client) //delete if no sauce and keep the mask attached foreva
				mask.clear_hugger_source()
				qdel(src)
			return TRUE
		else
			qdel(mask)
			return FALSE
	else
		qdel(mask)
		return FALSE

//strains
/mob/living/carbon/xenomorph/facehugger/larval
	name = "Larval Facehugger"
	hugger_type = /obj/item/clothing/mask/facehugger/latching
	hug_range = 4

/mob/living/carbon/xenomorph/facehugger/combat/slash
	name = "Clawed Facehugger"
	hugger_type = /obj/item/clothing/mask/facehugger/latching/clawer
	hug_range = 5

/mob/living/carbon/xenomorph/facehugger/combat/slash/special_pounce(mob/living/carbon/human/host)
	host.attack_alien_harm(src)

/mob/living/carbon/xenomorph/facehugger/chemical
	///The type of chemical we inject
	var/datum/reagent/toxin/injected_chemical_type
	///The amount of chemical we should inject, in units
	var/amount_injected = 10

/mob/living/carbon/xenomorph/facehugger/chemical/special_pounce(mob/living/carbon/human/host)
	var/damage = 1
	damage = host.check_shields(COMBAT_MELEE_ATTACK, damage, MELEE)
	if(damage)
		host.apply_damage(damage, BRUTE, blocked = MELEE, sharp = TRUE, updating_health = TRUE) //Token brute for the injection
	host.reagents.add_reagent(injected_chemical_type, amount_injected, no_overdose = TRUE)
	playsound(host, 'sound/effects/spray3.ogg', 25, 1)
	host.visible_message(span_danger("[src] penetrates [host] with its sharp probscius!"), span_danger("[src] penetrates you with a sharp probscius before falling down!"))

/mob/living/carbon/xenomorph/facehugger/chemical/melee_effects(mob/living/carbon/human/host)
	special_pounce(host)

/mob/living/carbon/xenomorph/facehugger/chemical/neurotoxin
	name = "Neurotoxin Facehugger"
	hugger_type = /obj/item/clothing/mask/facehugger/latching/chemical/neuro
	hug_range = 4
	injected_chemical_type = /datum/reagent/toxin/xeno_neurotoxin
	amount_injected = 12

/mob/living/carbon/xenomorph/facehugger/chemical/neurotoxin/special_pounce(mob/living/carbon/human/host)
	var/basedamage = 100
	basedamage = host.modify_by_armor(basedamage, BIO, 0, BODY_ZONE_HEAD)
	var/damage = min(basedamage, max(0, 50 - host.getStaminaLoss()))
	basedamage -= damage
	damage += basedamage/20 //damage that would put target over 50 staminaloss is reduced by a factor of 20
	host.apply_damage(damage, STAMINA, BODY_ZONE_HEAD, updating_health = TRUE) //This should prevent sprinting

/mob/living/carbon/xenomorph/facehugger/chemical/aphrotoxin
	name = "Aphrotoxin Facehugger"
	hugger_type = /obj/item/clothing/mask/facehugger/latching/chemical/aphrotox
	hug_range = 4
	injected_chemical_type = /datum/reagent/toxin/xeno_aphrotoxin

/mob/living/carbon/xenomorph/facehugger/chemical/ozelomelyn
	name = "Ozelomelyn Facehugger"
	hugger_type = /obj/item/clothing/mask/facehugger/latching/chemical/ozelomelyn
	hug_range = 4
	injected_chemical_type = /datum/reagent/toxin/xeno_ozelomelyn

/mob/living/carbon/xenomorph/facehugger/combat/acid
	name = "Acid Facehugger"
	hugger_type = /obj/item/clothing/mask/facehugger/latching/chemical/acid
	hug_range = 3

/mob/living/carbon/xenomorph/facehugger/combat/acid/special_pounce(mob/living/carbon/human/host)
	set_plasma(0, TRUE)
	visible_message(span_danger("[src] releases a splatter of acid!"))
	playsound(loc, 'sound/bullets/acid_impact1.ogg', 50, 1)

	for(var/turf/acid_tile AS in RANGE_TURFS(1, loc))
		xenomorph_spray(acid_tile, 6 SECONDS, 16, null, TRUE)

	var/datum/effect_system/smoke_spread/xeno/acid/light/A = new(get_turf(src)) //Spawn acid smoke
	A.set_up(1,src)
	A.start()

/mob/living/carbon/xenomorph/facehugger/combat/resin
	name = "Resin Facehugger"
	hugger_type = /obj/item/clothing/mask/facehugger/latching/chemical/resin
	hug_range = 3

/mob/living/carbon/xenomorph/facehugger/combat/resin/special_pounce(mob/living/carbon/human/host)
	set_plasma(0, TRUE)
	visible_message(span_danger("[src] releases a mess of viscous resin!"))
	playsound(loc, SFX_ALIEN_RESIN_BUILD, 50, 1)

	for(var/turf/sticky_tile AS in RANGE_TURFS(1, loc))
		if(!locate(/obj/alien/resin/sticky/thin) in sticky_tile.contents)
			new /obj/alien/resin/sticky/thin(sticky_tile, hivenumber) //NTF edit - hivenumbers

	for(var/mob/living/carbon/human/target in range(1, loc))
		if(isxeno(target)) //Xenos aren't affected by sticky resin
			continue

		target.adjust_stagger(3 SECONDS)
		target.add_slowdown(15)
		var/basedamage = 100
		basedamage = target.modify_by_armor(basedamage, BIO, 0, BODY_ZONE_HEAD)
		var/damage = min(basedamage, max(0, 50 - target.getStaminaLoss()))
		basedamage -= damage
		damage += basedamage/20 //damage that would put target over 50 staminaloss is reduced by a factor of 20
		target.apply_damage(damage, STAMINA, BODY_ZONE_HEAD, updating_health = TRUE) //This should prevent sprinting
		target.ExtinguishMob()
