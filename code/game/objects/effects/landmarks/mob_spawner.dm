//One off mob spawners
/obj/effect/landmark/mob_spawner
	name = "MOB SPAWNER"
	///The type of mob to spawn
	var/mob/living/mob_spawn
	///Spawn probability
	var/spawn_prob = 100

/obj/effect/landmark/mob_spawner/Initialize(mapload)
	. = ..()
	if(prob(spawn_prob))
		new mob_spawn(loc)
	qdel(src)

/obj/effect/landmark/mob_spawner/monkey
	name = "monkey spawner"
	icon = 'icons/mob/human_races/r_monkey.dmi'
	icon_state = "monke"
	mob_spawn = /mob/living/carbon/human/species/monkey
	spawn_prob = 50

/obj/effect/landmark/mob_spawner/farwa
	name = "farwa spawner"
	icon = 'icons/mob/human_races/r_farwa.dmi'
	icon_state = "monke"
	mob_spawn = /mob/living/carbon/human/species/monkey/farwa
	spawn_prob = 50

/obj/effect/landmark/mob_spawner/neutralcivilian/
	name = "neutral civilian spawner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x2"
	mob_spawn = /mob/living/carbon/human/ai/neutral
	spawn_prob = 100

/obj/effect/landmark/mob_spawner/neutralcivilian/Initialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_GAMEMODE_LOADED, PROC_REF(spawn_civneutral))

/obj/effect/landmark/mob_spawner/neutralcivilian/proc/spawn_civneutral(dcs)
	sleep(5 SECONDS) //let shit settle

/obj/effect/landmark/mob_spawner/neutralevzcivilian
	name = "neutral east vietzhuan civilian spawner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x2"
	mob_spawn = /mob/living/carbon/human/ai/evzneutral
	spawn_prob = 100

/obj/effect/landmark/mob_spawner/neutralevzcivilian/Initialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_GAMEMODE_LOADED, PROC_REF(spawn_evzneutral))

/obj/effect/landmark/mob_spawner/neutralevzcivilian/proc/spawn_evzneutral(dcs)
	sleep(5 SECONDS) //let shit settle
