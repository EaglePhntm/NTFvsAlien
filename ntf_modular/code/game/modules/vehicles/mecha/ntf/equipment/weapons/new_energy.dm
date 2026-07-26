#define HEAT_GAIN_BASE 4
#define HEAT_GAIN_LOW 4

#warn ntf_energy

/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit
	var/heat_amount = 0
	var/heat_gain_amount = HEAT_GAIN_LOW
	var/heat_loss_amount = HEAT_GAIN_BASE / 2

#define FIRING_RAPID 1
#define FIRING_CONCENTRATED 2
#define FIRING_BLAST 3

/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit/plasma_rifle
	name = "\improper exosuit-mounted plasma caster"
	desc = "A PL-38 rifle with a modified stock to fit to an exosuit's weapon adapter. Has a slightly bigger heatsink."
	fire_sound = 'sound/mecha/weapons/mech_laser_heavy.ogg'
	max_integrity = 50
	variance = 2
	explodes_on_zeroing = TRUE
	var/firing_mode = FIRING_RAPID

/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit/plasma_rifle/Initialize(mapload)
	. = ..()
	apply_mode()

/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit/plasma_rifle/get_snowflake_data()
	return list(
		"snowflake_id" = MECHA_SNOWFLAKE_ID_MODE,
		"name" = "PL-38 Plasma Caster",
		"firing_mode" = firing_mode == FIRING_RAPID ? "Rapid" : firing_mode == FIRING_CONCENTRATED ? "Concentrated" : "Spread")

/*
/obj/item/mecha_parts/mecha_equipment/repair_droid/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(action != "toggle")
		return
	chassis.cut_overlay(droid_overlay)
	if(activated)
		START_PROCESSING(SSobj, src)
		droid_overlay = image(icon, icon_state = "repair_droid_a")
		log_message("Activated.", LOG_MECHA)
	else
		STOP_PROCESSING(SSobj, src)
		droid_overlay = image(icon, icon_state = "repair_droid")
		log_message("Deactivated.", LOG_MECHA)
	chassis.add_overlay(droid_overlay)
*/
/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit/plasma_rifle/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(action != "toggle")
		firing_mode = (firing_mode % 3) + 1 // cycles 1 -> 2 -> 3 -> 1
		apply_mode()
		balloon_alert(usr, "[icon2html(src, usr)][span_notice("Switched to [firing_mode == FIRING_RAPID ? "Rapid" : firing_mode == FIRING_CONCENTRATED ? "Burst" : "Heavy"] mode.")]")
		return TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit/plasma_rifle/proc/apply_mode()
	switch(firing_mode)
		if(FIRING_RAPID)
			energy_drain = 20
			projectile_delay = 0.5 SECONDS
			ammotype = /datum/ammo/energy/plasma/rifle_standard
		if(FIRING_CONCENTRATED)
			energy_drain = 32
			projectile_delay = 0.85 SECONDS
			ammotype = /datum/ammo/energy/plasma/rifle_marksman
		if(FIRING_BLAST)
//			windup_delay = 0.5 SECONDS
			energy_drain = 80
			projectile_delay = 1.25 SECONDS
			ammotype = /datum/ammo/energy/plasma/blast
			fire_mode = GUN_FIREMODE_SEMIAUTO

/obj/item/mecha_parts/mecha_equipment/weapon/energy/exosuit/plasma_rifle/action()
	if(!chassis)
		return
	if(chassis.get_charge() < energy_drain)
		balloon_alert(chassis.occupants, "[icon2html(src, chassis.occupants)][span_warning("Insufficient power!")]")
		return
	return ..()
