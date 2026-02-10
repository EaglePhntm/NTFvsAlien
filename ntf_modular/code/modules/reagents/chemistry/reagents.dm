/datum/reagent/consumable/nutriment/cum
	name = "Humanoid Sperm"
	description = "Cum, somehow is supposedly imbued with sexual magic, used in reproduction, fun and sexual healing."
	nutriment_factor = 1
	color = "#dadada"
	custom_metabolism = REAGENTS_METABOLISM
	reagent_ui_priority =  REAGENT_UI_MUNDANE
	brute_heal = 1
	burn_heal = 1
	blood_gain = 0.4

/datum/reagent/toxin/acid/xeno_cum
	name = "Acidic Semen"
	description = "The acidic semen supposed to be nutrition source for xenomorph sperm, now burning pain inside people, thankfully it's not potent as regular acid."
	color = "#9bd19aff"
	toxpwr = 0.5
	meltprob = 0

/datum/reagent/consumable/milk/xeno
	name = "Xenomorphic Milk"
	description = "An opaque greenish liquid produced by the mammary glands of xenomorphs."
	color = "#c4e2c4"
	taste_description = "fizzy milk"
	reagent_ui_priority =  REAGENT_UI_MUNDANE

/datum/reagent/consumable/nutriment/cum/xeno
	name = "Xenomorphic Sperm"
	description = "Xeno cum, not directly harmful when not ejected alongside acid like most xenomorphs do."
	nutriment_factor = 2
	color = "#9bd19a"
	reagent_ui_priority =  REAGENT_UI_MUNDANE
	brute_heal = 1.2
	burn_heal = 1.2
	blood_gain = 0.4

/datum/reagent/consumable/nutriment/cum/xeno/resin
	name = "Xenomorphic Resin"
	description = "Strange xenomorph ejaculate thet numbs the victim, slowing them and also it's extremely hard to clean from orifices due how sticky it is."
	nutriment_factor = 1
	color = "#360242"
	custom_metabolism = REAGENTS_METABOLISM * 0.5
	reagent_ui_priority =  REAGENT_UI_MUNDANE
	brute_heal = 1.4
	burn_heal = 1.4
	blood_gain = 0.2

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
	brute_heal = 0.75
	burn_heal = 0.75
	blood_gain = 0.7
	color = "#dadada63"

///ADRENALINE, basically old synaptizine with buffs?
/datum/reagent/medicine/adrenaline
	name = "Adrenaline"
	description = "Gotta go fast!"
	color = "#f14a17"
	overdose_threshold = REAGENTS_OVERDOSE/5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL/5
	scannable = TRUE
	custom_metabolism = REAGENTS_METABOLISM * 0.5
	purge_rate = 5

/datum/reagent/medicine/adrenaline/on_mob_add(mob/living/carbon/human/L, metabolism)
	if(TIMER_COOLDOWN_RUNNING(L, name))
		return
	L.adjustStaminaLoss(-30 * effect_str)
	to_chat(L, span_userdanger("You feel a burst of energy as the adrenaline courses through you! Time to go fast!"))

	if(L.health < L.health_threshold_crit && volume >= 3)
		to_chat(L, span_userdanger("Heart explosion! Power flows through your veins!"))
		L.adjustBruteLoss(-L.getBruteLoss(TRUE) * 0.40)
		L.jitter(5)

/datum/reagent/medicine/adrenaline/on_mob_life(mob/living/L, metabolism)
	L.reagent_shock_modifier += PAIN_REDUCTION_MEDIUM
	L.adjustDrowsyness(-0.5 SECONDS)
	L.AdjustUnconscious(-2 SECONDS)
	L.AdjustStun(-2 SECONDS)
	L.AdjustParalyzed(-2 SECONDS)
	L.adjustToxLoss(0.8 * effect_str)
	L.hallucination = max(0, L.hallucination - 10)
	switch(current_cycle)
		if(1 to 10)
			L.adjustStaminaLoss(-7.5 * effect_str)
		if(11 to 40)
			L.adjustStaminaLoss((current_cycle*0.75 - 14)*effect_str)
		if(41 to INFINITY)
			L.adjustStaminaLoss(15 * effect_str)
	return ..()

/datum/reagent/medicine/adrenaline/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/adrenaline/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(effect_str, effect_str, effect_str)

/datum/reagent/medicine/adrenaline/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_userdanger("The room spins as your adrenaline starts to wear off!"))
	TIMER_COOLDOWN_START(L, name, 60 SECONDS)
