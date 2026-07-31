#define RIGHT_SHOULDER_SLOT "slot_rshoulder"
#define LEFT_SHOULDER_SLOT "slot_lshoulder"
#define HEAD_SLOT "slot_head"
#define RIGHT_HAND_SLOT "slot_rhand"
#define LEFT_HAND_SLOT "slot_lhand"

/obj/item/mecha_parts/mecha_equipment
//	icon = 'icons/mecha/mecha_equipment_exosuit_floor.dmi'
	///Equipment sprite for the gear
	var/overlay_icon = 'icons/mecha/mecha_equipment_exosuit.dmi'
	///Ditto
	var/overlay_state
	///Whether it has a gear sprite or not
	var/has_mech_icon = FALSE
	///Slot for where the gear icon is located
	var/overlay_location = RIGHT_HAND_SLOT
	///What level of power is required to activate
	var/required_power_level = IGNITION_AUX

/obj/item/mecha_parts/mecha_equipment/action_checks(atom/target, ignore_cooldown = FALSE)
	if(!chassis.check_power())
		for(var/occupant in chassis.occupants)
			chassis.balloon_alert(occupant, "No power")
			return
	if(chassis.check_power() < required_power_level)
		for(var/occupant in chassis.occupants)
			chassis.balloon_alert(occupant, "insufficient power")
			return
	.=..()