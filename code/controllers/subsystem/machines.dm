SUBSYSTEM_DEF(machines)
	name = "Machines"
	dependencies = list(
		/datum/controller/subsystem/atoms,
	)
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_LOBBY|RUNLEVEL_SETUP|RUNLEVEL_GAME|RUNLEVEL_POSTGAME

#define SSMACHINES_PROFILE_THRESHOLD 1

	var/list/currentrun = list()
	var/list/processing_early = list()
	var/list/processing = list()
	var/list/processing_power = list()
	var/list/processing_late = list()
	var/list/processing_apcs = list()
	var/list/powernets = list()
	var/list/zlevel_cables = list() //up or down cables
	var/current_part = SSMACHINES_POWERNETS
	var/cost_powernets = 0
	var/cost_machines_early = 0
	var/cost_machines = 0
	var/cost_machines_power = 0
	var/cost_apcs = 0
	var/cost_apcs_charge = 0
	var/cost_apcs_late = 0
	var/cost_machines_late = 0
	var/top_machine_process_type = "none"
	var/top_machine_process_cost = 0
	var/top_machine_process_count = 0
	var/top_machine_power_type = "none"
	var/top_machine_power_cost = 0
	var/top_machine_power_count = 0
	var/list/machine_process_type_costs = list()
	var/list/machine_process_type_counts = list()
	var/list/machine_process_group_costs = list()
	var/list/machine_process_group_counts = list()
	var/list/machine_power_type_costs = list()
	var/list/machine_power_type_counts = list()
	var/list/machine_power_group_costs = list()
	var/list/machine_power_group_counts = list()

/datum/controller/subsystem/machines/Initialize()
	makepowernets()
	fire()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/machines/proc/makepowernets()
	for(var/datum/powernet/PN in powernets)
		qdel(PN)
	powernets.Cut()

	for(var/obj/structure/cable/PC AS in GLOB.cable_list)
		if(!PC.powernet)
			var/datum/powernet/NewPN = new()
			NewPN.add_cable(PC)
			propagate_network(PC,PC.powernet)

/datum/controller/subsystem/machines/stat_entry(msg)
	msg = "P:[get_current_part_name()]|R:[length(currentrun)]|PE:[length(processing_early)]|PM:[length(processing)]|PW:[length(processing_power)]|APC:[length(processing_apcs)]|PN:[length(powernets)]|PL:[length(processing_late)]"
	msg += "|C:PN[round(cost_powernets,0.1)] E[round(cost_machines_early,0.1)] M[round(cost_machines,0.1)] PW[round(cost_machines_power,0.1)] A[round(cost_apcs,0.1)] C[round(cost_apcs_charge,0.1)] L[round(cost_apcs_late,0.1)] ML[round(cost_machines_late,0.1)]"
	msg += "|Top:M [format_top_machine_type(top_machine_process_type, top_machine_process_cost, top_machine_process_count)] PW [format_top_machine_type(top_machine_power_type, top_machine_power_cost, top_machine_power_count)]"
	msg += "|Grp:M [get_top_machine_process_groups()] PW [get_top_machine_power_groups()]"
	return ..()

/datum/controller/subsystem/machines/proc/get_current_part_name()
	switch(current_part)
		if(SSMACHINES_POWERNETS)
			return "PN"
		if(SSMACHINES_MACHINES_EARLY)
			return "EARLY"
		if(SSMACHINES_MACHINES)
			return "M"
		if(SSMACHINES_MACHINES_POWER)
			return "PW"
		if(SSMACHINES_APCS)
			return "APC"
		if(SSMACHINES_APCS_CHARGE)
			return "CHG"
		if(SSMACHINES_APCS_LATE)
			return "LATE"
		if(SSMACHINES_MACHINES_LATE)
			return "ML"
	return "?"

