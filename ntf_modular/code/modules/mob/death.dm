/mob/death(gibbing, deathmessage, silent)
	. = ..()
	if(client && ishuman(src))
		INVOKE_ASYNC(src.client, TYPE_PROC_REF(/client, ask_reclone)) //pops up the prompt and recalcs the time
