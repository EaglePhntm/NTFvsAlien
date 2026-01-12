/mob/living/carbon/xenomorph/Destroy()
	var/mob/living/carbon/human/user = eaten_mob
	if(user)
		user.handle_unhaul()
		eaten_mob = null
	. = ..()

/mob/living/carbon/xenomorph/Paralyze(amount, updating, ignore_canstun)
	. = ..()
	var/mob/living/carbon/human/user = eaten_mob
	if(user)
		user.handle_unhaul()
		eaten_mob = null

/mob/living/carbon/xenomorph/Knockdown(amount, ignore_canstun)
	. = ..()
	var/mob/living/carbon/human/user = eaten_mob
	if(user)
		user.handle_unhaul()
		eaten_mob = null

/mob/living/carbon/xenomorph/knockback(source, distance, speed, dir, knockback_force)
	. = ..()
	var/mob/living/carbon/human/user = eaten_mob
	if(user)
		user.handle_unhaul()
		eaten_mob = null

/mob/living/carbon/xenomorph/death(gibbing, deathmessage, silent)
	var/mob/living/carbon/human/user = eaten_mob
	if(user)
		user.handle_unhaul()
		eaten_mob = null
	. = ..()

/mob/living/carbon/xenomorph/on_crit()
	var/mob/living/carbon/human/user = eaten_mob
	if(user)
		user.handle_unhaul()
		eaten_mob = null
	. = ..()

/mob/living/carbon/human/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount, damage_type, armor_type, effects, armor_penetration, isrightclick)
	if(HAS_TRAIT(src, TRAIT_HAULED))
		to_chat(xeno_attacker, span_warning("[src] is being hauled, we cannot do anything to them."))
		return
	. = ..()

#define XENO_GRAB_DISALLOWMENT_LIST list(/obj/item/explosive, /obj/item/weapon, /obj/item/clothing, /obj/item/storage, /obj/item/tool)

/obj/item/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount, damage_type, armor_type, effects, armor_penetration, isrightclick)
	if(!(SSticker.mode.round_type_flags & MODE_XENO_GRAB_DEAD_ALLOWED)) //imma just use dead grab cause its usually gonna be hand to hand with this
		if(is_type_in_list(src, XENO_GRAB_DISALLOWMENT_LIST))
			to_chat(xeno_attacker, span_xenonotice("<i>(War mode)</i> We have no reason to grab that."))
			return FALSE
	. = ..()
