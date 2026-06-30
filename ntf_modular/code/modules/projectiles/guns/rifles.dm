//non lethal edition of SR-127, meant to be slightly better.
/obj/item/weapon/gun/rifle/chambered/nonlethal
	name = "\improper NTC 'Moonbeam' NL sniper rifle"
	desc = "A light framed custom made bolt action rifle used by the NTC Specops, featuring a night vision scope and integrated IFF system... It is only able to fire non lethal rounds designed for it. In cases you wanna be an asshole. Through careful aim allows fire support from behind allies. It can have more types of attachments than standard sniper rifles. Uses 8.6×70mm magazines. Can also shoot regular ammo."
	icon = 'ntf_modular/icons/obj/items/guns/marksman64.dmi'
	gun_crosshair = 'icons/UI_Icons/gun_crosshairs/sniper.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	worn_icon_state = "moonbeam"
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/guns/marksman_left_64.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/guns/marksman_right_64.dmi',
		slot_s_store_str = 'ntf_modular/icons/mob/clothing/back.dmi',
		slot_back_str = 'ntf_modular/icons/mob/clothing/back.dmi',
	)
	icon_state = "moonbeam"
	cock_animation = "moonbeam_cock"
	caliber = CALIBER_86X70 //codex
	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES|GUN_IFF
	default_ammo_type = /obj/item/ammo_magazine/rifle/chamberedrifle/tranq
	wield_delay = 0.6 SECONDS //0.8 with stock
	cock_delay = 0.5 SECONDS
	fire_delay = 1.15 SECONDS
	aim_slowdown = 0.5
	recoil = 2 //0 with stock
	recoil_unwielded = 4 //2 with stock
	attachable_allowed = list(
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/nightvision,
		/obj/item/attachable/scope/optical,
		/obj/item/attachable/stock/tl127stock,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/stock/tl127stock/moonbeam,
		/obj/item/attachable/bayonet/converted,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/flashlight/under,
		/obj/item/weapon/gun/pistol/plasma_pistol,
		/obj/item/weapon/gun/flamer/mini_flamer,
		/obj/item/weapon/gun/rifle/pepperball/pepperball_mini,
	)

	starting_attachment_types = list(
	)

	attachable_offset = list("muzzle_x" = 40, "muzzle_y" = 19,"rail_x" = 10, "rail_y" = 25, "under_x" = 33, "under_y" = 16, "stock_x" = 8, "stock_y" = 12)

	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/chamberedrifle/tranq,
		/obj/item/ammo_magazine/rifle/chamberedrifle,
		/obj/item/ammo_magazine/rifle/chamberedrifle/flak,
		/obj/item/ammo_magazine/rifle/chamberedrifle/bluescreen,
	)

/obj/item/weapon/gun/rifle/chambered/nonlethal/fitted
	starting_attachment_types = list(
		/obj/item/attachable/scope/nightvision,
		/obj/item/attachable/stock/tl127stock/moonbeam,
	)

/obj/item/attachable/stock/tl127stock/moonbeam
	name = "\improper Moonbeam stock"
	desc = "A specialized stock for the Moonbeam"
	icon = 'ntf_modular/icons/obj/items/guns/attachments/stock.dmi'
	icon_state = "moonbeam"
	attach_features_flags = ATTACH_REMOVABLE
	wield_delay_mod = 0.2 SECONDS
	accuracy_mod = 0.15
	recoil_mod = -2
	scatter_mod = -2

/obj/item/ammo_magazine/rifle/chamberedrifle/tranq
	name = "Moonbeam NL sniper rifle tranq magazine"
	desc = "A box magazine filled with 8.6x70mm tranq rifle rounds for the Moonbeam."
	caliber = CALIBER_86X70
	icon_state = "moonbeam_tranq"
	icon_state_mini = "mag_moonbeam_tranq"
	icon = 'ntf_modular/icons/obj/items/ammo/sniper.dmi'
	default_ammo = /datum/ammo/bullet/sniper/pfc/nl
	max_rounds = 10
	bonus_overlay = "moonbeam_tranq"

/obj/item/ammo_magazine/rifle/chamberedrifle/bluescreen
	name = "Moonbeam NL sniper rifle bluescreen magazine"
	desc = "A box magazine filled with 8.6x70mm bluescreen rifle rounds for the Moonbeam, blunt rounds with an electric payload, effective for capturing nonorganic personnel, works on organics too... hardly"
	caliber = CALIBER_86X70
	icon_state = "moonbeam_bs"
	icon_state_mini = "mag_moonbeam_bs"
	icon = 'ntf_modular/icons/obj/items/ammo/sniper.dmi'
	default_ammo = /datum/ammo/bullet/sniper/pfc/bluescreen
	max_rounds = 10
	bonus_overlay = "moonbeam_bs"

/datum/ammo/bullet/sniper/pfc/nl
	name = "high caliber tranq rifle bullet"
	hud_state = "sniper_heavy"
	damage = 50
	damage_falloff = 0.1
	shrapnel_chance = 2

/datum/ammo/bullet/sniper/pfc/nl/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
	if(iscarbon(target_mob) && !isxeno(target_mob))
		var/mob/living/carbon/carbon_victim = target_mob
		carbon_victim.reagents.add_reagent(/datum/reagent/toxin/sleeptoxin, rand(8,10), no_overdose = TRUE)
		carbon_victim.add_slowdown(0.2,1)
	else if(isxeno(target_mob))
		var/mob/living/carbon/xenomorph/xtarg = target_mob
		xtarg.use_stun_health(proj.damage * (xtarg.xeno_caste.max_health/200))
		xtarg.add_slowdown(0.2,1)

/datum/ammo/bullet/sniper/pfc/bluescreen
	name = "high caliber bluescreen rifle bullet"
	hud_state = "sniper_heavy"
	damage = 50
	penetration = 10
	damage_falloff = 0.1
	shrapnel_chance = 1

