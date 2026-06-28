//MINI-B 9MM //Based on the Minebea PM-9

/obj/item/weapon/gun/smg/minib
	name = "\improper MINI-B machinepistol"
	desc = "A niche classic refurbished and improved by Kaizoku Zaibatsu for bodyguards and field adjutants, the MINI-B is a take on the SMG-2 platform and uses specialized highpowered 9MM armor piercing munitions."
	icon = 'ntf_modular/icons/obj/items/guns/submachineguns.dmi'
	worn_icon_state = "minib"
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/guns/submachineguns_left_1.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/guns/submachineguns_right_1.dmi',
	)
	icon_state = "minib"
	caliber = CALIBER_9X19 //codex
	max_shells = 25 //codex
	w_class = WEIGHT_CLASS_NORMAL
	fire_sound = 'sound/weapons/guns/fire/uzi.ogg'
	unload_sound = 'sound/weapons/guns/interact/uzi_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/uzi_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/uzi_cocked.ogg'
	default_ammo_type = /obj/item/ammo_magazine/smg/minib
	allowed_ammo_types = list(/obj/item/ammo_magazine/smg/minib, /obj/item/ammo_magazine/smg/minib/extended)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/magnetic_harness,
	)
	attachable_offset = list("muzzle_x" = 28, "muzzle_y" = 23,"rail_x" = 11, "rail_y" = 27, "under_x" = 22, "under_y" = 18, "stock_x" = 22, "stock_y" = 16)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.15 SECONDS
	aim_speed_modifier = 0.75
	fire_delay = 0.1 SECONDS
	burst_delay =  0.15 SECONDS
	burst_amount = 5
	accuracy_mult = 1
	accuracy_mult_unwielded = 0.8
	scatter = 4
	scatter_unwielded = 8
	aim_slowdown = 0.15
	wield_delay = 0.4 SECONDS
	damage_mult = 1

/obj/item/weapon/gun/smg/minib/kzescort
	default_ammo_type = /obj/item/ammo_magazine/smg/minib/extended
	starting_attachment_types = list(/obj/item/attachable/reddot, /obj/item/attachable/gyro, /obj/item/attachable/suppressor,)

/obj/item/ammo_magazine/smg/minib
	name = "\improper MB9 magazine (9mm)"
	desc = "A magazine for the MINI-B machinepistol."
	caliber = CALIBER_9X19
	icon = 'ntf_modular/icons/obj/items/ammo/submachinegun.dmi'
	icon_state = "minib"
	icon_state_mini = "mag_smg_dark"
	max_rounds = 25
	default_ammo = /datum/ammo/bullet/smg/minibap

/obj/item/ammo_magazine/smg/minib/extended
	name = "\improper MB9 extended magazine (9mm)"
	desc = "An extended magazine for the MINI-B machinepistol."
	icon_state = "minib_ext"
	max_rounds = 42
	w_class = WEIGHT_CLASS_SMALL
	bonus_overlay = "minib_ext"
	icon_state_mini = "mag_smg_dark"

/datum/ammo/bullet/smg/minibap
	name = "specialized armor-piercing machinepistol bullet"
	hud_state = "smg_ap"
	damage = 25
	penetration = 12.5
	sundering = 0.5
	damage_falloff = 1
	accurate_range = 7
