/mob/living/carbon/human
	var/can_restore_skills = FALSE
	var/extract_count = 0
	var/datum/skills/base_skills

/mob/living/carbon/human/proc/enable_skill_restore()
	can_restore_skills = TRUE

/datum/skills/proc/Copy()
	var/datum/skills/new_skills = new src.type()
	new_skills.unarmed = unarmed
	new_skills.melee_weapons = melee_weapons
	new_skills.combat = combat
	new_skills.pistols = pistols
	new_skills.shotguns = shotguns
	new_skills.rifles = rifles
	new_skills.smgs = smgs
	new_skills.heavy_weapons = heavy_weapons
	new_skills.smartgun = smartgun
	new_skills.engineer = engineer
	new_skills.construction = construction
	new_skills.leadership = leadership
	new_skills.medical = medical
	new_skills.surgery = surgery
	new_skills.pilot = pilot
	new_skills.police = police
	new_skills.powerloader = powerloader
	new_skills.large_vehicle = large_vehicle
	new_skills.mech = mech
	new_skills.stamina = stamina
	new_skills.sex = sex
	return new_skills

/obj/structure/bed/chair/kz/neural_station
	name = "Unknown industrial frame"
	desc = "A bulky metal assembly with inactive interfaces."
	icon = 'ntf_modular/icons/obj/structures/kz_stuff.dmi'
	icon_state = "kz_pod"
	base_icon_state = "kz_pod"
	resistance_flags = RESIST_ALL
	max_integrity = INFINITY
	max_buckled_mobs = 1
	var/mob/living/carbon/human/current_occupant
	var/obj/item/disk/kz_neurodisk/loaded_disk
	var/obj/machinery/computer/neural_station_console/attached_console

/obj/structure/bed/chair/kz/neural_station/examine(mob/user)
	. = ..()
	if(user.faction != FACTION_VSD)
		return
	. += "<br><b>KZ Neural Station</b><br>Kaizoku Covert Division prototype for neural harvesting and imprinting."
	. += "<br>Designed to capture and encode cortical skill structures onto NS-92 neurodisks, and transfer them to new hosts."
	. += "<br><i>Unauthorized disclosure will result in immediate contract termination and/or asset liquidation.</i><br>"
	if(attached_console)
		. += "It is linked to a neural station console."
	else
		. += "It is not linked to any console."

/obj/structure/bed/chair/kz/neural_station/Destroy()
	if(current_occupant)
		if(current_occupant.handcuffed)
			current_occupant.handcuffed.dropped(current_occupant)
		current_occupant.update_abstract_handcuffed()
	unbuckle_all_mobs(TRUE)
	if(attached_console)
		attached_console.linked_station = null
		attached_console = null
	return ..()

/obj/structure/bed/chair/kz/neural_station/attack_tk(mob/user)
	return FALSE

/obj/structure/bed/chair/kz/neural_station/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	if(!buckled_mob)
		return FALSE
	if(buckled_mob != user)
		buckled_mob.visible_message(
			span_warning("[user] starts unbuckling [buckled_mob] from [src]!"),
			span_userdanger("[user] starts unbuckling you from [src]!"),
			span_hear("You hear metal clanking."))
		if(!do_after(user, 5 SECONDS, buckled_mob))
			to_chat(user, span_warning("You fail to unbuckle [buckled_mob] from [src]."))
			return FALSE
		buckled_mob.visible_message(
			span_notice("[user] unbuckles [buckled_mob] from [src]."),
			span_notice("[user] unbuckles you from [src]."),
			span_hear("You hear metal clanking."))
	else
		if(!do_after(user, 10 SECONDS, buckled_mob))
			to_chat(user, span_warning("You fail to unbuckle yourself from [src]."))
			return FALSE
		user.visible_message(
			span_notice("You unbuckle yourself from [src]."),
			span_hear("You hear metal clanking."))
	unbuckle_mob(buckled_mob)
	add_fingerprint(user, "unbuckle")
	if(isliving(buckled_mob.pulledby))
		var/mob/living/pulling_mob = buckled_mob.pulledby
		pulling_mob.set_pull_offsets(buckled_mob, buckled_mob.grab_state)
	return buckled_mob

