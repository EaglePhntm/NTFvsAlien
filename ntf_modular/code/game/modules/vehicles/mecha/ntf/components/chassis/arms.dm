/obj/item/mecha_parts/mecha_pieces/mecha_arms
	name = "arms"
	icon_state = "arms"
	base_icon_state

	var/melee_sound
	var/melee_damage = 20
	var/action_delay = 1 SECONDS
	var/action_power_usage = 10

	type_of_piece = MECHA_ARMS

	layer = MECH_ARM_LAYER

	max_integrity = 100
	soft_armor = list(MELEE = 25, BULLET = 25, LASER = 25, ENERGY = 10, BOMB = 5, BIO = 0, FIRE = 50, ACID = 50)

/obj/item/mecha_parts/mecha_pieces/mecha_arms/loader
	name = "arms"
	desc = "The Xion Industrial Digital Interaction Manifolds allow you poke untold dangers from the relative safety of your cockpit."
	icon_state = "loader_arms"
//	melee_sound = 'sound/mecha/mech_punch.ogg'
	melee_damage = 20
	action_delay = 15
	action_power_usage = 10
	max_integrity = 70
	w_class = WEIGHT_CLASS_BULKY

/obj/item/mecha_parts/mecha_pieces/mecha_arms/light
	name = "light arms"
	desc = "As flexible as they are fragile, these Vey-Med manipulators can follow a pilot's movements in close to real time."
	icon_state = "light_arms"
//	melee_sound = 'sound/mecha/mech_punch_fast.ogg'
	action_delay = 10
	action_power_usage = 10
	max_integrity = 40

/obj/item/mecha_parts/mecha_pieces/mecha_arms/heavy
	name = "heavy arms"
	desc = "Designed to function where any other piece of equipment would have long fallen apart, the Hephaestus Superheavy Lifter series can take a beating and excel at delivering it."
	icon_state = "heavy_arms"
//	melee_sound = 'sound/mecha/mech_punch_slow.ogg'
	melee_damage = 30
	action_delay = 20
	action_power_usage = 60
	max_integrity = 90

/obj/item/mecha_parts/mecha_pieces/mecha_arms/combat
	name = "combat arms"
	desc = "Flexible, advanced manipulators built for combat."
	icon_state = "combat_arms"
	action_delay = 10
	action_power_usage = 50