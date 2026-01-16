/datum/looping_sound/femhornylite
	mid_sounds = list('ntf_modular/sound/vo/female/gen/se/horny1loop (1).ogg')
	mid_length = 470
	volume = 20
	range = 7

/datum/looping_sound/femhornylitealt
	mid_sounds = list('ntf_modular/sound/vo/female/gen/se/horny1loop (2).ogg')
	mid_length = 360
	volume = 20
	range = 7

/datum/looping_sound/femhornymed
	mid_sounds = list('ntf_modular/sound/vo/female/gen/se/horny2loop (1).ogg')
	mid_length = 420
	volume = 20
	range = 7

/datum/looping_sound/femhornymedalt
	mid_sounds = list('ntf_modular/sound/vo/female/gen/se/horny2loop (2).ogg')
	mid_length = 350
	volume = 20
	range = 7

/datum/looping_sound/femhornyhvy
	mid_sounds = list('ntf_modular/sound/vo/female/gen/se/horny3loop (1).ogg')
	mid_length = 440
	volume = 20
	range = 7

/datum/looping_sound/femhornyhvyalt
	mid_sounds = list('ntf_modular/sound/vo/female/gen/se/horny3loop (2).ogg')
	mid_length = 390
	volume = 20
	range = 7

/mob/living/verb/erp_panel()
	set category = "IC"
	set name = "ERP Panel"
	set desc = "Fuck 'em"
	set src in view(1)
	erptime(usr, src)

/mob/living/proc/erptime(mob/living/user, mob/living/target)
	if(!istype(target))
		return
	var/datum/sex_controller/usersexcon = user.sexcon
	usersexcon.start(target)

/* obsolete now
/mob/living/verb/Climax()
	set name = "Climax"
	set category = "IC"
	if(stat != DEAD)
		var/channel = SSsounds.random_available_channel()
		if(length(usr.do_actions))
			return
		playsound(usr, "sound/effects/squelch2.ogg", 30, channel = channel)
		if(!do_after(usr, 10 SECONDS, TRUE, usr, BUSY_ICON_GENERIC))
			usr?.balloon_alert(usr, "Interrupted")
			usr.stop_sound_channel(channel)
			return
		if(!usr)
			usr.stop_sound_channel(channel)
			return
		usr.emote("moan")
		usr.visible_message(span_warning("[usr] cums!"), span_warning("You cum."), span_warning("You hear a splatter."), 5)
		usr.balloon_alert(usr, "Orgasmed.")
		if(!isrobot(usr))
			if(usr.gender == MALE)
				new /obj/effect/decal/cleanable/blood/splatter/cum(usr.loc)
			else
				new /obj/effect/decal/cleanable/blood/splatter/girlcum(usr.loc)
		else
			new /obj/effect/decal/cleanable/blood/splatter/robotcum(usr.loc)
		if(isxeno(usr))
			new /obj/effect/decal/cleanable/blood/splatter/xenocum(usr.loc)
		playsound(usr.loc, "sound/effects/splat.ogg", 30)
		usr.reagents.remove_reagent(/datum/reagent/toxin/xeno_aphrotoxin, 4) // Remove aphrotoxin cause orgasm. Less than when you resist because takes shorter.
	else
		to_chat(usr, span_warning("You must be living to do that."))
		return
*/

/mob/living/proc/make_sucking_noise()
	if(gender == FEMALE)
		playsound(src, pick('ntf_modular/sound/misc/mat/girlmouth (1).ogg','ntf_modular/sound/misc/mat/girlmouth (2).ogg'), 25, TRUE, 7, ignore_walls = FALSE)
	else
		playsound(src, pick('ntf_modular/sound/misc/mat/guymouth (1).ogg','ntf_modular/sound/misc/mat/guymouth (2).ogg','ntf_modular/sound/misc/mat/guymouth (3).ogg','ntf_modular/sound/misc/mat/guymouth (4).ogg','ntf_modular/sound/misc/mat/guymouth (5).ogg'), 35, TRUE, 7, ignore_walls = FALSE)

/mob/living/proc/get_highest_grab_state_on(mob/living/victim)
	if(victim.pulledby == src)
		return TRUE
	return FALSE

