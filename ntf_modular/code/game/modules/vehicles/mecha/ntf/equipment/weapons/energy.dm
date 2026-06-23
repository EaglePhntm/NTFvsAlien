/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit_laser
	name = "\improper exosuit-mounted AER-9 laser rifle"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "A standard laser rifle, adapted to be mounted on an exosuit."
	icon_state = "lasermg"
	fire_sound = 'sound/mecha/weapons/mech_laser_light.ogg'
	mech_flags = EXOSUIT_MODULE_NTF|EXOSUIT_MODULE_COMBAT
	ammotype = /datum/ammo/energy/lasgun/marine
	max_integrity = 75
	energy_drain = 12
	variance = 0
	projectile_delay = 0.4 SECONDS
	slowdown = 0
	harmful = TRUE
	fire_mode = GUN_FIREMODE_AUTOMATIC

/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit_tribeam
	name = "\improper exosuit-mounted tri-beam"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "An exosuit-mounted, tri-beam laser rifle. Fires a burst of three individual lasers, will melt you."
	icon_state = "lasermg"
	fire_sound = 'sound/mecha/weapons/mech_laser_heavy.ogg'
	mech_flags = EXOSUIT_MODULE_NTF|EXOSUIT_MODULE_COMBAT
	ammotype = /datum/ammo/bullet/shotgun/tribeam
	max_integrity = 75
	energy_drain = 24
	variance = 0
	projectile_delay = 0.7 SECONDS
	slowdown = 0
	harmful = TRUE
	fire_mode = GUN_FIREMODE_AUTOMATIC

/datum/ammo/bullet/shotgun/tribeam
	name = "tri-beam shell"
	handful_icon_state = "shotgun_buckshot"
	icon_state = "buckshot"
	hud_state = "shotgun_buckshot"
	bonus_projectiles_type = /datum/ammo/energy/lasgun/marine/mech/smg
	bonus_projectiles_amount = 3
	bonus_projectiles_scatter = 3
	accuracy_variation = 9
	accurate_range = 3
	max_range = 15
	damage = 0
	damage_falloff = 0
