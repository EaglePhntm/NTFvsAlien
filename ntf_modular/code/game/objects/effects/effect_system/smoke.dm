/obj/effect/particle_effect/smoke/xeno/aphrotoxin
	color = "#ba03f1"
	alpha = 120
	smoke_traits = SMOKE_XENO|SMOKE_COUGH
	smoke_traits2 = SMOKE_XENO_APHROTOXIN

/datum/effect_system/smoke_spread/xeno/aphrotoxin
	smoke_type = /obj/effect/particle_effect/smoke/xeno/aphrotoxin

/obj/effect/particle_effect/smoke/xeno/aphrotoxin/light
	alpha = 60
	opacity = FALSE

/obj/effect/particle_effect/smoke/xeno/aphrotoxin/opaque
	alpha = 255

/datum/effect_system/smoke_spread/xeno/aphrotoxin/opaque
	smoke_type = /obj/effect/particle_effect/smoke/xeno/aphrotoxin/opaque

/datum/effect_system/smoke_spread/xeno/aphrotoxin/light
	smoke_type = /obj/effect/particle_effect/smoke/xeno/aphrotoxin/light

/obj/effect/particle_effect/smoke/xeno/aphrotoxin/light
	alpha = 120
	opacity = FALSE
	smoke_traits = SMOKE_XENO|SMOKE_COUGH
	smoke_traits2 = SMOKE_XENO_APHROTOXIN

/datum/effect_system/smoke_spread/xeno/aphrotoxin/light/fast
	smoke_type = /obj/effect/particle_effect/smoke/xeno/aphrotoxin/light/fast

/obj/effect/particle_effect/smoke/xeno/aphrotoxin/light/fast
	lifetime = 1
	smoke_traits = SMOKE_XENO|SMOKE_COUGH|SMOKE_EXTINGUISH
	smoke_traits2 = SMOKE_XENO_APHROTOXIN

/obj/effect/particle_effect/smoke/debris
	alpha = 50
	smoke_traits = SMOKE_COUGH
	opacity = FALSE
	lifetime = 1

/datum/effect_system/smoke_spread/debris
	smoke_type = /obj/effect/particle_effect/smoke/debris
