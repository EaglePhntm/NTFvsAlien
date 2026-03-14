/obj/structure/ship_ammo/cas/minirocket/satrapine
	name = "Satrapine mini rocket stack"
	desc = "A pack of laser guided mini rockets loaded with pain inducing Satrapine gas. Moving this will require some sort of lifter."
	icon_state = "minirocket_satrapine"
	icon = 'ntf_modular/icons/obj/structures/prop/mainship.dmi'
	point_cost = 250
	devastating_explosion_range = 0
	travelling_time = 4 SECONDS
	heavy_explosion_range = 0
	light_explosion_range = 2
	cas_effect = /obj/effect/overlay/blinking_laser/Satrapine
	crosshair = 'ntf_modular/icons/UI_icons/cas_crosshairs/rocket_satrapine.dmi'

/obj/structure/ship_ammo/cas/minirocket/satrapine/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(2)
	var/datum/effect_system/smoke_spread/satrapine/S = new
	for(var/obj/machinery/deployable/mounted/sentry/ads_system/ads in range(GLOB.ads_intercept_range,impact))
		if(!COOLDOWN_FINISHED(ads, intercept_cooldown))
			continue
		if(ads.try_intercept(impact, src, 0.5, 5))
			S.set_up(0, impact, 1)
			S.start()
			return
	S.set_up(2, impact, 9)
	S.start()
	explosion(impact, devastating_explosion_range, heavy_explosion_range, light_explosion_range, throw_range = 0, explosion_cause=src)

/obj/structure/ship_ammo/cas/minirocket/KnockOut
	name = "KnockOut mini rocket stack"
	desc = "A pack of laser guided mini rockets loaded with sleep inducing KnockOut gas. Moving this will require some sort of lifter."
	icon_state = "minirocket_knockout"
	icon = 'ntf_modular/icons/obj/structures/prop/mainship.dmi'
	point_cost = 250
	devastating_explosion_range = 0
	travelling_time = 4 SECONDS
	heavy_explosion_range = 0
	light_explosion_range = 2
	cas_effect = /obj/effect/overlay/blinking_laser/KnockOut
	crosshair = 'ntf_modular/icons/UI_icons/cas_crosshairs/rocket_KnockOut.dmi'

/obj/structure/ship_ammo/cas/minirocket/KnockOut/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(2)
	var/datum/effect_system/smoke_spread/sleepy/S = new
	for(var/obj/machinery/deployable/mounted/sentry/ads_system/ads in range(GLOB.ads_intercept_range,impact))
		if(!COOLDOWN_FINISHED(ads, intercept_cooldown))
			continue
		if(ads.try_intercept(impact, src, 0.5, 5))
			S.set_up(0, impact, 1)
			S.start()
			return
	S.set_up(2, impact, 9)
	S.start()
	explosion(impact, devastating_explosion_range, heavy_explosion_range, light_explosion_range, throw_range = 0, explosion_cause=src)

/obj/structure/ship_ammo/cas/minirocket/razorburn
	name = "Razorburn mini rocket stack"
	desc = "A pack of laser guided mini rockets loaded with synthesized concentrated razorburn foam dispersal agents. Moving this will require some sort of lifter."
	icon_state = "minirocket_razorburn"
	icon = 'ntf_modular/icons/obj/structures/prop/mainship.dmi'
	point_cost = 350
	devastating_explosion_range = 0
	travelling_time = 4 SECONDS
	heavy_explosion_range = 0
	light_explosion_range = 2
	cas_effect = /obj/effect/overlay/blinking_laser/razorburn
	crosshair = 'ntf_modular/icons/UI_icons/cas_crosshairs/rocket_razorburn.dmi'
	var/obj/item/reagent_containers/glass/beaker/large/B1
	var/obj/item/reagent_containers/glass/beaker/large/B2
	var/B1_chems = list(/datum/reagent/toxin/nanites = 10)
	var/B2_chems = list(/datum/reagent/foaming_agent = 5)

/obj/structure/ship_ammo/cas/minirocket/razorburn/Initialize(mapload)
	. = ..()
	B1 = new()
	B2 = new()

/obj/structure/ship_ammo/cas/minirocket/razorburn/Destroy()
	QDEL_NULL(B1)
	QDEL_NULL(B2)
	. = ..()

/obj/structure/ship_ammo/cas/minirocket/razorburn/detonate_on(turf/impact, attackdir = NORTH)
	impact.ceiling_debris_check(2)
	for(var/obj/machinery/deployable/mounted/sentry/ads_system/ads in range(GLOB.ads_intercept_range,impact))
		if(!COOLDOWN_FINISHED(ads, intercept_cooldown))
			continue
		if(ads.try_intercept(impact, src, 0.5, 5))
			var/datum/effect_system/smoke_spread/debris/S = new
			S.set_up(0, impact, 1)
			S.start()
			return
	B1.reagents.add_reagent_list(B1_chems)
	B2.reagents.add_reagent_list(B2_chems)
	chem_splash(impact, 1, list(B1.reagents, B2.reagents), 10, 1)
	explosion(impact, devastating_explosion_range, heavy_explosion_range, light_explosion_range, throw_range = 0, explosion_cause=src)

/obj/structure/ship_ammo/cas/minirocket/razorburn/metal_foam
	name = "metal foam mini rocket stack"
	desc = "A pack of laser guided mini rockets loaded with synthesized concentrated metal foam dispersal agents. Moving this will require some sort of lifter."
	icon_state = "minirocket_metal_foam"
	icon = 'ntf_modular/icons/obj/structures/prop/mainship.dmi'
	point_cost = 350
	devastating_explosion_range = 0
	travelling_time = 4 SECONDS
	heavy_explosion_range = 0
	light_explosion_range = 2
	cas_effect = /obj/effect/overlay/blinking_laser/metal_foam
	crosshair = 'ntf_modular/icons/UI_icons/cas_crosshairs/rocket_metal_foam.dmi'
	B1_chems = list(/datum/reagent/aluminum = 5)
	B2_chems = list(/datum/reagent/foaming_agent = 5, /datum/reagent/toxin/acid/polyacid = 1)
