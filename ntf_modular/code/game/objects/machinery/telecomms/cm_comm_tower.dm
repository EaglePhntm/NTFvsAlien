/// The time when xenos can start taking over comm towers
#define XENO_COMM_ACQUISITION_TIME (55 MINUTES)
/// The time until you can re-corrupt a comms relay after the last pylon was destroyed
#define XENO_PYLON_DESTRUCTION_DELAY (5 MINUTES)

#define NTC_SIDED_FREQS list(FREQ_COMMON, FREQ_PMC, FREQ_CIV_GENERAL, FREQ_ICC, FREQ_COMMAND, FREQ_CAS, FREQ_SEC, FREQ_MEDICAL, FREQ_ENGINEERING, FREQ_REQUISITIONS, FREQ_DEATHSQUAD, FREQ_ALPHA, FREQ_BRAVO, FREQ_CHARLIE, FREQ_DELTA)
#define SOM_FREQS list(FREQ_SOM, FREQ_COMMAND_SOM, FREQ_MEDICAL_SOM, FREQ_ENGINEERING_SOM, FREQ_ZULU, FREQ_YANKEE, FREQ_XRAY, FREQ_WHISKEY)
#define KZ_FREQS list(FREQ_VSD)
#define CM_FREQS list(FREQ_ICC)
#define CLF_FREQS list(FREQ_COLONIST)

/obj/item/circuitboard/machine/telecomms/relay/tower
	name = "\improper TC-4T Telecommunications Circuit Board"
	build_path = /obj/machinery/telecomms/relay/preset/tower

	frame_desc = "A TC-4T telecommunications circuit board. Requires 2 Power Cells, 2 Cable Coils and a Subspace Communications Dish."
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/obj/item/cell = 2,
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/subspace/filter = 2,
	)

/obj/item/circuitboard/machine/telecomms/relay/tower/faction
	name = "\improper TC-4T Telecommunications Circuit Board"
	build_path = /obj/machinery/telecomms/relay/preset/tower/faction

/obj/item/circuitboard/machine/telecomms/relay/tower/faction/som
	name = "\improper TC-4T Telecommunications SOM Circuit Board"
	build_path = /obj/machinery/telecomms/relay/preset/tower/faction/som

/obj/item/circuitboard/machine/telecomms/relay/tower/faction/clf
	name = "\improper TC-4T Telecommunications CLF Circuit Board"
	build_path = /obj/machinery/telecomms/relay/preset/tower/faction/clf

/obj/item/circuitboard/machine/telecomms/relay/tower/faction/cm
	name = "\improper TC-4T Telecommunications CM Circuit Board"
	build_path = /obj/machinery/telecomms/relay/preset/tower/faction/cm

/obj/item/circuitboard/machine/telecomms/relay/tower/faction/kz
	name = "\improper TC-4T Telecommunications KZ Circuit Board"
	build_path = /obj/machinery/telecomms/relay/preset/tower/faction/kz

/obj/item/storage/box/crate/loot/telecomm_tower_pack/Initialize(mapload)
	. = ..()
	new /obj/item/stack/cable_coil/twentyfive(src)
	new /obj/item/cell(src)
	new /obj/item/cell(src)
	new /obj/item/stack/sheet/metal/small_stack(src)
	new /obj/item/stock_parts/manipulator(src)
	new /obj/item/stock_parts/manipulator(src)
	new /obj/item/stock_parts/subspace/filter(src)
	new /obj/item/stock_parts/subspace/filter(src)


/obj/item/storage/box/crate/loot/telecomm_tower_pack/ntc/Initialize(mapload)
	. = ..()
	new /obj/item/circuitboard/machine/telecomms/relay/tower/faction(src)

/obj/item/storage/box/crate/loot/telecomm_tower_pack/som/Initialize(mapload)
	. = ..()
	new /obj/item/circuitboard/machine/telecomms/relay/tower/faction/som(src)

/obj/item/storage/box/crate/loot/telecomm_tower_pack/clf/Initialize(mapload)
	. = ..()
	new /obj/item/circuitboard/machine/telecomms/relay/tower/faction/clf(src)

/obj/item/storage/box/crate/loot/telecomm_tower_pack/cm/Initialize(mapload)
	. = ..()
	new /obj/item/circuitboard/machine/telecomms/relay/tower/faction/cm(src)

