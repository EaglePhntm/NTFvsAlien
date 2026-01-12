GLOBAL_LIST_EMPTY_TYPED(transmitters, /obj/structure/transmitter)

/obj/structure/transmitter
	name = "telephone receiver"
	icon = 'ntf_modular/icons/obj/structures/phone.dmi'
	icon_state = "wall_phone"
	desc = "It is a wall mounted telephone. The fine text reads: To log your details with the mainframe please insert your keycard into the slot below. Unfortunately the slot is jammed. You can still use the phone, however."

	var/phone_category = "Uncategorised"
	var/phone_color = "white"
	var/phone_id = "Telephone"
	var/phone_icon

	var/obj/item/phone/functional/attached_to
	var/atom/tether_holder

	var/obj/structure/transmitter/outbound_call
	var/obj/structure/transmitter/inbound_call
	var/pickup_sound = "rtb_handset"

	var/next_ring = 0

	var/phone_type = /obj/item/phone/functional

	var/range = 7

	var/enabled = TRUE
	/// Whether or not the phone is receiving calls or not. Varies between on/off or forcibly on/off.
	var/do_not_disturb = PHONE_DND_OFF
	/// The Phone_ID of the last person to call this telephone.
	var/last_caller

	var/timeout_timer_id
	var/timeout_duration = 30 SECONDS

	var/list/networks_receive = list(FACTION_TERRAGOV)
	var/list/networks_transmit = list(FACTION_TERRAGOV)

	var/datum/looping_sound/telephone/busy/busy_loop
	var/datum/looping_sound/telephone/hangup/hangup_loop
	var/datum/looping_sound/telephone/ring/outring_loop
	var/call_sound = 'ntf_modular/sound/machines/telephone/fnaf3_phonecall.ogg'
	var/call_sound_length = 2 SECONDS

/datum/looping_sound/telephone/ring
	start_sound = 'ntf_modular/sound/machines/telephone/dial.ogg'
	start_length = 3.2 SECONDS
	mid_sounds = 'ntf_modular/sound/machines/telephone/ring_outgoing_long.ogg'
	mid_length = 2.9 SECONDS
	volume = 10
	range = 0

/datum/looping_sound/telephone/busy
	start_sound = 'ntf_modular/sound/vo/callstation_unavailable.ogg'
	start_length = 5.7 SECONDS
	mid_sounds = 'ntf_modular/sound/machines/telephone/phone_busy.ogg'
	mid_length = 5 SECONDS
	volume = 15
	range = 0

/datum/looping_sound/telephone/hangup
	start_sound = 'ntf_modular/sound/machines/telephone/remote_hangup.ogg'
	start_length = 0.6 SECONDS
	mid_sounds = 'ntf_modular/sound/machines/telephone/phone_busy.ogg'
	mid_length = 5 SECONDS
	volume = 15
	range = 0

/obj/structure/transmitter/hidden
	do_not_disturb = PHONE_DND_FORCED

/obj/structure/transmitter/Initialize(mapload, ...)
	. = ..()
	base_icon_state = icon_state

	attached_to = new phone_type(src)
	RegisterSignal(attached_to, COMSIG_QDELETING, PROC_REF(override_delete))
	update_icon()

	outring_loop = new(list(attached_to))
	busy_loop = new(list(attached_to))
	hangup_loop = new(list(attached_to))

	if(!get_turf(src))
		return

	GLOB.transmitters += src

/obj/structure/transmitter/update_icon()
	. = ..()
	SEND_SIGNAL(src, "COMSIG_TRANSMITTER_UPDATE_ICON")
	if(attached_to.loc != src)
		icon_state = "[base_icon_state]_ear"
		return

	if(inbound_call)
		icon_state = "[base_icon_state]_ring"
	else
		icon_state = base_icon_state

/obj/structure/transmitter/proc/override_delete()
	SIGNAL_HANDLER
	recall_phone()


#define TRANSMITTER_UNAVAILABLE(T) (\
	T.get_calling_phone() \
	|| !T.attached_to \
	|| T.attached_to.loc != T \
	|| !T.enabled\
)

