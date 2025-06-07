/obj/structure/caspart/caschair/som
	name = "\improper Manta Jet pilot seat"
	icon = 'icons/obj/structures/prop/somship.dmi'
	icon_state = "somcas_cockpit"
	dir = 1
	layer = ABOVE_MOB_LAYER
	faction = FACTION_SOM
	home_dock = SHUTTLE_CAS_DOCK_SOM

///Handles updating the cockpit overlay
/obj/structure/caspart/caschair/som/set_cockpit_overlay(new_state)
	cut_overlays()
	cockpit = image('icons/obj/structures/prop/somship.dmi', src, new_state)
	cockpit.pixel_x = 0
	cockpit.pixel_y = 0
	cockpit.layer = ABOVE_ALL_MOB_LAYER
	add_overlay(cockpit)

/area/shuttle/som_cas
	name = "Manta Jet"

/datum/map_template/shuttle/cas/som
	shuttle_id = SHUTTLE_CAS_SOM
	name = "SOM Condor Jet"

/obj/docking_port/stationary/marine_dropship/cas/som
	name = "SOM CAS plane hangar pad"
	id = SHUTTLE_CAS_DOCK_SOM
	roundstart_template = /datum/map_template/shuttle/cas/som
	//fuckass thing wont work
	dwidth = 4
	dheight = 6
	width = 9
	height = 12

/obj/docking_port/mobile/marine_dropship/casplane/som
	name = "SOM Manta Jet"
	id = SHUTTLE_CAS_DOCK_SOM
	faction = FACTION_SOM
	dwidth = 5
	dheight = 7
	width = 8
	height = 11

/obj/docking_port/mobile/marine_dropship/casplane/som/Initialize(mapload)
	. = ..()
	if(faction == FACTION_SOM)
		cas_mini.minimap_flags = MINIMAP_FLAG_MARINE_SOM
		cas_mini.marker_flags = MINIMAP_FLAG_MARINE_SOM

/obj/docking_port/mobile/marine_dropship/casplane/som/process()
	#ifndef TESTING
	fuel_left--
	if((fuel_max*LOW_FUEL_WARNING_THRESHOLD) == fuel_left)
		chair.occupant?.playsound_local(loc, 'sound/voice/plane_vws/low_fuel.ogg', 70, FALSE)
	if((fuel_left <= LOW_FUEL_LANDING_THRESHOLD) && (state == PLANE_STATE_FLYING))
		to_chat(chair.occupant, span_warning("Out of fuel, landing."))
		chair.occupant?.playsound_local(loc, 'sound/voice/plane_vws/no_fuel.ogg', 70, FALSE)
		SSshuttle.moveShuttle(id, SHUTTLE_CAS_DOCK_SOM, TRUE)
		currently_returning = TRUE
		end_cas_mission(chair.occupant)
	if(fuel_left <= 0)
		fuel_left = 0
		turn_off_engines()
	#endif
