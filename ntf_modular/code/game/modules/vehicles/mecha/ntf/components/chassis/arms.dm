/obj/item/mecha_parts/mecha_arms
	name = "arms"
	icon = 'icons/mecha/mecha_parts.dmi'
	icon_state = "arms"
	var/base_icon_state = "arms"

	var/melee_sound
	var/melee_damage = 20
	var/action_delay = 1 SECONDS
	var/action_power_usage = 10

	max_integrity = 100
	soft_armor = list(MELEE = 25, BULLET = 25, LASER = 25, ENERGY = 10, BOMB = 5, BIO = 0, FIRE = 50, ACID = 50)