/obj/structure/bed/chair/kz/neural_station/user_buckle_mob(mob/living/affected_mob, mob/user, check_loc = TRUE)
	add_fingerprint(user, "buckle")
	if(affected_mob == user)
		if(!do_after(user, 10 SECONDS, affected_mob))
			to_chat(user, span_warning("You fail to buckle yourself to [src]!"))
			return FALSE
		if(buckle_mob(affected_mob, check_loc = check_loc))
			user.visible_message(
				span_warning("You buckle yourself to [src]!"),
				span_hear("You hear metal clanking."))
		return TRUE
	affected_mob.visible_message(
		span_warning("[user] starts buckling [affected_mob] to [src]!"),
		span_userdanger("[user] starts buckling you to [src]!"),
		span_hear("You hear metal clanking."))
	if(!do_after(user, 5 SECONDS, affected_mob))
		to_chat(user, span_warning("You fail to buckle [affected_mob] to [src]!"))
		return FALSE
	if(!buckle_mob(affected_mob, check_loc = check_loc))
		return FALSE
	affected_mob.visible_message(
		span_warning("[user] buckled [affected_mob] to [src]!"),
		span_userdanger("[user] buckled you to [src]!"),
		span_hear("You hear metal clanking."))
	return TRUE

/obj/structure/bed/chair/kz/neural_station/post_buckle_mob(mob/living/affected_mob)
	affected_mob.layer = BELOW_MOB_LAYER
	if(LAZYLEN(buckled_mobs))
		if(ishuman(buckled_mobs[1]))
			current_occupant = buckled_mobs[1]
	if(!current_occupant)
		return FALSE
	if(current_occupant.handcuffed)
		return FALSE
	var/obj/item/restraints/handcuffs/milker/cuffs = new(current_occupant)
	current_occupant.equip_to_slot_if_possible(cuffs, SLOT_HANDCUFFED, 1, 0, 1, 1)
	cuffs.parent_chair = WEAKREF(src)
	current_occupant.update_abstract_handcuffed()

/obj/structure/bed/chair/kz/neural_station/post_unbuckle_mob(mob/living/affected_mob)
	affected_mob.layer = initial(affected_mob.layer)
	if(!current_occupant)
		return FALSE
	if(current_occupant.handcuffed)
		current_occupant.handcuffed.dropped(current_occupant)
	current_occupant.update_abstract_handcuffed()
	current_occupant = null

/obj/structure/bed/chair/kz/neural_station/attack_hand(mob/living/user)
	if(user.faction == FACTION_VSD && user.a_intent == INTENT_HARM && loaded_disk)
		to_chat(user, span_notice("You carefully lift the neurodisk from the station."))
		if(!do_after(user, 7 SECONDS, src))
			to_chat(user, span_warning("You are interrupted! The neurodisk stays put."))
			return TRUE
		var/obj/item/disk/kz_neurodisk/new_disk = new /obj/item/disk/kz_neurodisk(src.loc)
		new_disk.stored_name = loaded_disk.stored_name
		new_disk.stored_skills = loaded_disk.stored_skills?.Copy()
		qdel(loaded_disk)
		loaded_disk = null
		to_chat(user, span_notice("You remove the neurodisk."))
		return TRUE
	if(LAZYLEN(buckled_mobs))
		user_unbuckle_mob(buckled_mobs[1], user)
		return TRUE
	var/mob/living/affected_mob = locate() in loc
	if(!affected_mob)
		return TRUE
	user_buckle_mob(affected_mob, user, check_loc = TRUE)

