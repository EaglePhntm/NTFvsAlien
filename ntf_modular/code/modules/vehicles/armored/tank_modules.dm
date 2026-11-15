/obj/item/tank_module/interior/teletruck
	name = "teleporter interior"
	desc = "A teleporter interior package, stocked with an advanced teleporter capable of being used from within the vehicle."
	icon_state = "cloner_interior"
	interior_typepath = /datum/interior/armored/teletruck
	set_max_occupants = 5

/obj/item/tank_module/interior/teletruck/on_equip(obj/vehicle/sealed/armored/vehicle, mob/living/user)
	. = ..()
	if(!.)
		return
	vehicle.enter_delay += 0.8 SECONDS
	vehicle.move_delay += 0.2 SECONDS
	vehicle.glide_size = 4

/obj/item/tank_module/interior/teletruck/on_unequip(mob/user)
	owner.enter_delay -= 0.8 SECONDS
	owner.move_delay -= 0.2 SECONDS
	owner.glide_size = initial(owner.glide_size)
	return ..()
