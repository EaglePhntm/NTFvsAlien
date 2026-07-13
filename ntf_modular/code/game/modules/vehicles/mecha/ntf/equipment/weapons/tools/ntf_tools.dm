// Most of these modules are the same as, or a adjusted variant of greyscale modules

/obj/item/mecha_parts/mecha_equipment/ability/zoom
	name = "enhanced zoom"
	desc = "A magnifying module that allows the pilot to see much further than with the standard optics. Night vision not included."
	icon_state = "zoom"
	equipment_slot = MECHA_UTILITY
	mech_flags = EXOSUIT_MODULE_NTF|EXOSUIT_MODULE_COMBAT
	ability_to_grant = /datum/action/vehicle/sealed/mecha/mech_zoom

/obj/item/mecha_parts/mecha_equipment/ability/zoom/try_attach_part(mob/user, obj/vehicle/sealed/mecha/M, attach_right = FALSE)
	if(istype(M, /obj/vehicle/sealed/mecha/ntf/marauder))
		to_chat(user, span_warning("You are unable to attach [src] to [M]!"))
		return
	return ..()

/obj/item/mecha_parts/mecha_equipment/generator/exosuit
	name = "phoron generator"
	icon_state = "phoron_engine_small"
	equipment_slot = MECHA_UTILITY // Uses a utility slot, for balance.
	desc = "An exosuit module that generates power using solid phoron as fuel."
	mech_flags = EXOSUIT_MODULE_NTF|EXOSUIT_MODULE_COMBAT
	max_fuel = 50000
	rechargerate = 15

/obj/item/mecha_parts/mecha_equipment/ability/smoke/cloak_smoke/exosuit
	name = "smoke generator"
	desc = "An exosuit module that somehow consumes a huge amount of electricity to generate concealing smoke."
	equipment_slot = MECHA_UTILITY
	mech_flags = EXOSUIT_MODULE_NTF|EXOSUIT_MODULE_COMBAT
	smoke_type = /datum/effect_system/smoke_spread/tactical
	size = 4
	duration = 5
	ability_to_grant = /datum/action/vehicle/sealed/mecha/mech_smoke/exosuit

/obj/item/mecha_parts/mecha_equipment/ability/night_vision/exosuit
	name = "night vision module"
	desc = "A night vision optical suite designed to be mounted on exosuits. Consumes energy when active."
	icon_state = "nvgs"
	equipment_slot = MECHA_UTILITY
	mech_flags = EXOSUIT_MODULE_NTF|EXOSUIT_MODULE_COMBAT
	ability_to_grant = /datum/action/vehicle/sealed/mecha/light_amplification

/obj/item/mecha_parts/mecha_equipment/passenger_compartment
	name = "passenger_compartment"
	desc = "A compartment that's able to be fitted to the interior of an exosuit, somehow increasing the passenger capacity, but making it more difficult to open the hatch."
	icon_state = "compartment"
	equipment_slot = MECHA_UTILITY
	var/increase_occupant_count_by = 1

/obj/item/mecha_parts/mecha_equipment/passenger_compartment/attach(obj/vehicle/sealed/mecha/M, attach_right = FALSE)
	.=..()
	M.max_occupants += increase_occupant_count_by
	M.destruction_sleep_duration += increase_occupant_count_by

/obj/item/mecha_parts/mecha_equipment/passenger_compartment/detach(obj/vehicle/sealed/mecha/M, attach_right = FALSE)
	.=..()
	M.max_occupants -= increase_occupant_count_by
	M.destruction_sleep_duration -= increase_occupant_count_by
	M.check_passengers()

/obj/vehicle/sealed/mecha/proc/check_passengers(mob/amount)
	if(amount > max_occupants)
		mob_exit()
		visible_message(span_warning("The exosuit is over-capacity, everyone falls out!"))
		return

/obj/item/mecha_parts/mecha_equipment/extinguisher/exosuit
	name = "exosuit extinguisher"
	desc = "Equipment for engineering exosuits. A rapid-firing high capacity fire extinguisher."
	icon_state = "mecha_exting"
	equipment_slot = MECHA_UTILITY
	equip_cooldown = 5
	energy_drain = 0
	range = MECHA_MELEE|MECHA_RANGED
	mech_flags = EXOSUIT_MODULE_NTF|EXOSUIT_MODULE_COMBAT
