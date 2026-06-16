/obj/item/weapon/gun/pistol/xmdivider/ntc
	name = "\improper NT/105 'Unity' Revolver"
	desc = "NTC's special production replica of Intertech's one of a kind 'Divider' revolver, named Unity after reverse engineering a sample. Fires .357 and .357 Foxfire rounds, This model has no burst fire but it has greater stopping power than it's original. They indeed let it get into enemy hands."
	icon = 'ntf_modular/icons/obj/items/guns/pistols.dmi'
	icon_state = "nt105"
	worn_icon_state = "nt105"
	caliber = CALIBER_357 //codex
	max_shells = 6
	default_ammo_type = /obj/item/ammo_magazine/pistol/ntunity
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/xmdivider, /obj/item/ammo_magazine/pistol/xmdivider/ap, /obj/item/ammo_magazine/pistol/ntunity)
	force = 8
	attachable_allowed = list(
		/obj/item/attachable/bayonet/converted,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/compensator,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/lace,
	)
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 20, "rail_x" = 17, "rail_y" = 22, "under_x" = 29, "under_y" = 15, "stock_x" = 10, "stock_y" = 18)
	burst_amount = 1
	//gonna adjust for no burst fire.
	windup_delay = 0.2 SECONDS
	fire_delay = 0.2 SECONDS
	scatter_unwielded = 4
	scatter = 1
	damage_mult = 1.3
	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	recoil = 1
	recoil_unwielded = 5
	//no red dot, holo sight instead.
	accuracy_mult_unwielded = 0.8
	accuracy_mult = 1
	aim_speed_modifier = 0.50
	holstered_underlay_icon = 'ntf_modular/icons/obj/items/storage/holster.dmi'

//XM104 cylinder placed in pistols
/obj/item/ammo_magazine/pistol/ntunity
	name = "\improper NT105 'Unity' Foxfire cylinder (.357)"
	desc = "CC/104 cylinder loaded with custom .357 armor-piercing incendiary rounds."
	icon = 'ntf_modular/icons/obj/items/ammo/pistol.dmi' //same icon as parent so using that mag wont fuck the color illusion
	default_ammo = /datum/ammo/bullet/revolver/heavy/foxfire
	max_rounds = 6
	caliber = CALIBER_357
	icon_state = "nt105"
	icon_state_mini = "nt105"
	bonus_overlay = "nt105_fox"

/datum/ammo/bullet/revolver/heavy/foxfire
	name = "armor-piercing foxfire heavy revolver bullet"
	handful_amount = 6
	damage = 50
	penetration = 15
	sundering = 5
	ammo_behavior_flags = AMMO_INCENDIARY|AMMO_BALLISTIC

//mom i want a mateba, we got a mateba at home, mateba at home:
/datum/ammo/bullet/revolver/heavy/foxfire/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
    if(ishuman(target_mob))
        staggerstun(target_mob, proj, paralyze = 0, stun = 1 SECONDS, stagger = 1 SECONDS, slowdown = 1, knockback = 1)
    else
        staggerstun(target_mob, proj, paralyze = 1 SECONDS, stagger = 1 SECONDS, slowdown = 1, knockback = 1)

/obj/item/ammo_magazine/pistol/g22tranq
	name = "\improper P-22 Custom tranq magazine (9mm)"
	caliber = CALIBER_9X19_TRANQUILIZER
	icon_state = "g22"
	icon_state_mini = "mag_pistol_normal"
	max_rounds = 12
	default_ammo = /datum/ammo/bullet/pistol/tranq
/obj/item/ammo_magazine/pistol/c99t
	name = "\improper PK-9 tranq magazine (.22)"
	default_ammo = /datum/ammo/bullet/pistol/tranq/weak
	caliber = CALIBER_22LR
	icon_state = "pk-9_tranq"
	max_rounds = 8
	icon_state_mini = "mag_pistol_green"

/datum/ammo/bullet/pistol/tranq
	name = "tranq bullet"
	hud_state = "pistol_tranq"
	armor_type = "bullet"
	damage = 15
	shell_speed = 3.3
	shrapnel_chance = 0.2
	var/inject_amount_min = 5
	var/inject_amount_max = 8

