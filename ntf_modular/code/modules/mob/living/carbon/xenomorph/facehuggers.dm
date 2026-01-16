//facehuggers which dont die after job's done but persist and are harder to remove.
/obj/item/clothing/mask/facehugger/latching
	name = "evolved larval facehugger"
	desc = "It has some sort of weird pulsating gigantic (for it's size) alien cock with bountiful massive balls and a strong boney tail."
	strip_delay = 8 SECONDS
	face_tint = TINT_4
	var/filter_color
	var/datum/reagent/injected_chemical_type
	var/amount_injected = 5
	var/special_effect_delay = 20 SECONDS
	var/mob/living/carbon/human/wearer
	var/max_ejaculates = 3
	var/cock_flavor = "girthy cock"
	var/harmless = FALSE
	strip_delay = 8 SECONDS
	can_self_remove = TRUE
	COOLDOWN_DECLARE(implant_cooldown)

/obj/item/clothing/mask/facehugger/latching/equipped(mob/living/user, slot)
	. = ..()
	if(slot == SLOT_UNDERWEAR || slot == SLOT_WEAR_MASK)
		wearer = user
		COOLDOWN_START(src, implant_cooldown, special_effect_delay)
		RegisterSignal(wearer, COMSIG_LIVING_IGNITED, PROC_REF(burn_moment))
		START_PROCESSING(SSobj, src)

/obj/item/clothing/mask/facehugger/latching/proc/burn_moment(datum/source, fire_stacks)
	SIGNAL_HANDLER
	kill_hugger()

/obj/item/clothing/mask/facehugger/latching/Initialize(mapload, ...)
	. = ..()
	if(filter_color)
		color = filter_color
		add_filter("base_color", -10, color_matrix_filter(filter_color))

/obj/item/clothing/mask/facehugger/latching/proc/special_effect()
	if(can_implant_embryo(wearer) && !sterile)
		wearer.visible_message(span_lovebold("[src] roughly slams it's [cock_flavor] into [wearer]'s [target_hole], a round bulge visibly sliding throug as it inserts an egg into [wearer]!"),
		span_lovebold("[src] roughly thrusts it's [cock_flavor] into your [target_hole], a round bulge visibly sliding through as it inserts an egg into you!"),
		span_notice("You hear squelching."))
		implant_embryo(wearer, target_hole, 1, force_xenohive = hivenumber)
	else
		wearer.visible_message(span_lovebold("[src]'s [cock_flavor] cums thick globs of acidic cum into [wearer]'s [target_hole]!"),
		span_lovebold("[src]'s [cock_flavor] pumps thick globs of acidic cum into your [target_hole]!"),
		span_notice("You hear spurting."))
		wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno, 1)
	wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno, 1)
	if(!harmless)
		wearer.reagents.add_reagent(/datum/reagent/toxin/acid/xeno_cum, 1)

/obj/item/clothing/mask/facehugger/latching/proc/thrust_effect()
	wearer.sexcon.adjust_arousal(5)

//changed so we dont honk mimi when idling
/obj/item/clothing/mask/facehugger/latching/go_idle(hybernate = FALSE, no_activate = FALSE)
	if(stat == DEAD)
		return FALSE
	deltimer(jumptimer) //Clear jump timers
	deltimer(activetimer)
	remove_danger_overlay() //Remove the danger overlay
	if(stat == CONSCIOUS)
		update_icon()
	else if(!attached && !(stasis || no_activate))
		activetimer = addtimer(CALLBACK(src, PROC_REF(go_active)), activate_time, TIMER_STOPPABLE|TIMER_UNIQUE)
		lifetimer = addtimer(CALLBACK(src, PROC_REF(check_lifecycle)), FACEHUGGER_DEATH, TIMER_STOPPABLE|TIMER_UNIQUE)

/obj/item/clothing/mask/facehugger/latching/try_impregnate(mob/living/carbon/human/target)
	return

/obj/item/clothing/mask/facehugger/latching/process()
	INVOKE_ASYNC(src, PROC_REF(sex_process)) //so we can have random delays to make it less robotic between two huggers

