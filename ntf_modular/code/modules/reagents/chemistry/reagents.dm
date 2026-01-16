/datum/reagent/consumable/nutriment/cum
	name = "Humanoid Sperm"
	description = "Cum, somehow is supposedly imbued with sexual magic, used in reproduction, fun and sexual healing."
	nutriment_factor = 2
	color = "#dadada"
	reagent_ui_priority =  REAGENT_UI_MUNDANE // nutriment is more important than other food chems
	brute_heal = 0.5
	burn_heal = 0.5
	blood_gain = 0.2

/datum/reagent/toxin/acid/xeno_cum
	name = "Acidic Semen"
	description = "The acidic semen supposed to be nutrition source for xenomorph sperm, now burning pain inside people, thankfully it's not potent as regular acid."
	color = "#9bd19aff"
	toxpwr = 0.5
	meltprob = 0

/datum/reagent/consumable/nutriment/cum/xeno
	name = "Xenomorphic Sperm"
	description = "Xeno cum, not directly harmful when not ejected alongside acid like most xenomorphs do, it is otherwise better than human cum in most ways."
	nutriment_factor = 4
	color = "#9bd19a"
	reagent_ui_priority =  REAGENT_UI_MUNDANE // nutriment is more important than other food chems
	brute_heal = 0.7
	burn_heal = 0.7
	blood_gain = 0.4

/datum/reagent/consumable/nutriment/cum/xeno/resin
	name = "Xenomorphic Resin"
	description = "Strange xenomorph ejaculate thet numbs the victim, slowing them and also it's extremely hard to clean from orifices due how sticky it is."
	nutriment_factor = 4
	color = "#360242"
	custom_metabolism = REAGENTS_METABOLISM
	reagent_ui_priority =  REAGENT_UI_TOXINS // nutriment is more important than other food chems
	brute_heal = 0.7
	burn_heal = 0.7
	blood_gain = 0.1

/datum/reagent/consumable/nutriment/cum/xeno/resin/on_mob_life(mob/living/L, metabolism)
	L.reagent_pain_modifier += PAIN_REDUCTION_VERY_HEAVY
	if(prob(50))
		L.heal_limb_damage(brute_heal, burn_heal)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		if(C.get_blood_volume() < BLOOD_VOLUME_NORMAL)
			C.adjust_blood_volume(blood_gain)
		C.add_slowdown(0.2,2)

	return ..()

/datum/reagent/consumable/nutriment/cum/girl
	name = "Female Lubricant"
	description = "Pussyjuice, less potent than cum for some reason but still somehow is imbued with magic, used in reproduction aid, fun and sexual healing."
	nutriment_factor = 1
	brute_heal = 0.25
	burn_heal = 0.25
	blood_gain = 0.3
	color = "#dadada63"