/datum/controller/subsystem/machines/fire(resumed = FALSE)
	if (!resumed)
		current_part = SSMACHINES_POWERNETS
		src.currentrun = powernets.Copy()

	var/seconds = wait * 0.1

	if(current_part == SSMACHINES_POWERNETS)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		var/timer = TICK_USAGE_REAL

		while(length(currentrun))
			var/datum/powernet/powernet = currentrun[length(currentrun)]
			currentrun.len--
			if(!QDELETED(powernet))
				powernet.reset() //reset the power state.
			if(MC_TICK_CHECK)
				return

		cost_powernets = MC_AVERAGE(cost_powernets, TICK_USAGE_TO_MS(timer))
		current_part = SSMACHINES_MACHINES_EARLY
		processing_power.Cut()
		src.currentrun = processing_early.Copy()

	if(current_part == SSMACHINES_MACHINES_EARLY)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		var/timer = TICK_USAGE_REAL

		while(length(currentrun))
			var/obj/machinery/thing = currentrun[length(currentrun)]
			currentrun.len--
			if(!QDELETED(thing))
				var/process_result = thing.process(seconds)
				if(process_result != PROCESS_KILL)
					if(thing.use_power && !thing.use_static_power)
						processing_power += thing
				else
					processing_early -= thing
					thing.datum_flags &= ~DF_ISPROCESSING
			else
				processing_early -= thing
			if(MC_TICK_CHECK)
				return

		cost_machines_early = MC_AVERAGE(cost_machines_early, TICK_USAGE_TO_MS(timer))
		current_part = SSMACHINES_MACHINES
		reset_machine_process_profile()
		src.currentrun = processing.Copy()

	if(current_part == SSMACHINES_MACHINES)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		var/timer = TICK_USAGE_REAL
		var/profile_types = cost_machines >= SSMACHINES_PROFILE_THRESHOLD

		while(length(currentrun))
			var/obj/machinery/thing = currentrun[length(currentrun)]
			currentrun.len--
			if(!QDELETED(thing))
				var/process_result
				if(profile_types)
					var/type_timer = TICK_USAGE_REAL
					process_result = thing.process(seconds)
					var/type_cost = TICK_USAGE_TO_MS(type_timer)
					var/type_key = "[thing.type]"
					machine_process_type_costs[type_key] += type_cost
					machine_process_type_counts[type_key] += 1
					var/group_key = get_machine_profile_group(thing)
					machine_process_group_costs[group_key] += type_cost
					machine_process_group_counts[group_key] += 1
				else
					process_result = thing.process(seconds)
				if(process_result != PROCESS_KILL)
					if(thing.use_power && !thing.use_static_power)
						processing_power += thing
				else
					processing -= thing
					thing.datum_flags &= ~DF_ISPROCESSING
			else
				processing -= thing
			if(MC_TICK_CHECK)
				return

		cost_machines = MC_AVERAGE(cost_machines, TICK_USAGE_TO_MS(timer))
		if(profile_types)
			update_top_machine_process_type()
		current_part = SSMACHINES_MACHINES_POWER
		reset_machine_power_profile()
		src.currentrun = processing_power.Copy()

	if(current_part == SSMACHINES_MACHINES_POWER)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		var/timer = TICK_USAGE_REAL
		var/profile_types = cost_machines_power >= SSMACHINES_PROFILE_THRESHOLD

		while(length(currentrun))
			var/obj/machinery/thing = currentrun[length(currentrun)]
			currentrun.len--
			if(!QDELETED(thing) && (thing.datum_flags & DF_ISPROCESSING))
				if(profile_types)
					var/type_timer = TICK_USAGE_REAL
					thing.auto_use_power() //add back the power state
					var/type_cost = TICK_USAGE_TO_MS(type_timer)
					var/type_key = "[thing.type]"
					machine_power_type_costs[type_key] += type_cost
					machine_power_type_counts[type_key] += 1
					var/group_key = get_machine_profile_group(thing)
					machine_power_group_costs[group_key] += type_cost
					machine_power_group_counts[group_key] += 1
				else
					thing.auto_use_power() //add back the power state
			if(MC_TICK_CHECK)
				return

		cost_machines_power = MC_AVERAGE(cost_machines_power, TICK_USAGE_TO_MS(timer))
		if(profile_types)
			update_top_machine_power_type()
		current_part = SSMACHINES_APCS
		src.currentrun = processing_apcs.Copy()

	if(current_part == SSMACHINES_APCS)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		var/timer = TICK_USAGE_REAL

		while(length(currentrun))
			var/obj/machinery/power/apc/thing = currentrun[length(currentrun)]
			currentrun.len--
			if(QDELETED(thing))
				processing_apcs -= thing
			else
				thing.process_power(seconds)
			if(MC_TICK_CHECK)
				return

		cost_apcs = MC_AVERAGE(cost_apcs, TICK_USAGE_TO_MS(timer))
		current_part = SSMACHINES_APCS_CHARGE
		src.currentrun = processing_apcs.Copy()

	if(current_part == SSMACHINES_APCS_CHARGE)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		var/timer = TICK_USAGE_REAL

		while(length(currentrun))
			var/obj/machinery/power/apc/thing = currentrun[length(currentrun)]
			currentrun.len--
			if(QDELETED(thing))
				processing_apcs -= thing
			else
				thing.process_charge(seconds)
			if(MC_TICK_CHECK)
				return

		cost_apcs_charge = MC_AVERAGE(cost_apcs_charge, TICK_USAGE_TO_MS(timer))
		current_part = SSMACHINES_APCS_LATE
		src.currentrun = processing_apcs.Copy()

	if(current_part == SSMACHINES_APCS_LATE)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		var/timer = TICK_USAGE_REAL

		while(length(currentrun))
			var/obj/machinery/power/apc/thing = currentrun[length(currentrun)]
			currentrun.len--
			if(QDELETED(thing))
				processing_apcs -= thing
			else
				thing.process_late(seconds)
			if(MC_TICK_CHECK)
				return

		cost_apcs_late = MC_AVERAGE(cost_apcs_late, TICK_USAGE_TO_MS(timer))
		current_part = SSMACHINES_MACHINES_LATE
		src.currentrun = processing_late.Copy()

	if(current_part == SSMACHINES_MACHINES_LATE)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		var/timer = TICK_USAGE_REAL

		while(length(currentrun))
			var/obj/machinery/thing = currentrun[length(currentrun)]
			currentrun.len--
			if(QDELETED(thing) || thing.process_late(seconds) == PROCESS_KILL)
				processing_late -= thing
				thing.datum_flags &= ~DF_ISPROCESSING
			if(MC_TICK_CHECK)
				return

		cost_machines_late = MC_AVERAGE(cost_machines_late, TICK_USAGE_TO_MS(timer))