/obj/item/clothing/mask/facehugger/latching/proc/sex_process()
	sleep(rand(1,6)) //tiny sleep to make it off-sync with self and other huggers
	if(!attached) //dont go further without a puss
		return
	if(!wearer)
		reset_attach_status()
		return
	var/as_planned = wearer?.wear_mask == src  || wearer?.w_underwear == src
	if(!as_planned)
		reset_attach_status()
		return
	Shake(duration = 0.5 SECONDS)
	if(COOLDOWN_FINISHED(src, implant_cooldown))
		COOLDOWN_START(src, implant_cooldown, special_effect_delay)
		special_effect()
		playsound(src, 'ntf_modular/sound/misc/mat/endin.ogg', 50, TRUE, 7, ignore_walls = FALSE)
	else
		wearer.visible_message(span_loveextreme("[src] roughly thrusts it's [cock_flavor] into [wearer]'s [target_hole]!"),
		span_loveextreme("[src] roughly thrusts it's [cock_flavor] into your [target_hole]!"),
		span_notice("You hear squelching."))
		playsound(wearer, 'ntf_modular/sound/misc/mat/segso.ogg', 50, TRUE, 5, ignore_walls = FALSE)
		thrust_effect()

/obj/item/clothing/mask/facehugger/latching/dropped(mob/user)
	reset_attach_status()
	playsound(loc, 'sound/voice/alien/facehugger_dies.ogg', 25, 1)
	activetimer = addtimer(CALLBACK(src, PROC_REF(go_active)), activate_time*2, TIMER_STOPPABLE|TIMER_UNIQUE)
	update_icon()

//claw
/obj/item/clothing/mask/facehugger/latching/clawer
	name = "evolved clawed facehugger"
	desc = "It has some sort of horrifying ribbed alien cock with small balls... And has sharp claws too. Fortunately it is easy to remove since most of its legs would be clawing at you."
	special_effect_delay = 15 SECONDS
	cock_flavor = "ribbed cock"
	strip_delay = 2 SECONDS

/obj/item/clothing/mask/facehugger/latching/clawer/special_effect()
	wearer.emote("scream")
	wearer.visible_message(span_danger("[src] goes in a fucking-frenzy into [wearer]'s [target_hole] with it's [cock_flavor] while cumming!"),span_danger("[src] goes on a fucking-frenzy and shreds your [target_hole] sloppily with it's cumming [cock_flavor]!"))
	wearer.do_attack_animation(wearer, ATTACK_EFFECT_REDSLASH)
	wearer.do_attack_animation(wearer, ATTACK_EFFECT_CLAW)
	wearer.sexcon.adjust_arousal(5)
	wearer.apply_damage(CARRIER_SLASH_HUGGER_DAMAGE/2, BRUTE, BODY_ZONE_PRECISE_GROIN, MELEE)
	wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno, 5)
	wearer.reagents.add_reagent(/datum/reagent/toxin/acid/xeno_cum, 1)

/obj/item/clothing/mask/facehugger/latching/clawer/thrust_effect()
	wearer.sexcon.adjust_arousal(5)
	if(prob(20))
		wearer.visible_message(span_danger("[src] roughly fucks [wearer] with a [cock_flavor], damaging [wearer.p_their()] [target_hole]!"),span_danger("[src] churns your [target_hole] painfully with it's [cock_flavor]!"))
		wearer.apply_damage(CARRIER_SLASH_HUGGER_DAMAGE/4, BRUTE, BODY_ZONE_PRECISE_GROIN, MELEE)
	if(prob(20))
		var/the_damage = CARRIER_SLASH_HUGGER_DAMAGE/4
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
/obj/item/clothing/mask/facehugger/latching/chemical
	name = "evolved chemical facehugger base"
	desc = "It has some sort of weird slimy wriggly thick alien cock with MASSIVE balls storing chemicals..."
	injected_chemical_type = /datum/reagent/toxin/acid
	filter_color = COLOR_GREEN
	special_effect_delay = 20 SECONDS
	strip_delay = 8 SECONDS
	//not all are used but helpful
	var/static/list/hugger_smoke_list = list(
		/datum/reagent/toxin/xeno_neurotoxin = /datum/effect_system/smoke_spread/xeno/neuro/light,
		/datum/reagent/toxin/xeno_hemodile = /datum/effect_system/smoke_spread/xeno/hemodile,
		/datum/reagent/toxin/xeno_transvitox = /datum/effect_system/smoke_spread/xeno/transvitox,
		/datum/reagent/toxin/xeno_ozelomelyn = /datum/effect_system/smoke_spread/xeno/ozelomelyn,
		/datum/reagent/toxin/xeno_aphrotoxin = /datum/effect_system/smoke_spread/xeno/aphrotoxin,
		/datum/reagent/toxin/acid = /datum/effect_system/smoke_spread/xeno/acid/light,
	)


