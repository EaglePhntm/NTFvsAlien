/obj/item/clothing/suit/resin_bodysuit
	name = "living resin bodysuit"
	desc = "Living mass of tentacles pretty much, yuck. This might be removed with fire."
	//get actual sprites.
	icon = 'ntf_modular/icons/obj/clothing/uniforms/uniforms.dmi'
	worn_icon_list = list(
		slot_w_uniform_str = 'ntf_modular/icons/obj/clothing/uniforms/uniforms.dmi',
		slot_wear_suit_str = 'ntf_modular/icons/obj/clothing/uniforms/uniforms.dmi',
		slot_underwear_str = 'ntf_modular/icons/obj/clothing/uniforms/uniforms.dmi'
		)
	icon_state = "resin_suit"
	color = COLOR_PURPLE
	equip_slot_flags = ITEM_SLOT_UNDERWEAR|ITEM_SLOT_ICLOTHING|ITEM_SLOT_OCLOTHING

/obj/item/clothing/suit/resin_bodysuit/equipped(mob/user, slot)
	if(!ishuman(user))
		return
	. = ..()
	if(slot != SLOT_L_HAND && slot != SLOT_R_HAND)
		RegisterSignal(user, COMSIG_LIVING_IGNITED, PROC_REF(burn_moment))
		user.visible_message(span_warning("[src] attaches itself to [user]!"),
				span_warning("[src] attaches itself to you!"),
				span_notice("You hear rustling."))
		ADD_TRAIT(src, TRAIT_NODROP, "parasite_trait")

/obj/item/clothing/suit/resin_bodysuit/proc/burn_moment(datum/source, fire_stacks)
	SIGNAL_HANDLER
	if(!ishuman(source))
		return
	var/mob/living/carbon/human/wearer = source
	wearer.visible_message(span_notice("The [src] writhes and melts away under the flames!"),
			span_notice("Your [src] writhes and melts away under the flames!"),
			span_notice("You hear sizzling."))
	REMOVE_TRAIT(src, TRAIT_NODROP, "parasite_trait")
	wearer.dropItemToGround(src)
	UnregisterSignal(wearer, COMSIG_LIVING_IGNITED, PROC_REF(burn_moment))
	if(!QDELETED(src))
		qdel(src)

/* not meant to fuck apparently
/obj/item/clothing/suit/resin_bodysuit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/parasitic_clothing)

/obj/item/clothing/suit/resin_bodysuit/Destroy()
	. = ..()
	remove_component(/datum/component/parasitic_clothing)
*/

/obj/item/clothing/resin_sack
	name = "living resin sack"
	desc = "A mass of resin and tentacles stuck to your back, weighting down a bit. This might be removed with fire."
	//get actual sprites.
	icon = 'ntf_modular/icons/obj/clothing/uniforms/uniforms.dmi'
	worn_icon_list = list(
		slot_back_str = 'ntf_modular/icons/obj/clothing/uniforms/uniforms.dmi',
		)
	icon_state = "resin_sack"
	slowdown = 0.1
	actions_types = list(/datum/action/item_action)
	equip_slot_flags = ITEM_SLOT_BACK
	var/evolve_timer
	COOLDOWN_DECLARE(egg_cooldown_timer)

//special egglay

/obj/item/clothing/resin_sack/attack_self(mob/user)
	. = ..()
	var/turf/current_turf = get_turf(user)
	if(!COOLDOWN_FINISHED(src, egg_cooldown_timer))
		balloon_alert(user, "On cooldown: [round((egg_cooldown_timer - world.time)/10)]s")
		return
	if(!current_turf.check_alien_construction(user, planned_building = /obj/alien/egg/hugger))
		return

	user.visible_message(span_xenonotice("[user] starts planting an egg."), \
		span_xenonotice("You start planting an egg."), null, 5)

	if(!do_after(user, 2.5 SECONDS, NONE, current_turf, BUSY_ICON_BUILD, extra_checks = CALLBACK(current_turf, TYPE_PROC_REF(/turf, check_alien_construction), user)))
		return

	var/datum/component/parasitic_clothing/paracomp = GetComponent(/datum/component/parasitic_clothing)
	new /obj/alien/egg/hugger(current_turf, paracomp.hivenumber)

	COOLDOWN_START(src, egg_cooldown_timer, 2 MINUTES)
	playsound(current_turf, 'sound/effects/splat.ogg', 15, 1)

/obj/item/clothing/resin_sack/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/parasitic_clothing)

/obj/item/clothing/resin_sack/Destroy()
	. = ..()
	remove_component(/datum/component/parasitic_clothing)

/obj/item/clothing/resin_sack/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_BACK)
		deltimer(evolve_timer)
		evolve_timer = addtimer(CALLBACK(src ,PROC_REF(try_evolve), user), 5 MINUTES, TIMER_STOPPABLE)

/obj/item/clothing/resin_sack/proc/try_evolve(mob/living/carbon/human/victim)
	if(!victim)
		return
	if(istype(victim.w_underwear, /obj/item/clothing/suit/resin_bodysuit))
		return
	if(victim.w_underwear)
		victim.dropItemToGround(victim.w_underwear)
	var/obj/item/clothing/suit/resin_bodysuit/goobersuit = new /obj/item/clothing/suit/resin_bodysuit(loc)
	victim.visible_message(span_warning("[src] evolves and wraps itself around [victim]!"),
			span_warning("[src] evolves and wraps itself around your body!"),
			span_notice("You hear rustling."))
	victim.equip_to_slot(goobersuit, SLOT_UNDERWEAR)

/obj/item/clothing/resin_sack/unequipped(mob/unequipper, slot)
	. = ..()
	deltimer(evolve_timer)
