/// Structures serving as landmarks and providing a buff to its users.
/// A notable code feature is that they use a separate roof image that phases out when you enter the tent.
/obj/structure/tent
	name = "tent"
	icon = 'ntf_modular/icons/obj/structures/tents_deployed_classic.dmi'
	opacity = FALSE // Seems only the initial turf blocks light, not all of the multitile. Therefore, useless.
	layer = INTERIOR_WALL_SOUTH_LAYER // This should be below FLY_LAYER but just thank chairs and other bs
	health = 200
	appearance_flags = TILE_BOUND

	/// Turf dimensions along the X axis, beginning from left, at ground level
	var/x_dim = 2
	/// Turf dimensions along the Y axis, beginning from bottom, at ground level
	var/y_dim = 3

	/// How much cold protection to add to entering humans - Full body clothing means complete (1) protection
	var/cold_protection_factor = 0.4

	/// Roof display icon_state or null to disable
	var/roof_state
	/// Roof image displayed on the roof plane
	var/image/roof_image

/obj/structure/tent/Initialize(mapload, ...)
	. = ..()
	bound_width = x_dim * world.icon_size
	bound_height = y_dim * world.icon_size
	register_turf_signals()
	RegisterSignal(src, COMSIG_TURF_CHANGE, PROC_REF(register_turf_signals))

	switch(SSmapping.configs[GROUND_MAP].armor)
		if("jungle")
			icon = 'ntf_modular/icons/obj/structures/tents_deployed_jungle.dmi'
		if("desert")
			icon = 'ntf_modular/icons/obj/structures/tents_deployed_desert.dmi'
		if("ice")
			icon = 'ntf_modular/icons/obj/structures/tents_deployed_snow.dmi'
		if("urban")
			icon = 'ntf_modular/icons/obj/structures/tents_deployed_urban.dmi'

	if(roof_state)
		roof_image = image(icon, src, roof_state)
		roof_image.plane = ROOF_PLANE
		roof_image.appearance_flags = KEEP_APART
		src.overlays += roof_image

/obj/structure/tent/proc/register_turf_signals()
	SIGNAL_HANDLER
	for(var/turf/turf in locs)
		RegisterSignal(turf, COMSIG_ATOM_ENTERED, PROC_REF(movable_entering_tent), override = TRUE)

/obj/structure/tent/proc/movable_entering_tent(turf/hooked, atom/movable/subject)
	SIGNAL_HANDLER
	if(!ismob(subject))
		return
	var/mob/subject_mob = subject
	RegisterSignal(subject_mob, list(COMSIG_MOVABLE_MOVED), PROC_REF(mob_moved), override = TRUE) // Must override because we can't know if mob was already inside tent without keeping an awful ref list
	var/atom/movable/screen/plane_master/roof/roof_plane = subject_mob.hud_used.plane_masters["[ROOF_PLANE]"]
	roof_plane?.invisibility = INVISIBILITY_MAXIMUM
	if(ishuman(subject))
		RegisterSignal(subject, COMSIG_HUMAN_COLD_PROTECTION_APPLY_MODIFIERS, PROC_REF(cold_protection), override = TRUE)

/obj/structure/tent/proc/cold_protection(mob/source, list/protection_data)
	SIGNAL_HANDLER
	protection_data["protection"] += cold_protection_factor

/obj/structure/tent/proc/mob_moved(mob/subject, turf/target_turf)
	SIGNAL_HANDLER
	if(!(target_turf in locs)) // Exited the tent
		mob_exited_tent(subject)

/obj/structure/tent/proc/mob_exited_tent(mob/subject)
	UnregisterSignal(subject, list(COMSIG_MOVABLE_MOVED))
	var/atom/movable/screen/plane_master/roof/roof_plane = subject.hud_used.plane_masters["[ROOF_PLANE]"]
	roof_plane?.invisibility = 0

/obj/structure/tent/attack_alien(mob/living/carbon/xenomorph/M, damage_amount, damage_type, armor_type, effects, armor_penetration, isrightclick)
	if(unslashable)
		return
	health -= 20
	if(health <= 0)
		visible_message(span_boldwarning("The [src] collapses!"))
		qdel(src)

