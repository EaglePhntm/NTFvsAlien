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
