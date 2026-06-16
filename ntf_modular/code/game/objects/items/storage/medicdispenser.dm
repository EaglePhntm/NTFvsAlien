/obj/machinery/deployable/dispenser/medic
	name = "NM Automedical dispenser"
	desc = "The Novamed Automedical dispenser is a machine capable of holding a large amount of items on it, while also healing nearby non-synthetics. Your allies will often ask you to lay down one of these. It can be climbed onto by more heal-slutty medics to provide even better healing in the vicinity... Being 'used' by another during that will boost the effect even more."
	color = COLOR_DARK_CYAN
	obj_flags = CAN_BE_HIT
	allow_pass_flags = PASS_AIR
	buckle_flags = CAN_BUCKLE
	var/mob/living/climbed_mob
	var/sex_boost_cd

/obj/machinery/deployable/dispenser/medic/MouseDrop_T(mob/target, mob/user)
	. = ..()
	var/mob/living/H = user
	if(!istype(H) || target != user)
		return

	do_climb(target)

///Checks to see if a mob can climb onto, or over this object
/obj/machinery/deployable/dispenser/medic/proc/can_climb(mob/living/user)
	if(!can_interact(user))
		return

	var/turf/destination_turf = loc
	var/turf/user_turf = get_turf(user)
	if(!istype(destination_turf) || !istype(user_turf))
		return
	if(!user.Adjacent(src))
		return

	if(destination_turf.density)
		return

	return destination_turf

///Attempts to climb onto, or past an object
/obj/machinery/deployable/dispenser/medic/proc/do_climb(mob/living/user)
	if(user.do_actions || !can_climb(user))
		return

	user.visible_message(span_warning("[user] starts to adjust \the [src] for sex-boosted mode and climb on it..."))

	ADD_TRAIT(user, TRAIT_IS_CLIMBING, REF(src))
	if(!do_after(user, 2 SECONDS, IGNORE_HELD_ITEM, src, BUSY_ICON_GENERIC))
		REMOVE_TRAIT(user, TRAIT_IS_CLIMBING, REF(src))
		return
	REMOVE_TRAIT(user, TRAIT_IS_CLIMBING, REF(src))

	var/turf/destination_turf = can_climb(user)
	if(!istype(destination_turf))
		return

	user.forceMove(destination_turf)
	climbed_mob = user
	buckle_mob(climbed_mob)
	RegisterSignal(climbed_mob, COMSIG_RECEIVED_SEX, PROC_REF(sexboost))
	RegisterSignal(climbed_mob, COMSIG_MOVABLE_MOVED, PROC_REF(disconnect_from_climbed))
	user.visible_message(span_warning("[user] [atom_flags & ON_BORDER ? "leaps over" : "climbs onto"] \the [src]!"))
	user.visible_message(span_warning("[src]'s 'mana-uplink' pops out and slides itself into [user.gender == MALE ? "onto [user]'s cock!" : "into [user]'s pussy!"]"))
	playsound(user, pick(list('ntf_modular/sound/misc/mat/insert (1).ogg','ntf_modular/sound/misc/mat/insert (2).ogg')), 20, TRUE, 7, ignore_walls = FALSE)

/obj/machinery/deployable/dispenser/medic/deploy()
	affecting_list = list()
	for(var/mob/living/carbon/human/human in view(2, src))
		if((human.species.species_flags & ROBOTIC_LIMBS)) // can only affect nonrobots
			continue
		RegisterSignal(human, COMSIG_QDELETING, PROC_REF(on_affecting_qdel))
		affecting_list[human] = beam(human, "medbeam", maxdistance = 3)
		RegisterSignal(affecting_list[human], COMSIG_QDELETING, PROC_REF(on_beam_qdel))
		human.playsound_local(get_turf(src), 'sound/machines/dispenser/dispenser_heal.ogg', 30)
	for(var/turf/turfs AS in RANGE_TURFS(2, src))
		RegisterSignal(turfs, COMSIG_ATOM_ENTERED, PROC_REF(entered_tiles))
	active = TRUE
	START_PROCESSING(SSobj, src)

/obj/machinery/deployable/dispenser/medic/proc/sexboost()
	SIGNAL_HANDLER
	if(COOLDOWN_FINISHED(src, sex_boost_cd))
		for(var/mob/living/person in affecting_list)
			affecting_list[person] = beam(person, "plasmabeam", maxdistance = 3, time = 1.9 SECONDS)
		do_healing(1) //additive with being carried usually since it runs independently from process
		COOLDOWN_START(src, sex_boost_cd, 1.9 SECONDS)