/obj/item/storage/box/crate/loot/telecomm_tower_pack/kz/Initialize(mapload)
	. = ..()
	new /obj/item/circuitboard/machine/telecomms/relay/tower/faction/kz(src)

/obj/machinery/telecomms/relay/preset/tower
	name = "TC-4T telecommunications tower"
	icon = 'ntf_modular/icons/obj/structures/machinery/comm_tower2.dmi'
	icon_state = "comm_tower"
	desc = "A portable compact TC-4T telecommunications tower. Used to set up subspace communications lines between planetary and extra-planetary locations."
	id = "TC-4T Relay"
	autolinkers = list("relay")
	layer = FLY_LAYER
	use_power = NO_POWER_USE
	idle_power_usage = 0
	netspeed = 40
	resistance_flags = UNACIDABLE|XENO_DAMAGEABLE|CAN_BE_HIT|PORTAL_IMMUNE|BANISH_IMMUNE
	var/health = 450 //we use this seperate var so shit dont delete I guess.
	freq_listening = NTC_SIDED_FREQS

/obj/machinery/telecomms/relay/preset/tower/Initialize()
	GLOB.all_static_telecomms_towers += src
	. = ..()
	if(z)
		SSminimaps.add_marker(src, MINIMAP_FLAG_ALL, image('icons/UI_icons/map_blips.dmi', null, "supply"))
	START_PROCESSING(SSslowprocess, src)

/obj/machinery/telecomms/relay/preset/tower/Destroy()
	GLOB.all_static_telecomms_towers -= src
	. = ..()

// doesn't need power, instead uses health
/obj/machinery/telecomms/relay/preset/tower/is_operational()
	. = ..()
	if(machine_stat & BROKEN)
		return FALSE
	if(health <= 0)
		return FALSE
	return TRUE

/obj/machinery/telecomms/relay/preset/tower/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount, damage_type, armor_type, effects, armor_penetration, isrightclick)
	xeno_attacker.do_attack_animation(src, ATTACK_EFFECT_CLAW)
	playsound(loc, SFX_ALIEN_CLAW_METAL, 25)
	update_health(damage_amount)

/obj/machinery/telecomms/relay/preset/tower/tail_stab_act(mob/living/carbon/xenomorph/xeno, damage, target_zone, penetration, structure_damage_multiplier, stab_description, disorientamount, can_hit_turf)
	if(!xeno.blunt_stab)
		xeno.do_attack_animation(src, ATTACK_EFFECT_REDSTAB)
		xeno.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
	else
		xeno.do_attack_animation(src, ATTACK_EFFECT_SMASH)
	playsound(src, "alien_tail_swipe", 50, TRUE)
	playsound(src, pick('sound/effects/bang.ogg','sound/effects/metal_crash.ogg','sound/effects/meteorimpact.ogg'), 25, 1)
	Shake(duration = 0.5 SECONDS)
	update_health(damage * structure_damage_multiplier)
	return TRUE

/obj/machinery/telecomms/relay/preset/tower/bullet_act(atom/movable/projectile/P)
	..()
	if(istype(P.ammo, /datum/ammo/xeno/boiler_gas))
		update_health(50)

	update_health(floor(P.damage/2))
	return TRUE

/obj/machinery/telecomms/relay/preset/tower/proc/update_health(damage = 0)
	if(!damage)
		return
	if(damage > 0 && health <= 0)
		return // Leave the poor thing alone

	health -= damage
	health = clamp(health, 0, initial(health))

	if(health <= 0)
		toggled = FALSE // requires flipping on again once repaired
	if(health < initial(health))
		desc = "[initial(desc)] [span_warning(" It is damaged and needs a welder for repairs!")]"
	else
		desc = initial(desc)
	update_state()

// In any case that might warrant reevaluating working state
/obj/machinery/telecomms/relay/preset/tower/proc/update_state()
	if(!toggled || !is_operational() || health <= 0)
		if(on)
			message_admins("Portable communication relay shut down for Z-Level [src.z] [ADMIN_JMP(src)]")
			on = FALSE
	else if(!on)
		playsound(src, 'ntf_modular/sound/machines/tcomms_on.ogg', vol = 80, vary = FALSE, sound_range = 16, falloff = 0.5)
		message_admins("Portable communication relay started for Z-Level [src.z] [ADMIN_JMP(src)]")
		on = TRUE
	update_icon()
	return on

