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
