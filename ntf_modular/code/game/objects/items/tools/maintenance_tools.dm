/obj/item/tool/weldingtool/attack(mob/living/M, mob/living/user)
	. = ..()
	if(welding && user.a_intent != INTENT_HELP)
		use(3)
		M.adjust_fire_stacks(3)
		M.IgniteMob()

