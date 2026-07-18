/obj/item/mecha_parts/mecha_pieces/mecha_legs
	icon_state = "legs"

	var/movement_delay = 1
	var/turning_delay = 0.5
	var/crush_damage = 30
	var/stability = 10
	var/pivot_step = FALSE
	var/tank_turns = FALSE
	var/can_strafe = TRUE
	var/can_move_diagonally = TRUE
	var/step_sound = 'sound/mecha/mechstep.ogg'
	var/turn_sound = 'sound/mecha/mechturn.ogg'
	max_integrity = 200

	type_of_piece = MECHA_LEGS

	layer = MECH_LEG_LAYER

/obj/item/mecha_parts/mecha_pieces/mecha_legs/tracks
	icon_state = "tracks"

	movement_delay = 2
	turning_delay = 3
	stability = 50
	max_integrity = 200
	pivot_step = TRUE
	tank_turns = TRUE
	can_move_diagonally = FALSE
	step_sound = 'ntf_modular/sound/effects/engine.ogg'
	turn_sound = 'sound/mecha/powerloader_turn2.ogg'

/obj/item/mecha_parts/mecha_pieces/mecha_legs/heavy_legs
	icon_state = "heavy_legs"

	movement_delay = 3
	turning_delay = 1.5
	stability = 30
	max_integrity = 200
	tank_turns = TRUE
	can_move_diagonally = FALSE

/obj/item/mecha_parts/mecha_pieces/mecha_legs/combat_legs
	icon_state = "combat_legs"

	movement_delay = 1.5
	turning_delay = 1
	stability = 20
	max_integrity = 150

/obj/item/mecha_parts/mecha_pieces/mecha_legs/light_legs
	icon_state = "heavy_legs"

	movement_delay = 1
	turning_delay = 1
	stability = 10
	max_integrity = 35

/obj/item/mecha_parts/mecha_pieces/mecha_legs/quadlegs
	icon_state = "spiderlegs"

	movement_delay = 2.5
	turning_delay = 0.5
	stability = 75
	max_integrity = 100
	pivot_step = TRUE

/obj/item/mecha_parts/mecha_pieces/mecha_legs/wheels
	icon_state = "wheels"

	movement_delay = 1.5
	turning_delay = 1.5
	stability = 50
	max_integrity = 100
	pivot_step = TRUE
	step_sound = 'ntf_modular/sound/effects/engine.ogg'
	turn_sound = 'sound/mecha/powerloader_turn2.ogg'

/obj/item/mecha_parts/mecha_pieces/mecha_legs/loader
	icon_state = "loader_legs"

	movement_delay = 3
	turning_delay = 2
	stability = 30
	max_integrity = 100

/obj/item/mecha_parts/mecha_pieces/mecha_legs/ultra
	icon_state = "ultra_legs"

	movement_delay = 2
	turning_delay = 2
	stability = 15
	max_integrity = 150