/obj/structure/bed/chair/kz/neural_station/attackby(obj/item/attacking_item, mob/living/user)
	. = ..()
	if(.)
		return
	if(istype(attacking_item, /obj/item/disk/kz_neurodisk))
		if(user.faction != FACTION_VSD)
			to_chat(user, span_warning("You have no idea how to operate that kind of device."))
			return TRUE
		var/obj/item/disk/kz_neurodisk/disk = attacking_item
		if(!disk.stored_name)
			to_chat(user, span_warning("The neurodisk is empty! Load empty disks into the console."))
			return TRUE
		if(loaded_disk)
			to_chat(user, span_warning("A disk is already loaded!"))
			return TRUE
		to_chat(user, span_notice("You load the encoded neurodisk into the station."))
		loaded_disk = disk
		user.drop_held_item()
		qdel(attacking_item)
		return TRUE

/obj/structure/bed/chair/kz/neural_station/proc/can_extract(mob/living/carbon/human/target)
	if(!target || target.stat == DEAD || target.faction == FACTION_VSD || HAS_TRAIT(target, TRAIT_SKILLS_EXTRACTED) || target.extract_count >= 2 || !loaded_disk)
		return FALSE
	return TRUE

/obj/structure/bed/chair/kz/neural_station/proc/perform_extract(mob/living/carbon/human/target, mob/user)
	if(!can_extract(target))
		return FALSE
	if(!target.base_skills)
		to_chat(user, span_warning("Target has no base skills recorded!"))
		return FALSE
	var/datum/skills/base_copy = target.base_skills.Copy()
	loaded_disk.stored_name = target.real_name
	loaded_disk.stored_skills = base_copy
	var/list/skill_names = list(
		"unarmed","melee_weapons","combat","pistols","shotguns",
		"rifles","smgs","heavy_weapons","smartgun","engineer",
		"construction","leadership","medical","surgery","pilot",
		"police","powerloader","large_vehicle","mech","stamina","sex")
	var/list/old_values = list()
	for(var/skill in skill_names)
		old_values[skill] = target.skills.vars[skill]
	target.adjustCloneLoss(25)
	var/datum/status_effect/skill_modifier/extraction/existing_effect = target.has_status_effect(/datum/status_effect/skill_modifier/extraction)
	if(existing_effect)
		qdel(existing_effect)
	var/datum/status_effect/skill_modifier/extraction/extract_effect = target.apply_status_effect(/datum/status_effect/skill_modifier/extraction)
	if(!extract_effect)
		to_chat(user, span_warning("Extraction failed!"))
		return FALSE
	target.extract_count++
	if(target.client)
		addtimer(CALLBACK(target, /mob/living/carbon/human/proc/enable_skill_restore), 5 MINUTES)
	to_chat(user, span_notice("Extraction complete. Neurodisk encoded with [target]'s base skills."))
	to_chat(target, span_userdanger("Your mind feels distorted... You should rest in a cryotube."))
	if(attached_console)
		var/list/changes = list()
		for(var/skill in skill_names)
			var/old_val = old_values[skill]
			var/new_val = target.skills.vars[skill]
			if(old_val != new_val)
				changes += list(list("skill" = skill, "from" = old_val, "to" = new_val))
		var/extractor_name = user ? user.real_name : "Unknown"
		attached_console.logs += list(list(
			"time" = stationTimestamp(),
			"text" = "[stationTimestamp()] : Extracted from [target.real_name] by [extractor_name]",
			"type" = "extract",
			"changes" = changes
		))
	return TRUE

/obj/structure/bed/chair/kz/neural_station/proc/can_imprint(mob/living/carbon/human/target)
	if(!target || target.stat == DEAD || HAS_TRAIT(target, TRAIT_SKILLS_IMPRINTED) || !loaded_disk || !loaded_disk.stored_name)
		return FALSE
	return TRUE

