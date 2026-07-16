#define ADVMINER_BASE_POWER_REQUIREMENT 250
#define ADVMINER_PROCESS_REQUIREMENT 15
/obj/machinery/advminer
	name = "\improper 'Pioneer' Minning Drill frame"
	desc = "During droughts of planetary resources, after a trough scan and survey, Pioneer mining drills are able to excavate resources from mineral sites deeper than most drills are capable of going. Years of strip mining with most drills have left a lot of planetary colony sites bare of resources, leading to the resurgence of Pioneer drills in some places."
	icon = 'icons/obj/mining_drill.dmi'
	icon_state = "mining_drill_"
	density = TRUE
	anchored = FALSE
	wrenchable = TRUE
	var/progress = 0
	var/obj/structure/oredeposit/dep
	var/obj/item/advmining_drill/current_drill
	var/obj/item/cell/powercell

/obj/machinery/advminer/New(loc, ...)
	. = ..()
	current_drill = new /obj/item/advmining_drill(src)
	powercell = new /obj/item/cell/high(src)

/obj/machinery/advminer/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(anchored)
		for(var/atom/a in get_turf(src))
			if(istype(a, /obj/structure/oredeposit))
				if(dep != a)
					progress = 0
					dep = a
					start_processing()
					return
	else
		progress = 0
		dep = null

/obj/machinery/advminer/process()
	if(!dep || !current_drill || !powercell || !anchored)
		//update_icon_state()
		progress = 0
		stop_processing()
	if(current_drill.durability <= 0 || powercell.charge <= GetPowerRequirement() || GetCurrentLayer() != current_drill.depthlayer)
		progress = 0
		stop_processing()
	else
		progress += current_drill.speedmod / dep.miningdifficulty
		if(progress > ADVMINER_PROCESS_REQUIREMENT)
			progress -= ADVMINER_PROCESS_REQUIREMENT
			current_drill.durability -= 1
			powercell.charge -= GetPowerRequirement()
			dep.GetDrilled(current_drill)
	update_icon_state()


/obj/machinery/advminer/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(istype(attacking_item,/obj/item/advmining_drill))
		if(do_after(user,5 SECONDS,TRUE, src,BUSY_ICON_BUILD))
			if(!user.drop_held_item())
				return
			current_drill.forceMove(get_turf(user))
			current_drill = attacking_item
			current_drill.forceMove(src)
			playsound(src,'sound/items/ratchet.ogg',SOUND_AUDIBLE_VOLUME_MIN)
			start_processing()
	if(istype(attacking_item,/obj/item/cell))
		if(do_after(user,5 SECONDS,TRUE, src,BUSY_ICON_BUILD))
			if(!user.drop_held_item())
				return
			powercell.forceMove(get_turf(user))
			powercell = attacking_item
			powercell.forceMove(src)
			playsound(src,'sound/machines/click.ogg',SOUND_AUDIBLE_VOLUME_MIN)
			start_processing()


/obj/machinery/advminer/examine(mob/user)
	. = ..()
	if(!current_drill)
		.+= span_warning("No drillhead is currently installed...")
	else
		. += span_info("Currently installed drillhead is: [current_drill.name]. It is fit for [current_drill.depthlayer] layer, and will hold for [current_drill.durability] more cycles.")
		if(current_drill.durability <= 0)
			. += span_warning("The drillhead is no longer fit for service!")
		if(GetCurrentLayer() != current_drill.depthlayer)
			. += span_warning("This drillhead is not compatible with the current layer!")
	if(!powercell)
		. += span_warning("No power cell is currently installed...")
	else
		. += span_info("There is a powercell currently installed! It reads: [powercell.charge] / [powercell.maxcharge]!")
		var/enoughpowerfordepth = floor(powercell.charge / GetPowerRequirement())
		if(!enoughpowerfordepth)
			. += span_warning("It doesn't have enough power for even a single more cycle...")
		else
			. += span_info("It has enough power for [enoughpowerfordepth] more cycles")
	if(dep)
		. += span_info("It is currently over a mineral deposit! It is [dep.depth] cycles deep, currently at [GetCurrentLayer()]# layer.")

/obj/machinery/advminer/update_icon_state()
	if(!anchored || !current_drill || !powercell || !dep)
		icon_state = "mining_drill_"
	else
		if(current_drill.durability <= 0 || powercell.charge <= GetPowerRequirement() || GetCurrentLayer() != current_drill.depthlayer)
			icon_state = "mining_drill_error_"
		else
			icon_state = "mining_drill_active_"




/obj/machinery/advminer/proc/GetCurrentLayer()
	if(!dep)
		return 0
	return dep.GetLayer()

/obj/machinery/advminer/proc/GetPowerRequirement()
	if(!current_drill)
		return 0
	return current_drill.powermod * current_drill.depthlayer * ADVMINER_BASE_POWER_REQUIREMENT