/// Command tent, providing basics for field command: a phone, and an overwatch console
/obj/structure/tent/cmd
	icon_state = "cmd_interior"
	roof_state = "cmd_top"
	desc = "A standard USCM Command Tent. This one comes equipped with a self-powered Overwatch Console and a Telephone. It is very frail, do not burn, expose to sharp objects, or explosives."

/// Medical tent, procures a buff to surgery speed
/obj/structure/tent/med
	icon_state = "med_interior"
	roof_state = "med_top"
	desc = "A standard USCM Medical Tent. This one comes equipped with advanced field surgery facilities. It is very fragile however and won't withstand the rigors of war."
	var/surgery_speed_mult = 0.9
	var/surgery_pain_reduction = 5

/obj/structure/tent/med/movable_entering_tent(turf/hooked, atom/movable/subject)
	. = ..()
	if(ishuman(subject))
		RegisterSignal(subject, COMSIG_HUMAN_SURGERY_APPLY_MODIFIERS, PROC_REF(apply_surgery_modifiers), override = TRUE)

/obj/structure/tent/med/mob_exited_tent(mob/subject)
	. = ..()
	UnregisterSignal(subject, COMSIG_HUMAN_SURGERY_APPLY_MODIFIERS)

/obj/structure/tent/med/proc/apply_surgery_modifiers(mob/living/carbon/human/source, list/surgery_data)
	SIGNAL_HANDLER
	surgery_data["surgery_speed"] *= surgery_speed_mult
	surgery_data["pain_reduction"] += surgery_pain_reduction

/// Big Tent. It's just Big. Use it for shelter or organization!
/obj/structure/tent/big
	icon_state = "big_interior"
	roof_state = "big_top"
	x_dim = 3
	y_dim = 3

/obj/structure/tent/reqs
	icon_state = "reqs_interior"
	roof_state = "reqs_top"
	x_dim = 4
	y_dim = 3

//other shit
/// Plane master handling display of building roofs. They're meant to become invisible when inside a building.
/atom/movable/screen/plane_master/roof
	name = "roof plane master"
	plane = ROOF_PLANE
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY

/// Invisible Blocker Walls, they link up with the main tent and collapse with it
/obj/structure/blocker/tent
	name = "Tent Blocker"
	icon = 'icons/obj/structures/barricades/folding.dmi'
	icon_state = "folding_0" // for map editing only
	flags_atom = ON_BORDER
	invisibility = INVISIBILITY_MAXIMUM
	density = TRUE
	opacity = FALSE // Unfortunately this doesn't behave as we'd want with ON_BORDER so we can't make tent opaque
	/// The tent this blocker relates to, will be destroyed along with it
	var/obj/structure/tent/linked_tent

/obj/structure/blocker/tent/Initialize(mapload, ...)
	. = ..()
	icon_state = null
	linked_tent = locate(/obj/structure/tent) in loc
	if(!linked_tent)
		return INITIALIZE_HINT_QDEL
	RegisterSignal(linked_tent, COMSIG_PARENT_QDELETING, PROC_REF(collapse))

/obj/structure/blocker/tent/Destroy(force)
	. = ..()
	linked_tent = null

/obj/structure/blocker/tent/proc/collapse()
	SIGNAL_HANDLER
	qdel(src)

/obj/structure/blocker/tent/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = NONE
		PF.flags_can_pass_front = NONE
		PF.flags_can_pass_behind = NONE

/obj/structure/blocker/tent/get_projectile_hit_boolean(obj/item/projectile/P)
	. = ..()
	return FALSE // Always fly through the tent

/// Component to handle power requirements following removal of the tent
/datum/component/tent_powered_machine
	dupe_mode = COMPONENT_DUPE_HIGHLANDER
	var/obj/structure/tent/linked_tent

