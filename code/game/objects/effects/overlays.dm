#define LASER_TYPE_CAS "cas_laser"
#define LASER_TYPE_OB "railgun_laser"
#define LASER_TYPE_RAILGUN "railgun_laser"

/obj/effect/overlay
	name = "overlay"

/obj/effect/overlay/beam//Not actually a projectile, just an effect.
	name="beam"
	icon='icons/effects/beam.dmi'
	icon_state="b_beam"

/obj/effect/overlay/beam/Initialize(mapload)
	. = ..()
	QDEL_IN(src, 1 SECONDS)

/obj/effect/overlay/palmtree_r
	name = "Palm tree"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "palm1"
	density = TRUE
	layer = FLY_LAYER
	anchored = TRUE

/obj/effect/overlay/palmtree_l
	name = "Palm tree"
	icon = 'icons/misc/beach2.dmi'
	icon_state = "palm2"
	density = TRUE
	layer = FLY_LAYER
	anchored = TRUE

/obj/effect/overlay/coconut
	name = "Coconuts"
	icon = 'icons/misc/beach.dmi'
	icon_state = "coconuts"

/obj/effect/overlay/sparks
	name = "Sparks"
	layer = ABOVE_ALL_MOB_LAYER
	icon = 'icons/effects/effects.dmi'
	icon_state = "electricity"

/obj/effect/overlay/temp
	anchored = TRUE
	layer = ABOVE_ALL_MOB_LAYER //above mobs
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT //can't click to examine it
	var/effect_duration = 10 //in deciseconds


//Lase dots

/obj/effect/overlay/blinking_laser //Used to indicate incoming CAS
	name = "blinking laser"
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'icons/effects/lases.dmi'
	icon_state = "laser_target3"
	layer = ABOVE_TREE_LAYER

//CAS:

//Minirockets
/obj/effect/overlay/blinking_laser/tfoot
	icon_state = "tanglefoot_target"

/obj/effect/overlay/blinking_laser/smoke
	icon_state = "smoke_target"

/obj/effect/overlay/blinking_laser/flare
	icon_state = "flare_target"

/obj/effect/overlay/blinking_laser/minirocket
	icon_state = "minirocket_target"

/obj/effect/overlay/blinking_laser/incendiary
	icon_state = "incendiary_target"

//Directional
/obj/effect/overlay/blinking_laser/heavygun
	icon_state = "gau_target"

/obj/effect/overlay/blinking_laser/laser
	icon_state = "laser_beam_target"

//Missiles
/obj/effect/overlay/blinking_laser/widowmaker
	icon_state = "widowmaker_target"

/obj/effect/overlay/blinking_laser/banshee
	icon_state = "banshee_target"

/obj/effect/overlay/blinking_laser/keeper
	icon_state = "keeper_target"

/obj/effect/overlay/blinking_laser/fatty
	icon_state = "fatty_target"

/obj/effect/overlay/blinking_laser/napalm
	icon_state = "napalm_target"

/obj/effect/overlay/blinking_laser/monarch
	icon_state = "monarch_target"

/obj/effect/overlay/blinking_laser/swansong
	icon_state = "swansong_target"

// Bombs, then bomblets

/obj/effect/overlay/blinking_laser/bomb
	icon_state = "bomb_target"

/obj/effect/overlay/blinking_laser/bomb_fat
	icon_state = "fat_bomb_target"

/obj/effect/overlay/blinking_laser/bomblet
	icon_state = "bomblet_target"

//Marine-only visuals. Prediction HUD, etc. Does not show without marine headset
/obj/effect/overlay/blinking_laser/marine
	name = "prediction matrix"
	icon = 'icons/effects/lases.dmi'
	icon_state = "nothing"
	var/icon_state_on = "nothing"
	hud_possible = list(SQUAD_HUD_TERRAGOV)

/obj/effect/overlay/blinking_laser/marine/Initialize(mapload)
	. = ..()
	notify_ai_hazard()
	prepare_huds()
	var/datum/atom_hud/squad/squad_hud = GLOB.huds[DATA_HUD_SQUAD_TERRAGOV]
	squad_hud.add_to_hud(src)
	set_visuals()

/obj/effect/overlay/blinking_laser/marine/proc/set_visuals()
	var/image/new_hud_list = hud_list[SQUAD_HUD_TERRAGOV]
	if(!new_hud_list)
		return

	new_hud_list.icon = 'icons/effects/lases.dmi'
	new_hud_list.icon_state = icon_state_on
	hud_list[SQUAD_HUD_TERRAGOV] = new_hud_list

