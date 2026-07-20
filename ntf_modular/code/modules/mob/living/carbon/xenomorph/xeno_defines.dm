/mob/living/carbon/xenomorph
	var/melee_multiplier_from_hive = 1
	var/haul_timer
	speaking_noise = SFX_ALIEN_TALK
	/// Stored aphrotoxin globs created from Boiler's Create Bomb.
	var/aphro_ammo = 0
	var/phero_efficency_mult = 1
	var/weedless_regen = FALSE
	COOLDOWN_DECLARE(gender_swap_cooldown)
