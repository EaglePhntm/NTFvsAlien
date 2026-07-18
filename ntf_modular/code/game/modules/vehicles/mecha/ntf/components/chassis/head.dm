#define EXOSUIT_SENSORS_BASIC /datum/exo_sensors/basic
#define EXOSUIT_SENSORS_ADV /datum/exo_sensors/adv
#define EXOSUIT_SENSORS_ULTRA /datum/exo_sensors/ultra
#define EXOSUIT_SENSORS_NONE /datum/exo_sensors/none

/datum/exo_sensors
	var/accuracy_mod
	var/rof_mod
	var/damage_mod
	var/max_range_mod

/datum/exo_sensors/none
	accuracy_mod = 0.6
	rof_mod = 1
	damage_mod = 0.85
	max_range_mod = 0.9

/datum/exo_sensors/basic
	accuracy_mod = 0.9
	rof_mod = 1
	damage_mod = 0.9
	max_range_mod = 1.5

/datum/exo_sensors/adv
	accuracy_mod = 1.2
	rof_mod = 1.1
	damage_mod = 1.1
	max_range_mod = 1.5

/datum/exo_sensors/ultra
	accuracy_mod = 1.3
	rof_mod = 1.15
	damage_mod = 1.15
	max_range_mod = 1.5

/obj/item/mecha_parts/mecha_pieces/mecha_head
	name = "head"
	icon_state = "loader_head"

	layer = MECH_INTERMEDIATE_LAYER

	type_of_piece = MECHA_HEAD

	var/vision_flags = 0
	var/see_invisible = 0
	var/active_sensors = 0
	var/sensor_augments_profile = EXOSUIT_SENSORS_BASIC

/obj/item/mecha_parts/mecha_pieces/mecha_head/powerloader
	name = "exosuit sensors"
	desc = "A primitive set of sensors designed to work in tandem with most MKI Eyeball platforms."
	repair_materials = list(STEEL = TERTIARY_REPAIR_AMT, GLASS = TERTIARY_REPAIR_AMT)
	max_integrity = 100

/obj/item/mecha_parts/mecha_pieces/mecha_head/light
	name = "light sensors"
	icon_state = "light_head"
	repair_materials = list(STEEL = TERTIARY_REPAIR_AMT, GLASS = TERTIARY_REPAIR_AMT)
	max_integrity = 50
	vision_flags = SEE_TURFS
	sensor_augments_profile = EXOSUIT_SENSORS_ADV
//	see_invisible = SEE_INVISIBLE_NOLIGHTING
	desc = "A series of high resolution optical sensors. They can overlay several images to give the pilot a sense of location even in total darkness. "

/obj/item/mecha_parts/mecha_pieces/mecha_head/heavy
	name = "heavy sensors"
	desc = "A solitary sensor moves inside a recessed slit in the armour plates."
	icon_state = "heavy_head"
	repair_materials = list(STEEL = SECONDARY_REPAIR_AMT, RGLASS = TERTIARY_REPAIR_AMT)
	max_integrity = 150

/obj/item/mecha_parts/mecha_pieces/mecha_head/combat
	name = "combat sensors"
	icon_state = "combat_head"
	repair_materials = list(STEEL = SECONDARY_REPAIR_AMT, RGLASS = TERTIARY_REPAIR_AMT)
	vision_flags = SEE_MOBS
	sensor_augments_profile = EXOSUIT_SENSORS_ULTRA
//	see_invisible = SEE_INVISIBLE_NOLIGHTING
	max_integrity = 100