//Prediction lines. Those horizontal blue lines you see when CAS fires something
/obj/effect/overlay/blinking_laser/marine/lines
	layer = WALL_OBJ_LAYER //Above walls/items, not above mobs
	icon_state_on = "middle"

/obj/effect/overlay/blinking_laser/marine/lines/Initialize(mapload)
	. = ..()
	dir = pick(CARDINAL_DIRS) //Randomises type, for variation

//Drop pod.
/obj/effect/overlay/blinking_laser/marine/pod_warning
	name = "pod warning"
	icon = 'icons/effects/lases.dmi'
	icon_state_on = "pod_laser"

/obj/effect/overlay/blinking_laser/marine/pod_warning/set_visuals()
	var/image/new_hud_list = hud_list[SQUAD_HUD_TERRAGOV]
	if(!new_hud_list)
		return

	new_hud_list.icon = 'icons/effects/lases.dmi'
	new_hud_list.icon_state = icon_state_on
	hud_list[SQUAD_HUD_TERRAGOV] = new_hud_list

/obj/effect/overlay/temp/Initialize(mapload, effect_duration)
	. = ..()
	flick(icon_state, src)
	if(!(effect_duration < 0))
		QDEL_IN(src, effect_duration ? effect_duration : src.effect_duration)

/obj/effect/overlay/temp/point
	name = "arrow"
	desc = "It's an arrow hanging in mid-air. There may be a wizard about."
	icon = 'icons/mob/screen/generic.dmi'
	icon_state = "arrow"
	plane = POINT_PLANE
	anchored = TRUE
	effect_duration = 25

/obj/effect/overlay/temp/point/big
	icon_state = "big_arrow"
	effect_duration = POINT_TIME

//Special laser for coordinates, not for CAS
/obj/effect/overlay/temp/laser_coordinate
	name = "laser"
	anchored = TRUE
	mouse_opacity = 1
	icon = 'icons/obj/items/projectiles.dmi'
	icon_state = "laser_target_coordinate"
	effect_duration = 600
	var/obj/item/binoculars/tactical/source_binoc

/obj/effect/overlay/temp/laser_coordinate/Destroy()
	if(source_binoc)
		source_binoc.laser_cooldown = world.time + source_binoc.cooldown_duration
		source_binoc = null
	return ..()

/obj/effect/overlay/temp/laser_target
	name = "laser"
	anchored = TRUE
	mouse_opacity = 1
	icon = 'icons/obj/items/projectiles.dmi'
	icon_state = "laser_target_blue"
	effect_duration = 600
	var/target_id
	var/obj/item/binoculars/tactical/source_binoc
	var/obj/machinery/camera/laser_cam/linked_cam
	var/datum/squad/squad
	///what kind of laser we are, used for signals
	var/lasertype = LASER_TYPE_RAILGUN

/obj/effect/overlay/temp/laser_target/Initialize(mapload, effect_duration, named, assigned_squad = null, assigned_faction)
	. = ..()
	if(named)
		name = "\improper[named] at [get_area_name(src)]"
	target_id = UNIQUEID //giving it a unique id.
	squad = assigned_squad
	if(squad)
		squad.squad_laser_targets += src
	switch(lasertype)
		if(LASER_TYPE_RAILGUN)
			SEND_GLOBAL_SIGNAL(COMSIG_GLOB_RAILGUN_LASER_CREATED, src)
		if(LASER_TYPE_CAS)
			SEND_GLOBAL_SIGNAL(COMSIG_GLOB_CAS_LASER_CREATED, src, assigned_faction)
		if(LASER_TYPE_OB)
			SEND_GLOBAL_SIGNAL(COMSIG_GLOB_OB_LASER_CREATED, src)

/obj/effect/overlay/temp/laser_target/Destroy()
	if(squad)
		squad.squad_laser_targets -= src
		squad = null
	if(source_binoc)
		source_binoc.laser_cooldown = world.time + source_binoc.cooldown_duration
		source_binoc.laser = null
		source_binoc = null
	if(linked_cam)
		qdel(linked_cam)
		linked_cam = null
	return ..()

/obj/effect/overlay/temp/laser_target/ex_act(severity) //immune to explosions
	return

/obj/effect/overlay/temp/laser_target/examine(user)
	. = ..()
	if(ishuman(user))
		. += span_danger("It's a laser to designate artillery targets, get away from it!")

/obj/effect/overlay/temp/laser_target/cas
	icon_state = "laser_target_coordinate"
	lasertype = LASER_TYPE_CAS
	var/assigned_faction = FACTION_TERRAGOV