/datum/ammo/bullet/sniper/pfc/bluescreen/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
	. = ..()
	//no emp on robot they had enough
	do_sparks(3, TRUE, target_mob)
	if(!ishuman(target_mob))
		return
	var/mob/living/carbon/human/human_victim = target_mob
	if(human_victim.species.species_flags & ROBOTIC_LIMBS)
		human_victim.adjustStaminaLoss(proj.damage)
		human_victim.add_slowdown(0.2,1)
		human_victim.AdjustStun(0.3 SECONDS)
		if(human_victim.getStaminaLoss() > 20)
			human_victim.overlay_fullscreen_timer(human_victim.getStaminaLoss(), 10, "glitch", /atom/movable/screen/fullscreen/robot_glitch)
		if((human_victim.getStaminaLoss() >= human_victim.maxHealth*2) && !human_victim.IsUnconscious())
			human_victim.ParalyzeNoChain(15 SECONDS) //fake unconscious basically
			human_victim.AdjustMute(15 SECONDS)
			human_victim.overlay_fullscreen_timer(15 SECONDS, 10, "bluescreen", /atom/movable/screen/fullscreen/dead/robot)
			human_victim.visible_message(span_warning("[human_victim] shudders violently whilst spitting out error text before collapsing, flailing on the ground randomly."), span_blue("You are bluescreening, but you should be able to recover from this by rebooting automatically in about 15s."), span_notice("You hear a clanker glitching."))
	else
		if(prob(50))
			empulse(target_mob.loc, 0,0,0,1)
		human_victim.adjustStaminaLoss(proj.damage/2)
		human_victim.AdjustStun(0.2 SECONDS)
		human_victim.jitter(3)
		human_victim.add_slowdown(0.1,1)
		human_victim.visible_message(span_warning("[human_victim] shakes with an electric shock!"), span_warning("You feel lightning mess up your nerves, locking your body!"), span_notice("You hear a clanker glitching."))

/datum/ammo/bullet/sniper/pfc/bluescreen/on_hit_obj(obj/target_obj, atom/movable/projectile/proj)
	. = ..()
	if(prob(50))
		empulse(target_obj.loc, 0,0,0,1)
	do_sparks(3, TRUE, target_obj)

/datum/ammo/bullet/sniper/pfc/bluescreen/on_hit_turf(turf/target_turf, atom/movable/projectile/proj)
	. = ..()
	if(prob(50))
		empulse(target_turf, 0,0,0,1)
	do_sparks(3, TRUE, target_turf)

/obj/item/ammo_magazine/packet/p86x70mm/tranq
	name = "box of 8.6x70mm tranq"
	desc = "A box containing 50 rounds of 8.6x70mm caseless tranq."
	caliber = CALIBER_86X70
	icon_state = "86x70mm"
	default_ammo = /datum/ammo/bullet/sniper/pfc/nl
	current_rounds = 50
	max_rounds = 50


//halter bullpup rifle
/obj/item/weapon/gun/rifle/nt_halter
	name = "\improper NT 'Halter' assault rifle"
	desc = "The standardized NTC bullpup AR design made to be used as their default primary firearm Chambered in 7.62x38mm."
	icon = 'ntf_modular/icons/obj/items/guns/rifles64.dmi'
	icon_state = "halter"
	worn_icon_state = "halter"
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/guns/rifles_left_64.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/guns/rifles_right_64.dmi',
		slot_s_store_str = 'ntf_modular/icons/mob/clothing/back.dmi',
		slot_back_str = 'ntf_modular/icons/mob/clothing/back.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	fire_sound = 'sound/weapons/guns/fire/famas.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/m41a_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/m41a_reload.ogg'
	cocked_sound = 'sound/weapons/guns/interact/m16_cocked.ogg'
	caliber = CALIBER_762X38 //codex
	max_shells = 36 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle/nt_halter
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/nt_halter,
		/obj/item/ammo_magazine/rifle/nt_halter/extended,
		/obj/item/ammo_magazine/rifle/nt_halter/drum,
		/obj/item/ammo_magazine/rifle/nt_halter/charged,
		/obj/item/ammo_magazine/rifle/nt_halter/smart,
		/obj/item/ammo_magazine/rifle/nt_halter/foxfire,
		/obj/item/ammo_magazine/rifle/nt_halter/laser,
		/obj/item/ammo_magazine/rifle/nt_halter/laser/extended,
		/obj/item/ammo_magazine/rifle/nt_halter/laser/drum,
		/obj/item/ammo_magazine/rifle/nt_halter/rubber,
		/obj/item/ammo_magazine/rifle/nt_halter/rubber/extended,
	)
	attachable_allowed = list(
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet/converted,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/som,
		/obj/item/attachable/compensator,
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

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC) //no twink ass firemodes, like god intended
	attachable_offset = list("muzzle_x" = 51, "muzzle_y" = 19,"rail_x" = 25, "rail_y" = 23, "under_x" = 35, "under_y" = 13, "stock_x" = 0, "stock_y" = 13)
	fire_delay = 0.2 SECONDS
	burst_amount = 1
	burst_delay = 0.15 SECONDS
	wield_delay = 0.7 SECONDS
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_slowdown = 0.4
	akimbo_scatter_mod = 24
	akimbo_additional_delay = 0.8
	aim_speed_modifier = 3
	scatter = -1
	scatter_unwielded = 18
	accuracy_mult_unwielded = 0.8

/obj/item/weapon/gun/rifle/nt_halter/cqb
	name = "\improper NT 'Halter-CQB' carbine"
	desc = "A variant of Halter series standardized NTC bullpup AR design made into a carbine, Chambered in 7.62x38mm. This one is altered for close combat. The smaller frame make it lighter and easier to handle in close range encounters but it suffers from range reduction and overall accuracy."
	icon = 'ntf_modular/icons/obj/items/guns/rifles64.dmi'
	attachable_offset = list("muzzle_x" = 39, "muzzle_y" = 19,"rail_x" = 19, "rail_y" = 23, "under_x" = 29, "under_y" = 13, "stock_x" = 0, "stock_y" = 13)
	icon_state = "haltercqb"
	worn_icon_state = "haltercqb"
	fire_delay = 0.15 SECONDS
	aim_speed_modifier = 2.5
	aim_slowdown = 0.3
	scatter = 8
	accuracy_mult = 0.9
	scatter_unwielded = 14
	wield_delay = 0.4 SECONDS
	damage_falloff_mult = 1
	akimbo_additional_delay = 1.5
	damage_mult = 0.9

/obj/item/weapon/gun/rifle/nt_halter/cqb/elite
	name = "\improper NT 'Halter-CQB-E' carbine"
	desc = "A custom variant of Halter series though not obvious from the outside, Chambered in 7.62x38mm. This one is retrofitted with custom, expensive materials and modifications that allow it to be more accurate with longer effective range yet be even lighter."
	accuracy_mult = 1
	scatter = 6
	aim_speed_modifier = 2
	wield_delay = 0.3 SECONDS
	damage_falloff_mult = 0.7
	damage_mult = 1

