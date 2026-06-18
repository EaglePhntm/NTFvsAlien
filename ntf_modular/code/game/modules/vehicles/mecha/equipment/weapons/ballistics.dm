/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/exosuit_lmg
	name = "\improper exosuit-mounted LMG"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "A mounted light machinegun chambered in 5.56x45mm NATO, offering a good combination of mobility and firepower."
	icon_state = "smg"
	muzzle_iconstate = "muzzle_flash"
	fire_sound = 'sound/mecha/weapons/mech_smg.ogg'
	mech_flags = EXOSUIT_MODULE_VENDABLE|EXOSUIT_MODULE_COMBAT
	ammotype = /datum/ammo/bullet/rifle
	max_integrity = 75

	projectiles = 120
	projectiles_cache = 360
	projectiles_cache_max = 360
	variance = 5
	projectile_delay = 0.4 SECONDS
	slowdown = 0
	rearm_time = 1.5 SECONDS
	harmful = TRUE
	weight = 5
	ammo_type = EXOSUIT_AMMO_LMG
	hud_icons = list("smg", "smg_empty")
	fire_mode = GUN_FIREMODE_AUTOMATIC
	cooldown_key = MECH_COOLDOWN_KEY_RAPIDFIRE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/exosuit_smg
	name = "\improper exosuit-mounted SMG"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "A mounted submachinegun chambered in 9x19 Parabellum, it offers excellent portability and stability."
	icon_state = "smg"
	muzzle_iconstate = "muzzle_flash"
	fire_sound = 'sound/mecha/weapons/mech_smg.ogg'
	mech_flags = EXOSUIT_MODULE_VENDABLE|EXOSUIT_MODULE_COMBAT
	ammotype = /datum/ammo/bullet/smg
	max_integrity = 75

	projectiles = 120
	projectiles_cache = 720
	projectiles_cache_max = 720
	variance = 10
	projectile_delay = 0.2 SECONDS
	slowdown = 0
	rearm_time = 2 SECONDS
	harmful = TRUE
	weight = 5
	ammo_type = EXOSUIT_AMMO_SMG
	hud_icons = list("smg", "smg_empty")
	fire_mode = GUN_FIREMODE_AUTOMATIC
	cooldown_key = MECH_COOLDOWN_KEY_RAPIDFIRE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/exosuit_gl
	name = "\improper exosuit-mounted grenade launcher"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "A exosuit-mounted four-barrel grenade launcher, chambered in low-pressure, high-explosive 40mm grenades."
	icon_state = "smg"
	muzzle_iconstate = "muzzle_flash"
	fire_sound = 'sound/mecha/weapons/mech_smg.ogg'
	mech_flags = EXOSUIT_MODULE_VENDABLE|EXOSUIT_MODULE_COMBAT
	ammotype = /datum/ammo/grenade_container
	max_integrity = 75

	projectiles = 4
	projectiles_cache = 34
	projectiles_cache_max = 34
	variance = 5
	projectile_delay = 1.5 SECONDS
	slowdown = 0
	rearm_time = 5 SECONDS
	harmful = TRUE
	weight = 5
	ammo_type = EXOSUIT_AMMO_GRENADE
	hud_icons = list("smg", "smg_empty")
	fire_mode = GUN_FIREMODE_AUTOMATIC
	cooldown_key = MECH_COOLDOWN_KEY_RAPIDFIRE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/exosuit_br
	name = "\improper exosuit-mounted battle rifle"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "A mounted battle rifle chambered in 7.62x51mm NATO, it offers good precision and stopping power."
	icon_state = "smg"
	muzzle_iconstate = "muzzle_flash"
	fire_sound = 'sound/mecha/weapons/mech_smg.ogg'
	mech_flags = EXOSUIT_MODULE_VENDABLE|EXOSUIT_MODULE_COMBAT
	ammotype = /datum/ammo/bullet/rifle/mpi_km
	max_integrity = 75

	projectiles = 60
	projectiles_cache = 180
	projectiles_cache_max = 180
	variance = 2
	projectile_delay = 0.7 SECONDS
	slowdown = 0
	rearm_time = 3 SECONDS
	harmful = TRUE
	weight = 5
	ammo_type = EXOSUIT_AMMO_BATTLERIFLE
	hud_icons = list("smg", "smg_empty")
	fire_mode = GUN_FIREMODE_AUTOMATIC
	cooldown_key = MECH_COOLDOWN_KEY_RAPIDFIRE