/obj/structure/bed/chair/kz/neural_station/proc/perform_imprint(mob/living/carbon/human/target, mob/user)
	if(!can_imprint(target))
		return FALSE
	if(!target.base_skills)
		to_chat(user, span_warning("Target has no base skills recorded!"))
		return FALSE
	if(!loaded_disk?.stored_skills)
		to_chat(user, span_warning("Disk data is corrupted!"))
		return FALSE
	var/datum/skills/disk_skills = loaded_disk.stored_skills
	var/datum/skills/target_base = target.base_skills
	var/datum/skills/target_current = target.skills
	var/list/skills_to_apply = list()
	var/list/skill_names = list(
		"unarmed","melee_weapons","combat","pistols","shotguns",
		"rifles","smgs","heavy_weapons","smartgun","engineer",
		"construction","leadership","medical","surgery","pilot",
		"police","powerloader","large_vehicle","mech","stamina","sex")
	for(var/skill in skill_names)
		var/base_value = target_base.vars[skill]
		var/disk_value = disk_skills.vars[skill]
		var/current_value = target_current.vars[skill]
		if(disk_value > base_value && disk_value > current_value)
			skills_to_apply[skill] = disk_value
	if(!skills_to_apply.len)
		to_chat(user, span_warning("No skills were improved by this imprint."))
		return FALSE
	var/list/old_values = list()
	for(var/skill in skill_names)
		old_values[skill] = target_current.vars[skill]
	var/datum/status_effect/skill_modifier/imprint/existing_effect = target.has_status_effect(/datum/status_effect/skill_modifier/imprint)
	if(existing_effect)
		qdel(existing_effect)
	var/datum/status_effect/skill_modifier/imprint/imprint_effect = target.apply_status_effect(/datum/status_effect/skill_modifier/imprint)
	if(!imprint_effect)
		to_chat(user, span_warning("Imprint failed!"))
		return FALSE
	imprint_effect.skills_to_apply = skills_to_apply
	if(!imprint_effect.apply_imprint())
		qdel(imprint_effect)
		to_chat(user, span_warning("Imprint failed!"))
		return FALSE
	if(target.client)
		addtimer(CALLBACK(target, /mob/living/carbon/human/proc/enable_skill_restore), 5 MINUTES)
	target.adjustCloneLoss(25)
	to_chat(user, span_notice("Imprint complete. [target]'s skills have been enhanced."))
	to_chat(target, span_userdanger("A wave of disorientation washes over you."))
	if(attached_console)
		var/list/changes = list()
		for(var/skill in skills_to_apply)
			var/old_val = old_values[skill]
			var/new_val = target.skills.vars[skill]
			if(old_val != new_val)
				changes += list(list("skill" = skill, "from" = old_val, "to" = new_val))
		var/imprinter_name = user ? user.real_name : "Unknown"
		attached_console.logs += list(list(
			"time" = stationTimestamp(),
			"text" = "[stationTimestamp()] : Imprinted [loaded_disk.stored_name] into [target.real_name] by [imprinter_name]",
			"type" = "imprint",
			"changes" = changes
		))
	loaded_disk.stored_name = null
	loaded_disk.stored_skills = null
	return TRUE

/datum/status_effect/skill_modifier
	id = "skill_modifier"
	status_type = STATUS_EFFECT_REPLACE
	duration = -1
	alert_type = null
	var/list/skill_differences = list()

/datum/status_effect/skill_modifier/on_apply()
	. = ..()
	var/mob/living/carbon/human/human_owner = owner
	if(!istype(human_owner))
		return FALSE
	apply_modifiers(human_owner)

/datum/status_effect/skill_modifier/proc/apply_modifiers(mob/living/carbon/human/human_owner)
	if(!skill_differences.len)
		return
	var/datum/skills/current_skills = human_owner.skills
	for(var/skill in skill_differences)
		var/difference = skill_differences[skill]
		if(!isnull(difference))
			current_skills.vars[skill] = max(0, current_skills.vars[skill] + difference)

