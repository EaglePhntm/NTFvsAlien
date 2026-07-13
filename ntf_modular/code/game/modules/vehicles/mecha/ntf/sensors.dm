/obj/item/mecha_parts/mecha_equipment/mech_sensors
	var/is_functional = TRUE
	var/vision_flags = MECHA_VISION_STANDARD
	equipment_slot = MECHA_VISION
	max_integrity = 100

/obj/item/mecha_parts/mecha_equipment/mech_sensors/obj_break(damage_flag)
	vision_flags |= MECHA_VISION_BROKEN
	is_functional = FALSE

/obj/item/mecha_parts/mecha_equipment/mech_sensors/reinforced
	name = "reinforced exosuit sensors"
	desc = "A standard set of sensors, encased with a steel cage and polycarbonate layers over the lens."
	max_integrity = 200
	vision_flags = MECHA_VISION_REINFORCED // shittier

/obj/item/mecha_parts/mecha_equipment/mech_sensors/high_def
	name = "high-fidelity exosuit sensors"
	desc = "A sensor suite using upgraded instruments and lenses for the most pristine imaging and situational awareness."
	max_integrity = 50
	vision_flags = MECHA_VISION_HIGHDEF // gooder
