
/obj/structure/xeno/evotower
	name = "evolution tower"
	desc = "A sickly outcrop from the ground. It seems to ooze a strange chemical that shimmers and warps the ground around it."
	icon = 'icons/Xeno/2x2building.dmi'
	icon_state = "evotower"
	bound_width = 64
	bound_height = 64
	obj_integrity = 600
	max_integrity = 600
	xeno_structure_flags = CRITICAL_STRUCTURE
	///boost amt to be added per tower per cycle
	var/boost_amount = 0.2

/obj/structure/xeno/evotower/Initialize(mapload, _hivenumber)
	. = ..()
	GLOB.hive_datums[hivenumber].evotowers += src
	set_light(2, 2, LIGHT_COLOR_GREEN)

/obj/structure/xeno/evotower/Destroy()
	GLOB.hive_datums[hivenumber].evotowers -= src
	return ..()

/obj/structure/xeno/evotower/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			take_damage(700, BRUTE, BOMB)
		if(EXPLODE_HEAVY)
			take_damage(500, BRUTE, BOMB)
		if(EXPLODE_LIGHT)
			take_damage(300, BRUTE, BOMB)
		if(EXPLODE_WEAK)
			take_damage(100, BRUTE, BOMB)

/obj/structure/xeno/psychictower
	name = "Psychic Relay"
	desc = "A sickly outcrop from the ground. It seems to allow for more advanced growth of the Xenomorphs."
	icon = 'icons/Xeno/2x2building.dmi'
	icon_state = "maturitytower"
	bound_width = 64
	bound_height = 64
	obj_integrity = 400
	max_integrity = 400
	xeno_structure_flags = CRITICAL_STRUCTURE

/obj/structure/xeno/psychictower/Initialize(mapload, _hivenumber)
	. = ..()
	GLOB.hive_datums[hivenumber].psychictowers += src
	set_light(2, 2, LIGHT_COLOR_GREEN)

/obj/structure/xeno/psychictower/Destroy()
	GLOB.hive_datums[hivenumber].psychictowers -= src
	return ..()

/obj/structure/xeno/psychictower/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			take_damage(700, BRUTE, BOMB)
		if(EXPLODE_HEAVY)
			take_damage(500, BRUTE, BOMB)
		if(EXPLODE_LIGHT)
			take_damage(300, BRUTE, BOMB)
		if(EXPLODE_WEAK)
			take_damage(100, BRUTE, BOMB)

/obj/structure/xeno/lighttower
	name = "Light tower"
	desc = "A resin formation that looks like a small pillar. It just provides light, not much more."
	icon = 'icons/Xeno/1x1building.dmi'
	icon_state = "lighttower"
	bound_width = 32
	bound_height = 32
	obj_integrity = 200
	max_integrity = 200

/obj/structure/xeno/lighttower/Initialize(mapload)
	. = ..()
	set_light(5, 4, LIGHT_COLOR_BLUE)
	playsound(src, "alien_drool", 25)

/obj/structure/xeno/lighttower/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			take_damage(500, BRUTE, BOMB)
		if(EXPLODE_HEAVY)
			take_damage(300, BRUTE, BOMB)
		if(EXPLODE_LIGHT)
			take_damage(200, BRUTE, BOMB)
		if(EXPLODE_WEAK)
			take_damage(100, BRUTE, BOMB)