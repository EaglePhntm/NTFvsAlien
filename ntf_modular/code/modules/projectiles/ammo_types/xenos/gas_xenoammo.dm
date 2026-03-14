/datum/ammo/xeno/boiler_gas/aphro
	name = "glob of aphrotoxin"
	icon_state = "boiler_aphro"
	icon = 'ntf_modular/icons/obj/items/projectiles.dmi'
	sound_hit = SFX_ACID_HIT
	sound_bounce = SFX_ACID_BOUNCE
	icon_key = BOILER_GLOB_APHRO
	select_text = "We will now fire aphrotoxin gas. This is nonlethal."
	ammo_behavior_flags = AMMO_XENO|AMMO_SKIPS_ALIENS|AMMO_TARGET_TURF
	danger_message = span_danger("A glob of aphrotoxin lands with a splat and explodes into enticing fumes!")
	bullet_color = COLOR_TOXIN_APHROTOXIN

/datum/ammo/xeno/boiler_gas/aphro/set_reagents()
	spit_reagents = list(/datum/reagent/toxin/xeno_aphrotoxin = reagent_transfer_amount)

/datum/ammo/xeno/boiler_gas/aphro/set_smoke()
	smoke_system = new /datum/effect_system/smoke_spread/xeno/aphrotoxin()

/datum/ammo/xeno/boiler_gas/aphro/enhance_trap(obj/structure/xeno/trap/trap, mob/living/carbon/xenomorph/user_xeno)
	if(!do_after(user_xeno, 2 SECONDS, NONE, trap))
		return FALSE
	trap.set_trap_type(TRAP_SMOKE_APHRO)
	trap.smoke = new /datum/effect_system/smoke_spread/xeno/aphrotoxin/opaque
	trap.smoke.set_up(2, get_turf(trap))
	return TRUE

/datum/ammo/xeno/boiler_gas/aphro/lance
	name = "pressurized glob of gas"
	icon_key = BOILER_GLOB_APHRO_LANCE
	select_text = "We will now fire a pressurized aphrotoxin lance. This is barely nonlethal."
	///As opposed to normal globs, this will pass by the target tile if they hit nothing.
	ammo_behavior_flags = AMMO_XENO|AMMO_SKIPS_ALIENS|AMMO_LEAVE_TURF
	danger_message = span_danger("A pressurized glob of aphrotoxin lands with a nasty splat and explodes into enticing fumes!")
	max_range = 16
	damage = 75
	penetration = 70
	reagent_transfer_amount = 55
	passed_turf_smoke_type = /datum/effect_system/smoke_spread/xeno/aphrotoxin/light
	hit_paralyze_time = 2 SECONDS
	hit_eye_blur = 16
	hit_drowsyness = 18
	fixed_spread_range = 2
	accuracy = 100
	accurate_range = 30
	shell_speed = 1.5

/datum/ammo/xeno/boiler_gas/aphro/fast
	name = "fast glob of aphrotoxin"
	icon_key = BOILER_GLOB_APHRO_FAST
	select_text = "We will now fire fast aphrotoxic gas. This is nonlethal."
	fixed_spread_range = 2
	shell_speed = 2

/datum/ammo/xeno/boiler_gas/fast/set_smoke()
	smoke_system = new /datum/effect_system/smoke_spread/xeno/aphrotoxin/light/fast()