/obj/effect/overlay/temp/laser_target/cas/Initialize(mapload, effect_duration, named, assigned_squad = null, assigned_faction = FACTION_TERRAGOV)
	. = ..()
	linked_cam = new(src, name)
	GLOB.active_cas_targets += src

/obj/effect/overlay/temp/laser_target/cas/Destroy()
	GLOB.active_cas_targets -= src
	return ..()

/obj/effect/overlay/temp/laser_target/cas/examine(user)
	. = ..()
	if(ishuman(user))
		. += span_danger("It's a laser to designate CAS targets, get away from it!")

/obj/effect/overlay/temp/laser_target/ob //This is a subtype of CAS so that CIC gets cameras on the lase
	icon_state = "laser_target2"
	lasertype = LASER_TYPE_OB

/obj/effect/overlay/temp/laser_target/ob/Initialize(mapload, effect_duration, named, assigned_squad)
	. = ..()
	linked_cam = new(src, name)
	GLOB.active_laser_targets += src

/obj/effect/overlay/temp/laser_target/ob/Destroy()
	GLOB.active_laser_targets -= src
	return ..()

/obj/effect/overlay/temp/blinking_laser //not used for CAS anymore but some admin buttons still use it
	name = "blinking laser"
	anchored = TRUE
	effect_duration = 10
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'icons/obj/items/projectiles.dmi'
	icon_state = "laser_target3"


/obj/effect/overlay/temp/sniper_laser
	name = "laser"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'icons/obj/items/projectiles.dmi'
	icon_state = "sniper_laser"


/obj/effect/overlay/temp/emp_sparks
	icon = 'icons/effects/effects.dmi'
	icon_state = "empdisable"
	name = "emp sparks"
	effect_duration = 10

/obj/effect/overlay/temp/emp_sparks/Initialize(mapload, effect_duration)
	setDir(pick(GLOB.cardinals))
	return ..()

/obj/effect/overlay/temp/emp_pulse
	name = "emp pulse"
	icon = 'icons/effects/effects.dmi'
	icon_state = "emppulse"
	effect_duration = 20


/obj/effect/overlay/temp/tank_laser
	name = "tanklaser"
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'icons/obj/items/projectiles.dmi'
	icon_state = "laser_target3"
	effect_duration = 20



//gib animation
/obj/effect/overlay/temp/gib_animation
	icon = 'icons/mob/mob.dmi'
	effect_duration = 14

/obj/effect/overlay/temp/gib_animation/Initialize(mapload, effect_duration, mob/source_mob, gib_icon)
	. = ..()
	if(source_mob)
		pixel_x += source_mob.pixel_x
	flick(gib_icon, src)

/obj/effect/overlay/temp/gib_animation/ex_act(severity)
	return

/obj/effect/overlay/temp/gib_animation/human
	icon = 'icons/mob/human_gib.dmi'
	pixel_x = -16
	pixel_y = -16

/obj/effect/overlay/temp/gib_animation/animal
	icon = 'icons/mob/animal.dmi'
	effect_duration = 12

/obj/effect/overlay/temp/gib_animation/xeno
	icon = 'icons/Xeno/64x64_Xeno_overlays.dmi'
	effect_duration = 10

/obj/effect/overlay/temp/gib_animation/xeno/Initialize(mapload, effect_duration, mob/source_mob, gib_icon, new_icon)
	icon = new_icon
	return ..()

//dust animation

/obj/effect/overlay/temp/dust_animation
	icon = 'icons/mob/mob.dmi'
	effect_duration = 12

/obj/effect/overlay/temp/dust_animation/Initialize(mapload, effect_duration, mob/source_mob, gib_icon)
	. = ..()
	pixel_x = source_mob.pixel_x
	pixel_y = source_mob.pixel_y
	icon_state = gib_icon

/obj/effect/overlay/temp/timestop_effect
	icon = 'icons/effects/160x160.dmi'
	icon_state = "time"
	pixel_x = -60
	pixel_y = -50
	alpha = 70

/obj/effect/overlay/eye
	layer = ABOVE_MOB_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon_state = "eye_open"
	pixel_x = 16
	pixel_y = 16

/obj/effect/overlay/dread
	layer = ABOVE_MOB_LAYER
	icon_state = "spooky"
	pixel_x = 16
	pixel_y = 16

/obj/effect/overlay/vis
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE
	vis_flags = VIS_INHERIT_DIR
	/// When detected to be unused it gets set to world.time, after a while it gets removed
	var/unused = 0
	/// Overlays which go unused for 2 minutes get cleaned up
	var/cache_expiration = 2 MINUTES