//standard mag
/obj/item/ammo_magazine/rifle/nt_halter
	name = "\improper NT 'Halter' magazine (7.62x38mm)"
	desc = "A magazine filled with 7.62x38mm rifle rounds for the Halter series of firearms."
	caliber = CALIBER_762X38
	icon_state = "halter"
	icon = 'ntf_modular/icons/obj/items/ammo/rifle.dmi'
	bonus_overlay = "halter_mag"
	default_ammo = /datum/ammo/bullet/rifle/heavy/halter
	max_rounds = 36
	aim_speed_mod = 0.1
	wield_delay_mod = 0.1 SECONDS

/datum/ammo/bullet/rifle/heavy/halter
	name = "heavy rifle bullet"

//extended mag
/obj/item/ammo_magazine/rifle/nt_halter/extended
	name = "\improper NT 'Halter' extended magazine (7.62x38mm)"
	desc = "An extended magazine filled with 7.62x38mm rifle rounds for the Halter series of firearms."
	max_rounds = 50
	icon_state = "halter_ex"
	bonus_overlay = "halter_ex"
	aim_speed_mod = 0.2
	wield_delay_mod = 0.2 SECONDS

//drum mag
/obj/item/ammo_magazine/rifle/nt_halter/drum
	name = "\improper NT 'Halter' drum magazine (7.62x38mm)"
	desc = "An drum magazine filled with 7.62x38mm rifle rounds for the Halter series of firearms."
	max_rounds = 80
	icon_state = "halter_drum"
	bonus_overlay = "halter_drum"
	aim_speed_mod = 0.3
	wield_delay_mod = 0.3 SECONDS

//emp mag
/obj/item/ammo_magazine/rifle/nt_halter/charged
	name = "\improper NT 'Halter' taser magazine (7.62x38mm Taser)"
	desc = "A magazine filled with specialized 7.62x38mm rifle rounds to deliver a powerful shock ontop of blunt force, for the Halter series of firearms."
	icon_state = "halter_charged"
	bonus_overlay = "halter_charged"
	max_rounds = 24
	default_ammo = /datum/ammo/bullet/rifle/heavy/halter/charged

/datum/ammo/bullet/rifle/heavy/halter/charged
	name = "heavy shocking rifle bullet"
	hud_state = "rifle_ap"
	damage = 20
	penetration = 5
	damage_type = BRUTE
	sundering = 2
	shrapnel_chance = 2
	bullet_color = COLOR_BRIGHT_BLUE
	var/emp_chance = 15

/datum/ammo/bullet/rifle/heavy/halter/charged/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
	. = ..()
	do_sparks(3, TRUE, target_mob)
	if(!ishuman(target_mob))
		return
	var/mob/living/carbon/human/human_victim = target_mob
	if(human_victim.species.species_flags & ROBOTIC_LIMBS)
		human_victim.adjustStaminaLoss(proj.damage)
		human_victim.add_slowdown(0.2,1)
		human_victim.AdjustStun(0.1 SECONDS)
		if(human_victim.getStaminaLoss() > 20)
			human_victim.overlay_fullscreen_timer(human_victim.getStaminaLoss(), 10, "glitch", /atom/movable/screen/fullscreen/robot_glitch)
		if((human_victim.getStaminaLoss() >= human_victim.maxHealth*2) && !human_victim.IsUnconscious())
			human_victim.ParalyzeNoChain(15 SECONDS) //fake unconscious basically
			human_victim.AdjustMute(15 SECONDS)
			human_victim.overlay_fullscreen_timer(15 SECONDS, 10, "bluescreen", /atom/movable/screen/fullscreen/dead/robot)
			human_victim.visible_message(span_warning("[human_victim] shudders violently whilst spitting out error text before collapsing, flailing on the ground randomly."), span_blue("You are bluescreening, but you should be able to recover from this by rebooting automatically in about 15s."), span_notice("You hear a clanker glitching."))
	else
		if(prob(emp_chance))
			empulse(target_mob.loc, 0,0,0,1)
		human_victim.adjustStaminaLoss(proj.damage/2)
		human_victim.AdjustStun(0.1 SECONDS)
		human_victim.jitter(3)
		human_victim.add_slowdown(0.1,1)
		human_victim.visible_message(span_warning("[human_victim] shakes with an electric shock!"), span_warning("You feel lightning mess up your nerves, locking your body!"), span_notice("You hear a clanker glitching."))

//smart mag
/obj/item/ammo_magazine/rifle/nt_halter/smart
	name = "\improper NT 'Halter' smart magazine (7.62x38mm Smart)"
	desc = "A magazine filled with specialized 7.62x38mm rifle rounds that slightly sways to avoid friendlies but loses overall power, for the Halter series of firearms."
	icon_state = "halter_smart"
	bonus_overlay = "halter_smart"
	default_ammo = /datum/ammo/bullet/rifle/heavy/halter/smart

//this just suck so imma let it be same as regular bullets, cause its also paid and you got aim mode which is good on this.
/datum/ammo/bullet/rifle/heavy/halter/smart
	name = "smart heavy rifle bullet"
	hud_state = "rifle_ap"
	ammo_behavior_flags = AMMO_BALLISTIC|AMMO_IFF
	bullet_color = COLOR_BLUE_GRAY

//foxfire mag
/obj/item/ammo_magazine/rifle/nt_halter/foxfire
	name = "\improper NT 'Halter' foxfire magazine (7.62x38mm AP-I)"
	desc = "A magazine filled with specialized 7.62x38mm AP-I rifle rounds that pierce armor and ignite targets, for the Halter series of firearms."
	icon_state = "halter_foxfire"
	bonus_overlay = "halter_foxfire"
	default_ammo = /datum/ammo/bullet/rifle/heavy/ap/foxfire

/datum/ammo/bullet/rifle/heavy/ap/foxfire
	name = "armor-piercing foxfire heavy rifle bullet"
	hud_state = "rifle_ap"
	//bit less crazy than actual heavy ap
	damage = 20
	penetration = 15
	sundering = 3
	bullet_color = COLOR_RED_LIGHT
	//incendiary was too op for the rof so we make it less likely by using a weaker deflag
	///Deflagrate AOE damage
	var/deflag_damage = 10
	///Multiplier for deflagrate chance
	var/deflagrate_mult = 0.7