/datum/component/tent_powered_machine/Initialize(...)
	. = ..()
	if(!istype(parent, /obj/structure/machinery))
		return COMPONENT_INCOMPATIBLE
	var/obj/structure/machinery/machine = parent
	var/obj/structure/tent/located_tent = locate(/obj/structure/tent) in machine.loc
	if(located_tent)
		linked_tent = located_tent
		machine.needs_power = FALSE
		RegisterSignal(linked_tent, COMSIG_PARENT_QDELETING, PROC_REF(enable_power_requirement))

/datum/component/tent_powered_machine/proc/enable_power_requirement()
	SIGNAL_HANDLER
	var/obj/structure/machinery/machine = parent
	machine.needs_power = TRUE

/// Component to handle destruction of objects following removal of the tent
/datum/component/tent_supported_object
	dupe_mode = COMPONENT_DUPE_HIGHLANDER
	var/obj/structure/tent/linked_tent

/datum/component/tent_supported_object/Initialize(...)
	. = ..()
	if(!istype(parent, /atom/movable))
		return COMPONENT_INCOMPATIBLE
	var/atom/movable/source = parent
	var/obj/structure/tent/located_tent = locate(/obj/structure/tent) in source.loc
	if(located_tent)
		linked_tent = located_tent
		RegisterSignal(linked_tent, COMSIG_PARENT_QDELETING, PROC_REF(tent_collapse))

/datum/component/tent_supported_object/proc/tent_collapse()
	SIGNAL_HANDLER
	qdel(parent)

/// Groundside console
/obj/structure/machinery/computer/overwatch/tent/Initialize(mapload, ...)
	AddComponent(/datum/component/tent_supported_object)
	return ..()

/// Telephone
/obj/structure/transmitter/tent
	layer = WALL_OBJ_LAYER

/obj/structure/transmitter/tent/Initialize(mapload, ...)
	AddComponent(/datum/component/tent_supported_object)
	return ..()

/// ASRS request console
/obj/machinery/computer/supplycomp/tent
	icon = 'ntf_modular/icons/obj/machines/cm/computer.dmi'
	icon_state = "request_wall"
	density = FALSE
	deconstructible = FALSE
	needs_power = FALSE
	indestructible = TRUE // Goes with the tent instead
	layer = WALL_OBJ_LAYER
/obj/machinery/computer/supplycomp/tent/Initialize()
	AddComponent(/datum/component/tent_supported_object)
	return ..()

/// NanoMED
/obj/machinery/vending/nanomed/tent
	unacidable = FALSE
	layer = WALL_OBJ_LAYER
	needs_power = FALSE
/obj/machinery/vending/nanomed/tent/Initialize()
	AddComponent(/datum/component/tent_supported_object)
	return ..()

/// Closeable curtains
/obj/structure/tent_curtain
	icon = 'ntf_modular/icons/obj/structures/tents_equipment.dmi'
	icon_state = "curtains-classic-o"
	desc = "USCM Curtains for USCM Tents used by USCM Personnel. Close this with right-click to ensure USCM Contents are contained."
	flags_atom = ON_BORDER
	layer = INTERIOR_DOOR_INSIDE_LAYER
	dir = SOUTH
	density = FALSE
	alpha = 180

/obj/structure/tent_curtain/Initialize(mapload, ...)
	. = ..()
	AddComponent(/datum/component/tent_supported_object)
	update_icon()

/obj/structure/tent_curtain/get_projectile_hit_boolean(obj/item/projectile/P)
	return FALSE

/obj/structure/tent_curtain/update_icon()
	. = ..()
	var/camo = SSmapping.configs[GROUND_MAP].armor
	if(density)
		icon_state = "curtains-[camo]"
	else
		icon_state = "curtains-[camo]-o"

/obj/structure/tent_curtain/attack_hand(mob/user)
	. = ..()
	if(!.)
		playsound(loc, "rustle", 10, TRUE, 4)
		density = !density
		update_icon()
		return TRUE

/obj/structure/tent_curtain/attack_alien(mob/living/carbon/xenomorph/M, damage_amount, damage_type, armor_type, effects, armor_penetration, isrightclick)
	if(unslashable)
		return
	visible_message(span_boldwarning("[src] gets torn to shreds!"))
	qdel(src)

