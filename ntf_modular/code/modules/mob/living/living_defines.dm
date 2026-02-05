/mob
	var/list/ckey_history = list() // The ckey of the player that first started controlling this mob, used for finding ssd retake candidates.
	var/speaking_noise
	var/datum/sex_controller/sexcon

	var/can_restore_skills = FALSE
	var/extract_count = 0
	var/inherent_accesses = list()
