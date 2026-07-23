/obj/vehicle/sealed/mecha/ntf/bullet_act(atom/movable/projectile/proj, def_zone, piercing_hit)
	var/actual_zone = def_zone || proj.def_zone
	var/armor_rating = soft_armor.getRating(proj.armor_type)
	var/pen_quality = clamp((proj.penetration - (armor_rating * cockpit_armor)) / max(armor_rating, 1), 0, 1)
	if(LAZYLEN(occupants))
		var/mob/living/occupant = pick(occupants)
		if(pen_quality && LAZYLEN(occupants) && !(mecha_flags & SILICON_PILOT) && !(mecha_flags & CANNOT_OVERPENETRATE) && (actual_zone == BODY_ZONE_HEAD || actual_zone == BODY_ZONE_CHEST))
			var/original_damage = proj.damage
			var/pilot_damage = round(proj.damage * pen_quality * 0.90)
			proj.damage -= pilot_damage
			. = ..()
			proj.damage = pilot_damage
			if(proj.armor_type == BOMB || proj.damage >= 300 || proj.penetration >= 90)
				var/occupant_count = length(occupants)
				proj.damage /= occupant_count
				for(var/mob/living/hitee in occupants)
					hitee.bullet_act(proj, actual_zone, piercing_hit)
				proj.damage = original_damage
				return
			occupant.bullet_act(proj, actual_zone, piercing_hit)
			proj.damage = original_damage
			return
	return ..()

/// tries to damage mech equipment depending on damage and where is being targetted
/obj/vehicle/sealed/mecha/ntf/try_damage_component(damage, def_zone, armor_type)
	var/list/gear = list()
	switch(def_zone)
		if(BODY_ZONE_L_ARM)
			gear = equip_by_category[MECHA_L_ARM]
		if(BODY_ZONE_R_ARM)
			gear = equip_by_category[MECHA_R_ARM]
		if(BODY_ZONE_HEAD)
			gear = list(head)
		if(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)
			gear = list(body)
		if(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
			gear = list(legs)
	if(armor_type == BOMB)
		gear = flat_equipment.Copy()
	if(!length(gear))
		return

	for(var/obj/item/mecha_parts/mecha_equipment/gear2 as anything in gear)
	// always leave at least 1 health
//		var/damage_to_deal = min(gear2.obj_integrity - 1, damage)
//		if(damage_to_deal <= 0)
//			return
		gear2.take_damage(damage)
		if(gear2.obj_integrity <= 1)
			to_chat(occupants, "[icon2html(src, occupants)][span_danger("[gear2] is critically damaged!")]")
			playsound(src, gear2.destroy_sound, 50)

/obj/vehicle/sealed/mecha/ntf/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.a_intent == INTENT_HARM)
		user.changeNext_move(CLICK_CD_MELEE) // Ugh. Ideally we shouldn't be setting cooldowns outside of click code.
		user.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
		playsound(loc, 'sound/weapons/tap.ogg', 40, TRUE, -1)
		user.visible_message(span_danger("[user] hits [src]. Nothing happens."), null, null, COMBAT_MESSAGE_RANGE)
		log_message("Attack by hand/paw (no damage). Attacker - [user].", LOG_MECHA, color="red")
		return
	toggle_hatch(user, FALSE)

//obj/vehicle/sealed/mecha/ntf/RightClick(mob/living/user)
//	if(!(user in occupants))
//		return
//	toggle_hatch(user, TRUE)

#define STUCK_AGAINST_TERRAIN 15 SECONDS
#define STUCK_AGAINST_TERRAIN_CHANCE 50

/obj/vehicle/sealed/mecha/ntf/proc/toggle_hatch(mob/living/user, toggling_lock = FALSE)
	if(hatch_status == HATCH_BROKEN)
		balloon_alert(user, "hatch is broken!")
		return

	if(toggling_lock)
		if(hatch_status == HATCH_OPEN)
			balloon_alert(user, "close it first!")
			return
		hatch_status = (hatch_status == HATCH_LOCKED) ? HATCH_CLOSED : HATCH_LOCKED
		playsound(src, hatch_status == HATCH_LOCKED ? 'sound/machines/closet/closet_lock.ogg' : 'sound/machines/closet/closet_unlock.ogg', 50)
		balloon_alert(user, hatch_status == HATCH_LOCKED ? "locked!" : "unlocked!")
	else
		if(hatch_status == HATCH_LOCKED)
			balloon_alert(user, "unlock first!")
			playsound(src, 'sound/machines/closet/closet_lock.ogg', 50)
			return
		if(is_flipped && hatch_location == flip_status && hatch_status == HATCH_CLOSED | hatch_status == HATCH_LOCKED)
			balloon_alert(user, "trying to open!")
			if(do_after(user, STUCK_AGAINST_TERRAIN, target = src))
				if(prob(STUCK_AGAINST_TERRAIN_CHANCE))
					balloon_alert(user, "hatch opened!")
					playsound(src, 'sound/machines/closet/closet_open.ogg', 50)
					hatch_status = HATCH_OPEN
				else
					balloon_alert(user, "hatch stuck!")

					return
			update_icon()
			return
		hatch_status = (hatch_status == HATCH_OPEN) ? HATCH_CLOSED : HATCH_OPEN
		playsound(src, hatch_status == HATCH_OPEN ? 'sound/machines/closet/closet_open.ogg' : 'sound/machines/closet/closet_close.ogg', 50)
		balloon_alert(user, hatch_status == HATCH_OPEN ? "opened!" : "closed!")
	update_icon()

#undef STUCK_AGAINST_TERRAIN
#undef STUCK_AGAINST_TERRAIN_CHANCE

/obj/vehicle/sealed/mecha/ntf/on_mouseclick(mob/user, atom/target, turf/location, control, list/modifiers)
	.=..()
	modifiers = params2list(modifiers)
	if(src != target)
		return
	if(modifiers[RIGHT_CLICK])
		return src.toggle_hatch(user, TRUE)
	toggle_hatch(user)

#define TRY_UNFLIP 7 SECONDS

/obj/vehicle/sealed/mecha/ntf/crowbar_act(mob/living/user, obj/item/I)
	.=..()
	if(is_flipped)
		if(do_after(user, TRY_UNFLIP, target = src))
			if(prob(50))
				balloon_alert(user, "exosuit rightened!")
				playsound(src, 'sound/items/crowbar.ogg', 50)
				attempt_unflip()
			else
				to_chat(user, span_warning("The [src] slides off the [I], back to the ground!"))
				playsound(src, 'sound/effects/bang.ogg', 50)
				return
	else
		return ..()

#undef TRY_UNFLIP