/obj/structure/transmitter/proc/get_transmitters()
	var/list/phone_list = list()

	for(var/possible_phone in GLOB.transmitters)
		var/obj/structure/transmitter/target_phone = possible_phone
		var/current_dnd = FALSE
		switch(target_phone.do_not_disturb)
			if(PHONE_DND_ON, PHONE_DND_FORCED)
				current_dnd = TRUE
		if(TRANSMITTER_UNAVAILABLE(target_phone) || current_dnd) // Phone not available
			continue
		var/net_link = FALSE
		for(var/network in networks_transmit)
			if(network in target_phone.networks_receive)
				net_link = TRUE
				continue
		if(!net_link)
			continue

		var/id = target_phone.phone_id
		var/num_id = 1
		while(id in phone_list)
			id = "[target_phone.phone_id] [num_id]"
			num_id++

		target_phone.phone_id = id
		phone_list[id] = target_phone

	return phone_list

/obj/structure/transmitter/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(TRANSMITTER_UNAVAILABLE(src))
		return UI_CLOSE

/obj/structure/transmitter/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(TRANSMITTER_UNAVAILABLE(src))
		return

	if(!ishuman(usr))
		return

	var/mob/living/carbon/human/user = usr

	switch(action)
		if("call_phone")
			call_phone(user, params["phone_id"])
			. = TRUE
			SStgui.close_uis(src)
		if("toggle_dnd")
			toggle_dnd(user)

	update_icon()

/obj/structure/transmitter/ui_data(mob/user)
	var/list/data = list()

	data["availability"] = do_not_disturb
	data["last_caller"] = last_caller

	return data

/obj/structure/transmitter/ui_static_data(mob/user)
	. = list()

	.["available_transmitters"] = get_transmitters() - list(phone_id)
	var/list/transmitters = list()
	for(var/i in GLOB.transmitters)
		var/obj/structure/transmitter/T = i
		transmitters += list(list(
			"phone_category" = T.phone_category,
			"phone_color" = T.phone_color,
			"phone_id" = T.phone_id,
			"phone_icon" = T.phone_icon
		))

	.["transmitters"] = transmitters

/obj/structure/transmitter/proc/call_phone(mob/living/carbon/human/user, calling_phone_id)
	var/list/transmitters = get_transmitters()
	transmitters -= phone_id

	if(!length(transmitters) || !(calling_phone_id in transmitters))
		to_chat(user, span_purple("[icon2html(src, user)] No transmitters could be located to call!"))
		return

	var/obj/structure/transmitter/T = transmitters[calling_phone_id]
	if(!istype(T) || QDELETED(T))
		transmitters -= T
		CRASH("Qdelled/improper atom inside transmitters list! (istype returned: [istype(T)], QDELETED returned: [QDELETED(T)])")

	if(TRANSMITTER_UNAVAILABLE(T))
		return

	outbound_call = T
	outbound_call.inbound_call = src
	T.last_caller = src.phone_id
	T.update_icon()

	to_chat(user, span_purple("[icon2html(src, user)] Dialing [calling_phone_id].."))
	playsound(get_turf(user), pickup_sound, 100)
	timeout_timer_id = addtimer(CALLBACK(src, PROC_REF(reset_call), TRUE), timeout_duration, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)
	outring_loop.start(attached_to)

	START_PROCESSING(SSobj, src)
	START_PROCESSING(SSobj, T)

	user.put_in_hands(attached_to)
	attached_to.pickup(user)

/obj/structure/transmitter/proc/toggle_dnd(mob/living/carbon/human/user)
	switch(do_not_disturb)
		if(PHONE_DND_ON)
			do_not_disturb = PHONE_DND_OFF
			to_chat(user, span_notice("Do Not Disturb has been disabled. You can now receive calls."))
		if(PHONE_DND_OFF)
			do_not_disturb = PHONE_DND_ON
			to_chat(user, span_warning("Do Not Disturb has been enabled. No calls will be received."))
		else
			return FALSE
	return TRUE