// When an operator attempts to flip the switch
/obj/machinery/telecomms/relay/preset/tower/proc/toggle_state(mob/user)
	if(!toggled && (!is_operational() || (health <= initial(health) / 2)))
		to_chat(user, span_warning("\The [src.name] needs repairs to be turned back on!"))
		return
	toggled = !toggled
	update_state()

/obj/machinery/telecomms/relay/preset/tower/update_icon_state()
	. = ..()
	if(health <= 0)
		icon_state = "[initial(icon_state)]_broken"
	else if(on)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_off"

/obj/machinery/telecomms/relay/preset/tower/attackby(obj/item/I, mob/user)
	if(iswelder(I))
		if(length(user.do_actions))
			balloon_alert(user, "Busy!")
			return
		if(user.skills.getRating(SKILL_ENGINEER) < SKILL_ENGINEER_METAL)
			to_chat(user, span_warning("You're not trained to repair [src]..."))
			return
		var/obj/item/tool/weldingtool/WT = I

		if(health >= initial(health))
			to_chat(user, span_warning("[src] doesn't need repairs."))
			return

		if(WT.remove_fuel(0, user))
			user.visible_message(span_notice("[user] begins repairing damage to [src]."),
			span_notice("You begin repairing the damage to [src]."))
			playsound(src.loc, 'sound/items/Welder2.ogg', 25, 1)
			if(do_after(user, 50 * - 10 * user.skills.getRating(SKILL_ENGINEER), IGNORE_HAND|IGNORE_HELD_ITEM, src, BUSY_ICON_FRIENDLY))
				user.visible_message(span_notice("[user] repairs some damage on [src]."),
				span_notice("You repair [src]."))
				update_health(-150)
				playsound(src.loc, 'sound/items/Welder2.ogg', 25, 1)
		return

	else if(ismultitool(I))
		return
	else
		return ..()

/obj/machinery/telecomms/relay/preset/tower/attack_hand(mob/user)
	if(issilicon(user))
		return ..()
	if(on)
		to_chat(user, span_warning("\The [src.name] blinks and beeps incomprehensibly as it operates, better not touch this..."))
		return
	toggle_state(user) // just flip dat switch

/obj/machinery/telecomms/relay/preset/tower/all
	freq_listening = list()

/obj/machinery/telecomms/relay/preset/tower/faction
	name = "NTC telecommunications relay"
	desc = "A mighty piece of hardware used to send massive amounts of data far away. This one is intercepting and rebroadcasting NTC frequencies."
	icon = 'ntf_modular/icons/obj/structures/machinery/comm_tower.dmi'
	icon_state = "comm_tower"
	id = "NTC Relay"
	autolinkers = list("relay")
	hide = TRUE
	freq_listening =  NTC_SIDED_FREQS
	var/faction_shorthand = "NTC"

/obj/machinery/telecomms/relay/preset/tower/faction/som
	freq_listening = list(FREQ_SOM, FREQ_COMMAND_SOM, FREQ_MEDICAL_SOM, FREQ_ENGINEERING_SOM, FREQ_ZULU, FREQ_YANKEE, FREQ_XRAY, FREQ_WHISKEY)
	faction_shorthand = "SOM"

/obj/machinery/telecomms/relay/preset/tower/faction/kz
	freq_listening = KZ_FREQS
	faction_shorthand = "KZ"

/obj/machinery/telecomms/relay/preset/tower/faction/cm
	freq_listening = CM_FREQS
	faction_shorthand = "CM"

/obj/machinery/telecomms/relay/preset/tower/faction/clf
	freq_listening = CLF_FREQS
	faction_shorthand = "CLF"

/obj/machinery/telecomms/relay/preset/tower/faction/Initialize(mapload, ...)
	if(faction_shorthand)
		name = replacetext(name, "NTC", faction_shorthand)
		desc = replacetext(desc, "NTC", faction_shorthand)
		id = replacetext(id, "NTC", faction_shorthand)
	return ..()

