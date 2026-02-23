// nightvision goggles - I added the code of the night_vision ones to avoid all the refactoring that would be needed otherwise in all the maps and loadout from just making them children of them (21 files plus all the maps.)

/obj/item/clothing/glasses/night
	name = "night vision goggles"
	desc = "You can totally see in the dark now!"
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi',
		"Synskin Combat Robot" = 'icons/mob/species/robot/glasses.dmi')
	icon_state = "night"
	worn_icon_state = "glasses"
	toggleable = TRUE
	// deactive_state = "night_vision_off" // gonna test what it does without a deactive_state
	color_cutoffs = list(30, 30, 30)
	goggles = TRUE
	active = FALSE
	actions_types = list(/datum/action/item_action/toggle)
	activation_sound = 'sound/effects/nightvision.ogg'
	deactivation_sound = 'sound/machines/click.ogg'
	///The battery inside
	var/obj/item/cell/night_vision_battery/battery
	///How much energy this module needs when activated
	var/active_energy_cost = 1
	///Looping sound to play
	var/datum/looping_sound/active_sound = /datum/looping_sound/scan_pulse
	///How loud the looping sound should be
	var/looping_sound_volume = 25

/obj/item/clothing/glasses/night/Initialize(mapload)
	. = ..()
	//Start with a charged battery
	battery = new /obj/item/cell/night_vision_battery(src)
	active_sound = new active_sound()
	active_sound.volume = looping_sound_volume
	update_worn_state()

/obj/item/clothing/glasses/night/examine(mob/user)
	. = ..()
	. += span_notice("This model drains [active_energy_cost] energy when active.")
	. += battery_status()
	. += "To eject the battery, [span_bold("[user.get_inactive_held_item() == src ? "click" : "ALT-click"]")] [src] with an empty hand. To insert a battery, [span_bold("click")] [src] with a compatible cell."

///Info regarding battery status; separate proc so that it can be displayed when examining the parent object
/obj/item/clothing/glasses/night/proc/battery_status()
	if(battery)
		return span_notice("Battery: [battery.charge]/[battery.maxcharge]")
	return span_warning("No battery installed!")

/obj/item/clothing/glasses/night/attack_hand(mob/living/user)
	if(user.get_inactive_held_item() == src && eject_battery(user))
		return
	return ..()

/obj/item/clothing/glasses/night/AltClick(mob/user)
	if(!eject_battery(user))
		return ..()

/obj/item/clothing/glasses/night/attackby(obj/item/I, mob/user, params)
	. = ..()
	insert_battery(I, user)

///Insert a battery, if checks pass
/obj/item/clothing/glasses/night/proc/insert_battery(obj/item/I, mob/user)
	if(!istype(I, /obj/item/cell/night_vision_battery))
		return

	if(battery && (battery.charge > battery.maxcharge / 2))
		balloon_alert(user, "battery already installed!")
		return
	//Hot swap!
	eject_battery()

	user.temporarilyRemoveItemFromInventory(I)
	I.forceMove(src)
	battery = I
	return TRUE

///Eject the internal battery, if there is one
/obj/item/clothing/glasses/night/proc/eject_battery(mob/user)
	if(user?.get_active_held_item() || !battery)
		return

	if(user)
		user.put_in_active_hand(battery)
	else
		battery.forceMove(get_turf(src))
	battery = null

	if(active)
		activate(user)

	return TRUE

/obj/item/clothing/glasses/night/activate(mob/user)
	if(active)
		STOP_PROCESSING(SSobj, src)
		active_sound.stop(src)
	else
		if(!battery || battery.charge < active_energy_cost)
			if(user)
				balloon_alert(user, "no power!")
			return FALSE	//Don't activate
		START_PROCESSING(SSobj, src)
		active_sound.start(src)

	update_worn_state(!active)	//The active var has not been toggled yet, so pass the opposite value
	return ..()

/obj/item/clothing/glasses/night/process()
	if(!battery?.use(active_energy_cost))
		if(ismob(loc))	//If it's deactivated while being worn, pass on the reference to activate() so that the user's sight is updated
			activate(loc)
		else
			activate()
		return PROCESS_KILL

///Simple proc to update the worn state of the glasses; will use the active value by default if no argument passed
/obj/item/clothing/glasses/night/proc/update_worn_state(state = active)
	worn_item_state_slots[slot_glasses_str] = initial(icon_state) + (state ? "" : "_off")

/obj/item/clothing/glasses/night/unequipped(mob/unequipper, slot)
	. = ..()
	if(active)
		activate(unequipper)

/obj/item/clothing/glasses/night/Destroy()
	QDEL_NULL(active_sound)
	return ..()

//So that the toggle button is only given when in the eyes slot
/obj/item/clothing/glasses/night/item_action_slot_check(mob/user, slot)
	return CHECK_BITFIELD(slot, ITEM_SLOT_EYES)

// Start of the Variants.

/obj/item/clothing/glasses/night/tx8
	name = "\improper BR-8 battle sight"
	desc = "A headset and night vision goggles system for the BR-8 Battle Rifle. Allows highlighted imaging of surroundings. Click it to toggle."
	icon = 'icons/obj/clothing/glasses.dmi'
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	toggleable = 1
	actions_types = list(/datum/action/item_action/toggle)


