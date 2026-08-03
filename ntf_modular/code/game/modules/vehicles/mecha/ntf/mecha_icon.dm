/obj/vehicle/sealed/mecha/ntf/update_icon() // taken from baystation mech icon code
	. = ..()
	var/list/overlays_to_make = list()
	if(body)
		var/image/body_overlay = image(icon = body.icon, icon_state = body.icon_state)
		body_overlay.layer = MECH_BASE_LAYER
		body_overlay.plane = FLOAT_PLANE
		overlays_to_make += body_overlay
	if(head)
		var/image/head_overlay = image(icon = head.icon, icon_state = head.icon_state)
		head_overlay.layer = MECH_INTERMEDIATE_LAYER
		head_overlay.plane = FLOAT_PLANE
		overlays_to_make += head_overlay
	if(!body)
		overlays = overlays_to_make
		return
	if(hatch_status == HATCH_OPEN || hatch_status == HATCH_BROKEN)
		var/image/door_overlay = image(icon = body.icon, icon_state = "[body.icon_state]_overlay_open")
		door_overlay.layer = MECH_COCKPIT_LAYER
		door_overlay.plane = FLOAT_PLANE
		overlays_to_make += door_overlay
	if(body.extra_overlays && (hatch_status == HATCH_CLOSED || hatch_status == HATCH_LOCKED))
		var/image/extra_overlays = image(icon = body.icon, icon_state = "[body.icon_state]_overlay_closed")
		extra_overlays.layer = MECH_COCKPIT_LAYER
		extra_overlays.plane = FLOAT_PLANE
		overlays_to_make += extra_overlays
	if(body.show_pilot_body)
		if(body.show_pilot_body == ALWAYS_SHOW_PILOT || (body.show_pilot_body == SHOW_PILOT_WHEN_OPEN && hatch_status == HATCH_OPEN))
			for(var/i in 1 to LAZYLEN(occupants))
				var/mob/pilot = occupants[i]
				var/image/draw_pilot = image(icon = pilot.icon, icon_state = pilot.icon_state)
				draw_pilot.appearance = pilot
				draw_pilot.layer = MECH_PILOT_LAYER //+ (body ? ((LAZYLEN(body.pilot_positions) - i) * 0.001) : 0)
				draw_pilot.plane = FLOAT_PLANE
				if(i <= LAZYLEN(body.pilot_positions))
					var/list/offsets = body.pilot_positions[i]["[dir]"]
					draw_pilot.pixel_x = offsets["x"]
					draw_pilot.pixel_y = offsets["y"]
				overlays_to_make += draw_pilot
	if(legs)
		var/image/legs_overlay = image(icon = legs.icon, icon_state = legs.icon_state)
		legs_overlay.layer = MECH_LEG_LAYER
		legs_overlay.plane = FLOAT_PLANE
		overlays_to_make += legs_overlay
	if(arms)
		var/image/arms_overlay = image(icon = arms.icon, icon_state = arms.icon_state)
		arms_overlay.layer = MECH_ARM_LAYER
		arms_overlay.plane = FLOAT_PLANE
		overlays_to_make += arms_overlay
	for(var/obj/item/mecha_parts/mecha_equipment/weapon/gun in flat_equipment)
		var/image/gun_overlays = image(icon = gun.overlay_icon, icon_state = gun.overlay_state)
		gun_overlays.layer = MECH_GEAR_LAYER
		gun_overlays.plane = FLOAT_PLANE
		overlays_to_make += gun_overlays

	for(var/obj/item/mecha_parts/mecha_equipment/weapon/gun in flat_equipment)
		var/image/gun_overlays = image(icon = gun.overlay_icon, icon_state = gun.overlay_state)
		gun_overlays.layer = MECH_GEAR_LAYER
		gun_overlays.plane = FLOAT_PLANE
		overlays_to_make += gun_overlays

	overlays = overlays_to_make
