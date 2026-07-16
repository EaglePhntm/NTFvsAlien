/obj/machinery/advreqtorio/ore_grinder
	name = "Ore Grinder"
	desc = "Grinds, seperates, and dispenses minerals found within mixed ores."
	icon = 'ntf_modular/icons/obj/machines/advreqtorio_machines.dmi'
	icon_state = "grinder"
	var/list/currcontents = list()
	var/list/mineralcontents = list()
	anchored = FALSE
	wrenchable = TRUE
	active_power_usage = 500

/obj/machinery/advreqtorio/ore_grinder/Initialize(mapload)
	. = ..()
	//This sucks but it will do for now until I finish making loaders and inserters
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(conveyable_enter),
		COMSIG_ATOM_INITIALIZED_ON = PROC_REF(conveyable_enter),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

///Restarts an idle running belt when something enters its turf.
/obj/machinery/advreqtorio/ore_grinder/proc/conveyable_enter(datum/source, atom/movable/entered)
	SIGNAL_HANDLER
	if(!isturf(loc))
		return
	if(entered == src || entered.loc != loc)
		return
	if(istype(entered,/obj/item/mixedminerals))
		var/obj/item/mixedminerals/mm = entered
		acceptRocc(mm)
		start_processing()

/obj/machinery/advreqtorio/ore_grinder/proc/acceptRocc(obj/item/mixedminerals/mm)
	currcontents += mm
	mm.forceMove(src)

/obj/machinery/advreqtorio/ore_grinder/proc/outputMinerals()
	var/returnval = FALSE
	for(var/orekey in mineralcontents)
		if(mineralcontents[orekey] >= 2000)
			mineralcontents[orekey] -= 2000
			new orekey(get_turf(src))
			returnval = TRUE
	return returnval

/obj/machinery/advreqtorio/ore_grinder/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	start_processing()

/obj/machinery/advreqtorio/ore_grinder/process()
	if(!anchored)
		use_power = IDLE_POWER_USE
		stop_processing()
	use_power = ACTIVE_POWER_USE
	var/areweactuallyworking = outputMinerals()
	if(currcontents.len > 0)
		var/obj/item/mixedminerals/mm = pick(currcontents)
		for(var/orekey in mm.oresinside)
			if(!mineralcontents[orekey])
				mineralcontents[orekey] = mm.oresinside[orekey]
			else
				mineralcontents[orekey] += mm.oresinside[orekey]
		currcontents -= mm
		qdel(mm)
		areweactuallyworking = TRUE
	if(currcontents.len <= 0 && !areweactuallyworking)
		use_power = IDLE_POWER_USE
		stop_processing()

