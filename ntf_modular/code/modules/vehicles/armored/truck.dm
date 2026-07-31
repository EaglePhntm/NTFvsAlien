


/datum/interior/armored/logi
	template = /datum/map_template/interior/logi

/datum/map_template/interior/logi
	name = "transport truck interior template"
	filename = "logitruck"

/obj/vehicle/sealed/armored/multitile/mrap/logi
	name = "\improper TransCO 'Roadmaster' Logistics Truck"
	desc = "A lightly armored logistic transport vehicle designed to transport trade goods across the earth wherever necessary while being able to outrun and take a few shots from the usual raider interception. It comes after-market equipped with tesla coils due to the xenomorph threats."
	icon = 'ntf_modular/icons/obj/vehicles/transport_truck.dmi'
	damage_icon_path = 'ntf_modular/icons/obj/vehicles/transport_truck.dmi'
	icon_state = "truck_enclosed"
	hitbox = /obj/hitbox/two_three
	interior = /datum/interior/armored/logi
	permitted_weapons = NONE
	permitted_mods = list(/obj/item/tank_module/ability/tesla)
	armored_flags = ARMORED_HAS_HEADLIGHTS|ARMORED_WRECKABLE|ARMORED_SELF_WALL_DAMAGE
	required_entry_skill = SKILL_LARGE_VEHICLE_DEFAULT
	minimap_icon_state = null
	turret_icon = null
	pixel_x = -16
	pixel_y = -40
	max_integrity = 700
	soft_armor = list(MELEE = 50, BULLET = 80 , LASER = 80, ENERGY = 70, BOMB = 30, BIO = 100, FIRE = 100, ACID = 50)
	hard_armor = list(MELEE = 0, BULLET = 5, LASER = 5, ENERGY = 5, BOMB = 5, BIO = 100, FIRE = 0, ACID = 0)
	facing_modifiers = list(VEHICLE_FRONT_ARMOUR = 0.8, VEHICLE_SIDE_ARMOUR = 1, VEHICLE_BACK_ARMOUR = 1.2) //not too much diff
	ram_damage = 150
	move_delay = 0.1 SECONDS
	glide_size = 9
	easy_load_list = list(
		/obj/item/ammo_magazine/tank,
		/obj/structure/largecrate,
		/obj/structure/closet/crate,
	)
	armor_integrity_mod = 8 //10 initial ap to penetrate, large caliber rifles and shouldnt bounce off.

/obj/vehicle/sealed/armored/multitile/mrap/logi/treads
	name = "\improper TransCO 'Roughauler' Treaded Military Truck"
	desc = "A treaded, armored logistic transport vehicle, designed to transport troops and supplies wherever necessary, relatively quickly and hopefully in one piece thanks to it's ballistic plating. It's threads make it possible to turn on spot, be immune to flat tires, resist side-shots and traverse rough terrain, probably.  It comes after-market equipped with tesla coils due to the xenomorph threats."
	icon = 'ntf_modular/icons/obj/vehicles/large_truck.dmi'
	damage_icon_path = 'ntf_modular/icons/obj/vehicles/large_truck.dmi'
	icon_state = "truck_enclosed_treads"
	hitbox = /obj/hitbox/medium
	max_integrity = 800
	soft_armor = list(MELEE = 50, BULLET = 80 , LASER = 80, ENERGY = 70, BOMB = 50, BIO = 100, FIRE = 100, ACID = 55)
	hard_armor = list(MELEE = 0, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 100, FIRE = 0, ACID = 0)
	facing_modifiers = list(VEHICLE_FRONT_ARMOUR = 0.8, VEHICLE_SIDE_ARMOUR = 0.8, VEHICLE_BACK_ARMOUR = 1.2) //tracks are armored yay
	move_delay = 0.2 SECONDS
	glide_size = 7
	armor_integrity_mod = 5 //16 initial ap to penetrate, should tank large caliber rifles.

/obj/vehicle/sealed/armored/multitile/mrap/logi/treads/enter_locations(atom/movable/entering_thing)
	return list(get_step(src, REVERSE_DIR(dir)))