/datum/ammo/bullet/rifle/heavy/ap/foxfire/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
	deflagrate(target_mob, proj, deflag_damage, deflagrate_mult)


//laser mag
/obj/item/ammo_magazine/rifle/nt_halter/laser
	name = "\improper NT 'Halter' laser magazine (7.62x38mm LE)"
	desc = "A magazine filled with specialized 7.62x38mm single shot laser emitter rounds that shoots laser bolts instead of a standard round."
	icon_state = "halter_laser"
	bonus_overlay = "halter_laser"
	default_ammo = /datum/ammo/energy/lasgun/halter

/datum/ammo/energy/lasgun/halter
	//slightly less damage than regular bullets but except laser standard sundering and bullet speed.
	name = "halter laser bolt"
	damage = 27
	bullet_color = COLOR_RED_LIGHT

//extended mag
/obj/item/ammo_magazine/rifle/nt_halter/laser/extended
	name = "\improper NT 'Halter' extended laser magazine (7.62x38mm LE)"
	desc = "An extended magazine filled with 7.62x38mm laser emitter rounds for the Halter series of firearms."
	max_rounds = 50
	icon_state = "halter_laser_ex"
	bonus_overlay = "halter_laser_ex"

//extended mag
/obj/item/ammo_magazine/rifle/nt_halter/laser/drum
	name = "\improper NT 'Halter' drum laser magazine (7.62x38mm)"
	desc = "An drum magazine filled with 7.62x38mm laser emitter rounds for the Halter series of firearms."
	max_rounds = 100
	icon_state = "halter_laser_drum"
	bonus_overlay = "halter_laser_drum"

//rubber mags
/obj/item/ammo_magazine/rifle/nt_halter/rubber
	name = "\improper NT 'Halter' rubber magazine (7.62x38mm rub)"
	desc = "A magazine filled with 7.62x38mm rubber rifle rounds for the Halter series of firearms."
	icon_state = "halter_rub"
	icon = 'ntf_modular/icons/obj/items/ammo/rifle.dmi'
	bonus_overlay = "halter_rub_mag"
	default_ammo = /datum/ammo/bullet/rifle/heavy/rubber

/obj/item/ammo_magazine/rifle/nt_halter/rubber/extended
	name = "\improper NT 'Halter' extended rubber magazine (7.62x38mm rub)"
	desc = "An extended magazine filled with 7.62x38mm rubber rounds for the Halter series of firearms."
	max_rounds = 50
	icon_state = "halter_rub_ex"
	bonus_overlay = "halter_rub_ex"

//im not making a sprite for this im lazy
/obj/item/ammo_magazine/packet/halter
	name = "box of 7.62x38mm"
	desc = "A box containing 120 rounds of 7.62x38mm."
	caliber = CALIBER_762X38
	icon_state = "7.62"
	default_ammo = /datum/ammo/bullet/rifle/heavy/halter
	current_rounds = 120
	max_rounds = 120
	color = COLOR_MAROON

/obj/item/ammo_magazine/packet/halter/rubber
	name = "box of 7.62x38mm rub"
	desc = "A box containing 120 rounds of 7.62x38mm rub."
	caliber = CALIBER_762X38
	icon_state = "7.62"
	default_ammo = /datum/ammo/bullet/rifle/heavy/rubber
	current_rounds = 120
	max_rounds = 120
	color = COLOR_BRIGHT_BLUE

/obj/item/ammo_magazine/packet/halter/laser
	name = "box of 7.62x38mm LE"
	desc = "A box containing 120 rounds of 7.62x38mm Laser Emitters."
	default_ammo = /datum/ammo/energy/lasgun/halter
	color = COLOR_RED

/obj/item/storage/box/visual/magazine/compact/halter_assaultrifle
	name = "Halter magazine box"
	desc = "A box specifically designed to hold a large amount of Halter magazines."
	closed_overlay = "mag_box_small_overlay_ar12"

/obj/item/storage/box/visual/magazine/compact/halter_assaultrifle/Initialize(mapload, ...)
	. = ..()
	storage_datum.storage_slots = 30
	storage_datum.set_holdable(can_hold_list = list(
		/obj/item/ammo_magazine/rifle/nt_halter,
	))

/obj/item/storage/box/visual/magazine/compact/halter_assaultrifle/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/nt_halter

/obj/item/storage/box/visual/magazine/compact/halter_assaultrifle_laser/full
	spawn_number = 30
	spawn_type = /obj/item/ammo_magazine/rifle/nt_halter/laser

//dragoon bs
//The Dragoon rapid engagement rifle.
/obj/item/weapon/gun/rifle/dragoon
	name = "\improper Dragoon Mk1 Rapid Engagement Rifle"
	desc = "The Dragoon Rapid Engagement rifle is a powerful, above-average capacity and agile rifle designed to be used in situations requiring frequent relocation and short engagements. Triangular casings allow it to hold a greater amount of ammo compared to similar rifles. Unfortunately it has not seen widespread adoption due to the lack of detachable magazine and a complex, delicate feeding mechanism that requires users to put additional care into every reload, lest the newly-loaded cartridges end up pushed right back up into the stripper clip. Fires an exotic 9.8x22mm cartridge with great penetration capabilities."
	icon = 'icons/obj/items/guns/marksman64.dmi'
	icon_state = "dragoon"
	worn_icon_state = "l11"
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	worn_icon_list = list(
		slot_l_hand_str = 'icons/mob/inhands/guns/marksman_left_64.dmi',
		slot_r_hand_str = 'icons/mob/inhands/guns/marksman_right_64.dmi',
	)
	gun_crosshair = 'icons/UI_Icons/gun_crosshairs/sniper.dmi'
	fire_sound = 'sound/weapons/guns/fire/mp38_1.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/sniper_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/c99_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/ml12_reload.ogg'
	empty_sound = null
	caliber = CALIBER_98x22 //codex
	max_chamber_items = 10 //codex
	default_ammo_type = /datum/ammo/bullet/dragoon
	allowed_ammo_types = list(
		/obj/item/ammo_magazine/rifle/boltclip/dragoon,
		/obj/item/ammo_magazine/rifle/boltclip/dragoon/pox
	)
	attachable_allowed = list(
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/suppressor/unremovable/invisible,
		/obj/item/attachable/stock/dragoon,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/motiondetector,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod
	)
	starting_attachment_types = list(/obj/item/attachable/suppressor/unremovable/invisible, /obj/item/attachable/stock/dragoon)

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	reciever_flags = AMMO_RECIEVER_HANDFULS|AMMO_RECIEVER_MULTICLIP

	gun_firemode_list = list(GUN_FIREMODE_SEMIAUTO)
	attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17,"rail_x" = 22, "rail_y" = 18, "under_x" = 32, "under_y" = 14, "stock_x" = 20, "stock_y" = 14)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 1.25 SECONDS

	burst_amount = 0
	fire_delay = 0.5 SECONDS
	accuracy_mult = 1.15
	accuracy_mult_unwielded = 0.75
	scatter = 0
	scatter_unwielded = 25
	recoil = 0
	recoil_unwielded = 4
	aim_slowdown = 0.60
	movement_acc_penalty_mult = 3

