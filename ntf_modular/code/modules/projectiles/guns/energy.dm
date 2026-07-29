/obj/item/weapon/gun/energy/lasgun/lasrifle/plasma_kz/kpx
	name = "\improper KPX/47 Spectra"
	desc = "Kaizoku Plasma eXperimental branded plasma rifle built on reworked volkite induction tech, optimized to fire focused purple beams with excellent accuracy. Designed for adaptable field use and compatible with an extended range of attachments."
	icon = 'ntf_modular/icons/obj/items/guns/energy64.dmi'
	icon_state = "spectra"
	worn_icon_state = "spectra"
	ammo_level_icon = ""
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	fire_sound = 'sound/weapons/guns/fire/volkite_1.ogg'
	dry_fire_sound = 'sound/weapons/guns/misc/error.ogg'
	unload_sound = 'sound/weapons/guns/interact/volkite_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/volkite_reload.ogg'
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/guns/energy_left_64.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/guns/energy_right_64.dmi',
	)
	fire_sound = 'sound/weapons/guns/fire/volkite_3.ogg'
	max_shots = 40
	ammo_datum_type = /datum/ammo/energy/volkite/kz_plasma
	rounds_per_shot = 36
	default_ammo_type = /obj/item/cell/lasgun/volkite
	gun_firemode = GUN_FIREMODE_AUTOMATIC
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_ENERGY|GUN_AMMO_COUNT_BY_SHOTS_REMAINING|GUN_SHOWS_LOADED
	allowed_ammo_types = list(
		/obj/item/cell/lasgun/volkite,
	)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet/converted,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/som,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/pistol/g22/tranq,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/buildasentry,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/shoulder_mount,
	)
	attachable_offset = list("muzzle_x" = 48, "muzzle_y" = 21,"rail_x" = 14, "rail_y" = 24, "under_x" = 42, "under_y" = 13, "stock_x" = 22, "stock_y" = 12)
	accuracy_mult = 1
	accuracy_mult_unwielded = 0.4
	aim_slowdown = 0.6
	damage_falloff_mult = 0.5
	scatter = 2
	scatter_unwielded = 25
	recoil_unwielded = 5
	wield_delay = 0.9 SECONDS
	fire_delay = 0.25 SECONDS


/datum/ammo/energy/volkite/kz_plasma
	name = "superheated plasma energy bolt"
	icon_state = "disablershot"
	hud_state = "laser_heat"
	hud_state_empty = "battery_empty_flash"
	ammo_behavior_flags = AMMO_ENERGY|AMMO_SOUND_PITCH
	bullet_color = COLOR_VIOLET
	armor_type = ENERGY
	max_range = 26
	accurate_range = 15
	shell_speed = 3.5
	accuracy_variation = 3
	damage = 30 //No fire burst so maybe fine.
	sundering = 2.5
	deflagrate_mult = 0

/datum/ammo/energy/plasma_dmr
	name = "ionized plasma bolt"
	icon_state = "overchargedlaser_green"
	hud_state = "electrothermal"
	hud_state_empty = "electrothermal_empty"
	damage = 50
	accurate_range = 11
	max_range = 22
	penetration = 7
	shell_speed = 3.5
	damage_falloff = 2
	ammo_behavior_flags = AMMO_ENERGY|AMMO_INCENDIARY|AMMO_TARGET_TURF
	bullet_color = LIGHT_COLOR_ELECTRIC_GREEN

	///Fire burn time
	var/burn_time = 15
	///Fire damage
	var/burn_damage = 10
	///Fire color
	var/fire_color = "green"

/datum/ammo/energy/plasma_dmr/proc/drop_fire(atom/target, atom/movable/projectile/proj)
	var/turf/target_turf = get_turf(target)
	var/burn_mod = 1
	if(istype(target_turf, /turf/closed/wall))
		burn_mod = 3
	target_turf.ignite(burn_time, burn_damage * burn_mod, fire_color)

	for(var/mob/living/mob_caught in target_turf)
		if(mob_caught.stat == DEAD || mob_caught == target)
			continue
		mob_caught.adjust_fire_stacks(burn_damage)
		mob_caught.IgniteMob()