/obj/item/folded_tent
	name = "Folded Abstract Tent"
	icon = 'ntf_modular/icons/obj/structures/tents_folded.dmi'
	w_class = SIZE_LARGE
	/// Required cleared area along X axis
	var/dim_x = 1
	/// Required cleared area along Y axis
	var/dim_y = 1
	/// Deployment X offset
	var/off_x = 0
	/// Deployment Y offset
	var/off_y = 0
	/// Map Template to use for the tent
	var/template

/// Check an area is clear for deployment of the tent
/obj/item/folded_tent/proc/check_area(turf/ref_turf, mob/message_receiver, display_error = FALSE)
	SHOULD_NOT_SLEEP(TRUE)
	. = TRUE
	var/list/turf_block = get_deployment_area(ref_turf)
	for(var/turf/turf as anything in turf_block)
		var/area/area = get_area(turf)
		if(!area.can_build_special)
			if(message_receiver)
				to_chat(message_receiver, span_warning("You cannot deploy tents on restricted areas."))
			if(display_error)
				new /obj/effect/overlay/temp/tent_deployment_area/error(turf)
			return FALSE
		if(istype(turf, /turf/open/shuttle))
			if(message_receiver)
				to_chat(message_receiver, span_boldwarning("What are you doing?!! Don't build that on the shuttle please!"))
			return FALSE
		if(turf.density)
			if(message_receiver)
				to_chat(message_receiver, span_warning("You cannot deploy the [src] here, something ([turf]) is in the way."))
			if(display_error)
				new /obj/effect/overlay/temp/tent_deployment_area/error(turf)
			return FALSE
		for(var/atom/movable/atom as anything in turf)
			if(isliving(atom) || (atom.density && atom.can_block_movement) || istype(atom, /obj/structure/tent))
				if(message_receiver)
					to_chat(message_receiver, span_warning("You cannot deploy the [src] here, something ([atom.name]) is in the way."))
				if(display_error)
					new /obj/effect/overlay/temp/tent_deployment_area/error(turf)
				return FALSE
	return TRUE

/obj/item/folded_tent/proc/unfold(turf/ref_turf)
	var/datum/map_template/template_instance = new template()
	template_instance.load(ref_turf, FALSE, FALSE)

/obj/item/folded_tent/proc/get_deployment_area(turf/ref_turf)
	RETURN_TYPE(/list/turf)
	var/turf/block_end_turf = locate(ref_turf.x + dim_x - 1, ref_turf.y + dim_y - 1, ref_turf.z)
	return block(ref_turf, block_end_turf)

/obj/item/folded_tent/attack_self(mob/living/user)
	. = ..()
	var/turf/deploy_turf = user.loc
	if(!istype(deploy_turf))
		return // In a locker or something. Get lost you already have a home.

	switch(user.dir) // Fix up offset deploy location so tent is better centered + can be deployed under all angles
		if(NORTH)
			deploy_turf = locate(deploy_turf.x + off_x, deploy_turf.y + 1, deploy_turf.z)
		if(SOUTH)
			deploy_turf = locate(deploy_turf.x + off_x, deploy_turf.y - dim_y, deploy_turf.z)
		if(EAST)
			deploy_turf = locate(deploy_turf.x + 1, deploy_turf.y + off_y, deploy_turf.z)
		if(WEST)
			deploy_turf = locate(deploy_turf.x - dim_x, deploy_turf.y + off_y, deploy_turf.z)

	if(!istype(deploy_turf) || (deploy_turf.x + dim_x > world.maxx) || (deploy_turf.y + dim_y > world.maxy)) // Map border basically
		return

	if(!is_ground_level(deploy_turf.z))
		to_chat(user, span_warning("USCM Operational Tents are intended for operations, not ship or space recreation."))
		return

	var/list/obj/effect/overlay/temp/tent_deployment_area/turf_overlay = list()
	var/list/turf/deployment_area = get_deployment_area(deploy_turf)

	if(!check_area(deploy_turf, user, TRUE))
		for(var/turf/turf in deployment_area)
			new /obj/effect/overlay/temp/tent_deployment_area(turf) // plus error in check_area
		return

	for(var/turf/turf in deployment_area)
		turf_overlay += new /obj/effect/overlay/temp/tent_deployment_area/casting(turf)

	user.visible_message(span_info("[user] starts deploying the [src]..."), \
		span_warning("You start assembling the [src]... Stand still, it might take a bit to figure it out..."))
	if(!do_after(user, 6 SECONDS, INTERRUPT_ALL, BUSY_ICON_BUILD))
		to_chat(user, span_warning("You were interrupted!"))
		for(var/gfx in turf_overlay)
			qdel(gfx)
		return

	if(!check_area(deploy_turf, user, TRUE))
		for(var/gfx in turf_overlay)
			QDEL_IN(gfx, 1.5 SECONDS)
		return

	unfold(deploy_turf)
	user.visible_message(span_info("[user] finishes deploying the [src]!"), span_info("You finish deploying the [src]!"))
	for(var/gfx in turf_overlay)
		qdel(gfx)
	qdel(src) // Success!