/datum/status_effect/skill_modifier/on_remove()
	. = ..()
	var/mob/living/carbon/human/human_owner = owner
	if(!istype(human_owner))
		return
	var/datum/skills/current_skills = human_owner.skills
	for(var/skill in skill_differences)
		var/difference = skill_differences[skill]
		if(!isnull(difference))
			current_skills.vars[skill] = max(0, current_skills.vars[skill] - difference)
	if(HAS_TRAIT(human_owner, TRAIT_SKILLS_EXTRACTED))
		REMOVE_TRAIT(human_owner, TRAIT_SKILLS_EXTRACTED, TRAIT_GENERIC)
	if(HAS_TRAIT(human_owner, TRAIT_SKILLS_IMPRINTED))
		REMOVE_TRAIT(human_owner, TRAIT_SKILLS_IMPRINTED, TRAIT_GENERIC)
	if(HAS_TRAIT(human_owner, TRAIT_SKILLS_EDITED))
		REMOVE_TRAIT(human_owner, TRAIT_SKILLS_EDITED, TRAIT_GENERIC)

/datum/status_effect/skill_modifier/extraction
	id = "skill_extraction"
	alert_type = null
	duration = -1
	var/list/pre_extraction_skills = list()

/datum/status_effect/skill_modifier/extraction/on_apply()
	var/mob/living/carbon/human/human_owner = owner
	if(!istype(human_owner) || !human_owner.base_skills)
		return FALSE
	var/datum/skills/current_skills = human_owner.skills
	var/list/skill_names = list(
		"unarmed","melee_weapons","combat","pistols","shotguns",
		"rifles","smgs","heavy_weapons","smartgun","engineer",
		"construction","leadership","medical","surgery","pilot",
		"police","powerloader","large_vehicle","mech","stamina","sex")
	for(var/skill in skill_names)
		pre_extraction_skills[skill] = current_skills.vars[skill]
		if(current_skills.vars[skill] > 0)
			skill_differences[skill] = -1
	ADD_TRAIT(human_owner, TRAIT_SKILLS_EXTRACTED, TRAIT_GENERIC)
	return ..()

/datum/status_effect/skill_modifier/imprint
	id = "skill_imprint"
	alert_type = null
	duration = -1
	var/list/skills_to_apply = list()

/datum/status_effect/skill_modifier/imprint/on_apply()
	var/mob/living/carbon/human/human_owner = owner
	if(!istype(human_owner) || !human_owner.base_skills)
		return FALSE
	ADD_TRAIT(human_owner, TRAIT_SKILLS_IMPRINTED, TRAIT_GENERIC)
	ADD_TRAIT(human_owner, TRAIT_SKILLS_EDITED, TRAIT_GENERIC)
	return ..()

/datum/status_effect/skill_modifier/imprint/proc/apply_imprint()
	var/mob/living/carbon/human/human_owner = owner
	if(!istype(human_owner) || !skills_to_apply.len)
		return FALSE
	var/datum/skills/current_skills = human_owner.skills
	var/list/differences = list()
	for(var/skill in skills_to_apply)
		var/new_value = skills_to_apply[skill]
		var/old_value = current_skills.vars[skill]
		var/diff = new_value - old_value
		if(diff > 0)
			differences[skill] = diff
	if(!differences.len)
		return FALSE
	skill_differences = differences
	apply_modifiers(human_owner)
	return TRUE

/obj/machinery/computer/neural_station_console
	name = "Unknown diagnostic terminal"
	desc = "A compact terminal with concealed wiring and sealed panels."
	icon = 'ntf_modular/icons/obj/structures/kz_stuff.dmi'
	icon_state = "kz_terminal"
	base_icon_state = "kz_terminal"
	resistance_flags = RESIST_ALL
	var/obj/structure/bed/chair/kz/neural_station/linked_station
	var/list/logs = list()

/obj/machinery/computer/neural_station_console/examine(mob/user)
	. = ..()
	if(user.faction != FACTION_VSD)
		return
	. += "<br><b>KZ Neural Station Console</b><br>Kaizoku Covert Division control interface for neural harvesting and imprinting operations."
	. += "<br>Allows extraction and imprinting of cortical skill structures via NS-92 neurodisks."
	. += "<br><i>Unauthorized access will result in immediate contract termination and/or asset liquidation.</i><br>"
	if(linked_station)
		. += "It is linked to a neural station."
	else
		. += "It is not linked to any station."