/obj/machinery/telecomms/relay/preset/tower/faction/colony
	freq_listening = list(FREQ_CIV_GENERAL)
	faction_shorthand = "colony"

//mapcomms ---------

/obj/machinery/telecomms/relay/preset/tower/mapcomms
	name = "TC-3T static telecommunications tower"
	desc = "A static heavy-duty TC-3T telecommunications tower. Used to set up subspace communications lines between planetary and extra-planetary locations. Will need to have extra communication frequencies programmed into it by multitool."
	use_power = NO_POWER_USE
	idle_power_usage = 10000
	icon = 'ntf_modular/icons/obj/structures/machinery/comm_tower3.dmi'
	icon_state = "static1"
	id = "TC-3T relay"
	autolinkers = list("relay")
	toggled = FALSE
	health = 1000
	bound_height = 64
	bound_width = 64
	freq_listening = NTC_SIDED_FREQS
	var/obj/structure/xeno/recovery_pylon/attached_pylon
	var/toggle_cooldown = 0

	/// Tower has been taken over by xenos, is not usable
	var/corrupted = FALSE
	/// Tower has been taken before, this gives xenos an extra resin point on capture for the first time.
	var/captured_before = FALSE


	/// Held image for the current overlay on the tower from xeno corruption
	var/image/corruption_image

	/// Holds the delay for when a cluster can recorrupt the comms tower after a pylon has been destroyed
	COOLDOWN_DECLARE(corruption_delay)

/obj/machinery/telecomms/relay/preset/tower/mapcomms/Initialize()
	. = ..()

/obj/machinery/telecomms/relay/preset/tower/mapcomms/examine(mob/user)
	. = ..()
	if(isxeno(user) && !COOLDOWN_FINISHED(src, corruption_delay))
		. += span_xenonotice("Corruption cooldown: [(COOLDOWN_TIMELEFT(src, corruption_delay) / (1 SECONDS))] seconds.")

/obj/machinery/telecomms/relay/preset/tower/mapcomms/attack_hand(mob/user)
	if(length(user.do_actions))
		balloon_alert(user, "Busy!")
		return
	if(toggle_cooldown > world.time) //cooldown only to prevent spam toggling
		to_chat(user, span_warning("\The [src]'s processors are still cooling! Wait before trying to flip the switch again."))
		return
	if(corrupted)
		to_chat(user, span_warning("[src] is entangled in resin. Impossible to interact with."))
		return
	var/current_state = on
	if(!do_after(user, 20, IGNORE_HELD_ITEM|IGNORE_HAND, src, BUSY_ICON_FRIENDLY))
		return
	if(current_state != on)
		to_chat(user, span_notice("\The [src] is already turned [on ? "on" : "off"]!"))
		return
	if(machine_stat & NOPOWER)
		to_chat(user, span_warning("\The [src] makes a small plaintful beep, and nothing happens. It seems to be out of power."))
		return FALSE
	if(toggle_cooldown > world.time) //cooldown only to prevent spam toggling
		to_chat(user, span_warning("\The [src]'s processors are still cooling! Wait before trying to flip the switch again."))
		return
	toggle_state(user) // just flip dat switch
	var/turf/commloc = get_turf(src)
	var/area/commarea = get_area(src)
	if(on) //now, if it went on it now uses power
		use_power = IDLE_POWER_USE
		message_admins("[key_name(user)] turned \the [src] in [commarea] ON. [ADMIN_JMP(commloc.loc)]")
	else
		use_power = NO_POWER_USE
		message_admins("[key_name(user)] turned \the [src] in [commarea] OFF. [ADMIN_JMP(commloc.loc)]")
	toggle_cooldown = world.time + 4 SECONDS
	update_icon_state()

