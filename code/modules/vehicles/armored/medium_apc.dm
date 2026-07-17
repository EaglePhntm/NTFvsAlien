/obj/vehicle/sealed/armored/multitile/medium/apc
	name = "TAV - Nike"
	desc = "A heavily armoured vehicle with light armaments designed to ferry troops around the battlefield, or assist with search and rescue (SAR) operations."
	icon = 'icons/obj/armored/2x2/medium_vehicles.dmi'
	turret_icon = 'icons/obj/armored/2x2/medium_vehicles.dmi'
	turret_icon_state = "apc_turret"
	damage_icon_path = null
	interior = null
	minimap_icon_state = null
	armored_flags = ARMORED_HAS_PRIMARY_WEAPON|ARMORED_HAS_SECONDARY_WEAPON|ARMORED_HAS_UNDERLAY|ARMORED_PURCHASABLE_TRANSPORT|ARMORED_SELF_WALL_DAMAGE
	icon_state = "apc"
	move_delay = 0.25 SECONDS
	obj_integrity = 800
	max_integrity = 800
	max_occupants = 5
	permitted_mods = list(/obj/item/tank_module/ability/zoom)
	soft_armor = list(MELEE = 50, BULLET = 80, LASER = 80, ENERGY = 70, BOMB = 50, BIO = 100, FIRE = 100, ACID = 50)
	hard_armor = list(MELEE = 0, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 100, FIRE = 0, ACID = 0)
