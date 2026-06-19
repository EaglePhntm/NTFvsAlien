/datum/action/vehicle/sealed/mecha/pulsearmor/phazon
	name = "Electro-Pulse Armor"
	action_icon_state = "pulsearmor"
	delay
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_MECHABILITY_PULSE_ARMOR,
	)
	power_cost = 500
	block_max = 100
	block_remaining
	decay_per_second = 7.5
	movespeed_mod = 2
	cooldown_time = 30 SECONDS