/obj/machinery/computer/neural_station_console/Initialize(mapload)
	. = ..()
	if(!linked_station)
		for(var/obj/structure/bed/chair/kz/neural_station/station in range(3, src))
			if(!station.attached_console)
				linked_station = station
				station.attached_console = src
				break

/obj/machinery/computer/neural_station_console/Destroy()
	if(linked_station)
		linked_station.attached_console = null
		linked_station = null
	return ..()

/obj/machinery/computer/neural_station_console/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(user.faction != FACTION_VSD)
		to_chat(user, span_warning("Access denied."))
		return
	ui_interact(user)

/obj/machinery/computer/neural_station_console/attack_hand_alternate(mob/living/user)
	if(user.faction != FACTION_VSD)
		to_chat(user, span_warning("Access denied."))
		return
	ui_interact(user)

/obj/machinery/computer/neural_station_console/ui_interact(mob/user, datum/tgui/ui)
	if(user.faction != FACTION_VSD)
		to_chat(user, span_warning("Access denied."))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NeuralStationConsole")
		ui.open()

/obj/machinery/computer/neural_station_console/ui_data(mob/user)
	var/list/data = list()
	if(!linked_station)
		data["error"] = "No neural station linked."
		return data
	var/mob/living/carbon/human/target = linked_station.current_occupant
	data["has_disk"] = !!linked_station?.loaded_disk
	data["disk_has_data"] = linked_station?.loaded_disk && linked_station.loaded_disk.stored_name ? TRUE : FALSE
	data["disk_name"] = linked_station?.loaded_disk?.stored_name
	var/list/formatted_logs = list()
	for(var/list/log_entry in logs)
		var/list/formatted_entry = list()
		formatted_entry["text"] = log_entry["text"]
		formatted_entry["type"] = log_entry["type"]
		var/list/formatted_changes = list()
		for(var/list/change in log_entry["changes"])
			var/formatted_skill = capitalize(replacetext(change["skill"], "_", " "))
			formatted_changes += list(list(
				"skill" = formatted_skill,
				"from" = change["from"],
				"to" = change["to"],
				"direction" = (change["to"] > change["from"] ? "up" : "down")
			))
		formatted_entry["changes"] = formatted_changes
		formatted_logs += list(formatted_entry)
	var/list/reversed_logs = list()
	for(var/i = formatted_logs.len; i >= 1; i--)
		reversed_logs += list(formatted_logs[i])
	data["logs"] = reversed_logs
	if(!target)
		data["no_target"] = TRUE
		return data
	data["target_name"] = target.real_name
	data["health"] = target.health
	data["brute"] = target.getBruteLoss()
	data["burn"] = target.getFireLoss()
	data["toxin"] = target.getToxLoss()
	data["clone"] = target.getCloneLoss()
	data["brain"] = target.getBrainLoss()
	data["oxy"] = target.getOxyLoss()
	var/list/skills_data = list()
	if(target.base_skills && target.skills)
		var/list/skill_names = list(
			"unarmed","melee_weapons","combat","pistols","shotguns",
			"rifles","smgs","heavy_weapons","smartgun","engineer",
			"construction","leadership","medical","surgery","pilot",
			"police","powerloader","large_vehicle","mech","stamina","sex")
		for(var/skill in skill_names)
			var/base_value = target.base_skills.vars[skill]
			var/current_value = target.skills.vars[skill]
			var/color = "white"
			if(current_value < base_value)
				color = "red"
			else if(current_value > base_value)
				color = "green"
			skills_data += list(list(
				"name" = skill,
				"base" = base_value,
				"current" = current_value,
				"color" = color))
	data["skills"] = skills_data
	return data

