/mob/living/carbon/human/resuscitate()
	. = ..()
	client.reclone_start_time = null
	client.reclone_time = null