/datum/ammo/bullet/dragoon
	name = "exotic rifle bullet"
	damage_falloff = 0.5
	ammo_behavior_flags = AMMO_BALLISTIC|AMMO_SNIPER
	accurate_range = 20
	shell_speed = 4
	max_range = 30
	handful_amount = 4
	damage = 45
	penetration = 17.5
	sundering = 2
	accurate_range_min = 4

/datum/ammo/bullet/dragoon/flathead
	name = "flathead exotic rifle bullet"
	handful_amount = 4
	damage_type = STAMINA
	damage = 45
	penetration = 15
	sundering = 20

/datum/ammo/bullet/dragoon/pox
	name = "green-tipped exotic rifle bullet"
	damage = 30
	penetration = 10
	sundering = 3

/datum/ammo/bullet/dragoon/pox/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
	if(iscarbon(target_mob))
		var/mob/living/carbon/carbon_victim = target_mob
		carbon_victim.reagents.add_reagent(/datum/reagent/toxin/poxomelanin, 4, no_overdose = FALSE)

//mg27-e
/obj/item/weapon/gun/standard_mmg/machinegunner/spec
	name = "\improper MG-27-E medium machinegun"
	desc = "The MG-27-E is the home improved version of the olden MG-27, it sports lighter post-factory components and a soulsteel rifle shield that must be installed and uninstalled between deployments, allowing it to take a lot of punishment while deployed and work as if a shield for the gunner, it can be shot without being deployed in a pinch but It's impossible to utilize the gun and the bullet shield together due the weight while undeployed, therefore it is uninstalled while taking the weapon in hand. It uses 10x27mm boxes."
	icon = 'ntf_modular/icons/obj/machines/deployable/mounted_machinegun.dmi'
	icon_state = "t27e"
	worn_icon_state = "t27e"
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/guns/machineguns_left_1.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/guns/machineguns_right_1.dmi',
	)
	scatter = 8
	deployed_scatter_change = -50
	wield_delay = 1.8 SECONDS
	soft_armor = list(MELEE = 30, BULLET = 80, LASER = 80, ENERGY = 70, BOMB = 60, BIO = 100, FIRE = 0, ACID = 0)
	max_integrity = 500
	deployable_item = /obj/machinery/deployable/mounted/shielded

/obj/machinery/deployable/mounted/shielded
	allow_pass_flags = PASS_AIR|PASS_LOW_STRUCTURE

//Valerian Rifle
/obj/item/weapon/gun/rifle/valerian
	name = "\improper Valerian carbine"
	desc = "The Atsuko-Kalin manufacturing company created the Valerian as a hard-hitting suppressed carbine."
	icon = 'ntf_modular/icons/obj/items/guns/rifles64.dmi'
	icon_state = "valerian"
	worn_icon_state = "valerian"
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/guns/rifles_left_64.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/guns/rifles_right_64.dmi',
		slot_s_store_str = 'ntf_modular/icons/mob/suit_slot.dmi',
		slot_back_str = 'ntf_modular/icons/mob/clothing/back.dmi',
	)
	inhand_x_dimension = 64
	inhand_y_dimension = 32
	fire_sound = 'sound/weapons/guns/fire/asval.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/t18_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/t18_reload.ogg'
	caliber = CALIBER_9X39 //codex
	max_shells = 20 //codex
	force = 20
	default_ammo_type = /obj/item/ammo_magazine/rifle/valerian
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/valerian, /obj/item/ammo_magazine/rifle/valerian/ext, /obj/item/ammo_magazine/rifle/valerian/lrg)
	attachable_allowed = list(
		/obj/item/attachable/stock/valstock/valerian,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/gyro,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/magnetic_harness,
		/obj/item/attachable/bayonet/converted,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/som,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
		/obj/item/attachable/scope/nightvision,
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

	gun_features_flags = GUN_CAN_POINTBLANK|GUN_AMMO_COUNTER|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC, GUN_FIREMODE_AUTOBURST)
	starting_attachment_types = list(/obj/item/attachable/stock/valstock/valerian)
	attachable_offset = list("muzzle_x" = 30, "muzzle_y" = 16,"rail_x" = 10, "rail_y" = 22, "under_x" = 19, "under_y" = 16, "stock_x" = 5, "stock_y" = 14)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.1 SECONDS
	aim_speed_modifier = 2.25

	fire_delay = 0.2 SECONDS
	burst_delay = 0.1 SECONDS
	extra_delay = 0.2 SECONDS
	accuracy_mult = 0.9
	recoil = 1
	recoil_unwielded = 4
	scatter = 4
	burst_amount = 3
	aim_slowdown = 0.3
	scatter_unwielded = 22
	burst_scatter_mult = 2
	damage_falloff_mult = 0.9
	movement_acc_penalty_mult = 5
	accuracy_mult_unwielded = 0.75
	akimbo_scatter_mod = 16

/obj/item/weapon/gun/rifle/valerian/surveillant
	starting_attachment_types = list(/obj/item/attachable/stock/valstock/valerian, /obj/item/attachable/verticalgrip, /obj/item/attachable/scope/nightvision)

/obj/item/weapon/gun/rifle/valerian/recon
	default_ammo_type = /obj/item/ammo_magazine/rifle/valerian/ext
	starting_attachment_types = list(/obj/item/attachable/stock/valstock/valerian, /obj/item/attachable/angledgrip, /obj/item/attachable/reddot)

/obj/item/attachable/stock/valstock/valerian
	name = "\improper Valerian stock"
	desc = "A specialized stock for the Valerian"
	icon = 'ntf_modular/icons/obj/items/guns/attachments/stock.dmi'
	icon_state = "valerian"
	attach_features_flags = ATTACH_REMOVABLE
	wield_delay_mod = 0.2 SECONDS
	accuracy_mod = 0.2
	recoil_mod = -1
	scatter_mod = -1

