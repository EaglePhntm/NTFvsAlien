/obj/vehicle/sealed/mecha/bullet_act(atom/movable/projectile/proj, def_zone, piercing_hit)
	var/actual_zone = def_zone || proj.def_zone
	var/armor_rating = soft_armor.getRating(proj.armor_type)
	var/pen_quality = clamp((proj.penetration - (armor_rating * cockpit_armor)) / max(armor_rating, 1), 0, 1)
	if(pen_quality && LAZYLEN(occupants) && !(mecha_flags & SILICON_PILOT) && !(mecha_flags & CANNOT_OVERPENETRATE) && (actual_zone == BODY_ZONE_HEAD || actual_zone == BODY_ZONE_CHEST))
		var/original_damage = proj.damage
		var/pilot_damage = round(proj.damage * pen_quality * 0.90)
		proj.damage -= pilot_damage
		. = ..()
		proj.damage = pilot_damage
		pick(occupants).bullet_act(proj, actual_zone, piercing_hit)
		proj.damage = original_damage
		return
	return ..()


/*
/obj/vehicle/sealed/mecha/bullet_act(atom/movable/projectile/proj, def_zone, piercing_hit)
	var/actual_zone = def_zone || proj.def_zone
	var/armor_rating = soft_armor.getRating(proj.armor_type)
	var/pen_quality = clamp((proj.penetration - (armor_rating * cockpit_armor)) / max(armor_rating, 1), 0, 1)

	if(pen_quality && LAZYLEN(occupants) && !(mecha_flags & SILICON_PILOT) && !(mecha_flags & CANNOT_OVERPENETRATE) && (actual_zone == BODY_ZONE_HEAD || actual_zone == BODY_ZONE_CHEST))
		var/original_damage = proj.damage
		var/pilot_damage = round(proj.damage * pen_quality * 0.90)
		proj.damage -= pilot_damage
		. = ..()
		proj.damage = pilot_damage
		pick(occupants).bullet_act(proj, actual_zone, piercing_hit)
		proj.damage = original_damage
		return

	return ..()
*/

/*
/obj/vehicle/sealed/mecha/bullet_act(atom/movable/projectile/proj, def_zone, piercing_hit) //wrapper
	var/known_firer = key_name(proj.firer)
	if(known_firer)
		known_firer += " fired by [known_firer]"
	log_message("Hit by projectile [known_firer]. Type: [proj]([proj.ammo.damage_type]).", LOG_MECHA, color="red")
	// yes we *have* to run the armor calc proc here I love tg projectile code too
	try_damage_component(
		modify_by_armor(proj.damage, proj.ammo.armor_type, proj.ammo.penetration, attack_dir = REVERSE_DIR(proj.dir)),
		proj.def_zone,
	)
	return ..()
*/