/obj/item/folded_tent/cmd
	name = "folded USCM Command Tent"
	icon_state = "cmd"
	desc = "A standard USCM Command Tent. This one comes equipped with a self-powered Overwatch Console and a Telephone. Unfold in a suitable location to maximize usefulness. Staff Officer not included. ENTRANCE TO THE SOUTH."
	dim_x = 2
	dim_y = 3
	off_x = -1
	template = /datum/map_template/tent/cmd

/obj/item/folded_tent/med
	name = "folded USCM Medical Tent"
	icon_state = "med"
	desc = "A standard USCM Medical Tent. This one comes equipped with advanced field surgery facilities. Unfold in a suitable location to maximize health gains. Surgical Tray not included. ENTRANCE TO THE SOUTH."
	dim_x = 2
	dim_y = 3
	template = /datum/map_template/tent/med

/obj/item/folded_tent/reqs
	name = "folded USCM Requisitions Tent"
	icon_state = "req"
	desc = "A standard USCM Requisitions Tent. Now, you can enjoy req line anywhere you go! Unfold in a suitable location to maximize resource distribution. ASRS not included. ENTRANCE TO THE SOUTH."
	dim_x = 4
	dim_y = 3
	off_x = -2
	template = /datum/map_template/tent/reqs

/obj/item/folded_tent/big
	name = "folded USCM Big Tent"
	icon_state = "big"
	desc = "A standard USCM Tent. This one is just a bigger, general purpose version. Unfold in a suitable location for maximum FOB vibes. Mess Tech not included. ENTRANCE TO THE SOUTH."
	dim_x = 3
	dim_y = 3
	off_x = -2
	template = /datum/map_template/tent/big

/obj/effect/overlay/temp/tent_deployment_error
	icon = 'ntf_modular/icons/effects/effects.dmi'
	icon_state = "placement_zone"
	color = "#bb0000"
	effect_duration = 1.5 SECONDS
	layer = ABOVE_FLY_LAYER

/obj/effect/overlay/temp/tent_deployment_area
	icon = 'ntf_modular/icons/effects/effects.dmi'
	icon_state = "placement_zone"
	color = "#f39e00"
	effect_duration = 1.5 SECONDS
	layer = FLY_LAYER

/obj/effect/overlay/temp/tent_deployment_area/casting
	effect_duration = 10 SECONDS
	color = "#228822"

/obj/effect/overlay/temp/tent_deployment_area/error
	layer = ABOVE_FLY_LAYER
	color = "#bb0000"

/datum/map_template/tent
	name = "Base Tent"
	var/map_id = "change this"

/datum/map_template/tent/New()
	mappath = "maps/tents/[map_id].dmm"
	return ..()

/datum/map_template/tent/cmd
	name = "CMD Tent"
	map_id = "tent_cmd"

/datum/map_template/tent/med
	name = "MED Tent"
	map_id = "tent_med"

/datum/map_template/tent/big
	name = "Big Tent"
	map_id = "tent_big"

/datum/map_template/tent/reqs
	name = "Reqs Tent"
	map_id = "tent_reqs"
