//facehuggers which dont die after job's done but persist and are harder to remove.
/obj/item/clothing/mask/facehugger/latching
	name = "evolved larval facehugger"
	desc = "It has some sort of weird pulsating alien cock and a strong boney tail with stronger legs."
	strip_delay = 8 SECONDS
	face_tint = TINT_3
	var/filtercolor = COLOR_RED
	var/datum/reagents/injected_chemical_type
	var/amount_injected = 10
	var/special_effect_delay = 10 SECONDS
	var/larval = TRUE
	var/sexcon
	var/mob/living/carbon/human/wearer
	COOLDOWN_DECLARE(implant_cooldown)

/obj/item/clothing/mask/facehugger/latching/Initialize(mapload, ...)
	. = ..()
	add_filter("base_color", -10, color_matrix_filter(filtercolor))

/obj/item/clothing/mask/facehugger/latching/proc/special_effect()
	wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno, 2)
	wearer.reagents.add_reagent(/datum/reagent/toxin/acid, 1)

/obj/item/clothing/mask/facehugger/latching/proc/thrust_effect()
	wearer.adjustStaminaLoss(2)
	wearer.sexcon.adjust_arousal(2)

/obj/item/clothing/mask/facehugger/latching/equipped(mob/living/user, slot)
	if(slot != SLOT_WEAR_MASK && slot != SLOT_UNDERWEAR || stat == DEAD)
		reset_attach_status(FALSE)
		return
	wearer = user
	if(target_hole == HOLE_MOUTH)
		user.ParalyzeNoChain(10 SECONDS)
		if(ishuman(user))
			var/hugsound = user.gender == FEMALE ? SFX_FEMALE_HUGGED : SFX_MALE_HUGGED
			playsound(loc, hugsound, 25, 0)
	else
		user.emote("scream")
		user.ParalyzeNoChain(3 SECONDS)
	attached = TRUE
	go_idle(FALSE, TRUE)

/obj/item/clothing/mask/facehugger/latching/process()
	if(!wearer)
		return
	if(COOLDOWN_FINISHED(src, implant_cooldown))
		COOLDOWN_START(src, implant_cooldown, special_effect_delay)
		if(can_implant_embryo(wearer) && larval)
			wearer.visible_message(span_xenonotice("[src] roughly thrusts a tentacle into [wearer]'s [target_hole], a round bulge visibly sliding through it as it inserts an egg into [wearer]!"),
			span_xenonotice("[src] roughly thrusts it's cock into your [target_hole], a round bulge visibly sliding through it as it inserts an egg into you!"),
			span_notice("You hear squelching."))
			playsound(src, 'ntf_modular/sound/misc/mat/endin.ogg', 50, TRUE, 7, ignore_walls = FALSE)
			implant_embryo(wearer, target_hole, force_xenohive = hivenumber)
		else
			wearer.visible_message(span_love("[src]'s cock cums globs of acidic cum into [wearer]'s [target_hole]!"),
			span_love("[src]'s cock pumps globs of acidic cum into your [target_hole]!"),
			span_love("You hear spurting."))
			playsound(src, 'ntf_modular/sound/misc/mat/endin.ogg', 50, TRUE, 7, ignore_walls = FALSE)
		special_effect()
	else
		wearer.visible_message(span_love("[src] roughly thrusts it's cock into [wearer]'s [target_hole]!"),
		span_love("[src] roughly thrusts it's cock into your [target_hole]!"),
		span_love("You hear squelching."))
		playsound(wearer, 'ntf_modular/sound/misc/mat/segso.ogg', 50, TRUE, 5, ignore_walls = FALSE)
		thrust_effect()

/obj/item/clothing/mask/facehugger/latching/dropped(mob/user)
	reset_attach_status()
	playsound(loc, 'sound/voice/alien/facehugger_dies.ogg', 25, 1)
	activetimer = addtimer(CALLBACK(src, PROC_REF(go_active)), activate_time*2, TIMER_STOPPABLE|TIMER_UNIQUE)
	update_icon()

//special parent --------
/obj/item/clothing/mask/facehugger/latching/special
	name = "combat evolved facehugger base"
	larval = FALSE

//claw
/obj/item/clothing/mask/facehugger/latching/special/clawer
	name = "evolved clawed facehugger"
	desc = "It has some sort of horrifying ribbed alien cock with small balls that are likely empty... And has sharp claws too. Fortunately it is easy to remove since most of its legs would be clawing at you."
	special_effect_delay = 8 SECONDS
	strip_delay = 2 SECONDS

/obj/item/clothing/mask/facehugger/latching/special/clawer/special_effect()
	wearer.emote("scream")
	wearer.visible_message(span_danger("[src] goes in a fucking-frenzy into [wearer]'s [target_hole] with it's ribbed cock while cumming!"),span_danger("[src] goes on a fucking-frenzy and shreds your [target_hole] sloppily with it's ribbed, cumming cock!"))
	wearer.do_attack_animation(wearer, ATTACK_EFFECT_REDSLASH)
	wearer.do_attack_animation(wearer, ATTACK_EFFECT_CLAW)
	wearer.sexcon.adjust_arousal(3)
	wearer.apply_damage(CARRIER_SLASH_HUGGER_DAMAGE*1.5, BRUTE, BODY_ZONE_PRECISE_GROIN, MELEE)
	wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno, 5)
	wearer.reagents.add_reagent(/datum/reagent/toxin/acid, 1)

