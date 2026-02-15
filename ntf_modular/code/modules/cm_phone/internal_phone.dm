/obj/structure/transmitter/internal
	name = "\improper internal telephone receiver"

	phone_type = /obj/item/phone/functional/old

	var/atom/relay_obj

/obj/structure/transmitter/internal/ui_host(mob/user, datum/tgui/ui)
	if(!relay_obj)
		return ..()
	return relay_obj

/obj/structure/transmitter/internal/Destroy()
	relay_obj = null
	return ..()

GLOBAL_LIST_EMPTY(radio_packs)

/obj/item/storage/backpack/marine/radiopack
	icon = 'ntf_modular/icons/obj/items/storage/backpack.dmi'
	actions_types = list(/datum/action/item_action/rto_pack/use_phone)
	var/obj/structure/transmitter/internal/internal_transmitter

	var/phone_category = PHONE_MARINE
	var/list/networks_receive = list(FACTION_TERRAGOV)
	var/list/networks_transmit = list(FACTION_TERRAGOV)
	var/mode = 1  /// 0 = beacon, 1 = phone

/datum/action/item_action/rto_pack/use_phone/New(mob/living/user, obj/item/holder)
	..()
	name = "Use Phone"
	button.name = name
	button.overlays.Cut()
	var/image/IMG = image('ntf_modular/icons/mob/hud/actions.dmi', button, "phone")
	button.overlays += IMG

/datum/action/item_action/rto_pack/use_phone/action_activate()
	. = ..()
	for(var/obj/item/storage/backpack/marine/radiopack/radio_backpack in owner)
		radio_backpack.use_phone(owner)
		return

/obj/item/storage/backpack/marine/radiopack/Initialize()
	. = ..()
	internal_transmitter = new(src)
	internal_transmitter.relay_obj = src
	internal_transmitter.phone_category = phone_category
	internal_transmitter.enabled = FALSE
	internal_transmitter.networks_receive = networks_receive
	internal_transmitter.networks_transmit = networks_transmit
	internal_transmitter.call_sound = 'ntf_modular/sound/machines/telephone/telephone_ring.ogg'
	internal_transmitter.call_sound_length = 3 SECONDS
	RegisterSignal(internal_transmitter, "COMSIG_TRANSMITTER_UPDATE_ICON", PROC_REF(check_for_ringing))
	GLOB.radio_packs += src
	update_mode()

/obj/item/storage/backpack/marine/radiopack/examine(mob/user)
	. = ..()
	. += "\The [src] can switch between beacon mode and phone mode using a screwdriver."

/obj/item/storage/backpack/marine/radiopack/screwdriver_act(mob/living/user, obj/item/I)
	mode = !mode
	playsound(src, 'sound/items/screwdriver2.ogg', 15, 1)
	update_mode(user)
	return TRUE

/obj/item/storage/backpack/marine/radiopack/proc/update_mode(mob/living/user)
	if(mode)
		if(user)
			user.balloon_alert(user, "Phone mode")
		var/datum/component/beacon/elbeacon = GetComponent(/datum/component/beacon)
		if(elbeacon)
			if(elbeacon.active)
				elbeacon.toggle_activation(src, user)
			remove_component(/datum/component/beacon)
	else
		if(user)
			user.balloon_alert(user, "Beacon mode")
		AddComponent(/datum/component/beacon, FALSE, 0, icon_state + "_active")


/obj/item/storage/backpack/marine/radiopack/proc/check_for_ringing()
	SIGNAL_HANDLER
	Shake(duration = 5 SECONDS)
	update_icon()

/obj/item/storage/backpack/marine/radiopack/update_icon_state()
	. = ..()

	if(!internal_transmitter)
		return

	if(!internal_transmitter.attached_to \
		|| internal_transmitter.attached_to.loc != internal_transmitter)
		icon_state = "radiopack_ear"
		return

	if(internal_transmitter.inbound_call)
		icon_state = "radiopack_ring"
	else
		icon_state = "radiopack"

/obj/item/storage/backpack/marine/radiopack/forceMove(atom/dest)
	. = ..()
	if(isturf(dest))
		internal_transmitter.set_tether_holder(src)
	else
		internal_transmitter.set_tether_holder(loc)

/obj/item/storage/backpack/marine/radiopack/Destroy()
	GLOB.radio_packs -= src
	qdel(internal_transmitter)
	return ..()

/obj/item/storage/backpack/marine/radiopack/pickup(mob/user)
	. = ..()
	autoset_phone_id(user)

/obj/item/storage/backpack/marine/radiopack/equipped(mob/user, slot)
	. = ..()
	autoset_phone_id(user)

