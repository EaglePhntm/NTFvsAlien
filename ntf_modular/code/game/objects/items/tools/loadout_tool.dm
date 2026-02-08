/obj/item/radio/loadout_tool
	name = "Personal Holophone"
	desc = "A holophone used for radio communication and other personal things, duh. Also used to download miniskillsofts into your neural implant RAM, temporary and less effective than actual skillsofts that are chip based. ALT+CLICK to view loadout and skillsoft menu. RCLICK to turn it on/off."
	icon = 'ntf_modular/icons/obj/items/pda.dmi'
	icon_state = "pda_white"
	var/screen_overlay = "pda_on"
	active = FALSE
	light_range = 1
	light_power = 2
	light_color = COLOR_BLUE

/obj/item/radio/loadout_tool/Initialize(mapload)
	. = ..()
	GLOB.nightfall_toggleable_lights += src

/obj/item/radio/loadout_tool/Destroy()
	GLOB.nightfall_toggleable_lights -= src
	return ..()

/obj/item/flashlight/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage * xeno_attacker.xeno_melee_damage_modifier, damage_type = BRUTE, armor_type = MELEE, effects = TRUE, armor_penetration = xeno_attacker.xeno_caste.melee_ap, isrightclick = FALSE)
	if(turn_light(xeno_attacker, FALSE) != CHECKS_PASSED)
		return
	playsound(loc, SFX_ALIEN_CLAW_METAL, 25, 1)
	xeno_attacker.do_attack_animation(src, ATTACK_EFFECT_CLAW)
	to_chat(xeno_attacker, span_warning("We disable the metal thing's lights.") )

/obj/item/radio/loadout_tool/RightClick(mob/user)
	if(user.l_hand != src && user.r_hand != src) //only rclickable in hand
		return
	active = !active
	turn_light(user, active)
	set_light_on(active)
	playsound(loc, 'sound/machines/terminal_button01.ogg', 50, TRUE)
	update_appearance(UPDATE_OVERLAYS)

/obj/item/radio/loadout_tool/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/item/radio/loadout_tool/on_enter_storage(obj/item/storage/S)
	. = ..()
	active = FALSE
	turn_light(null, active)
	set_light_on(active)
	playsound(loc, 'sound/machines/terminal_button01.ogg', 50, TRUE)
	update_appearance(UPDATE_OVERLAYS)

/obj/item/radio/loadout_tool/update_overlays()
	. = ..()
	if(active)
		. += mutable_appearance(icon, screen_overlay)
		. += emissive_appearance(icon, screen_overlay, src)

/obj/item/radio/loadout_tool/interact(mob/user)
	if(!active)
		to_chat(user, span_notice("You have to turn on the screen first."))
		return
	. = ..()

/obj/item/radio/loadout_tool/AltClick(mob/user)
	. = ..()
	if(!active)
		to_chat(user, span_notice("You have to turn on the screen first."))
		return
	var/datum/faction_stats/your_faction = GLOB.faction_stats_datums[user.faction]
	if(!your_faction)
		to_chat(user, "You don't have the credentials to this network.")
		return
	var/datum/individual_stats/stats = your_faction.get_player_stats(user)
	if(!stats)
		return
	stats.current_mob = user //taking over ssd's creates a mismatch
	//we have to update selected tab/job so we load the correct data for the UI
	var/mob/living/living_user = user

	if(!isliving(user) || !(living_user?.job?.title in stats.valid_jobs))
		stats.selected_job = stats.valid_jobs[1]
	else
		stats.selected_job = living_user.job.title
	stats.selected_tab = "Loadout"
	stats.interact(user)

/obj/item/radio/loadout_tool/red
	icon_state = "pda_red"

/obj/item/radio/loadout_tool/green
	icon_state = "pda_green"

/obj/item/radio/loadout_tool/blue
	icon_state = "pda_blue"

/obj/item/radio/loadout_tool/purple
	icon_state = "pda_purple"

/obj/item/radio/loadout_tool/large
	name = "Personal Holopad"
	desc = "A holopad used for radio communication and other personal things such as watching porn in a larger screen, duh. Also used to download miniskillsofts into your neural implant RAM, temporary and less effective than actual skillsofts that are chip based."
	icon_state = "pda_large_white"
	screen_overlay = "pda_large_on"

/obj/item/radio/loadout_tool/large/red
	icon_state = "pda_large_red"

/obj/item/radio/loadout_tool/large/green
	icon_state = "pda_large_green"

/obj/item/radio/loadout_tool/large/blue
	icon_state = "pda_large_blue"

/obj/item/radio/loadout_tool/large/purple
	icon_state = "pda_large_purple"
