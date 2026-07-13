#define ENGINE_ON 1
#define ENGINE_OFF 2

/obj/vehicle/sealed/mecha/ntf
	desc = "NTF Exosuit"
	allow_diagonal_movement = FALSE
	move_delay = 3
	max_integrity = 400
	soft_armor = list(MELEE = 60, BULLET = 40, LASER = 30, ENERGY = 30, BOMB = 25, BIO = 0, FIRE = 50, ACID = 50)
	max_temperature = 25000
	force = 30
	mech_type = EXOSUIT_MODULE_NTF|EXOSUIT_MODULE_COMBAT
	max_equip_by_category = list(
		MECHA_UTILITY = 1,
		MECHA_POWER = 1,
		MECHA_ARMOR = 0,
	)
	step_energy_drain = POWER_USAGE_STANDARD
	facing_modifiers = list(VEHICLE_FRONT_ARMOUR = 0.75, VEHICLE_SIDE_ARMOUR = 1, VEHICLE_BACK_ARMOUR = 1.25)
	operation_req_access = list()
	internals_req_access = list()
	destruction_sleep_duration = 6
	can_dna_lock = FALSE
	can_be_moved_in_maints = TRUE
	enter_delay = EGRESS_TIME_STANDARD
	exit_delay = EGRESS_TIME_STANDARD
	pixel_x = -8

/// How resistant the hull is to projectile penetration
	var/cockpit_armor = COCKPIT_TOUGHENED

	var/engine_state = ENGINE_OFF
	var/datum/looping_sound/exosuit_engine/fuel/soundloop
	var/engine_starting_sound

/obj/vehicle/sealed/mecha/ntf/Initialize(mapload)
	.=..()
	set_jump_component()

/obj/vehicle/sealed/mecha/ntf/proc/set_jump_component(duration = 0.2 SECONDS, cooldown = 1 SECONDS, cost = 8, height = 8, sound = null, flags = JUMP_SHADOW, jump_pass_flags = null)
	var/list/arg_list = list(duration, cooldown, cost, height, sound, flags, jump_pass_flags)
	if(SEND_SIGNAL(src, COMSIG_LIVING_SET_JUMP_COMPONENT, arg_list))
		duration = arg_list[1]
		cooldown = arg_list[2]
		cost = arg_list[3]
		height = arg_list[4]
		sound = arg_list[5]
		flags = arg_list[6]
		jump_pass_flags = arg_list[7]

	var/gravity = get_gravity()
	if(gravity < 1) //low grav
		duration *= 2.5 - gravity
		cooldown *= 2 - gravity
		cost *= gravity * 0.5
		height *= 2 - gravity
	else if(gravity > 1) //high grav
		duration *= gravity * 0.5
		cooldown *= gravity
		cost *= gravity
		height *= gravity * 0.5

	AddComponent(/datum/component/jump/exosuit, _jump_duration = duration, _jump_cooldown = cooldown, _stamina_cost = cost, _jump_height = height, _jump_sound = sound, _jump_flags = flags, _jumper_allow_pass_flags = jump_pass_flags)

/obj/vehicle/sealed/mecha/ntf/fire_act(burn_level)
	if(burn_level > 25)
		take_damage(burn_level, FIRE)

/obj/vehicle/sealed/mecha
	///Whether or not adding a DNA is possible
	var/can_dna_lock = TRUE
	///If the incoming occupant is a passenger or not
	var/loading_passenger = FALSE
	///If there's light amplification (mech NVGs) or not
	var/light_amplification = FALSE
	///Settings for mech NVGs
	var/color_cutoffs = list()
	///Settings for mech NVGs
	var/lighting_cutoff = null
	///Sound effect for when a occupant dies
	var/occupant_death_note = 'ntf_modular/sound/effects/deadspace_alert.ogg'

/// Passenger loading (via drag-drop)

/obj/vehicle/sealed/mecha/auto_assign_occupant_flags(mob/M)
	if(loading_passenger)
		return
	..()

/obj/vehicle/sealed/mecha/nft/remove_occupant(mob/M)
	REMOVE_TRAIT(M, TRAIT_EXOSUIT_NV, VEHICLE_TRAIT)
	M.update_sight()
	return ..()

/obj/vehicle/sealed/mecha/MouseDrop_T(mob/living/passenger, mob/user)
	if(!ishuman(passenger) || passenger == user)
		return ..()
	if(!Adjacent(user))
		return ..()
	if(occupant_amount() >= max_occupants || is_occupant(passenger))
		return ..()
	if(obj_integrity <= 0)
		return ..()
	user.visible_message(
			span_notice("[user] loads [passenger] into \the [src]."),
			span_notice("You load [passenger] into \the [src].")
	)
	if(!do_after(user, enter_delay, target = passenger, user_display = BUSY_ICON_FRIENDLY))
		return ..()
	if(occupant_amount() >= max_occupants || is_occupant(passenger) || QDELETED(src))
		return ..()
	moved_inside(passenger, is_passenger = TRUE)
