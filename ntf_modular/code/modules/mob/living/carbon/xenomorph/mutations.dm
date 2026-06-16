//*********************//
//        Shell        //
//*********************//
// hunter - lone lurker
/datum/mutation_upgrade/shell/lone_lurker
	name = "Lone Lurker"
	desc = "You will gain the ability to regenerate health, sunder and plasma off weeds as if on weeds but your benefit from pheromones is reduced to 0.5x/0.7x/0.9x."
	/// For the first structure, what will our phero effectiveness reduction be
	var/multiplier_initial = 0.7
	/// For each structure
	var/multiplier_per_structure = -0.2

/datum/mutation_upgrade/shell/lone_lurker/get_desc_for_alert(new_amount)
	if(!new_amount)
		return ..()
	return "You will gain the ability to regenerate health, sunder and plasma off weeds as if on weeds but your benefit from pheromones is reduced to [get_multiplier(new_amount)]x"

/datum/mutation_upgrade/shell/lone_lurker/on_mutation_enabled()
	. = ..()
	xenomorph_owner.phero_efficency_mult -= get_multiplier(0)
	xenomorph_owner.weedless_regen = TRUE

/datum/mutation_upgrade/shell/lone_lurker/on_mutation_disabled()
	. = ..()
	xenomorph_owner.phero_efficency_mult += get_multiplier(0)
	xenomorph_owner.weedless_regen = initial(xenomorph_owner.weedless_regen)

/datum/mutation_upgrade/shell/lone_lurker/on_structure_update(previous_amount, new_amount)
	. = ..()
	xenomorph_owner.phero_efficency_mult -= get_multiplier(new_amount - previous_amount, FALSE)

/datum/mutation_upgrade/shell/lone_lurker/proc/get_multiplier(structure_count, include_initial = TRUE)
	return (include_initial ? multiplier_initial : 0) + (multiplier_per_structure * structure_count)


//*********************//
//         Spur        //
//*********************//

//hunter - execution
/datum/mutation_upgrade/spur/ambush/assassin
	name = "Execution"
	desc = "Phase Out's duration is decreased by 3 seconds. Your next sneak attack has an additional 15/22.5/30 AP."

/datum/mutation_upgrade/spur/ambush/assassin/get_desc_for_alert(new_amount)
	if(!new_amount)
		return ..()
	return  "Phase Out's duration is decreased by 3 seconds. Your next sneak attack has an additional [get_ap(new_amount)] AP."

//hunter - leaper
/datum/mutation_upgrade/spur/maul/assassin
	name = "Leaper"
	desc = "Lunge's cooldown is set to 60/50/40% of its original value."

//*********************//
//         Veil        //
//*********************//
//hunter death trail
/datum/mutation_upgrade/veil/death_trail
	name = "Death Trail"
	desc = "The duration of your Death Mark increases by 1.50x/1.75x/2x and bonus sneak attack damage of it is increased by 1.5x/1.75x/2x"
	var/multiplier_initial = 0.25
	var/multiplier_per_structure = 0.25

/datum/mutation_upgrade/veil/death_trail/get_desc_for_alert(new_amount)
	if(!new_amount)
		return ..()
	return "he duration of your Death Mark increases by [1 + get_multiplier(new_amount)] and bonus sneak attack damage of it is increased by [1 + get_multiplier(new_amount)]x"

/datum/mutation_upgrade/veil/death_trail/on_mutation_enabled()
	. = ..()
	var/datum/action/ability/activable/xeno/hunter_mark/assassin/dm_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/hunter_mark/assassin]
	if(!dm_ability)
		return
	dm_ability.death_mark_multiplier += initial(dm_ability.death_mark_multiplier) * get_multiplier(0)
	dm_ability.death_mark_damage_multiplier += initial(dm_ability.death_mark_damage_multiplier) * get_multiplier(0)

/datum/mutation_upgrade/veil/death_trail/on_mutation_disabled()
	. = ..()
	var/datum/action/ability/activable/xeno/hunter_mark/assassin/dm_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/hunter_mark/assassin]
	if(!dm_ability)
		return
	dm_ability.death_mark_multiplier -= initial(dm_ability.death_mark_multiplier) * get_multiplier(0)
	dm_ability.death_mark_damage_multiplier -= initial(dm_ability.death_mark_damage_multiplier) * get_multiplier(0)

/datum/mutation_upgrade/veil/death_trail/on_structure_update(previous_amount, new_amount)
	. = ..()
	var/datum/action/ability/activable/xeno/hunter_mark/assassin/dm_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/hunter_mark/assassin]
	if(!dm_ability)
		return
	dm_ability.death_mark_multiplier += initial(dm_ability.death_mark_multiplier) * get_multiplier(new_amount - previous_amount, FALSE)
	dm_ability.death_mark_damage_multiplier += initial(dm_ability.death_mark_damage_multiplier) * get_multiplier(new_amount - previous_amount, FALSE)