/obj/item/clothing/mask/facehugger/latching/chemical/special_effect()
	wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno, 2)
	wearer.visible_message(span_loveextreme("[src] slams it's [cock_flavor] ballsdeep into [wearer]'s [target_hole] and it's balls start to throb strongly, pumping thick globs of something inside!"),span_loveextreme("[src] slams it's [cock_flavor] ballsdeep into your [target_hole] and it's balls start to throb strongly, pumping thick globs of something inside!"))
	wearer.visible_message(span_lovebold("[injected_chemical_type.name] gas explodes out of [wearer]'s [target_hole], around [src]'s [cock_flavor]!"),span_lovebold("[injected_chemical_type.name] gas explodes out of your [target_hole], around [src]'s [cock_flavor]!"))
	var/smoke_choice = hugger_smoke_list[injected_chemical_type]
	var/datum/effect_system/smoke_spread/smoke = new smoke_choice(get_turf(wearer))
	smoke.set_up(1, get_turf(wearer), 2)
	playsound(src, 'sound/effects/airhiss.ogg', 25)
	smoke.start()
	if(wearer.reagents.get_reagent_amount(injected_chemical_type) < 50)
		wearer.reagents.add_reagent(injected_chemical_type, amount_injected, no_overdose = TRUE)

/obj/item/clothing/mask/facehugger/latching/chemical/thrust_effect()
	if(prob(5))
		wearer.visible_message(span_love("[src] slams it's [cock_flavor] ballsdeep into [wearer]'s [target_hole]! Leaking slightly..!"),span_love("[src] slams it's [cock_flavor] ballsdeep into your [target_hole]! Leaking slightly..!"))
		wearer.reagents.add_reagent(injected_chemical_type, 1)
		wearer.sexcon.adjust_arousal(5)
	wearer.sexcon.adjust_arousal(5)

//aphrotox
/obj/item/clothing/mask/facehugger/latching/chemical/aphrotox
	name = "evolved aphrotoxin facehugger"
	desc = "It has some sort of weird slimy wriggly thick alien cock with MASSIVE balls storing some <b>pink</b> glowing chemical..."
	cock_flavor = "tentacle-like cock"
	injected_chemical_type = /datum/reagent/toxin/xeno_aphrotoxin
	filter_color = COLOR_PINK

/obj/item/clothing/mask/facehugger/latching/chemical/aphrotox/thrust_effect()
	if(prob(5))
		wearer.visible_message(span_love("[src] slams it's [cock_flavor] ballsdeep into [wearer] and seemingly writhes it around [wearer.p_their()] [target_hole]! Rubbing pheromones inside..."),span_love("[src] slams it's [cock_flavor] ballsdeep into your [target_hole] writhes it around! You feel hotter..."))
		wearer.reagents.add_reagent(injected_chemical_type, 1)
		wearer.sexcon.adjust_arousal(5)
	wearer.sexcon.adjust_arousal(5)

/obj/item/clothing/mask/facehugger/latching/chemical/ozelomelyn
	name = "evolved ozelomelyn facehugger"
	desc = "It has some sort of knotted, thick alien cock with MASSIVE balls storing some <b>white</b> glowing chemical... Seems it uses the knot to pressurize gas inside it's victims before making it explode out all at once."
	cock_flavor = "knotted cock"
	injected_chemical_type = /datum/reagent/toxin/xeno_ozelomelyn
	filter_color = COLOR_MAGENTA

/obj/item/clothing/mask/facehugger/latching/chemical/neuro
	name = "evolved neurotoxin facehugger"
	desc = "It has some sort of knotted, thick alien cock with MASSIVE balls storing some <b>dark orange</b> glowing chemical... Seems it uses the knot to pressurize gas inside it's victims before making it explode out all at once."
	filter_color = COLOR_DARK_ORANGE
	injected_chemical_type = /datum/reagent/toxin/xeno_neurotoxin

