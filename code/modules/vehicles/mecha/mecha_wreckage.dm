#define REPAIR_STAGE1 1
#define REPAIR_STAGE2 2
#define REPAIR_STAGE3 3
#define REPAIR_STAGE4 4

///////////////////////////////////
////////  Mecha wreckage   ////////
///////////////////////////////////
/obj/structure/mecha_wreckage
	name = "exosuit wreckage"
	desc = "Remains of some unfortunate mecha. Completely irreparable, but perhaps something can be salvaged."
	icon = 'icons/mecha/mecha.dmi'
	hit_sound = 'sound/effects/metal_crash.ogg'
	density = TRUE
	anchored = FALSE
	opacity = FALSE
	resistance_flags = XENO_DAMAGEABLE
	max_integrity = 600
	///list of welder-salvaged items that it can output
	var/list/welder_salvage = list(/obj/item/stack/sheet/plasteel)
	/// times we can salvage this mech
	var/salvage_num = 5
	///list of crowbar-salvaged items that it can output
	var/list/crowbar_salvage = list()
	/// if the wires got pulled yet
	var/wires_removed = FALSE
	///AIs to be salvaged
	var/mob/living/silicon/ai/AI
	/// parts of the mechs that can be taken out
	var/list/parts
	/// Can it be repaired?
	var/is_repairable = TRUE
	var/original_mech = /obj/vehicle/sealed/mecha
	var/repair_stage = REPAIR_STAGE1

/obj/structure/mecha_wreckage/Initialize(mapload, mob/living/silicon/ai/AI_pilot)
	. = ..()
	if(parts)
		for(var/i in 1 to 2)
			if(!length(parts))
				break
			if(prob(60))
				continue
			var/part = pick(parts)
			welder_salvage += part
		parts = null

/obj/structure/mecha_wreckage/Destroy()
	if(AI)
		QDEL_NULL(AI)
	QDEL_LIST(crowbar_salvage)
	return ..()

/obj/structure/mecha_wreckage/examine(mob/user)
	. = ..()
	if(!AI)
		return
	. += span_notice("The AI recovery beacon is active.")
	if(is_repairable)
		.+= span_notice("You can repair this wreck with a multitool, then a wrench, sheets of plasteel, then a blowtorch.")

/obj/structure/mecha_wreckage/attackby(obj/item/I, mob/user)
	if(!is_repairable || !repair_stage == REPAIR_STAGE3)
		return ..()
	var/obj/item/stack/sheet/plasteel/plasteel = I
	var/skill_diff = SKILL_ENGINEER_ENGI - user.skills.getRating(SKILL_ENGINEER)
	if((skill_diff > 0) && !do_after(user, skill_diff SECONDS, NONE, src, BUSY_ICON_UNSKILLED))
		return
	if(!do_after(user, (5 + skill_diff) SECONDS, NONE, src, BUSY_ICON_BUILD) || repair_stage != REPAIR_STAGE3)
		return
	if(!plasteel.use(20))
		user.balloon_alert(user, "need [20]")
		return
	playsound(loc, 'sound/items/ratchet.ogg', 25, TRUE)
	balloon_alert_to_viewers("structure repaired!")
	repair_stage = REPAIR_STAGE4

/obj/structure/mecha_wreckage/welder_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(!I.use_tool(src, user, 0, volume=50))
		return

	if(is_repairable && repair_stage == REPAIR_STAGE4)

		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
			user.visible_message(span_notice("[user] fumbles around figuring out [src]'s internal hull."),
			span_notice("You fumble around figuring out [src]'s internal hull."))
			var/fumbling_time = 15 SECONDS - 2 SECONDS * user.skills.getRating(SKILL_ENGINEER)
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED) || repair_stage != REPAIR_STAGE4)
				return

		playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
		user.visible_message(span_notice("[user] starts repairing [src]'s internal hull."),
		span_notice("You start repairing [src]'s internal hull."))
		if(!do_after(user, 20 SECONDS - clamp((user.skills.getRating(SKILL_ENGINEER) - SKILL_ENGINEER_ENGI) * 5, 0, 20) SECONDS, NONE, src, BUSY_ICON_BUILD) || repair_stage != REPAIR_STAGE4)
			return FALSE

		playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
		user.visible_message(span_notice("[user] repairs [src]'s internal hull."),
		span_notice("You repair [src]'s internal hull."))
		balloon_alert_to_viewers("mech repaired!")
		new original_mech(loc)
		qdel(src)
		return TRUE

	if(salvage_num <= 0 || !length(welder_salvage))
		to_chat(user, span_notice("You don't see anything that can be cut with [I]!"))
		return

	if(prob(30))
		to_chat(user, span_notice("You fail to salvage anything valuable from [src]!"))
		return

	var/type = pick(welder_salvage)
	var/N = new type(get_turf(user))
	user.visible_message(span_notice("[user] cuts [N] from [src]."), span_notice("You cut [N] from [src]."))
	if(!istype(N, /obj/item/stack))
		welder_salvage -= type
	salvage_num--