/// Automatically sets the phone_id based on the current or updated user
/obj/item/storage/backpack/marine/radiopack/proc/autoset_phone_id(mob/user)
	if(!user)
		internal_transmitter.phone_id = "[src]"
		internal_transmitter.enabled = FALSE
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		switch(user.faction)
			if(FACTION_TERRAGOV)
				internal_transmitter.phone_category = PHONE_MARINE
			if(FACTION_SOM)
				internal_transmitter.phone_category = PHONE_SOM
			if(FACTION_VSD)
				internal_transmitter.phone_category = PHONE_KZ
			if(FACTION_CLF)
				internal_transmitter.phone_category = PHONE_CLF
			if(FACTION_ICC)
				internal_transmitter.phone_category = PHONE_CM
			else
				internal_transmitter.phone_category = "Civilian"
		internal_transmitter.networks_receive = list(H.faction)
		internal_transmitter.networks_transmit = list(H.faction)
		if(H.comm_title)
			internal_transmitter.phone_id = "[H.comm_title] [H]"
		else if(H.job)
			internal_transmitter.phone_id = "[H.job] [H]"
		else
			internal_transmitter.phone_id = "[H]"

		if(H.assigned_squad)
			internal_transmitter.phone_id += " ([H.assigned_squad.name])"
	else
		internal_transmitter.phone_id = "[user]"
	internal_transmitter.enabled = TRUE

/obj/item/storage/backpack/marine/radiopack/dropped(mob/user)
	. = ..()
	autoset_phone_id(null) // Disable phone when dropped

/obj/item/storage/backpack/marine/radiopack/proc/use_phone(mob/user)
	if(!mode)
		balloon_alert(user, "\The [src] is currently in beacon mode.")
		return
	internal_transmitter.attack_hand(user)


/obj/item/storage/backpack/marine/radiopack/attackby(obj/item/W, mob/user)
	if(internal_transmitter && internal_transmitter.attached_to == W)
		internal_transmitter.attackby(W, user)
	else
		. = ..()

/obj/item/storage/backpack/marine/radiopack/som_net
	name = "\improper SOM Radio operator Backpack"
	color = COLOR_ORANGE
	networks_receive = list(FACTION_SOM)
	networks_transmit = list(FACTION_SOM)
	phone_category = PHONE_SOM

/obj/item/storage/backpack/marine/radiopack/kz_net
	name = "\improper KZ Radio operator Pack"
	color = COLOR_YELLOW
	networks_receive = list(FACTION_VSD)
	networks_transmit = list(FACTION_VSD)
	phone_category = PHONE_KZ

/obj/item/storage/backpack/marine/radiopack/clf_net
	name = "\improper CLF radio operator Pack"
	color = COLOR_PURPLE
	networks_receive = list(FACTION_CLF)
	networks_transmit = list(FACTION_CLF)
	phone_category = PHONE_CLF

/obj/item/storage/backpack/marine/radiopack/cm_net
	name = "\improper CM radio operator Pack"
	color = COLOR_MODERATE_BLUE
	networks_receive = list(FACTION_ICC)
	networks_transmit = list(FACTION_ICC)
	phone_category = PHONE_CM

#define COMMS_OFF 0
#define COMMS_SETTING 1
#define COMMS_SETUP 2

//antenna module into scout helmet type shit
/obj/item/armor_module/module/antenna
	var/obj/structure/transmitter/internal/internal_transmitter

	var/phone_category = PHONE_MARINE
	var/list/networks_receive = list(FACTION_TERRAGOV)
	var/list/networks_transmit = list(FACTION_TERRAGOV)

/obj/item/armor_module/module/antenna/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	var/datum/action/item_action = actions[1]
	item_action.button.overlays.Cut()

	var/image/IMG = image('ntf_modular/icons/obj/structures/phone.dmi', item_action.button, "scout_microphone")
	item_action.button.overlays += IMG

/obj/item/armor_module/module/antenna/activate(mob/living/user)
	playsound(loc, 'sound/machines/terminal_button01.ogg', 50, 1)
	use_phone(user)
	/*
	switch(tgui_alert(user, "Use which interface?", "Antenna Module", list("Cancel","Coords","Microphone")))
		if("Microphone")
			use_phone(user)
			update_button(FALSE)
		if("Coords")
			update_button(TRUE)
			if(comms_setup == COMMS_SETTING)
				to_chat(user, span_notice("Your Antenna module is still in the process of starting up!"))
				return
			if(comms_setup == COMMS_SETUP)
				var/turf/location = get_turf(user)
				user.show_message(span_notice("The [src] beeps and states, \"Uplink data: LONGITUDE [location.x]. LATITUDE [location.y]. Area ID: [get_area(src)]\""), EMOTE_TYPE_AUDIBLE, span_notice("The [src] vibrates but you can not hear it!"))
				return
		if("Cancel")
			return
	*/

/obj/item/armor_module/module/antenna/on_attach(obj/item/attaching_to, mob/user)
	. = ..()
	RegisterSignal(attaching_to, COMSIG_ITEM_EQUIPPED_TO_SLOT, PROC_REF(on_equip_antenna))
	RegisterSignal(attaching_to, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))

/obj/item/armor_module/module/antenna/on_detach(obj/item/detaching_from, mob/user)
	. = ..()
	UnregisterSignal(detaching_from, list(COMSIG_ITEM_EQUIPPED,COMSIG_ATOM_ATTACKBY,COMSIG_ITEM_RIGHTCLICKON))
	autoset_phone_id(null)

