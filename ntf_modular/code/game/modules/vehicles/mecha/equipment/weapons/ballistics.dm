/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/small_lmg
	name = "\improper Coeus submachine gun"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "A mounted light machinegun chambered in 5.56x45mm NATO, offering a good combination of mobility and firepower."
	icon_state = "smg"
	muzzle_iconstate = "muzzle_flash"
	fire_sound = 'sound/mecha/weapons/mech_smg.ogg'
	mech_flags = EXOSUIT_MODULE_VENDABLE|EXOSUIT_MODULE_COMBAT
/*
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,12), "E" = list(54,14), "W" = list(-20,34)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,12), "E" = list(52,34), "W" = list(-22,14)),
	)
	flash_offsets_core = list(
		MECHA_R_ARM = list("N" = list(52,46), "S" = list(14,29), "E" = list(70,32), "W" = list(-13,34)),
		MECHA_L_ARM = list("N" = list(12,46), "S" = list(50,29), "E" = list(77,33), "W" = list(-8,32)),
	)
*/
	ammotype = /datum/ammo/bullet/rifle
	max_integrity = 75

	projectiles = 120
	projectiles_cache = 360
	projectiles_cache_max = 360
	variance = 15
	projectile_delay = 0 SECONDS
	slowdown = 0
	rearm_time = 1.5 SECONDS
	harmful = TRUE
	weight = 5
	ammo_type = MECHA_AMMO_556
	hud_icons = list("smg", "smg_empty")
	fire_mode = GUN_FIREMODE_AUTOMATIC
	cooldown_key = MECH_COOLDOWN_KEY_RAPIDFIRE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/small_smg
	name = "\improper Coeus submachine gun"
	icon = 'icons/mecha/mecha_equipment_64x32.dmi'
	desc = "A mounted submachinegun chambered in 4.6x30mm, it offers excellent portability and stability."
	icon_state = "smg"
	muzzle_iconstate = "muzzle_flash"
	fire_sound = 'sound/mecha/weapons/mech_smg.ogg'
	mech_flags = EXOSUIT_MODULE_VENDABLE|EXOSUIT_MODULE_COMBAT
/*
	flash_offsets = list(
		MECHA_R_ARM = list("N" = list(36,30), "S" = list(-2,12), "E" = list(54,14), "W" = list(-20,34)),
		MECHA_L_ARM = list("N" = list(-4,30), "S" = list(32,12), "E" = list(52,34), "W" = list(-22,14)),
	)
	flash_offsets_core = list(
		MECHA_R_ARM = list("N" = list(52,46), "S" = list(14,29), "E" = list(70,32), "W" = list(-13,34)),
		MECHA_L_ARM = list("N" = list(12,46), "S" = list(50,29), "E" = list(77,33), "W" = list(-8,32)),
	)
*/
	ammotype = /datum/ammo/bullet/smg/ap
	max_integrity = 75

	projectiles = 120
	projectiles_cache = 720
	projectiles_cache_max = 720
	variance = 15
	projectile_delay = 0 SECONDS
	slowdown = 0
	rearm_time = 2 SECONDS
	harmful = TRUE
	weight = 5
	ammo_type = MECHA_AMMO_46
	hud_icons = list("smg", "smg_empty")
	fire_mode = GUN_FIREMODE_AUTOMATIC
	cooldown_key = MECH_COOLDOWN_KEY_RAPIDFIRE