/obj/structure/mecha_wreckage/wrench_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(is_repairable && repair_stage == REPAIR_STAGE2)
		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
			user.visible_message(span_notice("[user] fumbles around figuring out [src]'s hydraulics."),
			span_notice("You fumble around figuring out [src]'s hydraulics."))
			var/fumbling_time = 10 SECONDS - 2 SECONDS * user.skills.getRating(SKILL_ENGINEER)
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED) || repair_stage != REPAIR_STAGE2)
				return

		playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
		user.visible_message(span_notice("[user] starts repairing [src]'s hydraulics."),
		span_notice("You start repairing [src]'s hydraulics."))
		if(!do_after(user, 15 SECONDS - clamp((user.skills.getRating(SKILL_ENGINEER) - SKILL_ENGINEER_ENGI) * 5, 0, 15) SECONDS, NONE, src, BUSY_ICON_BUILD) || repair_stage != REPAIR_STAGE2)
			return FALSE

		playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
		repair_stage = REPAIR_STAGE3
		user.visible_message(span_notice("[user] repairs [src]'s hydraulics."),
		span_notice("You repair [src]'s hydraulics."))
		return TRUE

/obj/structure/mecha_wreckage/multitool_act(mob/living/user, obj/item/I)
	..()
	. = TRUE

	if(is_repairable && repair_stage == REPAIR_STAGE1)
		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_ENGI)
			user.visible_message(span_notice("[user] fumbles around figuring out [src]'s core circuitry."),
			span_notice("You fumble around figuring out [src]'s core circuitry."))
			var/fumbling_time = 5 SECONDS - 2 SECONDS * user.skills.getRating(SKILL_ENGINEER)
			if(!do_after(user, fumbling_time, NONE, src, BUSY_ICON_UNSKILLED) || repair_stage != REPAIR_STAGE1)
				return

		playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
		user.visible_message(span_notice("[user] starts resetting [src]'s core circuitry."),
		span_notice("You start resetting [src]'s core circuitry."))
		if(!do_after(user, 8 SECONDS - clamp((user.skills.getRating(SKILL_ENGINEER) - SKILL_ENGINEER_ENGI) * 5, 0, 15) SECONDS, NONE, src, BUSY_ICON_BUILD) || repair_stage != REPAIR_STAGE1)
			return FALSE

		playsound(loc, 'sound/items/ratchet.ogg', 25, 1)
		repair_stage = REPAIR_STAGE2
		user.visible_message(span_notice("[user] resets [src]'s core circuitry."),
		span_notice("You reset [src]'s core circuitry."))
		return TRUE

/obj/structure/mecha_wreckage/wirecutter_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(wires_removed)
		to_chat(user, span_notice("You don't see anything that can be cut with [I]!"))
		return
	var/N = new /obj/item/stack/cable_coil(get_turf(user), rand(1,3))
	user.visible_message(span_notice("[user] cuts [N] from [src]."), span_notice("You cut [N] from [src]."))
	wires_removed = TRUE

/obj/structure/mecha_wreckage/crowbar_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(length(crowbar_salvage))
		var/obj/S = pick(crowbar_salvage)
		S.forceMove(user.drop_location())
		user.visible_message(span_notice("[user] pries [S] from [src]."), span_notice("You pry [S] from [src]."))
		crowbar_salvage -= S
		return
	to_chat(user, span_notice("You don't see anything that can be cut with [I]!"))

/obj/structure/mecha_wreckage/ivan
	name = "\improper Ivan wreckage"
	icon_state = "ivan-broken"
	original_mech = /obj/vehicle/sealed/mecha/ntf/ivan

/obj/structure/mecha_wreckage/gygax
	name = "\improper Gygax wreckage"
	icon_state = "gygax-broken"
	parts = list(
		/obj/item/mecha_parts/part/gygax_torso,
		/obj/item/mecha_parts/part/gygax_head,
		/obj/item/mecha_parts/part/gygax_left_arm,
		/obj/item/mecha_parts/part/gygax_right_arm,
		/obj/item/mecha_parts/part/gygax_left_leg,
		/obj/item/mecha_parts/part/gygax_right_leg,
	)
	original_mech = /obj/vehicle/sealed/mecha/ntf/gygax

/obj/structure/mecha_wreckage/gygax/dark
	name = "\improper Dark Gygax wreckage"
	icon_state = "darkgygax-broken"
	original_mech = /obj/vehicle/sealed/mecha/ntf/gygax/dark

/obj/structure/mecha_wreckage/marauder
	name = "\improper Marauder wreckage"
	icon_state = "marauder-broken"
	original_mech = /obj/vehicle/sealed/mecha/ntf/marauder

/obj/structure/mecha_wreckage/mauler
	name = "\improper Mauler wreckage"
	icon_state = "mauler-broken"
	desc = "The syndicate won't be very happy about this..."
	original_mech = /obj/vehicle/sealed/mecha/ntf/marauder/mauler

/obj/structure/mecha_wreckage/seraph
	name = "\improper Seraph wreckage"
	icon_state = "seraph-broken"
	original_mech = /obj/vehicle/sealed/mecha/ntf/marauder/seraph