/obj/structure/transmitter/attack_hand(mob/user)
	. = ..()

	if(!attached_to || attached_to.loc != src)
		return

	if(!ishuman(user))
		return

	if(!enabled)
		return

	if(!get_calling_phone())
		tgui_interact(user)
		return

	var/obj/structure/transmitter/T = get_calling_phone()

	if(T.attached_to && ismob(T.attached_to.loc))
		var/mob/M = T.attached_to.loc
		to_chat(M, span_purple("[icon2html(src, M)] [phone_id] has picked up."))
		playsound(T.attached_to.loc, 'ntf_modular/sound/machines/telephone/remote_pickup.ogg', 20)
	if(T.timeout_timer_id)
		deltimer(T.timeout_timer_id)
		T.timeout_timer_id = null

	to_chat(user, span_purple("[icon2html(src, user)] Picked up a call from [T.phone_id]."))
	playsound(get_turf(user), pickup_sound, 100)

	T.outring_loop.stop(attached_to)
	user.put_in_active_hand(attached_to)
	update_icon()


#undef TRANSMITTER_UNAVAILABLE

/obj/structure/transmitter/proc/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PhoneMenu", phone_id)
		ui.open()

/obj/structure/transmitter/proc/set_tether_holder(atom/A)
	tether_holder = A

	if(attached_to)
		attached_to.reset_tether()

/obj/structure/transmitter/proc/reset_call(timeout = FALSE)
	var/obj/structure/transmitter/T = get_calling_phone()
	if(T)
		if(T.attached_to && ismob(T.attached_to.loc))
			var/mob/M = T.attached_to.loc
			to_chat(M, span_purple("[icon2html(src, M)] You hear a click as the phone goes dead. [phone_id] has hung up on you."))
			T.hangup_loop.start(attached_to)

		if(attached_to && ismob(attached_to.loc))
			var/mob/M = attached_to.loc
			if(timeout)
				to_chat(M, span_purple("[icon2html(src, M)] Your call to [T.phone_id] has reached voicemail, nobody picked up the phone."))
				busy_loop.start(attached_to)
				outring_loop.stop(attached_to)
			else
				to_chat(M, span_purple("[icon2html(src, M)] You have hung up on [T.phone_id]."))

	if(outbound_call)
		outbound_call.inbound_call = null
		outbound_call = null

	if(inbound_call)
		inbound_call.outbound_call = null
		inbound_call = null

	if(timeout_timer_id)
		deltimer(timeout_timer_id)
		timeout_timer_id = null

	if(T)
		if(T.timeout_timer_id)
			deltimer(T.timeout_timer_id)
			T.timeout_timer_id = null

		T.update_icon()
		addtimer(CALLBACK(T), PROC_REF(post_stop_cleanup), 5 SECONDS) //this is necessary because FUCKING sound loops are unreliable.
		STOP_PROCESSING(SSobj, T)

	outring_loop.stop(attached_to)

	addtimer(CALLBACK(src), PROC_REF(post_stop_cleanup), 5 SECONDS)
	STOP_PROCESSING(SSobj, src)

/obj/structure/transmitter/process()
	if(!timeout_timer_id)
		outring_loop.stop(attached_to)
	if(attached_to.loc == attached_to.attached_to)
		outring_loop.stop(attached_to)
		busy_loop.stop(attached_to)
		hangup_loop.stop(attached_to)
	if(inbound_call)
		if(!attached_to)
			addtimer(CALLBACK(src), PROC_REF(post_stop_cleanup), 5 SECONDS)
			STOP_PROCESSING(SSobj, src)
			return

		if(attached_to.loc == attached_to.attached_to)
			if(next_ring < world.time)
				playsound(loc, call_sound, 75)
				visible_message(span_warning("[src] rings vigorously!"))
				next_ring = world.time + 3 SECONDS

	else if(outbound_call)
		var/obj/structure/transmitter/T = get_calling_phone()
		if(!T)
			addtimer(CALLBACK(src), PROC_REF(post_stop_cleanup), 5 SECONDS)
			STOP_PROCESSING(SSobj, src)
			return

		var/obj/item/phone/functional/P = T.attached_to

		if(P && attached_to.loc == src && P.loc == T && next_ring < world.time)
			playsound(get_turf(attached_to), call_sound, 20, FALSE, 14)
			visible_message(span_warning("[src] rings vigorously!"))
			next_ring = world.time + 3 SECONDS

	else
		addtimer(CALLBACK(src), PROC_REF(post_stop_cleanup), 5 SECONDS)
		STOP_PROCESSING(SSobj, src)
		return