/obj/item/clothing/mask/facehugger/latching/chemical/neuro
	name = "evolved neurotoxin facehugger"
	desc = "It has some sort of knotted, thick alien cock with MASSIVE balls storing some <b>dark orange</b> glowing chemical... Seems it uses the knot to pressurize gas inside it's victims before making it explode out all at once."
	filter_color = COLOR_DARK_ORANGE
	injected_chemical_type = /datum/reagent/toxin/xeno_neurotoxin

//acid
/obj/item/clothing/mask/facehugger/latching/chemical/acid
	name = "evolved acid facehugger"
	desc = "This repulsive looking thing's balls are bloated with throbbing, MASSIVE putrescent green sacks of flesh beneath massive similiarly green and massive shaft."
	cock_flavor = "acid-dripping cock"
	filter_color = COLOR_GREEN
	impact_time = 1 SECONDS
	activate_time = 1.5 SECONDS
	jump_cooldown = 1.5 SECONDS
	proximity_time = 0.5 SECONDS
	special_effect_delay = 20 SECONDS
	strip_delay = 8 SECONDS

/obj/item/clothing/mask/facehugger/latching/chemical/acid/special_effect()
	wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno, 4)
	wearer.reagents.add_reagent(/datum/reagent/toxin/acid/xeno_cum, 1)
	wearer.emote("scream")
	wearer.visible_message(span_loveextreme("[src] slams it's [cock_flavor] ballsdeep into [wearer]'s [target_hole] and it's balls start to throb strongly, pumping thick globs of something inside!"),span_loveextreme("[src] slams it's [cock_flavor] ballsdeep into your [target_hole] and it's balls start to throb strongly, pumping thick globs of something inside!"))
	wearer.visible_message(span_danger("Acid spurts from [wearer]'s [target_hole] around [src]'s [cock_flavor]!!!"),span_danger("Acid spurts from your [target_hole] around [src]'s [cock_flavor]!!!"))
	playsound(loc, 'sound/bullets/acid_impact1.ogg', 50, 1)
	xenomorph_spray(loc, 3 SECONDS, 16, null, TRUE)
	if(wearer.reagents.get_reagent_amount(injected_chemical_type) < 50)
		wearer.reagents.add_reagent(injected_chemical_type, amount_injected, no_overdose = TRUE)
//resin
/obj/item/clothing/mask/facehugger/latching/chemical/resin
	name = "resin hugger"
	desc = "This truly bizzare creature has MASSIVE, purple, bloated balls and it's sticky massive cock drips with purple, viscous resin."
	cock_flavor = "resin-coated cock"
	filter_color = COLOR_STRONG_VIOLET
	impact_time = 1 SECONDS
	activate_time = 1.5 SECONDS
	jump_cooldown = 1.5 SECONDS
	proximity_time = 0.5 SECONDS
	special_effect_delay = 20 SECONDS
	strip_delay = 8 SECONDS

/obj/item/clothing/mask/facehugger/latching/chemical/resin/special_effect()
	wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno/resin, 4)
	wearer.reagents.add_reagent(/datum/reagent/toxin/acid/xeno_cum, 1)
	wearer.emote("scream")
	wearer.visible_message(span_lovebold("[src] slams it's [cock_flavor] ballsdeep into [wearer]'s [target_hole] and it's balls start to throb strongly, pumping thick globs of something inside!"),span_lovebold("[src] slams it's [cock_flavor] ballsdeep into your [target_hole] and it's balls start to throb strongly, pumping thick globs of something inside!"))
	wearer.visible_message(span_danger("Sticky resin spurts from [wearer]'s [target_hole] around [src]'s [cock_flavor]!"),span_danger("Sticky resin spurts from your [target_hole] around [src]'s [cock_flavor]!"))
	playsound(loc, 'sound/bullets/acid_impact1.ogg', 50, 1)
	new /obj/alien/resin/sticky(get_turf(wearer), hivenumber) //no area effect but non thin sticky
	wearer.adjust_stagger(3 SECONDS)
	wearer.add_slowdown(15)
	if(wearer.reagents.get_reagent_amount(injected_chemical_type) < 50)
		wearer.reagents.add_reagent(injected_chemical_type, amount_injected, no_overdose = TRUE)

