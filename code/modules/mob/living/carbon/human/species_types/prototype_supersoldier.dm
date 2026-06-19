/datum/species/human/prototype_supersoldier
	name = "Prototype Supersoldier"
	//slowdown = -0.25
	inherent_traits = list(TRAIT_TOO_TALL)
	inherent_actions = list(/datum/action/supersoldier_stims,/datum/action/ability/indominable)
	namepool = /datum/namepool/prototype_supersoldier
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	Prototype Supersoldiers are Novamed's experimental military units made to be superior in strength and speed compared to regular soldiers but their altered neural architecture makes them incompatible with skillsofts, \
	they were designed primarily to be able to withstand extreme combat stims that make them highly adaptable and dangerous. But they are less resillient to extreme injury due to abuse of these stims.<br /><br /><br /><br />  \
	<b>Physiology</b>:<br /><br /> \
	Prototype Supersoldiers have enhanced physical capabilities, including increased muscle mass and improved cardiovascular efficiency, and being taller overall.<br /><br /><br /><br />  \
	<b>Psychology</b>:<br /><br /> \
	Prototype Supersoldiers are generally more single-minded than regular humans, usually indoctrinated from the vat or training facilities alongside their genes being modified for loyalty.<br /><br />"

/datum/species/human/prototype_supersoldier/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	H.health_threshold_crit = -25

/datum/species/human/prototype_supersoldier/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	H.health_threshold_crit = initial(H.health_threshold_crit)
