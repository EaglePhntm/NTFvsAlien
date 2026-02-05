#define NEST_RESIST_TIME 60 SECONDS
#define NEST_UNBUCKLED_COOLDOWN 5 SECONDS

///Alium nests. Essentially beds with an unbuckle delay that only aliums can buckle mobs to.
/obj/structure/bed/nest
	name = "alien nest"
	desc = "It's a gruesome pile of thick, sticky resin shaped like a nest."
	icon = 'icons/Xeno/Effects.dmi'
	icon_state = "nest"
	hit_sound = SFX_ALIEN_RESIN_BREAK
	buckling_y = 6
	buckling_x = 0
	buildstacktype = null //can't be disassembled and doesn't drop anything when destroyed
	resistance_flags = UNACIDABLE|XENO_DAMAGEABLE
	//obj_flags = parent_type::obj_flags|PROJ_IGNORE_DENSITY
	max_integrity = 50
	layer = BELOW_OPEN_DOOR_LAYER
	var/unbuckletime = 6 SECONDS
	var/resist_time = NEST_RESIST_TIME
	///deep cave made ones need a welder to save people from.
	var/welder_needed_unbuckle = FALSE

/obj/structure/bed/nest/ai_should_stay_buckled(mob/living/carbon/npc)
	return TRUE

/obj/structure/bed/nest/attackby(obj/item/I, mob/user, params)
	. = ..()

	if(istype(I, /obj/item/grab))
		var/obj/item/grab/G = I
		if(!ismob(G.grabbed_thing))
			return
		var/mob/M = G.grabbed_thing
		to_chat(user, span_notice("You place [M] on [src]."))
		if(!density)
			M.forceMove(loc)
		user_buckle_mob(M, user)


/obj/structure/bed/nest/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage * xeno_attacker.xeno_melee_damage_modifier, damage_type = BRUTE, armor_type = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(xeno_attacker.a_intent != INTENT_HARM)
		return attack_hand(xeno_attacker)
	return ..()

/obj/structure/bed/nest/user_buckle_mob(mob/living/buckling_mob, mob/living/user, check_loc = TRUE, silent, skip)
	if(skip)
		return ..()
	if(user.incapacitated() || !in_range(user, src) || buckling_mob.buckled)
		return FALSE
/*
	if(!isxeno(user))
		to_chat(user, span_warning("Gross! You're not touching that stuff."))
		return FALSE
*/
	if(LAZYLEN(buckled_mobs))
		to_chat(user, span_warning("There's already someone in [src]."))
		return FALSE
	if(ishuman(buckling_mob))
		var/mob/living/carbon/human/H = buckling_mob
		if(!TIMER_COOLDOWN_FINISHED(H, COOLDOWN_NEST))
			to_chat(user, span_warning("[H] was recently unbuckled. Wait a bit."))
			return FALSE

	user.visible_message(span_warning("[user] pins [buckling_mob] into [src], preparing the securing resin."),
	span_warning("[user] pins [buckling_mob] into [src], preparing the securing resin."))

	if(!do_mob(user, buckling_mob, 2 SECONDS, BUSY_ICON_HOSTILE))
		return FALSE
	if(QDELETED(src))
		return FALSE
	if(LAZYLEN(buckled_mobs))
		to_chat(user, span_warning("There's already someone in [src]."))
		return FALSE
	if(!ishuman(buckling_mob))
		to_chat(user, span_warning("[buckling_mob] is not something we can capture."))
		return FALSE

	log_combat(user, buckling_mob, "nested", src)
	buckling_mob.visible_message(span_xenonotice("[user] applies a thick, vile resin, securing [buckling_mob] into [src]!"),
		span_xenonotice("[user] drenches you in a foul-smelling resin, trapping you in [src]!"),
		span_notice("You hear squelching."))
	playsound(loc, SFX_ALIEN_RESIN_MOVE, 50)

	silent = TRUE
	return ..()


