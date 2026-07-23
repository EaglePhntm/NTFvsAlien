/datum/looping_sound/exosuit_engine/fuel
	start_sound = null
	start_length = 0
	mid_sounds = list('sound/machines/generator/generator_mid1.ogg'=1, 'sound/machines/generator/generator_mid2.ogg'=1, 'sound/machines/generator/generator_mid3.ogg'=1)
	mid_length = 4
	end_sound = null
	volume = 15

/datum/looping_sound/exosuit_engine/electric
	start_sound = null
	start_length = 0
	mid_sounds = list('sound/machines/generator/generator_mid1.ogg'=1, 'sound/machines/generator/generator_mid2.ogg'=1, 'sound/machines/generator/generator_mid3.ogg'=1)
	mid_length = 4
	end_sound = null
	volume = 15

// Sensor profiles

/datum/exo_sensors
	var/accuracy_mod
	var/rof_mod
	var/damage_mod
	var/max_range_mod

/datum/exo_sensors/none
	accuracy_mod = 0.6
	rof_mod = 1
	damage_mod = 0.85
	max_range_mod = 0.9

/datum/exo_sensors/basic
	accuracy_mod = 0.9
	rof_mod = 1
	damage_mod = 0.9
	max_range_mod = 1.5

/datum/exo_sensors/adv
	accuracy_mod = 1.2
	rof_mod = 1.1
	damage_mod = 1.1
	max_range_mod = 1.5

/datum/exo_sensors/ultra
	accuracy_mod = 1.3
	rof_mod = 1.15
	damage_mod = 1.15
	max_range_mod = 1.5

// Armor for wrecked parts

/datum/wrecked_body
	var/soft_armor = list()
	var/block_chance = 80

/datum/wrecked_body/light
	soft_armor = list(MELEE = 15, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 5)

/datum/wrecked_body/medium
	soft_armor = list(MELEE = 20, BULLET = 5, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 5, ACID = 10)

/datum/wrecked_body/heavy
	soft_armor = list(MELEE = 25, BULLET = 10, LASER = 5, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 10, ACID = 10)