/obj/item/armor_module/module/antenna/proc/on_equip_antenna(datum/source, mob/living/carbon/human/equipper, slot)
	SIGNAL_HANDLER
	if(slot == SLOT_HEAD)
		autoset_phone_id(equipper)
		RegisterSignal(equipper, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	else
		autoset_phone_id(null) // Disable phone when dropped
		UnregisterSignal(equipper, COMSIG_MOVABLE_MOVED)

/obj/item/armor_module/module/antenna/proc/on_attackby(datum/source, obj/item/scout_phone, mob/living/user)
	SIGNAL_HANDLER
	if(internal_transmitter && internal_transmitter.attached_to == scout_phone)
		internal_transmitter.attackby(scout_phone, user)

/obj/item/armor_module/module/antenna/Initialize()
	. = ..()
	internal_transmitter = new(src)
	internal_transmitter.relay_obj = src
	internal_transmitter.phone_category = phone_category
	internal_transmitter.enabled = FALSE
	internal_transmitter.networks_receive = networks_receive
	internal_transmitter.networks_transmit = networks_transmit
	internal_transmitter.outring_loop.start_length = 0 SECONDS
	internal_transmitter.outring_loop.start_sound = null
	internal_transmitter.outring_loop.mid_sounds = 'ntf_modular/sound/machines/telephone/scout_ring_outgoing.ogg'
	internal_transmitter.outring_loop.mid_length = 3 SECONDS
	internal_transmitter.hangup_loop.start_sound = 'ntf_modular/sound/machines/telephone/scout_hang_up.ogg'
	internal_transmitter.hangup_loop.mid_sounds = null
	internal_transmitter.busy_loop.start_sound = 'ntf_modular/sound/machines/telephone/scout_remote_hangup.ogg'
	internal_transmitter.busy_loop.mid_sounds = null
	internal_transmitter.call_sound = 'ntf_modular/sound/machines/telephone/scout_ring.ogg'
	internal_transmitter.call_sound_length = 2.5 SECONDS
	internal_transmitter.attached_to.icon_state = "scout_microphone"
	internal_transmitter.attached_to.worn_icon_state = ""
	internal_transmitter.attached_to.name = "helmet microphone"
	internal_transmitter.attached_to.desc = "A small microphone attached to the helmet, used to communicate with the internal radio transmitter."
	internal_transmitter.pickup_sound = 'ntf_modular/sound/machines/telephone/scout_pick_up.ogg'
	internal_transmitter.putdown_sound = 'ntf_modular/sound/machines/telephone/scout_hang_up.ogg'
	internal_transmitter.attached_to.can_be_raised = FALSE
	internal_transmitter.bypass_tgui_range = TRUE
	internal_transmitter.call_sound_range = 1
	RegisterSignal(internal_transmitter, "COMSIG_TRANSMITTER_UPDATE_ICON", PROC_REF(check_for_ringing))
	GLOB.radio_packs += src

/*
/obj/item/armor_module/module/antenna/proc/update_button(mode)
	var/datum/action/item_action = actions[1]
	item_action.button.overlays.Cut()
	if(mode) //true if usual antenna icon, false if microphone
		item_action.update_button_icon()
	else
		var/image/IMG = image('ntf_modular/icons/obj/structures/phone.dmi', item_action.button, "scout_microphone")
		item_action.button.overlays += IMG
*/

/obj/item/armor_module/module/antenna/proc/check_for_ringing()
	SIGNAL_HANDLER
	parent.Shake(duration = 5 SECONDS)

/obj/item/armor_module/module/antenna/proc/on_move(atom/dest)
	SIGNAL_HANDLER
	if(!internal_transmitter)
		return
	if(!parent)
		internal_transmitter.set_tether_holder(src)
		return
	if(isturf(dest))
		internal_transmitter.set_tether_holder(parent)
	else
		internal_transmitter.set_tether_holder(parent.loc)

/obj/item/armor_module/module/antenna/Destroy()
	GLOB.radio_packs -= src
	qdel(internal_transmitter)
	return ..()

/// Automatically sets the phone_id based on the current or updated user
/obj/item/armor_module/module/antenna/proc/autoset_phone_id(mob/user)
	if(!user)
		internal_transmitter.phone_id = "[src]"
		internal_transmitter.enabled = FALSE
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.comm_title)
			internal_transmitter.phone_id = "[H.comm_title] [H]"
		else if(H.job)
			internal_transmitter.phone_id = "[H.job] [H]"
		else
			internal_transmitter.phone_id = "[H]"

		if(H.assigned_squad)
			internal_transmitter.phone_id += " ([H.assigned_squad.name])"
	else
		internal_transmitter.phone_id = "[user]"
	internal_transmitter.enabled = TRUE

/obj/item/armor_module/module/antenna/proc/use_phone(mob/user)
	if(!parent)
		internal_transmitter.set_tether_holder(src)
		return
	if(isturf(loc))
		internal_transmitter.set_tether_holder(parent)
	else
		internal_transmitter.set_tether_holder(parent.loc)
	internal_transmitter.attack_hand(user)

#undef COMMS_OFF
#undef COMMS_SETTING
#undef COMMS_SETUP
