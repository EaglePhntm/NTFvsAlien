/obj/item/weapon/shield/riot/marine/soulsteel
	name = "soulsteel ablative ballistic shield"
	desc = "An expensive, very heavy metal shield made of a metal only found in phantom city, almost one of a kind... Adept at blocking projectiles and lasers, better than a normal shield in every way. This will slow you down even more while holding it due how heavy it is."
	max_integrity = 500
	integrity_failure = 100
	soft_armor = list(MELEE = 40, BULLET = 70, LASER = 70, ENERGY = 60, BOMB = 30, BIO = 50, FIRE = 0, ACID = 15)
	hard_armor = list(MELEE = 0, BULLET = 5, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	color = COLOR_STRONG_VIOLET
	slowdown = 0.5

/obj/item/weapon/shield/riot/marine/soulsteel/equipped(mob/user, slot)
	if(!user.has_movespeed_modifier(type))
		user.add_movespeed_modifier(type, TRUE, 0, (item_flags & IMPEDE_JETPACK) ? SLOWDOWN_IMPEDE_JETPACK : NONE, TRUE, 0.7)
	. = ..()

/obj/item/weapon/shield/riot/marine/soulsteel/unequipped(mob/unequipper, slot)
	if(unequipper.has_movespeed_modifier(type))
		unequipper.remove_movespeed_modifier(type)
	. = ..()