/obj/machinery/telecomms/relay/preset/tower/mapcomms/attackby(obj/item/I, mob/user)
	if(ismultitool(I))
		if(!is_operational() || (health <= initial(health) * 0.5))
			to_chat(user, span_warning("\The [src.name] needs repairs to have frequencies added to its software!"))
			return
		var/choice = tgui_input_list(user, "What do you wish to do?", "TC-3T comms tower", list("Wipe communication frequencies", "Add your faction's frequencies"))
		if(choice == "Wipe communication frequencies")
			freq_listening = list(FREQ_CIV_GENERAL)
			to_chat(user, span_notice("You wipe the preexisting frequencies from \the [src]."))
			return
		else if(choice == "Add your faction's frequencies")
			if(!do_after(user, 10, IGNORE_HAND|IGNORE_HELD_ITEM, BUSY_ICON_BUILD))
				return
			if(user.faction in GLOB.faction_to_radio)
				switch(faction)
					if(FACTION_TERRAGOV,FACTION_NANOTRASEN,FACTION_ICC)
						freq_listening -=  NTC_SIDED_FREQS
						freq_listening +=  NTC_SIDED_FREQS
					if(FACTION_SOM)
						freq_listening -= SOM_FREQS
						freq_listening += SOM_FREQS
					if(FACTION_VSD)
						freq_listening -= KZ_FREQS
						freq_listening += KZ_FREQS
					if(FACTION_CLF)
						freq_listening -= CLF_FREQS
						freq_listening += CLF_FREQS
				to_chat(user, span_notice("You add your faction's communication frequencies to \the [src]'s comm list."))
			else
				to_chat(user, span_notice("You don't have a fitting faction."))
			return
	. = ..()

/obj/machinery/telecomms/relay/preset/tower/mapcomms/power_change()
	..()
	if((machine_stat & NOPOWER))
		if(on)
			toggle_state()
			on = FALSE
			update_icon()

/obj/machinery/telecomms/relay/preset/tower/mapcomms/process()
	. = ..()
	if(!is_operational())
		handle_xeno_acquisition(get_turf(src))

/// Handles xenos corrupting the tower when weeds touch the turf it is located on
/obj/machinery/telecomms/relay/preset/tower/mapcomms/proc/handle_xeno_acquisition(turf/weeded_turf)
	if(corrupted)
		return

	var/obj/alien/weeds/theweed = locate() in weeded_turf
	if(!theweed)
		return

	if(theweed.get_xeno_hivenumber() == XENO_HIVE_CORRUPTED)
		return

	if(SSticker.current_state == GAME_STATE_FINISHED)
		return

	if(is_operational())
		return

	if(world.time < XENO_COMM_ACQUISITION_TIME)
		addtimer(CALLBACK(src, PROC_REF(handle_xeno_acquisition), weeded_turf), (XENO_COMM_ACQUISITION_TIME - world.time), TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_NO_HASH_WAIT)
		return

	if(!COOLDOWN_FINISHED(src, corruption_delay))
		addtimer(CALLBACK(src, PROC_REF(handle_xeno_acquisition), weeded_turf), (COOLDOWN_TIMELEFT(src, corruption_delay)), TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_NO_HASH_WAIT)
		return

	attached_pylon = new /obj/structure/xeno/recovery_pylon(loc, theweed.get_xeno_hivenumber())
	new /obj/alien/weeds/node/resting(loc, theweed.get_xeno_hivenumber())

	RegisterSignal(attached_pylon, COMSIG_PREQDELETED, PROC_REF(uncorrupt))

	corrupted = TRUE

	corruption_image = image(icon, icon_state = "resin_growing")

	flick_overlay(src, corruption_image, (2 SECONDS))
	addtimer(CALLBACK(src, PROC_REF(switch_to_idle_corruption)), (2 SECONDS))

	if(!captured_before)
		captured_before = TRUE
		attached_pylon.radius += 1

/// Handles removing corruption effects from the comms relay
/obj/machinery/telecomms/relay/preset/tower/mapcomms/proc/uncorrupt(datum/deleting_datum)
	SIGNAL_HANDLER

	corrupted = FALSE

	overlays -= corruption_image

	COOLDOWN_START(src, corruption_delay, XENO_PYLON_DESTRUCTION_DELAY)

/// Handles moving the overlay from growing to idle
/obj/machinery/telecomms/relay/preset/tower/mapcomms/proc/switch_to_idle_corruption()
	if(!corrupted)
		return

	corruption_image = image(icon, icon_state = "resin_idle")

	overlays += corruption_image


#undef NTC_SIDED_FREQS
#undef SOM_FREQS
#undef KZ_FREQS
#undef CM_FREQS
#undef CLF_FREQS