/obj/structure/bed/nest/user_unbuckle_mob(mob/living/buckled_mob, mob/user, silent)
	if(user.do_actions)
		return FALSE
	if(buckled_mob != user)
		if(user.incapacitated())
			return FALSE
		var/area/the_area = get_area(src)
		if(the_area.ceiling >= CEILING_UNDERGROUND && !isxeno(user) && welder_needed_unbuckle)
			to_chat(user, span_warning("You need to use a welder to get through this thick resin."))
			return FALSE
		buckled_mob.visible_message(span_notice("\The [user] begins to pull \the [buckled_mob] free from \the [src]!"),
			span_notice("\The [user] begins to pull you free from \the [src]."),
			span_notice("You hear squelching."))
		if(isxeno(user))
			unbuckletime = 1 SECONDS//xeno go brr
		if(!do_after(user, unbuckletime, FALSE, buckled_mob, BUSY_ICON_FRIENDLY))
			return FALSE
		buckled_mob.visible_message(span_notice("\The [user] pulls \the [buckled_mob] free from \the [src]!"),
			span_notice("\The [user] pulls you free from \the [src]."),
			span_notice("You hear squelching."))
		playsound(loc, SFX_ALIEN_RESIN_MOVE, 50)
		TIMER_COOLDOWN_START(user, COOLDOWN_NEST, NEST_UNBUCKLED_COOLDOWN)
		silent = TRUE
		return ..()

	var/area/the_area = get_area(src)
	if(the_area.ceiling >= CEILING_UNDERGROUND && welder_needed_unbuckle)
		to_chat(buckled_mob, span_warning("The resin here is too strong to break free on your own..."))
		return FALSE
	if(buckled_mob.incapacitated(TRUE))
		to_chat(buckled_mob, span_warning("You're currently unable to try that."))
		return FALSE
	buckled_mob.visible_message(span_warning("\The [buckled_mob] struggles to break free of \the [src]."), span_warning("You struggle to break free from \the [src]."), span_notice("You hear squelching."))
	if(!do_after(buckled_mob, resist_time, FALSE, buckled_mob, BUSY_ICON_DANGER))
		return FALSE
	buckled_mob.visible_message(span_danger("\The [buckled_mob] breaks free from \the [src]!"),
		span_danger("You pull yourself free from \the [src]!"),
		span_notice("You hear squelching."))
	silent = TRUE
	buckled_mob.AdjustStun(2 SECONDS)
	buckled_mob.set_lying_angle(90)
	buckled_mob.apply_damage(50, STAMINA, BODY_ZONE_L_ARM)
	buckled_mob.apply_damage(50, STAMINA, BODY_ZONE_R_ARM)
	buckled_mob.apply_damage(25, STAMINA, BODY_ZONE_L_LEG)
	buckled_mob.apply_damage(25, STAMINA, BODY_ZONE_R_LEG)
	return ..()


/obj/structure/bed/nest/post_buckle_mob(mob/living/buckling_mob)
	. = ..()
	ENABLE_BITFIELD(buckling_mob.restrained_flags, RESTRAINED_XENO_NEST)
	buckling_mob.pulledby?.stop_pulling()

/obj/structure/bed/nest/post_unbuckle_mob(mob/living/buckled_mob)
	. = ..()
	if(QDELETED(buckled_mob))
		return
	DISABLE_BITFIELD(buckled_mob.restrained_flags, RESTRAINED_XENO_NEST)


/obj/structure/bed/nest/update_overlays()
	. = ..()
	if(LAZYLEN(buckled_mobs))
		if(!istype(src, /obj/structure/bed/nest/wall))
			. += image("icon_state" = "nest_overlay", "layer" = LYING_MOB_LAYER + 0.1)

/obj/structure/bed/nest/fire_act(burn_level)
	take_damage(burn_level * 2, BURN, FIRE)

#undef NEST_RESIST_TIME
#undef NEST_UNBUCKLED_COOLDOWN