/obj/machinery/computer/neural_station_console/attackby(obj/item/attacking_item, mob/living/user)
	if(istype(attacking_item, /obj/item/disk/kz_neurodisk))
		if(user.faction != FACTION_VSD)
			to_chat(user, span_warning("You have no idea how to operate that kind of device."))
			return TRUE
		var/obj/item/disk/kz_neurodisk/disk = attacking_item
		if(disk.stored_name)
			to_chat(user, span_warning("You can't load encoded neurodisks into the console!"))
			return TRUE
		if(linked_station?.loaded_disk)
			to_chat(user, span_warning("A disk is already loaded!"))
			return TRUE
		to_chat(user, span_notice("You start loading the empty neurodisk into the console."))
		if(!do_after(user, 7 SECONDS, src))
			to_chat(user, span_warning("Loading interrupted!"))
			return TRUE
		linked_station.loaded_disk = disk
		to_chat(user, span_notice("You load the empty neurodisk into the console."))
		user.drop_held_item()
		qdel(attacking_item)
		return TRUE
	return ..()

/obj/machinery/computer/neural_station_console/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	var/mob/living/user = usr
	if(user.faction != FACTION_VSD)
		to_chat(user, span_warning("Access denied."))
		return
	if(!linked_station)
		to_chat(user, span_warning("No neural station linked."))
		return
	switch(action)
		if("extract")
			if(!user?.client)
				return
			var/mob/living/carbon/human/target = linked_station.current_occupant
			if(!target)
				to_chat(user, span_warning("No one is in the station."))
				return
			if(!linked_station.can_extract(target))
				to_chat(user, span_warning("Extraction not possible."))
				return
			if(!do_after(user, 60 SECONDS, target))
				to_chat(user, span_warning("Extraction interrupted!"))
				return
			if(linked_station.perform_extract(target, user))
				. = TRUE
				if(ui?.user?.client)
					ui?.send_full_update()
		if("imprint")
			if(!user?.client)
				return
			var/mob/living/carbon/human/target = linked_station.current_occupant
			if(!target)
				to_chat(user, span_warning("No one is in the station."))
				return
			if(!linked_station.can_imprint(target))
				to_chat(user, span_warning("Imprint not possible."))
				return
			if(!do_after(user, 60 SECONDS, target))
				to_chat(user, span_warning("Imprint interrupted!"))
				return
			if(linked_station.perform_imprint(target, user))
				. = TRUE
				if(ui?.user?.client)
					ui?.send_full_update()
		if("eject_disk")
			if(linked_station.loaded_disk)
				var/obj/item/disk/kz_neurodisk/old_disk = linked_station.loaded_disk
				linked_station.loaded_disk = null
				var/obj/item/disk/kz_neurodisk/new_disk = new(get_turf(user))
				new_disk.stored_name = old_disk.stored_name
				new_disk.stored_skills = old_disk.stored_skills?.Copy()
				qdel(old_disk)
				if(!user.put_in_hands(new_disk))
					new_disk.forceMove(get_turf(user))
				to_chat(user, span_notice("You eject the neurodisk."))
				. = TRUE
		if("clear_logs")
			logs.Cut()
			. = TRUE

/obj/item/disk/kz_neurodisk
	name = "Unlabeled data disk"
	desc = "A small metallic disk with no markings."
	icon_state = "nucleardisk"
	resistance_flags = RESIST_ALL
	var/stored_name
	var/datum/skills/stored_skills

/obj/item/disk/kz_neurodisk/examine(mob/user)
	. = ..()
	if(user.faction != FACTION_VSD)
		return
	. += "<br><b>NS-92 Covert Neurodisk</b><br>Kaizoku Covert Division encrypted module containing extracted neural skill architecture."
	. += "<br><i>Unauthorized disclosure will result in immediate termination.</i><br>"
	if(stored_name)
		. += "This neurodisk contains <b>[stored_name]'s</b> scan."

/obj/item/disk/kz_neurodisk/attack_self(mob/user)
	. = ..()
	if(user.faction != FACTION_VSD || !stored_name)
		return
	to_chat(user, span_notice("You initiate the neurodisk wiping process."))
	if(!do_after(user, 7 SECONDS, src))
		to_chat(user, span_warning("Neurodisk wiping interrupted! You'll need to start over."))
		return TRUE
	stored_name = null
	stored_skills = null
	to_chat(user, span_notice("Neurodisk successfully wiped."))