/datum/ammo/bullet/rifle/heavy/valerian
	name = "heavy subsonic rifle bullet"
	damage = 35
	accurate_range = 10
	shell_speed = 3
	max_range = 20
	damage_falloff = 1.25
	shrapnel_chance = 2

//standard mag
/obj/item/ammo_magazine/rifle/valerian
	name = "\improper Valerian magazine (9x39mm)"
	desc = "A magazine filled with 9x39mm rifle rounds for the Valerian carbine."
	caliber = CALIBER_9X39
	icon_state = "valerian_mag"
	icon = 'ntf_modular/icons/obj/items/ammo/rifle.dmi'
	bonus_overlay = "valerian_mag"
	default_ammo = /datum/ammo/bullet/rifle/heavy/valerian
	max_rounds = 20

//extended mag
/obj/item/ammo_magazine/rifle/valerian/ext
	name = "\improper Valerian extended magazine (9x39mm)"
	desc = "An extended magazine filled with 9x39mm rifle rounds for the Valerian carbine."
	max_rounds = 30
	icon_state = "valerian_extmag"
	bonus_overlay = "valerian_extmag"
	aim_speed_mod = 0.06
	wield_delay_mod = 0.06 SECONDS

//large mag
/obj/item/ammo_magazine/rifle/valerian/lrg
	name = "\improper Valerian large magazine (9x39mm)"
	desc = "A large magazine filled with 9x39mm rifle rounds for the Valerian carbine."
	max_rounds = 45
	icon_state = "valerian_lrgmag"
	bonus_overlay = "valerian_lrgmag"
	aim_speed_mod = 0.15
	wield_delay_mod = 0.15 SECONDS

//MPA Rifle