/datum/controller/subsystem/machines/proc/reset_machine_process_profile()
	top_machine_process_type = "none"
	top_machine_process_cost = 0
	top_machine_process_count = 0
	machine_process_type_costs.Cut()
	machine_process_type_counts.Cut()
	machine_process_group_costs.Cut()
	machine_process_group_counts.Cut()

/datum/controller/subsystem/machines/proc/reset_machine_power_profile()
	top_machine_power_type = "none"
	top_machine_power_cost = 0
	top_machine_power_count = 0
	machine_power_type_costs.Cut()
	machine_power_type_counts.Cut()
	machine_power_group_costs.Cut()
	machine_power_group_counts.Cut()

/datum/controller/subsystem/machines/proc/update_top_machine_process_type()
	for(var/type_key in machine_process_type_costs)
		var/type_cost = machine_process_type_costs[type_key]
		if(type_cost > top_machine_process_cost)
			top_machine_process_cost = type_cost
			top_machine_process_count = machine_process_type_counts[type_key]
			top_machine_process_type = type_key

/datum/controller/subsystem/machines/proc/update_top_machine_power_type()
	for(var/type_key in machine_power_type_costs)
		var/type_cost = machine_power_type_costs[type_key]
		if(type_cost > top_machine_power_cost)
			top_machine_power_cost = type_cost
			top_machine_power_count = machine_power_type_counts[type_key]
			top_machine_power_type = type_key

/datum/controller/subsystem/machines/proc/get_top_machine_process_groups()
	return get_top_machine_groups(machine_process_group_costs, machine_process_group_counts)

/datum/controller/subsystem/machines/proc/get_top_machine_power_groups()
	return get_top_machine_groups(machine_power_group_costs, machine_power_group_counts)

/datum/controller/subsystem/machines/proc/get_top_machine_groups(list/group_costs, list/group_counts)
	var/list/found_groups = list()
	var/list/output = list()
	for(var/i in 1 to 3)
		var/top_group = null
		var/top_cost = 0
		for(var/group_key in group_costs)
			if(found_groups[group_key])
				continue
			var/group_cost = group_costs[group_key]
			if(group_cost > top_cost)
				top_cost = group_cost
				top_group = group_key
		if(!top_group)
			break
		found_groups[top_group] = TRUE
		output += "[top_group]([round(top_cost,0.1)]/[group_counts[top_group]])"
	if(!length(output))
		return "none"
	return output.Join(",")

/datum/controller/subsystem/machines/proc/format_top_machine_type(machine_type, machine_cost, machine_count)
	if(!machine_count)
		return "none"
	return "[machine_type]([round(machine_cost,0.1)]/[machine_count])"

/datum/controller/subsystem/machines/proc/get_machine_profile_group(obj/machinery/thing)
	var/type_string = "[thing.type]"
	var/slashes_seen = 0
	for(var/i in 1 to length(type_string))
		if(copytext(type_string, i, i + 1) != "/")
			continue
		slashes_seen++
		if(slashes_seen == 4)
			return copytext(type_string, 1, i)
	return type_string

/datum/controller/subsystem/machines/proc/setup_template_powernets(list/cables)
	for(var/A in cables)
		var/obj/structure/cable/PC = A
		if(!PC.powernet)
			var/datum/powernet/NewPN = new()
			NewPN.add_cable(PC)
			propagate_network(PC,PC.powernet)


/datum/controller/subsystem/machines/Recover()
	if(istype(SSmachines.processing))
		processing = SSmachines.processing

	if(istype(SSmachines.processing_early))
		processing_early = SSmachines.processing_early

	if(istype(SSmachines.processing_power))
		processing_power = SSmachines.processing_power

	if(istype(SSmachines.processing_late))
		processing_late = SSmachines.processing_late

	if(istype(SSmachines.processing_apcs))
		processing_apcs = SSmachines.processing_apcs

	if(istype(SSmachines.powernets))
		powernets = SSmachines.powernets

#undef SSMACHINES_PROFILE_THRESHOLD
