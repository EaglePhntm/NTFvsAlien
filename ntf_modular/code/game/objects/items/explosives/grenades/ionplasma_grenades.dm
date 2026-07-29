/obj/item/explosive/grenade/ionplasma
	name = "\improper M55 PLASFIRE grenade"
	desc = "The M55 PLASFIRE, nickamed 'GOBLIN' has a grenade casing design similar to the M15 model but disperses ionizing plasma fire in a tight radius. The PLASFIRE M55 is used to cut off tight bottlenecks and enforce prolonged area denial compared to the M40 HIDP incendiary grenade. It is set to detonate in 3 seconds."
	icon = 'ntf_modular/icons/obj/items/grenade.dmi'
	icon_state = "grenade_ionplasma"
	worn_icon_state = "grenade_ionplasma"
	hud_state = "electrothermal"
	det_time = 3 SECONDS
	icon_state_mini = "grenade_green"

/obj/item/explosive/grenade/ionplasma/prime()
    plasma_radius(1, get_turf(src))
    playsound(loc, SFX_INCENDIARY_EXPLOSION, 35)
    qdel(src)


/obj/item/explosive/grenade/ionplasma/proc/plasma_radius(radius = 1, turf/epicenter, burn_intensity = 30, burn_duration = 35, burn_damage = 20, fire_stacks = 10, colour = "green", fire_type = /obj/fire/flamer) //~Art updated fire.
    if(!isturf(epicenter))
        CRASH("flame_radius used without a valid turf parameter")
    radius = clamp(radius, 1, 50) //Sanitize inputs
    var/burn_mod = 1
    for(var/t in filled_turfs(epicenter, radius, "square", pass_flags_checked = PASS_AIR))
        var/turf/turf_to_flame = t
        if(istype(turf_to_flame, /turf/closed/wall))
            burn_mod = 3

        turf_to_flame.ignite(randfloat(burn_duration*0.1, burn_duration), burn_intensity * burn_mod, colour, burn_damage, fire_stacks, fire_type)

        for(var/mob/living/mob_caught in turf_to_flame)
            if(mob_caught.stat == DEAD)
                continue
            mob_caught.adjust_fire_stacks(burn_damage)
            mob_caught.IgniteMob()