/obj/structure/transmitter/proc/post_stop_cleanup()
	if(!timeout_timer_id)
		outring_loop.stop(attached_to)
	if(attached_to.loc == attached_to.attached_to)
		outring_loop.stop(attached_to)
		busy_loop.stop(attached_to)
		hangup_loop.stop(attached_to)

/obj/structure/transmitter/proc/recall_phone()
	if(ismob(attached_to.loc))
		var/mob/M = attached_to.loc
		M.drop_held_item(attached_to)
		playsound(get_turf(M), pickup_sound, 100, FALSE, 7)

	attached_to.forceMove(src)
	reset_call()
	busy_loop.stop(attached_to)
	outring_loop.stop(attached_to)
	hangup_loop.stop(attached_to)
	attached_to.lose_hearing_sensitivity(INNATE_TRAIT)

	update_icon()

/obj/structure/transmitter/proc/get_calling_phone()
	if(outbound_call)
		return outbound_call
	else if(inbound_call)
		return inbound_call

	return

/obj/structure/transmitter/proc/handle_speak(atom/movable/speaker, message)
//	if(L.flags & SIGNLANG)
//		return

	var/obj/structure/transmitter/T = get_calling_phone()
	if(!istype(T))
		return

	var/obj/item/phone/functional/P = T.attached_to

	if(!P || !attached_to)
		return

	P.handle_hear(speaker, message)
	if(P.loc != P.attached_to)
		playsound(P, "talk_phone", 5)
	log_say("TELEPHONE: [key_name(speaker)] on Phone '[phone_id]' to '[T.phone_id]' said '[message]'")

/obj/structure/transmitter/attackby(obj/item/W, mob/user)
	if(W == attached_to)
		recall_phone()
	else
		. = ..()

/obj/structure/transmitter/Destroy()
	if(attached_to)
		if(attached_to.loc == src)
			UnregisterSignal(attached_to, COMSIG_QDELETING)
			qdel(attached_to)
		else
			attached_to.attached_to = null
		attached_to = null

	GLOB.transmitters -= src
	SStgui.close_uis(src)

	reset_call()
	return ..()

/obj/item/phone/functional
	name = "telephone"
	icon = 'ntf_modular/icons/obj/structures/phone.dmi'
	icon_state = "d_phone"

	force = 3
	throwforce = 2
	throw_speed = 1
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("calls", "rings")
	hitsound = 'sound/weapons/ring.ogg'

	var/obj/structure/transmitter/attached_to
	var/datum/tether_effect

	var/raised = FALSE
	var/zlevel_transfer = FALSE
	var/zlevel_transfer_timer = TIMER_ID_NULL
	var/zlevel_transfer_timeout = 5 SECONDS
	var/can_be_raised = TRUE // This is for items like the scout helmet where you don't need to raise it.

/obj/item/phone/functional/old

	icon_state = "rpb_phone"

/obj/item/phone/functional/Initialize(mapload)
	. = ..()
	if(istype(loc, /obj/structure/transmitter))
		attach_to(loc)

/obj/item/phone/functional/equipped(mob/user, slot)
	. = ..()
	become_hearing_sensitive(INNATE_TRAIT)

/obj/item/phone/functional/Destroy()
	remove_attached()
	return ..()

