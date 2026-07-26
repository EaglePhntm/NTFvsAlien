/obj/vehicle/sealed/mecha/ntf/deconstruct(disassembled = TRUE, mob/living/blame_mob)
	if(!(mecha_flags & MECHA_IS_WRECKABLE))
		return ..()
	if((mecha_flags & MECHA_IS_WRECK))
		return ..()
	wreck_mecha()

/obj/vehicle/sealed/mecha/ntf/proc/wreck_mecha()
	completely_disabled = TRUE
//	soft_armor = body.wrecked_profile.soft_armor
	density = FALSE
	anchored = FALSE
	construction_state = MECHA_OPEN_HATCH
	mecha_flags |= MECHA_IS_WRECK
	obj_integrity = body.wreck_health
