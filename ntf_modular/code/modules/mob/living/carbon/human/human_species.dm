/mob/living/carbon/human/ai/neutral/Initialize(mapload, datum/outfit/job/outfit)
	. = ..()
	ASYNC
		if(!outfit)
			outfit = pick(GLOB.civindep_outfits)
		outfit = new outfit()
		var/datum/job/outfit_job = SSjob.type_occupations[outfit.jobtype]
		job = outfit_job
		outfit.equip(src, FALSE, TRUE)
		if(wear_id)
			wear_id.access = job.access
			wear_id.iff_signal = NONE
		job = SSjob.type_occupations[/datum/job/civindep]
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/monkey) //give me civilians, neutral humans AI damn it!

/mob/living/carbon/human/ai/evzneutral

/mob/living/carbon/human/ai/evzneutral/Initialize(mapload, datum/outfit/job/outfit)
	. = ..()
	a_intent = INTENT_HARM
	ASYNC
		if(!outfit)
			outfit = pick(GLOB.eastvietzhuan_outfits)
		outfit = new outfit()
		var/datum/job/outfit_job = SSjob.type_occupations[outfit.jobtype]
		job = outfit_job
		outfit.equip(src, FALSE, TRUE)
		if(wear_id)
			wear_id.access = job.access
			wear_id.iff_signal = NONE
		job = SSjob.type_occupations[/datum/job/civindep/eastvietzhuan]
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/human/monkey) //give me civilians, neutral humans AI damn it!
