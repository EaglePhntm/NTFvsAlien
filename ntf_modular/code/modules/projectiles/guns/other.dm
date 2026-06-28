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

// RPO-S, old VSD disposable rocket launcher, thermobaric firing.

/obj/item/weapon/gun/launcher/rocket/oneuse/thermobaric
	name = "\improper RPO-S Disposable Rocket Flamethrower"
	desc = "An old VSD design still in circulation after being produced by the millions back in the day and still being produced nowdays in the frontier, and by Kaizoku Zaibatsu who inherited the relatively simple, inexpensive design."
	icon = 'icons/obj/items/guns/special64.dmi'
	icon_state = "rpo"
	worn_icon_state = "rpo"
	max_shells = 1 //codex
	caliber = CALIBER_93MM //codex
	load_method = SINGLE_CASING //codex
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo_type = /obj/item/ammo_magazine/rocket/oneuse/thermobaric
	allowed_ammo_types = list(/obj/item/ammo_magazine/rocket/oneuse/thermobaric)
	reciever_flags = AMMO_RECIEVER_CLOSED|AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_AUTO_EJECT_LOCKED
	equip_slot_flags = ITEM_SLOT_BELT
	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_WIELDED_STABLE_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_DEPLOYED_FIRE_ONLY|GUN_SMOKE_PARTICLES
	attachable_allowed = list(/obj/item/attachable/magnetic_harness)
	/// Indicates extension state of the launcher. True: Fireable and unable to fit in storage. False: Able to fit in storage but must be extended to fire.

	dry_fire_sound = 'sound/weapons/guns/fire/launcher_empty.ogg'
	reload_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'
	unload_sound = 'sound/weapons/guns/interact/launcher_reload.ogg'
	attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 6, "rail_y" = 19, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
	fire_delay = 1 SECONDS
	scatter = -100

/obj/item/weapon/gun/launcher/rocket/oneuse/thermobaric/Initialize(mapload, spawn_empty)
	. = ..(mapload, FALSE)

// Do a short windup, swap the extension status of the rocket if successful, then swap the flags.
/obj/item/weapon/gun/launcher/rocket/oneuse/thermobaric/unique_action(mob/living/user)
	playsound(user, 'sound/weapons/guns/misc/oneuse_deploy.ogg', 25, 1)
	if(!do_after(user, 20, TRUE, src, BUSY_ICON_DANGER))
		return
	extended = !extended
	if(!extended)
		w_class = WEIGHT_CLASS_NORMAL
		gun_features_flags |= GUN_DEPLOYED_FIRE_ONLY
	else
		w_class = WEIGHT_CLASS_BULKY
		gun_features_flags &= ~GUN_DEPLOYED_FIRE_ONLY
	update_icon()

/obj/item/weapon/gun/launcher/rocket/oneuse/thermobaric/update_icon_state()
	. = ..()
	if(extended)
		icon_state = "[base_gun_icon]_extended"
	else
		icon_state = base_gun_icon

/obj/item/weapon/gun/launcher/rocket/oneuse/thermobaric/update_item_state()
	var/current_state = worn_icon_state

	worn_icon_state = "[base_gun_icon][extended ? "_extended" : ""][item_flags & WIELDED ? "_w" : ""]"

	if(current_state != worn_icon_state && ishuman(gun_user))
		var/mob/living/carbon/human/human_user = gun_user
		if(src == human_user.l_hand)
			human_user.update_inv_l_hand()
		else if (src == human_user.r_hand)
			human_user.update_inv_r_hand()
