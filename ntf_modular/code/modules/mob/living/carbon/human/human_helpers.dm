/mob/living/carbon/human/resuscitate()
	. = ..()
	if(client)
		client.reclone_start_time = null
		client.reclone_time = null
