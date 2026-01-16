/datum/component/parasitic_clothing
	var/implant_delay = 29.9 SECONDS
	var/hivenumber = XENO_HIVE_NORMAL
	var/fixed_hole = null
	var/mob/living/carbon/human/wearer = null
	var/atom/origin = null
	COOLDOWN_DECLARE(implant_cooldown)

/datum/component/parasitic_clothing/Destroy(force, silent)
	QDEL_NULL(implant_cooldown)
	wearer = null
	return ..()

/datum/component/parasitic_clothing/Initialize(_hivenumber, _fixed_hole)
	. = ..()
	hiveify(_hivenumber, _fixed_hole)

/datum/component/parasitic_clothing/proc/hiveify(_hivenumber, _fixed_hole)
	if(_hivenumber)
		hivenumber = _hivenumber
	if(_fixed_hole)
		fixed_hole = _fixed_hole
	var/datum/hive_status/hive = GLOB.hive_datums[hivenumber]
	if(isclothing(parent))
		var/obj/item/clothing/cparent = parent
		cparent.color = hive.color
		cparent.update_icon(UPDATE_ICON)

/datum/component/parasitic_clothing/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(equipped))
	RegisterSignal(parent, COMSIG_ITEM_UNEQUIPPED, PROC_REF(dropped))

/datum/component/parasitic_clothing/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_UNEQUIPPED)

/datum/component/parasitic_clothing/proc/equipped(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER
	if(slot != SLOT_L_HAND && slot != SLOT_R_HAND)
		wearer = equipper
		wearer.visible_message(span_warning("[parent] attaches itself to [wearer]!"),
				span_warning("[parent] attaches itself to you!"),
				span_notice("You hear rustling."))
		ADD_TRAIT(parent, TRAIT_NODROP, "parasite_trait")
		RegisterSignal(wearer, COMSIG_LIVING_IGNITED, PROC_REF(burn_moment))
		COOLDOWN_START(src, implant_cooldown, implant_delay) // so it dont instant egg
		START_PROCESSING(SSslowprocess, src)
	else
		dropped(source, equipper)


/datum/component/parasitic_clothing/proc/dropped(datum/source, mob/user)
	SIGNAL_HANDLER
	STOP_PROCESSING(SSslowprocess, src)
	UnregisterSignal(wearer, COMSIG_LIVING_IGNITED, PROC_REF(burn_moment))
	wearer = null
	REMOVE_TRAIT(parent, TRAIT_NODROP, "parasite_trait")

/datum/component/parasitic_clothing/proc/burn_moment(datum/source, fire_stacks)
	SIGNAL_HANDLER
	if(wearer)
		wearer.visible_message(span_warning("[parent] emits a screech and detaches from [wearer]!"),
				span_warning("[parent] screeches and detaches from you!"),
				span_notice("You hear screeching."))
		REMOVE_TRAIT(parent, TRAIT_NODROP, "parasite_trait")
		playsound(wearer.loc, 'sound/voice/alien/facehugger_dies.ogg', 25, 1)
		wearer.dropItemToGround(parent, TRUE)
		wearer = null
	qdel(parent)

/datum/component/parasitic_clothing/process()
	if(!wearer)
		STOP_PROCESSING(SSslowprocess, src)
		return
	if(wearer.stat == DEAD)
		return
	//wheel of fuck
	var/target_hole = pick(HOLE_LIST)
	if(fixed_hole)
		target_hole = fixed_hole
	if(COOLDOWN_FINISHED(src, implant_cooldown))
		COOLDOWN_START(src, implant_cooldown, implant_delay)
		if(!(wearer.status_flags & XENO_HOST))
			wearer.visible_message(span_xenonotice("[parent] roughly thrusts a tentacle into [wearer]'s [target_hole], a round bulge visibly sliding through it as it inserts an egg into [wearer]!"),
			span_xenonotice("[parent] roughly thrusts a tentacle into your [target_hole], a round bulge visibly sliding through it as it inserts an egg into you!"),
			span_notice("You hear squelching."))
			playsound(wearer, 'ntf_modular/sound/misc/mat/endin.ogg', 50, TRUE, 7, ignore_walls = FALSE)
			implant_embryo(wearer, target_hole, force_xenohive = hivenumber)
		else
			wearer.visible_message(span_love("[parent]'s tentacle pumps globs slightly acidic cum into [wearer]'s [target_hole]!"),
			span_love("[parent] tentacle pumps globs of slightly acidic cum into your [target_hole]!"),
			span_love("You hear spurting."))
			playsound(wearer, 'ntf_modular/sound/misc/mat/endin.ogg', 50, TRUE, 7, ignore_walls = FALSE)
		wearer.reagents.add_reagent(/datum/reagent/consumable/nutriment/cum/xeno, 3)
		wearer.reagents.add_reagent(/datum/reagent/toxin/acid, 1)
		if(wearer.reagents.get_reagent_amount(/datum/reagent/medicine/tricordrazine) < 4)
			wearer.reagents.add_reagent(/datum/reagent/medicine/tricordrazine, 2)
		if(wearer.reagents.get_reagent_amount(/datum/reagent/medicine/spaceacillin) < 2)
			wearer.reagents.add_reagent(/datum/reagent/medicine/spaceacillin, 2)
	else
		wearer.visible_message(span_love("[parent] roughly thrusts a tentacle into [wearer]'s [target_hole]!"),
		span_love("[parent] roughly thrusts a tentacle into your [target_hole]!"),
		span_love("You hear squelching."))
		wearer.adjustStaminaLoss(2)
		playsound(wearer, 'ntf_modular/sound/misc/mat/segso.ogg', 50, TRUE, 5, ignore_walls = FALSE)
		wearer.sexcon.adjust_arousal(2)