/obj/machinery/deployable/dispenser/medic/post_unbuckle_mob(mob/living/buckled_mob)
	. = ..()
	disconnect_from_climbed()

/obj/machinery/deployable/dispenser/medic/proc/disconnect_from_climbed()
	SIGNAL_HANDLER
	if(!isnull(climbed_mob))
		climbed_mob = null
		visible_message(span_warning("[src]'s 'mana-uplink' pops out and retracts into itself."))
		playsound(src, pick(list('ntf_modular/sound/misc/cork_pop.ogg','ntf_modular/sound/misc/cork_pop (2).ogg')), 75, TRUE, 7, ignore_walls = FALSE)

/obj/machinery/deployable/dispenser/medic/process()
	do_healing()

//it should go from 2 base to 4 mounted, and 6 (total) when fucked while mounted.
/obj/machinery/deployable/dispenser/medic/proc/do_healing(healing_rate = 2, misc_healing = 0.10, internal_healing = 0.10)
	if(climbed_mob)
		if(climbed_mob in loc)
			healing_rate *= 2
			misc_healing *= 2
			internal_healing *= 2
			do_thrust_animate(src, climbed_mob)
			do_thrust_animate(climbed_mob,src) //carries them up with the machine
			for(var/mob/living/person in affecting_list)
				affecting_list[person] = beam(person, "bsa_beam", maxdistance = 3, time = 1.9 SECONDS)
			climbed_mob.visible_message(span_loveextreme("[src] roughly thrusts it's 'mana-uplink' [climbed_mob.gender == MALE ? "around [climbed_mob]'s cock!" : "into [climbed_mob]'s cunt!"]!"))
			playsound(climbed_mob, 'ntf_modular/sound/misc/mat/segso.ogg', 50, TRUE, 5, ignore_walls = FALSE)
			climbed_mob.sexcon.adjust_arousal(5)
		else
			UnregisterSignal(climbed_mob, COMSIG_RECEIVED_SEX)
			climbed_mob = null

	for(var/mob/living/carbon/human/affecting AS in affecting_list)
		if(!line_of_sight(src, affecting, 3))
			qdel(affecting_list[affecting])
			affecting_list -= affecting
			UnregisterSignal(affecting, COMSIG_QDELETING)
			continue
		affecting.heal_overall_damage(healing_rate, healing_rate, FALSE, TRUE)
		affecting.adjustOxyLoss(-misc_healing)
		affecting.adjustToxLoss(-misc_healing)
		affecting.adjust_radiation(-misc_healing)
		if(internal_healing)
			//Sex so good it sustains the dead around it
			if(affecting.stat == DEAD && affecting.dead_ticks < GLOB.time_before_dnr)
				affecting.dead_ticks = max(0, round(affecting.dead_ticks-(internal_healing*5)))
			affecting.adjust_blood_volume(internal_healing*2)
			affecting.adjustStaminaLoss(-internal_healing*10)
			for(var/datum/internal_organ/organussy in affecting.internal_organs)
				organussy.heal_organ_damage(internal_healing)

/obj/machinery/deployable/dispenser/medic/entered_tiles(datum/source, mob/living/carbon/human/entering)
	//SIGNAL_HANDLER (issues with parenting if it dont work we'll have to find something else)
	if(!ishuman(entering) || (entering.species.species_flags & ROBOTIC_LIMBS)) // can only affect nonrobots
		return
	if(entering in affecting_list)
		return
	if(!line_of_sight(src, entering))
		return

	RegisterSignal(entering, COMSIG_QDELETING, PROC_REF(on_affecting_qdel))
	entering.playsound_local(get_turf(src), 'sound/machines/dispenser/dispenser_heal.ogg', 30)
	affecting_list[entering] = beam(entering, "medbeam", maxdistance = 3)
	RegisterSignal(affecting_list[entering], COMSIG_QDELETING, PROC_REF(on_beam_qdel))

/obj/item/storage/backpack/dispenser/medic
	name = "NM automedical dispenser"
	desc = "The Novamed Automedical dispenser is a machine capable of holding a large amount of items on it, while also healing nearby non-synthetics. Your allies will often ask you to lay down one of these."
	color = COLOR_DARK_CYAN

/obj/item/storage/backpack/dispenser/medic/Initialize(mapload, ...)
	. = ..()
	remove_component(/datum/component/deployable_item) //get rid of old
	AddComponent(/datum/component/deployable_item, /obj/machinery/deployable/dispenser/medic, 0, 0)
