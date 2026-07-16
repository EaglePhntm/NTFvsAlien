/obj/item/mecha_parts/mecha_pieces/mecha_legs
	icon_state = "legs"

	var/movement_delay = 1 SECONDS
	var/turning_delay = 0.5 SECONDS
	var/crush_damage = 30
	var/stability = 10
	max_integrity = 200

	layer = MECH_LEG_LAYER

/obj/item/mecha_parts/mecha_pieces/mecha_legs/tracks
	icon_state = "tracks"

	movement_delay = 2 SECONDS
	turning_delay = 3 SECONDS
	stability = 50
	max_integrity = 200

/obj/item/mecha_parts/mecha_pieces/mecha_legs/heavy_legs
	icon_state = "heavy_legs"

	movement_delay = 3 SECONDS
	turning_delay = 1.5 SECONDS
	stability = 30
	max_integrity = 200

/obj/item/mecha_parts/mecha_pieces/mecha_legs/combat_legs
	icon_state = "combat_legs"

	movement_delay = 1.5 SECONDS
	turning_delay = 1 SECONDS
	stability = 20
	max_integrity = 100

/obj/item/mecha_parts/mecha_pieces/mecha_legs/light_legs
	icon_state = "heavy_legs"

	movement_delay = 1 SECONDS
	turning_delay = 1 SECONDS
	stability = 10
	max_integrity = 35

/obj/item/mecha_parts/mecha_pieces/mecha_legs/quadlegs
	icon_state = "spiderlegs"

	movement_delay = 2.5 SECONDS
	turning_delay = 0.5 SECONDS
	stability = 75
	max_integrity = 100

/obj/item/mecha_parts/mecha_pieces/mecha_legs/wheels
	icon_state = "wheels"

	movement_delay = 1.5 SECONDS
	turning_delay = 1.5 SECONDS
	stability = 50
	max_integrity = 100

/obj/item/mecha_parts/mecha_pieces/mecha_legs/loader_legs
	icon_state = "loader_legs"

	movement_delay = 3 SECONDS
	turning_delay = 2 SECONDS
	stability = 30
	max_integrity = 100
