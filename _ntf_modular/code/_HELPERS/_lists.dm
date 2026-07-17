//i cant believe tgmc doesnt have this

/**
 * Picks a random element from a list based on a weighting system.
 * For example, given the following list:
 * A = 6, B = 3, C = 1, D = 0
 * A would have a 60% chance of being picked,
 * B would have a 30% chance of being picked,
 * C would have a 10% chance of being picked,
 * and D would have a 0% chance of being picked.
 * You should only pass integers in.
 */
/proc/pick_weight(list/list_to_pick)
	if(length(list_to_pick) == 0)
		return null

	var/total = 0
	for(var/item in list_to_pick)
		if(!list_to_pick[item])
			list_to_pick[item] = 0
		total += list_to_pick[item]

	total = rand(1, total)
	for(var/item in list_to_pick)
		var/item_weight = list_to_pick[item]
		if(item_weight == 0)
			continue

		total -= item_weight
		if(total <= 0)
			return item

	return null

/**
* Like pick_weight, but decreases the value of the picked element by 1
 * For example, given the following list:
 * A = 6, B = 3, C = 1, D = 0
 * A would have a 60% chance of being picked, after which it would decrease by one and the new list would be
 * A = 5, B = 3, C = 1, D = 0
 * Tt would then have a 55.55...% to be picked, rinse and repeat
*/
/proc/pick_weight_take(list/list_to_pick)
	. = pick_weight(list_to_pick)
	list_to_pick[.]--
