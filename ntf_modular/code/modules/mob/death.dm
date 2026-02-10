/mob/death(gibbing, deathmessage, silent)
	. = ..()
	INVOKE_ASYNC(src.client, TYPE_PROC_REF(/client, ask_reclone)) //pops up the prompt