/obj/item/clothing/mask/facehugger/latching/chemical/resin/thrust_effect()
	if(prob(5))
		wearer.visible_message(span_love("[src] slams it's [cock_flavor] ballsdeep into [wearer] and gets stuck in the resin filled [target_hole] for a moment! Leaking more resin inside..."),span_love("[src] slams it's [cock_flavor] ballsdeep into your [target_hole] and seems to get stuck in the resin packed hole for a moment! Leaking more resin inside..."))
		wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno/resin, 1)
		wearer.sexcon.adjust_arousal(5)
	wearer.sexcon.adjust_arousal(5)

#undef FACEHUGGER_DEATH


//lets change eggs to have a new state of maturity

/datum/action/ability/xeno_action/lay_egg/advanced
	name = "Lay Egg (Queen)"
	desc = "Create an egg that will grow a larval hugger after a short delay. Empty eggs can have huggers inserted into them. Right click to toggle laying alternate latching variant."
	action_icon_state = "lay_egg_adv_off"
	use_selected_hugger = TRUE
	can_use_adv_huggers = TRUE

/datum/action/ability/xeno_action/lay_egg
	var/use_advanced_huggers = FALSE
	var/can_use_adv_huggers = FALSE
	action_icon = 'ntf_modular/icons/Xeno/construction.dmi'

	var/static/list/hugger_to_latching = list(
		/obj/item/clothing/mask/facehugger/larval = /obj/item/clothing/mask/facehugger/latching,
		/obj/item/clothing/mask/facehugger/combat/slash = /obj/item/clothing/mask/facehugger/latching/clawer,
		/obj/item/clothing/mask/facehugger/combat/chem_injector/neuro = /obj/item/clothing/mask/facehugger/latching/chemical/neuro,
		/obj/item/clothing/mask/facehugger/combat/chem_injector/ozelomelyn = /obj/item/clothing/mask/facehugger/latching/chemical/ozelomelyn,
		/obj/item/clothing/mask/facehugger/combat/chem_injector/aphrotoxin = /obj/item/clothing/mask/facehugger/latching/chemical/aphrotox,
		/obj/item/clothing/mask/facehugger/combat/acid = /obj/item/clothing/mask/facehugger/latching/chemical/acid,
		/obj/item/clothing/mask/facehugger/combat/resin = /obj/item/clothing/mask/facehugger/latching/chemical/resin,
	)

/datum/action/ability/xeno_action/lay_egg/alternate_action_activate()
	. = ..()
	if(!can_use_adv_huggers) //using this like an unlock
		return
	use_advanced_huggers = !use_advanced_huggers
	xeno_owner.balloon_alert(xeno_owner, "[use_advanced_huggers ? "Latching" : "Normal"]")
	if(use_advanced_huggers)
		action_icon_state = "lay_egg_adv_on"
	else
		action_icon_state = "lay_egg_adv_off"
	update_button_icon()


/datum/action/ability/xeno_action/lay_egg/proc/advanced_plant_egg(turf/current_turf, mob/living/carbon/xenomorph/xeno, mob/living/carbon/xenomorph/user)
	var/the_hugger = /obj/item/clothing/mask/facehugger/latching
	if(use_selected_hugger && xeno.selected_hugger_type)
		the_hugger = hugger_to_latching[xeno_owner.selected_hugger_type]
	new /obj/alien/egg/hugger(current_turf, xeno.get_xeno_hivenumber(), the_hugger, hand_attach_time_multiplier)

//harmless larval, a pet?
/obj/item/clothing/mask/facehugger/latching/friendly
	name = "evolved larval facehugger"
	desc = "It has some sort of weird pulsating gigantic (for it's size) alien cock with bountiful massive balls and a strong boney tail."
	hivenumber = XENO_HIVE_CORRUPTED
	harmless = TRUE
	strip_delay = 2 SECONDS
	special_effect_delay = 30 SECONDS

/obj/item/clothing/mask/facehugger/latching/friendly/update_icon_state()
	return

//immortal
/obj/item/clothing/mask/facehugger/proc/check_lifecycle()
	return FALSE