/obj/item/weapon/gun/rifle/mpar/mil
	name = "\improper Milspec Multi-Purpose Adaptive Marksman Rifle"
	desc = "The Multi-Purpose Adaptive Marksman Rifle is an experimental DMR produced by the Nine-Tailed Fox, intended for frontier and specialist usage. Some specialists prefer the rifle for its ability to take different types of magazines while others look for a DMR that can be better modified to suit specific roles than other platforms. Chambered in the archaic .308, the MPAR is hard-hitting but the specialized rounds cannot be regularly supplied unless through requisitions. The synthetic fiber sling attached to the weapon prevents the operator from losing the weapon. This is the milspec variant of the MPAR, slightly wider bullet grouping but lighter and more versatile than the civilian variant."
	icon = 'ntf_modular/icons/obj/items/guns/rifles64.dmi'
	icon_state = "m1amil"
	worn_icon_state = "m1amil"
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/guns/marksman_left_64.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/guns/marksman_right_64.dmi',
		slot_s_store_str = 'ntf_modular/icons/mob/suit_slot.dmi',
		slot_back_str = 'ntf_modular/icons/mob/clothing/back.dmi',
	)
	gun_crosshair = 'icons/UI_Icons/gun_crosshairs/sniper.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 32

	fire_sound = 'sound/weapons/guns/fire/mpar.ogg'
	fire_rattle = 'sound/weapons/guns/fire/mparrattle.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/t18_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/t18_reload.ogg'
	caliber = CALIBER_308 //codex
	aim_slowdown = 0.35
	wield_delay = 1.175 SECONDS
	force = 20
	max_shells = 15 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle/mpar
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/mpar, /obj/item/ammo_magazine/rifle/mpar/ext, /obj/item/ammo_magazine/rifle/mpar/smart, /obj/item/ammo_magazine/rifle/mpar/bomb, /obj/item/ammo_magazine/rifle/mpar/drain, /obj/item/ammo_magazine/rifle/mpar/electromag)
	attachable_allowed = list(
		/obj/item/attachable/stock/mparmil,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet/converted,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/gyro,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
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

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_CAN_POINTBLANK|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	starting_attachment_types = list(/obj/item/attachable/stock/mparmil)
	attachable_offset = list("muzzle_x" = 41, "muzzle_y" = 17,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 13, "stock_x" = 5, "stock_y" = 11)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.3 SECONDS
	aim_speed_modifier = 3

	fire_delay = 0.5 SECONDS
	accuracy_mult = 1.05
	scatter = 1
	scatter_unwielded = 14
	recoil_unwielded = 5
	burst_amount = 1
	movement_acc_penalty_mult = 3

/obj/item/weapon/gun/rifle/mpar/export
	name = "\improper Civilian Multi-Purpose Adaptive Rifle"
	desc = "The Multi-Purpose Adaptive Marksman Rifle is an experimental DMR produced by the Nine-Tailed Fox, intended for frontier and specialist usage. Some specialists prefer the rifle for its ability to take different types of magazines while others look for a DMR that can be better modified to suit specific roles than other platforms. Chambered in the archaic .308, the MPAR is hard-hitting but the specialized rounds cannot be regularly supplied unless through requisitions. The leather sling prevents the operator from losing the weapon. This is the civilian variant of the MPAR, slightly heavier but more stable with better shot placement."
	icon = 'ntf_modular/icons/obj/items/guns/rifles64.dmi'
	icon_state = "m1aexport"
	worn_icon_state = "m1aexport"
	worn_icon_list = list(
		slot_l_hand_str = 'ntf_modular/icons/mob/inhands/guns/marksman_left_64.dmi',
		slot_r_hand_str = 'ntf_modular/icons/mob/inhands/guns/marksman_right_64.dmi',
		slot_s_store_str = 'ntf_modular/icons/mob/suit_slot.dmi',
		slot_back_str = 'ntf_modular/icons/mob/clothing/back.dmi',
	)
	gun_crosshair = 'icons/UI_Icons/gun_crosshairs/sniper.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 32

	fire_sound = 'sound/weapons/guns/fire/mpar.ogg'
	fire_rattle = 'sound/weapons/guns/fire/mparrattle.ogg'
	dry_fire_sound = 'sound/weapons/guns/fire/m41a_empty.ogg'
	unload_sound = 'sound/weapons/guns/interact/t18_unload.ogg'
	reload_sound = 'sound/weapons/guns/interact/t18_reload.ogg'
	caliber = CALIBER_308 //codex
	aim_slowdown = 0.425
	wield_delay = 1.35 SECONDS
	force = 25
	max_shells = 15 //codex
	default_ammo_type = /obj/item/ammo_magazine/rifle/mpar
	allowed_ammo_types = list(/obj/item/ammo_magazine/rifle/mpar, /obj/item/ammo_magazine/rifle/mpar/ext, /obj/item/ammo_magazine/rifle/mpar/smart, /obj/item/ammo_magazine/rifle/mpar/bomb, /obj/item/ammo_magazine/rifle/mpar/drain, /obj/item/ammo_magazine/rifle/mpar/electromag)
	attachable_allowed = list(
		/obj/item/attachable/stock/mparexport,
		/obj/item/attachable/suppressor,
		/obj/item/attachable/bayonet/converted,
		/obj/item/attachable/bayonet,
		/obj/item/attachable/bayonet/som,
		/obj/item/attachable/compensator,
		/obj/item/attachable/reddot,
		/obj/item/attachable/verticalgrip,
		/obj/item/attachable/angledgrip,
		/obj/item/attachable/lasersight,
		/obj/item/attachable/flashlight/under,
		/obj/item/attachable/flashlight,
		/obj/item/attachable/foldable/bipod,
		/obj/item/attachable/gyro,
		/obj/item/attachable/extended_barrel,
		/obj/item/attachable/heavy_barrel,
		/obj/item/attachable/scope,
		/obj/item/attachable/scope/marine,
		/obj/item/attachable/scope/mini,
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

	gun_features_flags = GUN_WIELDED_FIRING_ONLY|GUN_AMMO_COUNTER|GUN_CAN_POINTBLANK|GUN_SMOKE_PARTICLES
	gun_firemode_list = list(GUN_FIREMODE_AUTOMATIC)
	starting_attachment_types = list(/obj/item/attachable/scope/marine, /obj/item/attachable/stock/mparexport)
	attachable_offset = list("muzzle_x" = 41, "muzzle_y" = 17,"rail_x" = 10, "rail_y" = 21, "under_x" = 21, "under_y" = 13, "stock_x" = 5, "stock_y" = 11)
	actions_types = list(/datum/action/item_action/aim_mode)
	aim_fire_delay = 0.5 SECONDS
	aim_speed_modifier = 4

	fire_delay = 0.5 SECONDS
	accuracy_mult = 1.1
	scatter = 0
	scatter_unwielded = 20
	recoil_unwielded = 8
	burst_amount = 1
	movement_acc_penalty_mult = 5

/obj/item/attachable/stock/mparmil
	name = "\improper MPAR milspec-variant stock"
	desc = "An irremovable, polymer milspec stock for the NTF variant of the Multi-Purpose Adaptive Marksman Rifle. Possess a magnetic attachment strip so the operator doesn't lose their rifle."
	icon = 'ntf_modular/icons/obj/items/guns/attachments/stock.dmi'
	icon_state = "m1amil"
	wield_delay_mod = 0.075 SECONDS
	accuracy_mod = 0.05
	recoil_mod = -1
	scatter_mod = 0
	///Handles the harness functionality for the stock, this allows for the weapon to reattach to the character
	var/datum/component/reequip/reequip_component

/obj/item/attachable/stock/mparmil/on_attach(attaching_item, mob/user)
	. = ..()
	if(!master_gun)
		return
	reequip_component = master_gun.AddComponent(/datum/component/reequip, list(SLOT_S_STORE, SLOT_BELT, SLOT_BACK))

/obj/item/attachable/stock/mparmil/on_detach(attaching_item, mob/user)
	. = ..()
	if(master_gun)
		return
	QDEL_NULL(reequip_component)

/obj/item/attachable/stock/mparexport
	name = "\improper MPAR export-variant stock"
	desc = "An irremovable, polished wooden stock for the export variant of the Multi-Purpose Adaptive Marksman Rifle"
	icon = 'ntf_modular/icons/obj/items/guns/attachments/stock.dmi'
	icon_state = "m1a"
	wield_delay_mod = 0.15 SECONDS
	accuracy_mod = 0.1
	recoil_mod = -2
	scatter_mod = -1
	///Handles the harness functionality for the stock, this allows for the weapon to reattach to the character
	var/datum/component/reequip/reequip_component

/obj/item/attachable/stock/mparexport/on_attach(attaching_item, mob/user)
	. = ..()
	if(!master_gun)
		return
	reequip_component = master_gun.AddComponent(/datum/component/reequip, list(SLOT_S_STORE, SLOT_BELT, SLOT_BACK))

/obj/item/attachable/stock/mparexport/on_detach(attaching_item, mob/user)
	. = ..()
	if(master_gun)
		return
	QDEL_NULL(reequip_component)

/datum/ammo/bullet/rifle/heavy/mpar
	name = "heavy rifle bullet"
	damage = 46.5
	accurate_range = 20
	shell_speed = 3.5
	max_range = 40
	damage_falloff = 1.25
	ammo_behavior_flags = AMMO_BALLISTIC|AMMO_SNIPER
	sundering = 1.5
	penetration = 12.5
	shrapnel_chance = 5
	accurate_range_min = 2

/datum/ammo/bullet/rifle/heavy/mpar/smasher
	name = "heavy shattering rifle bullet"
	ammo_behavior_flags = AMMO_BALLISTIC|AMMO_SNIPER
	shell_speed = 2.5
	damage = 22.5
	penetration = 7.5
	armor_type = BOMB
	sundering = 6
	damage_falloff = 1.25
	accurate_range = 15
	shrapnel_chance = 0
	accurate_range_min = 2
	///shatter effection duration when hitting mobs
	var/shatter_duration = 15 SECONDS

/datum/ammo/bullet/rifle/heavy/mpar/smasher/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
	if(!isliving(target_mob))
		return

	var/mob/living/living_victim = target_mob
	living_victim.apply_status_effect(STATUS_EFFECT_SHATTER, shatter_duration)

/datum/ammo/bullet/rifle/heavy/mpar/smart
	name = "heavy smart rifle bullet"
	icon_state = "bullet_red"
	hud_state = "rifle_ap"
	bullet_color = COLOR_BLUE_GRAY //Blue bullets to distinguish friendly fire restriction
	damage = 37.5
	ammo_behavior_flags = AMMO_BALLISTIC|AMMO_SNIPER|AMMO_IFF
	accurate_range = 15
	shell_speed = 3
	max_range = 30
	damage_falloff = 1
	penetration = 12.5
	sundering = 1.25
	penetration = 10
	shrapnel_chance = 5

/datum/ammo/bullet/rifle/heavy/mpar/plasmaloss
	name = "heavy tanglefoot bullet"
	hud_state = "spotrifle_plasmaloss"
	ammo_behavior_flags = AMMO_BALLISTIC|AMMO_SNIPER
	shell_speed = 2.5
	damage_falloff = 1.25
	damage = 20
	penetration = 1
	sundering = 0.75
	accurate_range_min = 2

/datum/ammo/bullet/rifle/heavy/mpar/plasmaloss/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
	if(isxeno(target_mob))
		var/mob/living/carbon/xenomorph/target_xeno = target_mob
		target_xeno.use_plasma(20 + 0.20 * target_xeno.xeno_caste.plasma_max * target_xeno.xeno_caste.plasma_regen_limit) // This is draining 20%+20 flat per hit.

/datum/ammo/bullet/rifle/heavy/mpar/electro
	name = "heavy shocking bullet"
	hud_state = "rifle_ap"
	damage = 15
	penetration = 2.5
	damage_type = BRUTE
	sundering = 0.5
	shrapnel_chance = 2
	bullet_color = COLOR_BRIGHT_BLUE
	var/emp_chance = 15

/datum/ammo/bullet/rifle/heavy/mpar/electro/on_hit_mob(mob/target_mob, atom/movable/projectile/proj)
	. = ..()
	do_sparks(3, TRUE, target_mob)
	if(!ishuman(target_mob))
		return
	var/mob/living/carbon/human/human_victim = target_mob
	if(human_victim.species.species_flags & ROBOTIC_LIMBS)
		human_victim.adjustStaminaLoss(proj.damage)
		human_victim.add_slowdown(0.2,1)
		human_victim.AdjustStun(0.1 SECONDS)
		if(human_victim.getStaminaLoss() > 25)
			human_victim.overlay_fullscreen_timer(human_victim.getStaminaLoss(), 10, "glitch", /atom/movable/screen/fullscreen/robot_glitch)
		if((human_victim.getStaminaLoss() >= human_victim.maxHealth*2) && !human_victim.IsUnconscious())
			human_victim.ParalyzeNoChain(15 SECONDS) //fake unconscious basically
			human_victim.AdjustMute(15 SECONDS)
			human_victim.overlay_fullscreen_timer(10 SECONDS, 10, "bluescreen", /atom/movable/screen/fullscreen/dead/robot)
			human_victim.visible_message(span_warning("[human_victim] shudders violently whilst spitting out error text before collapsing, flailing on the ground randomly."), span_blue("You are bluescreening, but you should be able to recover from this by rebooting automatically in about 15s."), span_notice("You hear a clanker glitching."))
	else
		if(prob(emp_chance))
			empulse(target_mob.loc, 0,0,0,1)
		human_victim.adjustStaminaLoss(proj.damage/2)
		human_victim.AdjustStun(0.1 SECONDS)
		human_victim.jitter(3)
		human_victim.add_slowdown(0.1,1)
		human_victim.visible_message(span_warning("[human_victim] shakes with an electric shock!"), span_warning("You feel lightning mess up your nerves, locking your body!"), span_notice("You hear a clanker glitching."))

/obj/item/ammo_magazine/rifle/mpar
	name = "\improper MPAR magazine (.308 FMJ)"
	desc = "A .308 MPAR magazine."
	caliber = CALIBER_308
	icon = 'ntf_modular/icons/obj/items/ammo/rifle.dmi'
	icon_state = "m1a_mag"
	icon_state_mini = "mag_rifle_big"
	bonus_overlay = "m1a_mag"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle/heavy/mpar
	max_rounds = 15

/obj/item/ammo_magazine/rifle/mpar/ext
	name = "\improper MPAR extended magazine (.308 FMJ)"
	desc = "A .308 MPAR extended magazine."
	caliber = CALIBER_308
	icon_state = "m1a_extmag"
	icon_state_mini = "mag_rifle_big"
	bonus_overlay = "m1a_extmag"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle/heavy/mpar
	max_rounds = 30
	aim_speed_mod = 0.15
	wield_delay_mod = 0.15 SECONDS

/obj/item/ammo_magazine/rifle/mpar/smart
	name = "\improper MPAR smart magazine (.308 Smart)"
	desc = "A .308 MPAR smart magazine, designed with IFF capabilities in mind for frontline support."
	caliber = CALIBER_308
	icon_state = "m1a_smartmag"
	icon_state_mini = "mag_rifle_big"
	bonus_overlay = "m1a_smartmag"
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo = /datum/ammo/bullet/rifle/heavy/mpar/smart
	max_rounds = 20
	aim_speed_mod = 0.05
	wield_delay_mod = 0.05 SECONDS

/obj/item/ammo_magazine/rifle/mpar/bomb
	name = "\improper MPAR shattering magazine (.308 Shatter)"
	desc = "A .308 MPAR shattering magazine, the munitions are designed to weaken and shatter enemy armor."
	caliber = CALIBER_308
	icon_state = "m1a_bombmag"
	icon_state_mini = "mag_rifle_big"
	bonus_overlay = "m1a_bombmag"
	w_class = WEIGHT_CLASS_SMALL
	default_ammo = /datum/ammo/bullet/rifle/heavy/mpar/smasher
	max_rounds = 10

/obj/item/ammo_magazine/rifle/mpar/drain
	name = "\improper MPAR tanglefoot magazine (.308 Tanglefoot)"
	desc = "A .308 MPAR tanglefoot magazine, the ammo drains xenomorphs of plasma."
	caliber = CALIBER_308
	icon_state = "m1a_tangmag"
	icon_state_mini = "mag_rifle_big"
	bonus_overlay = "m1a_tangmag"
	w_class = WEIGHT_CLASS_SMALL
	default_ammo = /datum/ammo/bullet/rifle/heavy/mpar/plasmaloss
	max_rounds = 10

/obj/item/ammo_magazine/rifle/mpar/electromag
	name = "\improper MPAR shock magazine (.308 Electro)"
	desc = "A .308 MPAR electromagnetic magazine, the ammo is designed to disrupt and weaken robotics through electromagnetic munitions."
	icon_state = "m1a_empmag"
	icon_state_mini = "mag_rifle_big"
	bonus_overlay = "m1a_empmag"
	w_class = WEIGHT_CLASS_SMALL
	max_rounds = 5
	default_ammo = /datum/ammo/bullet/rifle/heavy/mpar/electro
