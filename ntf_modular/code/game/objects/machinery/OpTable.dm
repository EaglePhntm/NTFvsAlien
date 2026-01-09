/obj/machinery/optable/stasis
	name = "Stasis Operating Table"
	desc = "Used for advanced medical procedures, this is an expensive, advanced version that keeps patients stasis-ed in case of critical status."
	icon = 'ntf_modular/icons/obj/surgery.dmi'

/obj/machinery/optable/stasis/post_buckle_mob(mob/living/buckled_mob)
	. = ..()
	buckled_mob.add_filter("stasis_filter", 1, color_matrix_filter(rgb(0, 132, 255)))
	ADD_TRAIT(buckled_mob, TRAIT_STASIS, type)

/obj/machinery/optable/stasis/post_unbuckle_mob(mob/living/buckled_mob)
	. = ..()
	buckled_mob.remove_filter("stasis_filter")
	REMOVE_TRAIT(buckled_mob, TRAIT_STASIS, type)