/obj/item/phone/functional/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode)
	. = ..()
	if(radio_freq || get_dist(src, speaker) > 0)
		return FALSE

	if((message_mode == MODE_WHISPER || message_mode == MODE_WHISPER_CRIT) && (!raised || !ismob(loc)))
		raw_message = stars(raw_message)

	attached_to.handle_speak(speaker, raw_message)

/obj/item/phone/functional/proc/handle_hear(atom/movable/speaker, message)
	if(!attached_to)
		return

	var/obj/structure/transmitter/T = attached_to.get_calling_phone()

	if(!T)
		return

	if(!ismob(loc))
		return
	var/mob/M = loc

	if(!raised)
		//to_chat(M, span_lightpurple("[icon2html(src, M)] You hear muffled, unintelligible speech through \the [src] in your hand."))
		message = stars(message)
	to_chat(M, span_lightpurple("[icon2html(src, M)] [T.phone_id]: \"[message]\"")) //i didnt include name cause I guess it makes sense not to.

/obj/item/phone/functional/proc/attach_to(obj/structure/transmitter/to_attach)
	if(!istype(to_attach))
		return

	remove_attached()

	attached_to = to_attach


/obj/item/phone/functional/proc/remove_attached()
	attached_to = null
	reset_tether()

/obj/item/phone/functional/proc/reset_tether()
	SIGNAL_HANDLER
	if (tether_effect)
		UnregisterSignal(tether_effect, COMSIG_QDELETING)
		if(!QDESTROYING(tether_effect))
			qdel(tether_effect)
		tether_effect = null
	if(!do_zlevel_check())
		on_beam_removed()

/obj/item/phone/functional/attack_hand(mob/user)
	if(attached_to && get_dist(user, attached_to) > attached_to.range)
		return FALSE
	return ..()


/obj/item/phone/functional/proc/on_beam_removed()
	if(!attached_to)
		return

	if(loc == attached_to)
		return

	if(get_dist(attached_to, src) > attached_to.range)
		attached_to.recall_phone()

	var/atom/tether_to = src

	if(loc != get_turf(src))
		tether_to = loc
		if(tether_to.loc != get_turf(tether_to))
			attached_to.recall_phone()
			return

	var/atom/tether_from = attached_to

	if(attached_to.tether_holder)
		tether_from = attached_to.tether_holder

	if(tether_from == tether_to)
		return

	tether_effect = tether_from.beam(tether_to, "wire", 'ntf_modular/icons/effects/beam.dmi', INFINITY, attached_to.range)
	RegisterSignal(tether_effect, COMSIG_QDELETING, PROC_REF(reset_tether))

/obj/item/phone/functional/attack_self(mob/user)
	..()
	if(can_be_raised)
		if(raised)
			set_raised(FALSE, user)
			to_chat(user, span_notice("You lower [src]."))
		else
			set_raised(TRUE, user)
			to_chat(user, span_notice("You raise [src] to your ear."))
	else
		set_raised(TRUE, user)


/obj/item/phone/functional/proc/set_raised(to_raise, mob/living/carbon/human/H)
	if(!istype(H))
		return

	if(!can_be_raised)
		return

	if(!to_raise)
		raised = FALSE
		icon_state = initial(icon_state)
		/* we dont need disabled radio
		var/obj/item/radio/R = H.wear_ear
		if(R)
			R?.set_on(TRUE)
		*/
	else
		raised = TRUE
		icon_state = "[initial(icon_state)]_ear"

		/* we dont need disabled radio
		var/obj/item/radio/R = H.wear_ear
		if(R)
			R?.set_on(FALSE)
		*/

	H.update_inv_r_hand()
	H.update_inv_l_hand()

/obj/item/phone/functional/dropped(mob/user)
	. = ..()
	set_raised(FALSE, user)

/obj/item/phone/functional/on_enter_storage(obj/item/storage/S)
	. = ..()
	if(attached_to)
		attached_to.recall_phone()
		attached_to.outring_loop.stop(src)
		attached_to.busy_loop.stop(src)
		attached_to.hangup_loop.stop(src)

