//****************************************** STATIC COMMS ************************************************//
/obj/effect/landmark/static_comms
	name = "static comms"
	icon = 'ntf_modular/icons/obj/structures/machinery/comm_tower3.dmi'
	icon_state = "comms_landmark"
	var/broken_on_spawn = FALSE

/obj/effect/landmark/static_comms/proc/spawn_tower()
	var/obj/machinery/telecomms/relay/preset/tower/mapcomms/commstower = new (loc)
	if(broken_on_spawn)
		commstower.update_health(damage = commstower.health) //fuck it up
	qdel(src)

/obj/effect/landmark/static_comms/net_one
	icon_state = "comms_landmark_1"

/obj/effect/landmark/static_comms/net_one/Initialize(mapload, ...)
	. = ..()
	GLOB.comm_tower_landmarks_net_one += src

/obj/effect/landmark/static_comms/net_one/Destroy()
	GLOB.comm_tower_landmarks_net_one -= src
	return ..()

/obj/effect/landmark/static_comms/net_two
	icon_state = "comms_landmark_2"

/obj/effect/landmark/static_comms/net_two/Initialize(mapload, ...)
	. = ..()
	GLOB.comm_tower_landmarks_net_two += src

/obj/effect/landmark/static_comms/net_two/Destroy()
	GLOB.comm_tower_landmarks_net_two -= src
	return ..()
