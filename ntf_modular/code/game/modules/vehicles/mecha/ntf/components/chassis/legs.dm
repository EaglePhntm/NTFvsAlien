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

	var/flip_position = FRONT_POSITION

	type_of_piece = MECHA_LEGS

	layer = MECH_LEG_LAYER

/obj/item/mecha_parts/mecha_pieces/mecha_legs/tracks
	icon_state = "tracks"
	repair_materials = list(STEEL = SECONDARY_REPAIR_AMT, PLASTEEL = SECONDARY_REPAIR_AMT)
	movement_delay = 2
	turning_delay = 3
	stability = 50
	max_integrity = 200
	pivot_step = TRUE
	tank_turns = TRUE
	can_strafe = FALSE
	can_move_diagonally = FALSE
	flip_position = SIDE_POSITION
	step_sound = 'ntf_modular/sound/effects/engine.ogg'
	turn_sound = 'sound/mecha/powerloader_turn2.ogg'
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 25, BOMB = 25, BIO = 0, FIRE = 90, ACID = 75)

/obj/item/mecha_parts/mecha_pieces/mecha_legs/heavy_legs
	icon_state = "heavy_legs"
	repair_materials = list(STEEL = SECONDARY_REPAIR_AMT, PLASTEEL = SECONDARY_REPAIR_AMT)
	movement_delay = 3
	turning_delay = 1.5
	stability = 30
	max_integrity = 200
	tank_turns = TRUE
	can_move_diagonally = FALSE
	soft_armor = list(MELEE = 70, BULLET = 60, LASER = 50, ENERGY = 10, BOMB = 15, BIO = 0, FIRE = 75, ACID = 75)

/obj/item/mecha_parts/mecha_pieces/mecha_legs/combat_legs
	icon_state = "combat_legs"
	repair_materials = list(STEEL = SECONDARY_REPAIR_AMT, PLASTEEL = TERTIARY_REPAIR_AMT)
	movement_delay = 1.5
	turning_delay = 1
	stability = 20
	max_integrity = 150
	soft_armor = list(MELEE = 50, BULLET = 40, LASER = 40, ENERGY = 10, BOMB = 10, BIO = 0, FIRE = 50, ACID = 50)

/obj/item/mecha_parts/mecha_pieces/mecha_legs/light_legs
	icon_state = "light_legs"
	repair_materials = list(STEEL = SECONDARY_REPAIR_AMT)
	movement_delay = 1
	turning_delay = 1
	stability = 10
	max_integrity = 35
	soft_armor = list(MELEE = 25, BULLET = 5, LASER = 10, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 25, ACID = 25)

/obj/item/mecha_parts/mecha_pieces/mecha_legs/quadlegs
	icon_state = "spiderlegs"
	repair_materials = list(STEEL = SECONDARY_REPAIR_AMT, PLASTEEL = TERTIARY_REPAIR_AMT)
	movement_delay = 2.5
	turning_delay = 0.5
	stability = 75
	max_integrity = 125
	flip_position = SIDE_POSITION
	pivot_step = TRUE
	soft_armor = list(MELEE = 40, BULLET = 30, LASER = 40, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 75, ACID = 50)

/obj/item/mecha_parts/mecha_pieces/mecha_legs/wheels
	icon_state = "wheels"
	repair_materials = list(STEEL = SECONDARY_REPAIR_AMT)
	movement_delay = 1.5
	turning_delay = 1.5
	stability = 50
	max_integrity = 100
	pivot_step = TRUE
	flip_position = SIDE_POSITION
	step_sound = 'ntf_modular/sound/effects/engine.ogg'
	turn_sound = 'sound/mecha/powerloader_turn2.ogg'
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 40, ENERGY = 25, BOMB = 5, BIO = 0, FIRE = 25, ACID = 25)

/obj/item/mecha_parts/mecha_pieces/mecha_legs/loader
	icon_state = "loader_legs"
	repair_materials = list(STEEL = SECONDARY_REPAIR_AMT)
	movement_delay = 3
	turning_delay = 2
	stability = 30
	max_integrity = 100
	soft_armor = list(MELEE = 50, BULLET = 40, LASER = 40, ENERGY = 0, BOMB = 5, BIO = 0, FIRE = 50, ACID = 50)

/obj/item/mecha_parts/mecha_pieces/mecha_legs/ultra
	icon_state = "ultra_legs"
	repair_materials = list(PLASTEEL = SECONDARY_REPAIR_AMT, URANIUM = TERTIARY_REPAIR_AMT)
	movement_delay = 2
	turning_delay = 2
	stability = 15
	max_integrity = 150
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 15, BOMB = 10, BIO = 0, FIRE = 50, ACID = 50)
