#define FUELTYPE_GAS /datum/reagent/fuel
//#define FUELTYPE_ELECTRIC 2

#define COOLDOWN_ENGINE_START "engine_start"

/obj/item/mecha_parts/exosuit_engine
	name = "exosuit fuel engine"
	desc = "A small engine, running on fuel. Has a built-in fuel container."

	max_integrity = 100

	var/fuel_type = FUELTYPE_GAS
	var/fuel_max = 1000
	var/fuel_amount = 0
	var/fuel_high_consumption = 2
	var/fuel_idle_consumption = 0.1
	var/comes_prefilled = TRUE

	var/is_functional = TRUE
	var/is_running = FALSE

	var/ignition_power_consumption = 20
	var/ignition_cycle_attempts = 2

	var/datum/looping_sound/engine_running_sound = /datum/looping_sound/exosuit_engine_fuel/sound_loop
	var/engine_starting_sound = 'sound/machines/generator/generator_start.ogg'
	var/engine_stop_sound = 'sound/machines/generator/generator_end.ogg'

	var/obj/vehicle/sealed/mecha/ntf/chassis

	// Amount of power the engine creates per tick
	var/engine_power_generated = 100
	// Amount of power the engine 'has to use', abstracted as a power cell
	var/obj/item/cell/engine_power/engine_power_pool

	var/obj/item/cell/starting_battery/starter_battery
	var/engine_initial_start_chance = 15

/obj/item/cell/engine_power
	name = "energy pool"
	desc = "A concept of the max amount of power/motivation an exosuit engine can produce. Should zero when the engines turns off."
	maxcharge = 500
	charge_amount = 100
	charge = 0

/obj/item/cell/starting_battery
	name = "electric start battery"
	desc = "A small battery for starting a small engine"
	maxcharge = 500
	charge_amount = 10
	charge = 500

/obj/item/mecha_parts/exosuit_engine/Destroy()
	engine_stop()
	return ..()

/obj/item/mecha_parts/exosuit_engine/proc/is_active()
	return is_running

/obj/item/mecha_parts/exosuit_engine/proc/add_battery(obj/item/cell/add_battery)
	QDEL_NULL(starter_battery)
	if(add_battery)
		add_battery.forceMove(src)
		starter_battery = add_battery
		return
	starter_battery = new /obj/item/cell (src)

/obj/item/mecha_parts/exosuit_engine/Initialize(mapload)
	.=..()
	if(engine_running_sound)
		engine_running_sound = new engine_running_sound(list(src))
	if(comes_prefilled)
		create_reagents(fuel_max, AMOUNT_VISIBLE, list(/datum/reagent/fuel = fuel_max))
	add_battery()

/obj/item/mecha_parts/exosuit_engine/get_fueltype()
	return fuel_type

/obj/item/mecha_parts/exosuit_engine/process()
	if(is_functional && is_running)
		if(fuel_amount >= fuel_idle_consumption)
			fuel_amount = max(0, fuel_amount - fuel_idle_consumption)
		if(engine_power_pool && !engine_power_pool.is_fully_charged())
			engine_power_pool.give(engine_power_generated * GLOB.CELLRATE)
		if(starter_battery && !starter_battery.is_fully_charged())
			var/starter_charge_amount = ((engine_power_generated * 0.1) * GLOB.CELLRATE)
			if(engine_power_pool && engine_power_pool.use(starter_charge_amount))
				starter_battery.give(starter_charge_amount)
		if(fuel_amount < fuel_idle_consumption)
			engine_stop()

/obj/item/mecha_parts/exosuit_engine/obj_break()
	engine_stop()
	is_functional = FALSE
	return ..()

/obj/item/mecha_parts/exosuit_engine/proc/attempt_engine_start()
	if(is_running)
		visible_message(span_warning("[src] is already running"))
		return FALSE
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_ENGINE_START))
		visible_message(span_warning("[src] is already trying to start"))
		return

	S_TIMER_COOLDOWN_START(src, COOLDOWN_ENGINE_START, 2 SECONDS)

	var/can_start = is_functional && fuel_amount >= 0
	var/current_start_chance = can_start ? engine_initial_start_chance : 0

	for(var/i in 1 to ignition_cycle_attempts)

		if(!starter_battery)
			playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3) // dead sound
			balloon_alert(src, "dead!")
			return FALSE

		if(starter_battery.charge < ignition_power_consumption)
			if(starter_battery.charge > ignition_power_consumption/5)
				playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3) // flat sound
				balloon_alert(src, "flat 1!")
				current_start_chance *= 0.2
			else
				playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3) // dead sound
				balloon_alert(src, "dead 2!")
				return FALSE
		else
			playsound(loc, 'sound/mecha/engine/engine_starting.ogg', 25, 1, 3) // normal start sound
			balloon_alert(src, "normal strart!")

	starter_battery.use(ignition_power_consumption)
	if(chassis)
		chassis.flicker_lights(draw = ignition_power_consumption)
	if(!prob(engine_initial_start_chance))
		return
	engine_start()

/obj/vehicle/sealed/mecha/ntf/proc/flicker_lights(draw = 50)
//	if(mecha_flags & LIGHTS_ON)
//		set_flicker(amount, flicker_time_lower = 1, flicker_time_upper = 1.2, flicker_delay = 0.3 SECONDS, ignore_flickering = TRUE)

/obj/item/mecha_parts/exosuit_engine/proc/engine_start()
	is_running = TRUE
	if(engine_running_sound)
		engine_running_sound?.start(skip_startsound = TRUE)
	START_PROCESSING(SSobj, src)

/obj/item/mecha_parts/exosuit_engine/proc/engine_stop()
	is_running = FALSE
	if(engine_running_sound)
		engine_running_sound?.stop(skip_startsound = TRUE)
	STOP_PROCESSING(SSobj, src)

#define FUEL_PER_CAN_POUR 100

/obj/item/mecha_parts/exosuit_engine/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/jerrycan))
		var/obj/item/reagent_containers/jerrycan/gascan = I
		if(gascan.reagents.total_volume == 0)
			balloon_alert(user, "no fuel!")
			return
		if(fuel_amount >= fuel_max)
			balloon_alert(user, "full!")
			return

		var/fuel_transfer_amount = min(gascan.fuel_usage*2, gascan.reagents.total_volume)
		gascan.reagents.remove_reagent(/datum/reagent/fuel, fuel_transfer_amount)
		fuel_amount = min(fuel_amount + FUEL_PER_CAN_POUR, fuel_max)
		playsound(loc, 'sound/effects/refill.ogg', 25, 1, 3)
		balloon_alert(user, "[fuel_amount/fuel_max*100]%")
		return TRUE
	return ..()

#undef FUEL_PER_CAN_POUR