/proc/add_cum_floor(turfu)
	if(!turfu || !isturf(turfu))
		return
	new /obj/effect/decal/cleanable/blood/splatter/cum(turfu)

//adds larva to a host.
/mob/living/carbon/xenomorph/proc/impregify(mob/living/carbon/victim, overrideflavor, maxlarvas = MAX_LARVA_PREGNANCIES, damaging = TRUE, damagemult = 1, damageloc = BODY_ZONE_PRECISE_GROIN)
	if(!istype(victim))
		return
	victim.reagents.remove_reagent(/datum/reagent/toxin/xeno_aphrotoxin, 10)
	victim.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno, 10)
	if(damaging)
		new /obj/effect/decal/cleanable/blood/splatter/xenocum(loc)
		var/aciddamagetodeal = 5
		var/impregdamagetodeal = (xeno_caste.melee_damage * xeno_melee_damage_modifier) / 6
		if(damagemult > 0)
			aciddamagetodeal *= damagemult
			impregdamagetodeal *= damagemult
		victim.apply_damage(aciddamagetodeal, BURN, damageloc, updating_health = TRUE)
		victim.apply_damage(impregdamagetodeal, BRUTE, damageloc, updating_health = TRUE)
		if(ismonkey(victim))
			victim.apply_damage(impregdamagetodeal, BRUTE, damageloc, updating_health = TRUE)
	if(!can_implant_embryo(victim))
		to_chat(src, span_warning("We came but this host is already full of young ones."))
		return
	if(victim.stat == DEAD)
		to_chat(src, span_warning("We impregnate \the [victim] with a dormant larva."))
	implant_embryo(victim, HOLE_VAGINA, source = src)
	if(prob(5))
		to_chat(src, span_warning("We sense we impregnated \the [victim] with TWINS!."))
		implant_embryo(victim, HOLE_VAGINA, 2, source = src)
	else
		implant_embryo(victim, HOLE_VAGINA, source = src)

/mob/living/carbon/xenomorph/proc/xenoimpregify()
	if(!preggo)
		to_chat(src, span_alien("We feel a new larva forming within us."))
		addtimer(CALLBACK(src, PROC_REF(xenobirth)), 5 MINUTES)
		preggo = TRUE
		return TRUE

/mob/living/carbon/xenomorph/proc/xenobirth()
	preggo = FALSE
	GLOB.round_statistics.total_larva_burst++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "total_larva_burst")
	playsound(src, pick('sound/voice/alien/chestburst.ogg','sound/voice/alien/chestburst2.ogg'), 10, FALSE, 7, ignore_walls = FALSE)
	visible_message(span_warning("A larva drops out of [src]'s cunt and burrows away!"), span_warning("a larva drops out of our cunt and burrows away."), span_warning("You hear a splatter."), 5)
	var/datum/job/xeno_job = SSjob.GetJobType(GLOB.hivenumber_to_job_type[hivenumber])
	xeno_job.add_job_points(1) //can be made a var if need be.
	hive.update_tier_limits()

/proc/can_implant_embryo(mob/living/victim, limit = MAX_LARVA_PREGNANCIES)
	var/implanted_embryos = 0
	for(var/obj/item/alien_embryo/implanted in victim.contents)
		implanted_embryos++
	if(implanted_embryos < limit)
		return TRUE
	return FALSE

/proc/implant_embryo(mob/living/victim, target_hole, times = 1, mob/living/carbon/xenomorph/source, force_xenohive)
	if(!target_hole)
		target_hole = pick(HOLE_LIST)
	for(var/index in 1 to times)
		if(can_implant_embryo(victim))
			var/obj/item/alien_embryo/embryo = new(victim)
			if(source)
				embryo.hivenumber = source.get_xeno_hivenumber()
			if(force_xenohive)
				embryo.hivenumber = force_xenohive
			embryo.target_hole = target_hole
			if(target_hole == HOLE_VAGINA)
				if(victim.gender != FEMALE)
					embryo.target_hole = HOLE_ASS
			GLOB.round_statistics.now_pregnant++
			SSblackbox.record_feedback("tally", "round_statistics", 1, "now_pregnant")
	if(source?.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[source.ckey]
		personal_statistics.impregnations++
		if(isxeno(source))
			source.claim_hive_target_reward(victim)
