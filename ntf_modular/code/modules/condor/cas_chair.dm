/obj/structure/caspart/caschair/som
	name = "\improper Manta Jet pilot seat"
	icon = 'icons/obj/structures/prop/somship.dmi'
	icon_state = "somcas_cockpit"
	dir = 1
	layer = ABOVE_MOB_LAYER
	req_access = null
	faction = FACTION_SOM

///Handles updating the cockpit overlay
/obj/structure/caspart/caschair/proc/set_cockpit_overlay(new_state)
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
	dwidth = 4
	dheight = 6
	width = 7
	height = 10

/obj/docking_port/mobile/marine_dropship/casplane/som
	name = "SOM Manta Jet"
	id = SHUTTLE_CAS_DOCK_SOM
	faction = FACTION_SOM
	dwidth = 4
	dheight = 6
	width = 7
	height = 10

/obj/structure/caspart/caschair/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!owner)
		return
	if(action == "toggle_engines")
		if(owner.mode == SHUTTLE_IGNITING)
			return
		switch(owner.state)
			if(PLANE_STATE_ACTIVATED)
				owner.turn_on_engines()
			if(PLANE_STATE_PREPARED)
				owner.turn_off_engines()
	if(action == "eject")
		if(owner.state != PLANE_STATE_ACTIVATED)
			return
		resisted_against()
		ui.close()

	if(owner.state == PLANE_STATE_ACTIVATED)
		return

	switch(action)
		if("launch")
			if(!cas_usable)
				to_chat(usr, span_warning("Combat has not yet initiated, CAS unavailable."))
				return
			if(owner.state == PLANE_STATE_FLYING || owner.mode != SHUTTLE_IDLE)
				return
			if(owner.fuel_left <= LOW_FUEL_TAKEOFF_THRESHOLD)
				to_chat(usr, span_warning("Unable to launch, low fuel."))
				return
			SSshuttle.moveShuttleToDock(owner.id, SSshuttle.generate_transit_dock(owner), TRUE)
			owner.currently_returning = FALSE
		if("land")
			if(owner.state != PLANE_STATE_FLYING)
				return
			SSshuttle.moveShuttle(owner.id, SHUTTLE_CAS_DOCK_SOM, TRUE)
			owner.end_cas_mission(usr)
			owner.currently_returning = TRUE
		if("deploy")
			if(owner.state != PLANE_STATE_FLYING)
				return
			owner.begin_cas_mission(usr)
		if("change_weapon")
			var/selection = text2num(params["selection"])
			owner.active_weapon = owner.equipments[selection]
			occupant.client.mouse_pointer_icon = owner.active_weapon.ammo_equipped.crosshair
		if("cycle_attackdir")
			if(params["newdir"] == null)
				owner.attackdir = turn(owner.attackdir, 90)
				return TRUE
			owner.attackdir = params["newdir"]
			return TRUE

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
