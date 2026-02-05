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

/obj/effect/landmark/corrupted_xeno_silo_spawn
	name = "corrupted xeno silo spawn landmark"
	icon = 'icons/Xeno/resin_silo.dmi'
	icon_state = "weed_silo"
	color = "#00ff80"
	var/hivenumber = XENO_HIVE_CORRUPTED

/obj/effect/landmark/corrupted_xeno_silo_spawn/Initialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_GAMEMODE_LOADED, PROC_REF(spawn_silo))

/obj/effect/landmark/corrupted_xeno_silo_spawn/proc/spawn_silo(dcs)
	var/datum/job/xenomorph/xeno_job = SSjob.GetJobType(GLOB.hivenumber_to_job_type[hivenumber])
	if(xeno_job.total_positions) //if this gamemode even has any corrupted
		new /obj/structure/xeno/silo(loc, hivenumber)

/obj/effect/landmark/reclone_tp
	icon = 'icons/mob/landmarks.dmi'
	icon_state = "x"

/obj/effect/landmark/reclone_tp/Initialize(mapload)
	. = ..()
	GLOB.reclone_tp_spots += src

/obj/effect/landmark/reclone_tp/Destroy()
	. = ..()
	GLOB.reclone_tp_spots += src