/obj/structure/mecha_wreckage/reticence
	name = "\improper Reticence wreckage"
	icon_state = "reticence-broken"
	color = "#87878715"
	desc = "..."
	is_repairable = FALSE

/obj/structure/mecha_wreckage/ripley
	name = "\improper Ripley wreckage"
	icon_state = "ripley-broken"
	parts = list(
		/obj/item/mecha_parts/part/ripley_torso,
		/obj/item/mecha_parts/part/ripley_left_arm,
		/obj/item/mecha_parts/part/ripley_right_arm,
		/obj/item/mecha_parts/part/ripley_left_leg,
		/obj/item/mecha_parts/part/ripley_right_leg,
	)
	is_repairable = FALSE

/obj/structure/mecha_wreckage/ripley/mk2
	name = "\improper Ripley MK-II wreckage"
	icon_state = "ripleymkii-broken"

/obj/structure/mecha_wreckage/ripley/lv624
	name = "MkIV Powerloader Wreckage"
	anchored = TRUE

/obj/structure/mecha_wreckage/ripley/firefighter
	name = "Firefighter wreckage"
	icon_state = "firefighter-broken"
	is_repairable = FALSE

/obj/structure/mecha_wreckage/clarke
	name = "\improper Clarke wreckage"
	icon_state = "clarke-broken"
	parts = list(
		/obj/item/mecha_parts/part/clarke_torso,
		/obj/item/mecha_parts/part/clarke_head,
		/obj/item/mecha_parts/part/clarke_left_arm,
		/obj/item/mecha_parts/part/clarke_right_arm,
		/obj/item/stack/conveyor,
	)
	original_mech = /obj/vehicle/sealed/mecha/ntf/clarke

/obj/structure/mecha_wreckage/ripley/deathripley
	name = "\improper Death-Ripley wreckage"
	icon_state = "deathripley-broken"
	parts = null
	is_repairable = FALSE

/obj/structure/mecha_wreckage/honker
	name = "\improper H.O.N.K wreckage"
	icon_state = "honker-broken"
	desc = "All is right in the universe."
	parts = list(
		/obj/item/mecha_parts/part/honker_torso,
		/obj/item/mecha_parts/part/honker_head,
		/obj/item/mecha_parts/part/honker_left_arm,
		/obj/item/mecha_parts/part/honker_right_arm,
		/obj/item/mecha_parts/part/honker_left_leg,
		/obj/item/mecha_parts/part/honker_right_leg,
	)
	original_mech = /obj/vehicle/sealed/mecha/ntf

/obj/structure/mecha_wreckage/durand
	name = "\improper Durand wreckage"
	icon_state = "durand-broken"
	parts = list(
		/obj/item/mecha_parts/part/durand_torso,
		/obj/item/mecha_parts/part/durand_head,
		/obj/item/mecha_parts/part/durand_left_arm,
		/obj/item/mecha_parts/part/durand_right_arm,
		/obj/item/mecha_parts/part/durand_left_leg,
		/obj/item/mecha_parts/part/durand_right_leg,
	)
	original_mech = /obj/vehicle/sealed/mecha/ntf/durand

/obj/structure/mecha_wreckage/phazon
	name = "\improper Phazon wreckage"
	icon_state = "phazon-broken"
	parts = list(
		/obj/item/mecha_parts/part/phazon_torso,
		/obj/item/mecha_parts/part/phazon_head,
		/obj/item/mecha_parts/part/phazon_left_arm,
		/obj/item/mecha_parts/part/phazon_right_arm,
		/obj/item/mecha_parts/part/phazon_left_leg,
		/obj/item/mecha_parts/part/phazon_right_leg,
	)
	original_mech = /obj/vehicle/sealed/mecha/ntf/phazon

/obj/structure/mecha_wreckage/savannah_ivanov
	name = "\improper Savannah-Ivanov wreckage"
	icon = 'icons/mecha/coop_mech.dmi'
	icon_state = "savannah_ivanov-broken"
	parts = list(
		/obj/item/mecha_parts/part/savannah_ivanov_torso,
		/obj/item/mecha_parts/part/savannah_ivanov_head,
		/obj/item/mecha_parts/part/savannah_ivanov_left_arm,
		/obj/item/mecha_parts/part/savannah_ivanov_right_arm,
		/obj/item/mecha_parts/part/savannah_ivanov_left_leg,
		/obj/item/mecha_parts/part/savannah_ivanov_right_leg,
	)
	is_repairable = FALSE

/obj/structure/mecha_wreckage/odysseus
	name = "\improper Odysseus wreckage"
	icon_state = "odysseus-broken"
	parts = list(
		/obj/item/mecha_parts/part/odysseus_torso,
		/obj/item/mecha_parts/part/odysseus_head,
		/obj/item/mecha_parts/part/odysseus_left_arm,
		/obj/item/mecha_parts/part/odysseus_right_arm,
		/obj/item/mecha_parts/part/odysseus_left_leg,
		/obj/item/mecha_parts/part/odysseus_right_leg,
	)
	is_repairable = FALSE

/obj/structure/mecha_wreckage/hoverpod
	name = "Hover pod wreckage"
	icon_state = "engineering_pod-broken"
	is_repairable = FALSE