/obj/item/clothing/mask/facehugger/latching/special/clawer/thrust_effect()
	wearer.sexcon.adjust_arousal(1)
	if(prob(25))
		wearer.adjustStaminaLoss(1)
		wearer.visible_message(span_danger("[src] roughly fucks [wearer] with a ribbed cock!"),span_danger("[src] churns your insides painfully with it's ribbed cock!"))
		wearer.apply_damage(CARRIER_SLASH_HUGGER_DAMAGE/1.5, BRUTE, BODY_ZONE_PRECISE_GROIN, MELEE)
	if(prob(50))
		var/the_damage = CARRIER_SLASH_HUGGER_DAMAGE/1.5
		var/gangbang = 0
		for(var/obj/item/clothing/mask/facehugger/combat/slash/frens in orange(3, loc))
			gangbang ++
			break //we just need one confirmed rest dont matter.
		if(gangbang) //less damage if we got frens around cause we are op.
			the_damage *= 0.5
		wearer.do_attack_animation(wearer, ATTACK_EFFECT_REDSLASH)
		playsound(loc, SFX_ALIEN_CLAW_FLESH, 25, 1)
		var/affecting = ran_zone(null, 0)
		if(!affecting) //Still nothing??
			affecting = BODY_ZONE_CHEST //Gotta have a torso?!
		the_damage = wearer.check_shields(COMBAT_MELEE_ATTACK, the_damage, MELEE, shield_flags = SHIELD_FLAG_XENOMORPH)
		wearer.apply_damage(the_damage, BRUTE, affecting, MELEE) //Crap base damage after armour...
		wearer.visible_message(span_danger("[src] frantically claws at [wearer] while fucking [wearer.p_their()] [target_hole]!"),span_danger("[src] frantically fucks your [target_hole] and claws you!"))

//chemical base -----------------------------
/obj/item/clothing/mask/facehugger/latching/special/chemical
	name = "evolved aphrotoxin facehugger"
	desc = "It has some sort of weird slimy wriggly thick alien cock with MASSIVE balls storing chemicals..."
	injected_chemical_type = /datum/reagent/toxin/acid
	filtercolor = COLOR_GREEN
	special_effect_delay = 10 SECONDS
	strip_delay = 4 SECONDS

/obj/item/clothing/mask/facehugger/latching/special/chemical/special_effect()
	wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno, 4)
	wearer.reagents.add_reagent(/datum/reagent/toxin/acid, 1)
	if(victim.reagents.get_reagent_amount(injected_chemical_type) < 50)
		wearer.reagents.add_reagent(injected_chemical_type, amount_injected, no_overdose = TRUE)

/obj/item/clothing/mask/facehugger/latching/special/chemical/thrust_effect()
	wearer.adjustStaminaLoss(1)
	wearer.sexcon.adjust_arousal(1)

//aphrotox
/obj/item/clothing/mask/facehugger/latching/special/chemical/aphrotox
	name = "evolved aphrotoxin facehugger"
	desc = "It has some sort of weird slimy wriggly thick alien cock with MASSIVE balls storing chemicals..."
	injected_chemical_type = /datum/reagent/toxin/xeno_aphrotoxin
	filtercolor = COLOR_PINK

/obj/item/clothing/mask/facehugger/latching/special/chemical/aphrotox/thrust_effect()
	wearer.adjustStaminaLoss(3)
	wearer.sexcon.adjust_arousal(3)

/obj/item/clothing/mask/facehugger/latching/special/chemical/acid
	name = "evolved acid facehugger"
	desc = "This repulsive looking thing's balls are bloated with throbbing, MASSIVE putrescent green sacks of flesh beneath massive similiarly green and massive shaft."
	filtercolor = COLOR_GREEN
	impact_time = 1 SECONDS
	activate_time = 1.5 SECONDS
	jump_cooldown = 1.5 SECONDS
	proximity_time = 0.5 SECONDS
	special_effect_delay = 10 SECONDS
	strip_delay = 4 SECONDS
	amount_injected = 5 //we got acid splash already and its bothersome to have acid in your veins

/obj/item/clothing/mask/facehugger/latching/special/chemical/acid/special_effect()
	wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno, 4)
	wearer.reagents.add_reagent(/datum/reagent/toxin/acid, 1)
	victim.emote("scream")
	wearer.visible_message(span_danger("[src] slams ballsdeep into [wearer]'s [target_hole] and it's balls start to throb strongly, pumping something inside!"),span_danger("[src] slams ballsdeep into your [target_hole] and it's balls start to throb strongly, pumping something inside!"))
	wearer.visible_message(span_danger("Acid spurts from [wearer]'s [target_hole] around [src]'s cock!!!"),span_danger("Acid spurts from your [target_hole] around [src]'s cock!!!"))
	playsound(loc, 'sound/bullets/acid_impact1.ogg', 50, 1)
	for(var/turf/acid_tile AS in RANGE_TURFS(0, loc))
		xenomorph_spray(acid_tile, 3 SECONDS, 16, null, TRUE)
	if(victim.reagents.get_reagent_amount(injected_chemical_type) < 50)
		wearer.reagents.add_reagent(injected_chemical_type, amount_injected, no_overdose = TRUE)

/obj/item/clothing/mask/facehugger/latching/special/chemical/acid/thrust_effect()
	wearer.adjustStaminaLoss(1)
	wearer.sexcon.adjust_arousal(1)
