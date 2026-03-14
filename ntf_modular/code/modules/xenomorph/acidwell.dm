/obj/structure/xeno/acidwell
	var/content_name = "acid"
	var/action_desc = "Place an acid well that can put out fires and burn intruders with gas."

/obj/structure/xeno/acidwell/neuro
	name = "neuro well"
	desc = "A neurotoxin well. It stores neurotoxin to put out fires and deter intruders."
	smoketype = /datum/effect_system/smoke_spread/xeno/neuro
	lightcolor = COLOR_TOXIN_XENO_NEUROTOXIN
	icon = 'ntf_modular/icons/Xeno/neuro_well.dmi'
	icon_state = "well"
	content_name = "neurotoxin"
	action_desc = "Place a neurotoxin well that can put out fires and deter intruders with gas."

/obj/structure/xeno/acidwell/neuro/punish_stepper(mob/living/stepper)
	stepper.next_move_slowdown += charges * 2 //Acid spray has slow down so this should too; scales with charges, Min 2 slowdown, Max 10
	stepper.apply_damage(charges * 10, STAMINA, BODY_ZONE_PRECISE_L_FOOT, BIO, penetration = 33)
	stepper.apply_damage(charges * 10,  STAMINA, BODY_ZONE_PRECISE_R_FOOT, BIO, penetration = 33)
	stepper.visible_message(span_danger("[stepper] is immersed in [src]'s neurotoxin!") , \
	span_danger("We are immersed in [src]'s neurotoxin!") , null, 5)
	playsound(stepper, "sound/bullets/acid_impact1.ogg", 10 * charges)
	new /obj/effect/temp_visual/acid_bath/neuro(get_turf(stepper))

/obj/structure/xeno/acidwell/aphro
	name = "aphro well"
	desc = "An aphrotoxin well. It stores aphrotoxin to put out fires and distact intruders."
	smoketype = /datum/effect_system/smoke_spread/xeno/aphrotoxin/opaque
	lightcolor = COLOR_TOXIN_APHROTOXIN
	icon = 'ntf_modular/icons/Xeno/aphro_well.dmi'
	icon_state = "well"
	content_name = "aphrotoxin"
	action_desc = "Place an aphrotoxin well that can put out fires and distract intruders with gas."

/obj/structure/xeno/acidwell/aphro/punish_stepper(mob/living/stepper)
	stepper.next_move_slowdown += charges * 2 //Acid spray has slow down so this should too; scales with charges, Min 2 slowdown, Max 10
	stepper.apply_damage(charges * 10, STAMINA, BODY_ZONE_PRECISE_L_FOOT, BIO, penetration = 33)
	stepper.apply_damage(charges * 10,  STAMINA, BODY_ZONE_PRECISE_R_FOOT, BIO, penetration = 33)
	stepper.visible_message(span_danger("[stepper] is immersed in [src]'s aphrotoxin!") , \
	span_danger("We are immersed in [src]'s aphrotoxin!") , null, 5)
	playsound(stepper, "sound/bullets/acid_impact1.ogg", 10 * charges)
	new /obj/effect/temp_visual/acid_bath/aphro(get_turf(stepper))
