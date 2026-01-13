GLOBAL_LIST_EMPTY(comm_tower_landmarks_net_one)
GLOBAL_LIST_EMPTY(comm_tower_landmarks_net_two)
GLOBAL_LIST_EMPTY(all_static_telecomms_towers)

/datum/game_mode
	var/zombies_regrow_limbs = FALSE
	var/zombie_rebirth = FALSE
	var/zombie_ids = FALSE
	var/static_comms_amount = 2

/datum/game_mode/pre_setup()
	. = ..()
	if(static_comms_amount)
		spawn_static_comms()

/datum/game_mode/proc/spawn_static_comms()
	for(var/i = 1 to static_comms_amount)
		var/obj/effect/landmark/static_comms/tower
		if(i % 2)
			tower = pick_n_take(GLOB.comm_tower_landmarks_net_one)
		else
			tower = pick_n_take(GLOB.comm_tower_landmarks_net_two)
		if(!tower)
			continue
		tower.spawn_tower()
	QDEL_LIST(GLOB.comm_tower_landmarks_net_one)
	QDEL_LIST(GLOB.comm_tower_landmarks_net_two)

/datum/game_mode/LateSpawn(mob/new_player/player)
	for(var/mob/living/carbon/human/foundfucko in GLOB.ssd_living_mobs)
		if(foundfucko.real_name == player.client.prefs.real_name && length(foundfucko.ckey_history) && (player.key in foundfucko.ckey_history))
			to_chat(player, span_warning("This character already exists in round waiting in SSD, Use take SSD mob instead."))
			player.take_ssd_mob()
			return
	. = ..()