/obj/item/clothing/glasses/night/m42_night_goggles
	name = "\improper M42 scout sight"
	desc = "A headset and night vision goggles system for the M42 Scout Rifle. Allows highlighted imaging of surroundings. Click it to toggle."
	icon = 'icons/obj/clothing/glasses.dmi'
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	toggleable = 1
	actions_types = list(/datum/action/item_action/toggle)


/obj/item/clothing/glasses/night/m42_night_goggles/upp
	name = "\improper Type 9 elite goggles"
	desc = "A headset and night vision goggles system used by USL forces. Allows highlighted imaging of surroundings. Click it to toggle."
	icon_state = "upp_goggles"
	deactive_state = "upp_goggles_0"

/obj/item/clothing/glasses/night/sectoid
	name = "alien lens"
	desc = "A thick, black coating over an alien's eyes, allowing them to see in the dark."
	icon_state = "alien_lens"
	worn_icon_state = "alien_lens"
	lighting_cutoff = LIGHTING_CUTOFF_FULLBRIGHT
	item_flags = DELONDROP
	toggleable = FALSE
	active = TRUE
	active_energy_cost = 0 // They are supposed to be alien and magical.
	color_cutoffs = list(30, 30, 30) // magic

/obj/item/clothing/glasses/night/sectoid/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SECTOID_TRAIT)

/obj/item/clothing/glasses/night/m56_goggles
	name = "\improper KTLD head mounted sight"
	desc = "A headset and goggles system made to pair with any KTLD weapon, such as the SG type weapons. Has a low-res short range imager, allowing for view of terrain."
	icon = 'icons/obj/clothing/glasses.dmi'
	icon_state = "m56_goggles"
	deactive_state = "m56_goggles_0"
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/glasses/night/m56_goggles/activate(mob/user)
	. = ..()
	if(!user)
		return
	if(active)
		SEND_SIGNAL(user, COMSIG_KTLD_ACTIVATED, src)
		RegisterSignal(user, COMSIG_ITEM_ZOOM, PROC_REF(activate))
	else
		UnregisterSignal(user, COMSIG_ITEM_ZOOM)

/obj/item/clothing/glasses/night/m56_goggles/equipped(mob/user, slot)
	. = ..()
	if(!active)
		return
	RegisterSignal(user, COMSIG_ITEM_ZOOM, PROC_REF(activate))

/obj/item/clothing/glasses/night/m56_goggles/unequipped(mob/unequipper, slot)
	. = ..()
	UnregisterSignal(unequipper, COMSIG_ITEM_ZOOM)

/obj/item/clothing/glasses/night/sunglasses
	name = "\improper KTLD sunglasses"
	desc = "A pair of designer sunglasses. This pair has been fitted with a KTLD head mounted sight."
	icon = 'icons/obj/clothing/glasses.dmi'
	icon_state = "m56sunglasses"
	worn_icon_state = "m56sunglasses"
	deactive_state = "degoggles_mesonsunglasses"
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle)
	prescription = TRUE

/obj/item/clothing/glasses/night/optgoggles
	name = "\improper Optical imager ballistic goggles"
	desc = "Standard issue NTC goggles. This pair has been fitted with an internal optical imaging scanner."
	icon_state = "optgoggles"
	worn_icon_state = "optgoggles"
	deactive_state = "degoggles_optgoggles"
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle)
	species_exception = list(/datum/species/robot)
	sprite_sheets = list(
		"Combat Robot" = 'icons/mob/species/robot/glasses.dmi',
		"Sterling Combat Robot" = 'icons/mob/species/robot/glasses_bravada.dmi',
		"Chilvaris Combat Robot" = 'icons/mob/species/robot/glasses_charlit.dmi',
		"Hammerhead Combat Robot" = 'icons/mob/species/robot/glasses_alpharii.dmi',
		"Ratcher Combat Robot" = 'icons/mob/species/robot/glasses_deltad.dmi',
		"Synskin Combat Robot" = 'icons/mob/species/robot/glasses.dmi')
	equip_slot_flags = ITEM_SLOT_EYES
	goggles = TRUE

/obj/item/clothing/glasses/night/optgoggles/prescription
	name = "\improper Optical imager prescription ballistic goggles"
	desc = "Standard issue NTC prescription goggles. This pair has been fitted with an internal optical imaging scanner."
	prescription = TRUE

/obj/item/clothing/glasses/night/vsd
	name = "\improper CM-12 night vision goggles"
	desc = "KZ's night vision goggles, For the extra tacticool feel, Crash Core and your superior officers are not responsible for blindness and burning."
	icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "vsd_nvg"
	worn_icon_state = "vsd_nvg"
	deactive_state = "vsd_nvg_off"
	toggleable = TRUE
	actions_types = list(/datum/action/item_action/toggle)
	color_cutoffs = list(30, 30, 0)
	worn_layer = COLLAR_LAYER

/obj/item/clothing/glasses/night/vsd/alt
	name = "\improper CM-13 night vision faceplate"
	desc = "KZs night vision Faceplate, made for attachments to the Medium armor variant of their armor. Crash Core and your superior officers are not responsible for blindness and burning."
	icon_state = "vsd_alt"
	worn_icon_state = "vsd_alt"
	deactive_state = "vsd_alt_off"