/datum/ammo/energy/plasma_dmr/on_hit_turf(turf/target_turf, atom/movable/projectile/proj)
	drop_fire(target_turf, proj)

/datum/ammo/energy/plasma_dmr/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
	drop_fire(target_mob, proj)

/datum/ammo/energy/plasma_dmr/on_hit_obj(obj/target_obj, atom/movable/projectile/proj)
	drop_fire(target_obj, proj)

/datum/ammo/energy/plasma_dmr/do_at_max_range(turf/target_turf, atom/movable/projectile/proj)
	drop_fire(target_turf, proj)

//PMR-14 Plasma Marksman Rifle
/obj/item/weapon/gun/rifle/plasma_dmr
	name = "\improper PMR-14 plasma marksman rifle"
	desc = "An experimental weapon designed to set the terrain and targets on fire. It hums with power as magnetic fields coil round each other. This is the Designated Marksman Rifle variant of the series with twenty bolts and higher projectile velocity."
	icon = 'ntf_modular/icons/obj/items/guns/energy64.dmi'
	icon_state = "lamplighter"
	worn_icon_state = "lamplighter"
	ammo_level_icon = ""
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/guns/energy_left_64.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/guns/energy_right_64.dmi',
	)
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	caliber = CALIBER_PLASMA
	max_shots = 20
	reload_sound = 'sound/weapons/guns/interact/tp14_reload.ogg'
	fire_sound = 'sound/weapons/guns/fire/laser3.ogg'
	default_ammo_type = /obj/item/ammo_magazine/rifle/plasma_dmr
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/plasma_dmr)
	type_of_casings = null
	attachable_offset = list("muzzle_x" = 48, "muzzle_y" = 18,"rail_x" = 25, "rail_y" = 22, "under_x" = 30, "under_y" = 15, "stock_x" = 21, "stock_y" = 17)
	attachable_allowed = list(
		/obj/item/attachable/bayonet/converted,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/som,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/gyro,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini/dmr,
		/obj/item/attachable/motiondetector,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/shotgun/combat/masterkey,
		/obj/item/weapon/gun/pistol/g22/tranq,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/grenade_launcher/underslung,
		/obj/item/attachable/buildasentry,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
		/obj/item/weapon/gun/flamer/hydro_cannon,
		/obj/item/attachable/shoulder_mount,
	)

	muzzleflash_iconstate = "muzzle_flash_laser"
	gun_features_flags = GUN_CAN_POINTBLANK|GUN_ENERGY|GUN_AMMO_COUNTER|GUN_IS_ATTACHMENT|GUN_SMOKE_PARTICLES|GUN_SHOWS_LOADED
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_AUTO_EJECT|AMMO_RECIEVER_DO_NOT_EJECT_HANDFULS|AMMO_RECIEVER_CYCLE_ONLY_BEFORE_FIRE
	actions_types = list()
	wield_delay = 1.5 SECONDS
	muzzle_flash_color = COLOR_GREEN

	aim_slowdown = 0.5
	fire_delay = 1 SECONDS
	scatter_unwielded = 20
	recoil = 0
	recoil_unwielded = 2

/obj/item/ammo_magazine/rifle/plasma_dmr
	name = "\improper PMR-14 plasma cell"
	desc = "An energy cell for the PMR-14 plasma marksman rifle."
	icon = 'ntf_modular/icons/obj/items/ammo/rifle.dmi'
	caliber = CALIBER_PLASMA
	icon_state = "lamplighter"
	max_rounds = 20
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/energy/plasma_dmr
	magazine_flags = NONE
	icon_state_mini = "mag_plasma"