/obj/item/phone/functional/forceMove(atom/dest)
	. = ..()
	if(.)
		reset_tether()

/obj/item/phone/functional/proc/do_zlevel_check()
	if(!attached_to || !loc.z || !attached_to.z)
		return FALSE

	if(zlevel_transfer)
		if(loc.z == attached_to.z)
			zlevel_transfer = FALSE
			if(zlevel_transfer_timer)
				deltimer(zlevel_transfer_timer)
			UnregisterSignal(attached_to, COMSIG_MOVABLE_MOVED)
			return FALSE
		return TRUE

	if(attached_to && loc.z != attached_to.z)
		zlevel_transfer = TRUE
		zlevel_transfer_timer = addtimer(CALLBACK(src, PROC_REF(try_doing_tether)), zlevel_transfer_timeout, TIMER_UNIQUE|TIMER_STOPPABLE)
		RegisterSignal(attached_to, COMSIG_MOVABLE_MOVED, PROC_REF(transmitter_move_handler))
		return TRUE
	return FALSE

/obj/item/phone/functional/proc/transmitter_move_handler(datum/source)
	SIGNAL_HANDLER
	zlevel_transfer = FALSE
	if(zlevel_transfer_timer)
		deltimer(zlevel_transfer_timer)
	UnregisterSignal(attached_to, COMSIG_MOVABLE_MOVED)
	reset_tether()

/obj/item/phone/functional/proc/try_doing_tether()
	zlevel_transfer_timer = TIMER_ID_NULL
	zlevel_transfer = FALSE
	UnregisterSignal(attached_to, COMSIG_MOVABLE_MOVED)
	reset_tether()

/obj/structure/transmitter/no_dnd
	do_not_disturb = PHONE_DND_FORBIDDEN

//desk desk phones (need a touch tone handset at some point)
/obj/structure/transmitter/desk
	name = "wired telephone"
	icon_state = "desk_phone"
	desc = "There is always ol' reliable."

/obj/structure/transmitter/desk/no_dnd
	do_not_disturb = PHONE_DND_FORBIDDEN

/obj/structure/transmitter/desk/rotary
	name = "rotary telephone"
	icon_state = "rotary_phone"
	desc = "The finger plate is a little stiff."
	phone_type = /obj/item/phone/functional/old

/obj/structure/transmitter/colony_net
	color = COLOR_CYAN
	networks_receive = list(FACTION_NEUTRAL)
	networks_transmit = list(FACTION_NEUTRAL)

/obj/structure/transmitter/colony_net/desk
	name = "wired telephone"
	icon_state = "desk_phone"
	desc = "The finger plate is a little stiff."

/obj/structure/transmitter/som_net
	color = COLOR_ORANGE
	networks_receive = list(FACTION_SOM)
	networks_transmit = list(FACTION_SOM)

/obj/structure/transmitter/som_net/desk
	name = "wired telephone"
	icon_state = "desk_phone"

	desc = "The finger plate is a little stiff."

/obj/structure/transmitter/clf_net
	color = COLOR_PURPLE
	networks_receive = list(FACTION_CLF)
	networks_transmit = list(FACTION_CLF)

/obj/structure/transmitter/clf_net/desk
	name = "wired telephone"
	icon_state = "desk_phone"
	desc = "The finger plate is a little stiff."

/obj/structure/transmitter/kz_net
	color = COLOR_YELLOW
	networks_receive = list(FACTION_VSD)
	networks_transmit = list(FACTION_VSD)

/obj/structure/transmitter/kz_net/desk
	name = "wired telephone"
	icon_state = "desk_phone"
	desc = "The finger plate is a little stiff."

/obj/structure/transmitter/cm_net
	color = COLOR_MODERATE_BLUE
	networks_receive = list(FACTION_ICC)
	networks_transmit = list(FACTION_ICC)

/obj/structure/transmitter/cm_net/desk
	name = "wired telephone"
	icon_state = "desk_phone"
	desc = "The finger plate is a little stiff."
