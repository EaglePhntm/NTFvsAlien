/obj/vehicle/sealed/mecha/ntf/update_icon()
	.=..()
	var/list/overlays_to_make = list()
	for(var/obj/item/mecha_parts/mecha_pieces/pieces as anything in list(body, head, legs, arms))
		if(pieces)
			overlays_to_make += pieces

	if(body)
		var/image/cabin_overlay = image(icon = body.icon, icon_state = "[body.icon_state]")
		overlays_to_make += cabin_overlay

		if(hatch_status == HATCH_OPEN || hatch_status == HATCH_BROKEN)
			var/image/door_overlay = image(icon = body.icon, icon_state = "[body.icon_state]_overlay_open")
			door_overlay.layer = MECH_COCKPIT_LAYER
			overlays_to_make += door_overlay

		if(body.extra_overlays && (hatch_status == HATCH_CLOSED || hatch_status == HATCH_LOCKED))
			var/image/extra_overlays = image(icon = body.icon, icon_state = "[body.icon_state]_overlay")
			extra_overlays.layer = MECH_COCKPIT_LAYER+0.01
			overlays_to_make += extra_overlays

		for(var/obj/item/mecha_parts/mecha_equipment/weapon/gun in flat_equipment)
			var/image/gun_overlays = image(icon = gun.overlay_icon, icon_state = gun.overlay_state)
			gun_overlays.layer = MECH_GEAR_LAYER
			overlays_to_make += gun_overlays

	overlays = overlays_to_make