/datum/ammo/bullet/pistol/tranq/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
	if(iscarbon(target_mob) && !isxeno(target_mob))
		var/mob/living/carbon/carbon_victim = target_mob
		carbon_victim.reagents.add_reagent(/datum/reagent/toxin/sleeptoxin, rand(inject_amount_min,inject_amount_max), no_overdose = TRUE)
	else if(isxeno(target_mob))
		var/mob/living/carbon/xenomorph/xtarg = target_mob
		xtarg.use_stun_health(proj.damage * (xtarg.xeno_caste.max_health/200))

/datum/ammo/bullet/pistol/tranq/weak
	name = "weak tranq bullet"
	damage = 10
	accuracy = -10 //like usual c99 ammo
	inject_amount_min = 3
	inject_amount_max = 5

/obj/item/weapon/gun/pistol/g22/tranq
	name = "\improper P-22 custom pistol"
	desc = "A 20th century military firearm customized for special forces use, fires chemical loaded bullets to take down enemies nonlethally. Must be cocked manually therefore has disgusting fire rate, but custom frame allows greater accuracy. This can be attached under a gun."
	icon = 'ntf_modular/icons/obj/items/guns/pistols.dmi'
	icon_state = "g22"
	worn_icon_state = "g22"
	fire_animation = null //it doesnt cycle itself.
	cock_animation = "g22_fire"
	cock_delay = 0.7 SECONDS
	caliber = CALIBER_9X19_TRANQUILIZER //codex
	max_shells = 13
	default_ammo_type = /obj/item/ammo_magazine/pistol/g22tranq
	allowed_ammo_types = list(/obj/item/ammo_magazine/pistol/g22tranq, /obj/item/ammo_magazine/pistol/g22)
	attachable_offset = list("muzzle_x" = 29, "muzzle_y" = 20,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 15, "stock_x" = 21, "stock_y" = 17)
	attachable_allowed = list(
		/obj/item/attachable/suppressor,
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/compensator,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/gyro,
		/obj/item/attachable/lace,
		/obj/item/attachable/motiondetector/advanced/pocket/covert,
	)
	starting_attachment_types = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/suppressor,
	)
	reciever_flags = AMMO_RECIEVER_MAGAZINES|AMMO_RECIEVER_REQUIRES_UNIQUE_ACTION|AMMO_RECIEVER_UNIQUE_ACTION_LOCKS
	cocked_message = "You rack the pistol"
	cock_locked_message = "The pistol is loaded! Fire it first!"
	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_IS_ATTACHMENT
	fire_delay = 0.7 SECONDS //manual cock anyway, meant to be able to not get obliterated up close too badly, unlike moonbeam.
	accuracy_mult = 1.8
	accuracy_mult_unwielded = 1.5
	burst_amount = 1
	akimbo_additional_delay = 0.9
	attach_delay = 3 SECONDS
	detach_delay = 3 SECONDS
	slot = ATTACHMENT_SLOT_UNDER

/obj/item/weapon/gun/pistol/g22/tranq/can_attach(obj/item/attaching_to, mob/attacher)
	if(!attachments_by_slot[ATTACHMENT_SLOT_RAIL])
		return TRUE
	to_chat(attacher, span_warning("You cannot attach [src] to [attaching_to] while [attachments_by_slot[ATTACHMENT_SLOT_RAIL]] occupies [src]'s rail slot."))
	return FALSE

/obj/item/weapon/gun/pistol/g22/tranq/on_attach(obj/item/attached_to, mob/user)
	gun_features_flags |= (GUN_WIELDED_STABLE_FIRING_ONLY|GUN_WIELDED_FIRING_ONLY)
	return ..()

/obj/item/weapon/gun/pistol/g22/tranq/on_detach(obj/item/attached_to, mob/user)
	gun_features_flags &= ~(GUN_WIELDED_STABLE_FIRING_ONLY|GUN_WIELDED_FIRING_ONLY)
	set_gun_user(user)
	return ..()

/obj/item/weapon/gun/pistol/m1911/custom/specops
	name = "\improper P-1911SO custom pistol"
	desc = "A handgun that has received an unholy amount of modifications. Lacks an auto magazine eject feature."
	default_ammo_type = /obj/item/ammo_magazine/pistol/m1911/ap
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/quickfire,
		/obj/item/attachable/lace,
		/obj/item/attachable/buildasentry,
		/obj/item/attachable/shoulder_mount,
		/obj/item/attachable/motiondetector/advanced/pocket/covert,
	)
	starting_attachment_types = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/suppressor,
	)
	accuracy_mult = 1.15
	accuracy_mult_unwielded = 0.95
	damage_mult = 1
