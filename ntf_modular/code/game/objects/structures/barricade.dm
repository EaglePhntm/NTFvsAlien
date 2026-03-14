/obj/structure/barricade/hitby(atom/movable/atom_movable)
	if(atom_movable.throwing && is_wired)
		if(iscarbon(atom_movable))
			var/mob/living/carbon/living_carbon = atom_movable
			if(living_carbon.mob_size <= MOB_SIZE_XENO) // so most of t3 xeno's are immune to that
				balloon_alert(living_carbon, "Wire slices into us")
				living_carbon.apply_damage(10, blocked = MELEE , sharp = TRUE, updating_health = TRUE)
				living_carbon.Knockdown(2 SECONDS) //Leaping into barbed wire is VERY bad
				playsound(living_carbon, 'ntf_modular/sound/machines/bonk.ogg', 75, FALSE)
	..()
