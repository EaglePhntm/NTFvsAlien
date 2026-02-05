//basically teleporter but floor instead
/turf/open/floor/step_trigger
	icon = 'icons/effects/effects.dmi'
	icon_state = "1"
	var/teleport_x // teleportation coordinates (if one is null, then no teleport!)
	var/teleport_y
	var/teleport_z

/turf/open/floor/step_trigger/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(!arrived)
		return
	if(arrived.throwing) //if its in the air still, ignore
		return
	INVOKE_ASYNC(src, PROC_REF(Trigger), arrived)

/turf/open/floor/step_trigger/proc/Trigger(atom/movable/A)
	set waitfor = 0

	if(!istype(A,/obj) && !istype(A,/mob)) //mobs and objects only.
		return

	if(istype(A,/obj/effect) || A.anchored)
		return

	if(A.throwing) //if its in the air still, ignore
		return

	if(teleport_x && teleport_y && teleport_z)

		if(A?.loc)
			if(isliving(A))
				var/mob/living/aliving = A
				aliving.animation_spin()
			A.x = teleport_x
			A.y = teleport_y
			A.z = teleport_z

/* Just a shit code that lets us make the illusion of falling down the supply shaft. */
/turf/open/floor/step_trigger/supply_fall
	var/final_teleport_x
	var/final_teleport_y
	var/final_teleport_z = 1
	teleport_z = 1

/turf/open/floor/step_trigger/supply_fall/Trigger(atom/movable/A)
	set waitfor = 0
	//we make this a var for the proc cause shuttle can replace the src we are using and fuck things up when tryinna find vars from the src
	var/f_teleport_x = teleport_x
	var/f_teleport_y = teleport_y
	var/f_teleport_z = teleport_z

	var/fn_teleport_x = final_teleport_x
	var/fn_teleport_y = final_teleport_y
	var/fn_teleport_z = final_teleport_z

	if(!istype(A,/obj) && !istype(A,/mob)) //mobs and objects only.
		return

	if(istype(A,/obj/effect) || A.anchored)
		return

	if(A.throwing) //if its in the air still, ignore
		return

	if(f_teleport_x && f_teleport_y && f_teleport_z && fn_teleport_x && fn_teleport_y && fn_teleport_z)

		if(A?.loc)

			A.x = f_teleport_x
			A.y = f_teleport_y
			A.z = f_teleport_z

			if(isliving(A))
				var/mob/living/aliving = A
				aliving.ImmobilizeNoChain(5 SECONDS)
				aliving.animation_spin(speed = 25, loop_amount = 2)
				aliving.playsound_local(aliving.loc, 'sound/effects/bomb_fall.ogg', 100, FALSE)
				aliving.emote("scream")
			A.x = fn_teleport_x
			A.y = fn_teleport_y
			A.z = fn_teleport_z
			A.pixel_y = 255
			A.alpha = 0
			animate(A, time = 5, alpha = initial(A.alpha), easing = LINEAR_EASING|EASE_OUT)
			animate(A, time = 10, pixel_y = initial(A.pixel_y), easing = BOUNCE_EASING)
			sleep(5)
			if(isliving(A))
				var/mob/living/aliving = A
				aliving.take_overall_damage(250, BRUTE, MELEE, updating_health = TRUE) //maybe survivable
				aliving.ParalyzeNoChain(15 SECONDS)
				if(ishuman(aliving) && aliving.faction)
					for(var/mob/living/carbon/human/human AS in GLOB.alive_human_list)
						if((human.faction == aliving.faction) || (GLOB.faction_to_iff[human.faction] & GLOB.faction_to_iff[aliving.faction]))
							to_chat(human, span_danger("(N-UI) Req Alert: '[aliving]' seems to have fallen down the requisitons elevator shaft, Mind the elevator and recover them swiftly."))
				if(isrobot(A))
					playsound(A.loc, 'ntf_modular/sound/misc/metal_rod_fall_meme.ogg', 75, FALSE)
				else
					playsound(A.loc, SFX_SLAM, 75, FALSE)

//cause the supply elevator fucking replaces the floors i cant map value them it seem, starting from bottom left

/turf/open/floor/step_trigger/supply_fall/row_one
	final_teleport_x = 23
	final_teleport_y = 109
	teleport_x = 23
	teleport_y = 123

/turf/open/floor/step_trigger/supply_fall/row_one/two
	final_teleport_x = 24
	teleport_x = 24

/turf/open/floor/step_trigger/supply_fall/row_one/three
	final_teleport_x = 25
	teleport_x = 25

/turf/open/floor/step_trigger/supply_fall/row_one/four
	final_teleport_x = 26
	teleport_x = 26

/turf/open/floor/step_trigger/supply_fall/row_one/five
	final_teleport_x = 27
	teleport_x = 27

//one above bottom row
/turf/open/floor/step_trigger/supply_fall/row_two
	final_teleport_x = 23
	final_teleport_y = 110
	teleport_x = 23
	teleport_y = 124

/turf/open/floor/step_trigger/supply_fall/row_two/two
	final_teleport_x = 24
	teleport_x = 24

/turf/open/floor/step_trigger/supply_fall/row_two/three
	final_teleport_x = 25
	teleport_x = 25

/turf/open/floor/step_trigger/supply_fall/row_two/four
	final_teleport_x = 26
	teleport_x = 26

/turf/open/floor/step_trigger/supply_fall/row_two/five
	final_teleport_x = 27
	teleport_x = 27

//third row
/turf/open/floor/step_trigger/supply_fall/row_three
	final_teleport_x = 23
	final_teleport_y = 111
	teleport_x = 23
	teleport_y = 125

/turf/open/floor/step_trigger/supply_fall/row_three/two
	final_teleport_x = 24
	teleport_x = 24

/turf/open/floor/step_trigger/supply_fall/row_three/three
	final_teleport_x = 25
	teleport_x = 25

/turf/open/floor/step_trigger/supply_fall/row_three/four
	final_teleport_x = 26
	teleport_x = 26

/turf/open/floor/step_trigger/supply_fall/row_three/five
	final_teleport_x = 27
	teleport_x = 27

//fourth row

/turf/open/floor/step_trigger/supply_fall/row_four
	final_teleport_x = 23
	final_teleport_y = 112
	teleport_x = 23
	teleport_y = 126

/turf/open/floor/step_trigger/supply_fall/row_four/two
	final_teleport_x = 24
	teleport_x = 24

/turf/open/floor/step_trigger/supply_fall/row_four/three
	final_teleport_x = 25
	teleport_x = 25

/turf/open/floor/step_trigger/supply_fall/row_four/four
	final_teleport_x = 26
	teleport_x = 26

/turf/open/floor/step_trigger/supply_fall/row_four/five
	final_teleport_x = 27
	teleport_x = 27


//fifth row, top
/turf/open/floor/step_trigger/supply_fall/row_five
	final_teleport_x = 23
	final_teleport_y = 113
	teleport_x = 23
	teleport_y = 127

/turf/open/floor/step_trigger/supply_fall/row_five/two
	final_teleport_x = 24
	teleport_x = 24

/turf/open/floor/step_trigger/supply_fall/row_five/three
	final_teleport_x = 25
	teleport_x = 25

/turf/open/floor/step_trigger/supply_fall/row_five/four
	final_teleport_x = 26
	teleport_x = 26

/turf/open/floor/step_trigger/supply_fall/row_five/five
	final_teleport_x = 27
	teleport_x = 27
