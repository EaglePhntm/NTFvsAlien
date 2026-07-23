#define FUELTYPE_GAS 1
#define FUELTYPE_ELECTRIC 2

#define COOLDOWN_ENGINE_START "engine_start"

/obj/item/mecha_parts/exosuit_engine
	name = "exosuit fuel engine"
	desc = "A small engine, running on fuel. Has a built-in fuel container."

	max_integrity = 100

	var/fuel_type = FUELTYPE_GAS
	var/fuel_max_amount = 100
	var/fuel_amount = 0
	var/fuel_high_consumption = 2
	var/fuel_idle_consumption = 0.1
	var/comes_prefilled = FALSE

	var/is_functional = TRUE
	var/is_running = FALSE

	var/ignition_power_consumption = 100
	var/ignition_cycle_attempts = 2

//	var/engine_running_sound = /datum/looping_sound/exosuit_engine/fuel/soundloop
	var/engine_starting_sound = 'sound/machines/generator/generator_start.ogg'
	var/engine_stop_sound = 'sound/machines/generator/generator_end.ogg'

	var/obj/vehicle/sealed/mecha/ntf/chassis

	// Amount of power the engine creates per tick
	var/engine_power_generated = 100
	// Amount of power the engine 'has to use'
	var/engine_abstract_power_current = 0
	// Max amount of power the engine can 'store'
	var/engine_abstract_power_max = 500

	var/obj/item/cell/engine_starter_battery
	var/engine_initial_start_chance = 15

///obj/item/mecha_parts/exosuit_engine/Initialize(mapload)

///obj/item/mecha_parts/exosuit_engine/attackby(obj/item/O, mob/user, params)
//	var/obj/item
//	if(!I.

/obj/item/mecha_parts/exosuit_engine/process()
	if(is_functional && is_running)
		if(fuel_amount >= fuel_idle_consumption)
			fuel_amount -= fuel_idle_consumption
		if(engine_abstract_power_current < engine_abstract_power_max)
			engine_abstract_power_current += engine_power_generated

/obj/item/mecha_parts/exosuit_engine/obj_break()
	engine_stop()
	is_functional = FALSE
	return ..()

/obj/item/mecha_parts/exosuit_engine/proc/attempt_engine_start()
	if(is_running)
		return FALSE
	if(!engine_starter_battery)
		visible_message(span_warning("[src] has no starter battery installed!"))
		return FALSE
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_ENGINE_START))
		return

	S_TIMER_COOLDOWN_START(src, COOLDOWN_ENGINE_START, "engine_start")

	var/can_start = is_functional && fuel_amount <= 0
	var/current_start_chance = can_start ? engine_initial_start_chance : 0

	visible_message(span_notice("The [src]'s engine attempts to start!"))
	engine_starter_battery.use(ignition_power_consumption)
	chassis.flicker_lights(draw = ignition_power_consumption)
//	playsound(src, 'sound/effects/engine.ogg', 50)
	if(!prob(engine_initial_start_chance))
		visible_message(span_notice("The [src]'s engine fails to start!"))

/obj/vehicle/sealed/mecha/ntf/proc/flicker_lights(draw = 50)
//	if(mecha_flags & LIGHTS_ON)
//		set_flicker(amount, flicker_time_lower = 1, flicker_time_upper = 1.2, flicker_delay = 0.3 SECONDS, ignore_flickering = TRUE)

/obj/item/mecha_parts/exosuit_engine/proc/engine_start()
	is_running = TRUE
	START_PROCESSING(SSobj, src)

/obj/item/mecha_parts/exosuit_engine/proc/engine_stop()
	is_running = FALSE
	STOP_PROCESSING(SSobj, src)

