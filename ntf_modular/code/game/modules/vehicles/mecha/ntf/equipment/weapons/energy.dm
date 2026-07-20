/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	icon_state = "lasermg"
	mech_flags = EXOSUIT_MODULE_NTF|EXOSUIT_MODULE_COMBAT
	max_integrity = 75
	harmful = TRUE
	fire_mode = GUN_FIREMODE_AUTOMATIC
	slowdown = 0

/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit/laser_rifle
	name = "\improper exosuit-mounted AER-9 laser rifle"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "A standard laser rifle, adapted to be mounted on an exosuit."
	fire_sound = 'sound/mecha/weapons/mech_laser_light.ogg'
	ammotype = /datum/ammo/energy/lasgun/marine
	energy_drain = 12
	variance = 0
	projectile_delay = 0.4 SECONDS

/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit/laser_scattershot
	name = "\improper exosuit-mounted tri-beam"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "An exosuit-mounted, tri-beam laser rifle. Fires a burst of three individual lasers, will melt you."
	fire_sound = 'sound/mecha/weapons/mech_laser_heavy.ogg'
	ammotype = /datum/ammo/bullet/shotgun/tribeam
	energy_drain = 24
	variance = 0
	projectile_delay = 0.7 SECONDS
