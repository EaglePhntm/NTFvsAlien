/mob/proc/get_iff_signal()
	var/obj/item/card/id/id = get_idcard()
	return id?.iff_signal

/mob/living/silicon/ai/get_iff_signal()
	return GLOB.faction_to_iff[faction]

/mob/camera/aiEye/get_iff_signal()
	if(ai)
		return ai.get_iff_signal()
	return GLOB.faction_to_iff[faction]