/datum/mutation_upgrade/veil/death_trail/proc/get_multiplier(structure_count, include_initial = TRUE)
	return (include_initial ? multiplier_initial : 0) + (multiplier_per_structure * structure_count)

//hunter - lights out
/datum/mutation_upgrade/veil/lights_out
	name = "Lights Out"
	desc = "Your Death Mark causes lights within 3/4/5 tiles of your target to shut down for 1/3 of it's duration."
	var/multiplier_per_structure = 1

/datum/mutation_upgrade/veil/lights_out/get_desc_for_alert(new_amount)
	if(!new_amount)
		return ..()
	return "Your Death Mark causes lights within [2 + get_multiplier(new_amount)] tiles of your target to shut down for 1/3 of it's duration."

/datum/mutation_upgrade/veil/lights_out/on_mutation_enabled()
	. = ..()
	var/datum/action/ability/activable/xeno/hunter_mark/assassin/dm_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/hunter_mark/assassin]
	if(!dm_ability)
		return
	dm_ability.turn_off_lights = TRUE
	dm_ability.light_off_range += get_multiplier(0)

/datum/mutation_upgrade/veil/lights_out/on_mutation_disabled()
	. = ..()
	var/datum/action/ability/activable/xeno/hunter_mark/assassin/dm_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/hunter_mark/assassin]
	if(!dm_ability)
		return
	dm_ability.turn_off_lights = FALSE
	dm_ability.light_off_range -= get_multiplier(0)

/datum/mutation_upgrade/veil/lights_out/on_structure_update(previous_amount, new_amount)
	. = ..()
	var/datum/action/ability/activable/xeno/hunter_mark/assassin/dm_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/hunter_mark/assassin]
	if(!dm_ability)
		return
	dm_ability.light_off_range += get_multiplier(new_amount - previous_amount)

/datum/mutation_upgrade/veil/lights_out/proc/get_multiplier(structure_count)
	return multiplier_per_structure * structure_count

//behemoth - cannonballs
//literally avalanche
/datum/mutation_upgrade/veil/cannonballs
	name = "Cannonballs"
	desc = "Earth Riser can have 1/2/3 more pillars active at a time, but its cooldown duration is doubled."
	var/amount_per_structure = 1

/datum/mutation_upgrade/veil/cannonballs/get_desc_for_alert(new_amount)
	if(!new_amount)
		return ..()
	return "Earth Riser can have [get_amount(new_amount)] more pillars active at a time, but its cooldown duration is doubled."

/datum/mutation_upgrade/veil/cannonballs/on_mutation_enabled()
	. = ..()
	var/datum/action/ability/activable/xeno/earth_riser/siege/earth_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/earth_riser/siege]
	if(!earth_ability)
		return
	var/datum/action/ability/xeno_action/primal_wrath/wrath_ability = xenomorph_owner.actions_by_path[/datum/action/ability/xeno_action/primal_wrath]
	if(wrath_ability?.ability_active) // When the wrath turns off, all the changes will be applied to the non-wrath version.
		wrath_ability.earth_riser_cooldown_changed -= initial(earth_ability.cooldown_duration)
		return
	earth_ability.cooldown_duration += initial(earth_ability.cooldown_duration)

/datum/mutation_upgrade/veil/cannonballs/on_mutation_disabled()
	. = ..()
	var/datum/action/ability/activable/xeno/earth_riser/siege/earth_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/earth_riser/siege]
	if(!earth_ability)
		return
	var/datum/action/ability/xeno_action/primal_wrath/wrath_ability = xenomorph_owner.actions_by_path[/datum/action/ability/xeno_action/primal_wrath]
	if(wrath_ability?.ability_active) // When the wrath turns off, all the changes will be applied to the non-wrath version.
		wrath_ability.earth_riser_cooldown_changed += initial(earth_ability.cooldown_duration)
		return
	earth_ability.cooldown_duration -= initial(earth_ability.cooldown_duration)

/datum/mutation_upgrade/veil/cannonballs/on_structure_update(previous_amount, new_amount)
	. = ..()
	var/datum/action/ability/activable/xeno/earth_riser/siege/earth_ability = xenomorph_owner.actions_by_path[/datum/action/ability/activable/xeno/earth_riser/siege]
	if(!earth_ability)
		return
	var/datum/action/ability/xeno_action/primal_wrath/wrath_ability = xenomorph_owner.actions_by_path[/datum/action/ability/xeno_action/primal_wrath]
	if(wrath_ability?.ability_active) // When the wrath turns off, all the changes will be applied to the non-wrath version.
		wrath_ability.earth_riser_pillars_changed -= get_amount(new_amount - previous_amount)
		return
	earth_ability.maximum_pillars += get_amount(new_amount - previous_amount)

/// Returns the amount that Earth Riser's maximum pillars should be increased by.
/datum/mutation_upgrade/veil/cannonballs/proc/get_amount(structure_count)
	return amount_per_structure * structure_count
