/mob
	var/list/ckey_history = list() // The ckey of the player that first started controlling this mob, used for finding ssd retake candidates.
	var/speaking_noise
	var/datum/sex_controller/sexcon

	var/inherent_accesses = list()
