/obj/item/mecha_parts/mecha_pieces/mecha_head
	name = "head"
	icon_state = "loader_head"

	layer = MECH_INTERMEDIATE_LAYER
	type_of_piece = MECHA_HEAD
	sensors_profile = EXOSUIT_SENSORS_BASIC

/obj/item/mecha_parts/mecha_pieces/mecha_head/loader
	name = "exosuit sensors"
	desc = "A primitive set of sensors designed to work in tandem with most MKI Eyeball platforms."
	repair_materials = list(STEEL = TERTIARY_REPAIR_AMT, GLASS = TERTIARY_REPAIR_AMT)
	max_integrity = 100
	soft_armor = list(MELEE = 20, BULLET = 10, LASER = 10, ENERGY = 0, BOMB = 5, BIO = 0, FIRE = 50, ACID = 50)

/obj/item/mecha_parts/mecha_pieces/mecha_head/light
	name = "light sensors"
	desc = "A series of high resolution optical sensors, overlaying images to give pilots a high level of awareness from a opaque cockpit."
	icon_state = "light_head"
	repair_materials = list(STEEL = TERTIARY_REPAIR_AMT, GLASS = TERTIARY_REPAIR_AMT)
	max_integrity = 50
	sensors_profile = EXOSUIT_SENSORS_ADV
	soft_armor = list(MELEE = 20, BULLET = 0, LASER = 5, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 50)

/obj/item/mecha_parts/mecha_pieces/mecha_head/heavy
	name = "heavy sensors"
	desc = "A solitary sensor moves inside a recessed slit in the armour plates."
	icon_state = "heavy_head"
	repair_materials = list(STEEL = SECONDARY_REPAIR_AMT, RGLASS = TERTIARY_REPAIR_AMT)
	max_integrity = 150
	soft_armor = list(MELEE = 60, BULLET = 50, LASER = 40, ENERGY = 10, BOMB = 10, BIO = 0, FIRE = 50, ACID = 50)

/obj/item/mecha_parts/mecha_pieces/mecha_head/combat
	name = "combat sensors"
	desc = "Ultra-high resolution, low-latency sensors, designed to give pilots near perfect real-time data from the cockpit."
	icon_state = "combat_head"
	repair_materials = list(STEEL = SECONDARY_REPAIR_AMT, RGLASS = TERTIARY_REPAIR_AMT)
	sensors_profile = EXOSUIT_SENSORS_ULTRA
	max_integrity = 100
	soft_armor = list(MELEE = 50, BULLET = 40, LASER = 40, ENERGY = 10, BOMB = 5, BIO = 0, FIRE = 50, ACID = 50)
