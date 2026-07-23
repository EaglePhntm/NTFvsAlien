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

//generates genetic material
/datum/reagent/consumable/nutriment/cum/xeno/strong
	name = "Xenomorphic Sperm"
	description = "Xeno cum, not directly harmful when not ejected alongside acid like most xenomorphs do."
	nutriment_factor = 2
	color = "#9bd19a"
	reagent_ui_priority =  REAGENT_UI_MUNDANE
	brute_heal = 1.2
	burn_heal = 1.2
	blood_gain = 0.4

/datum/reagent/consumable/milk/human
	name = "Human Milk"
	description = "An opaque white liquid from the mammary glands of a human being."
	color = "#ebebeb"
	taste_description = "warm milk"
	reagent_ui_priority =  REAGENT_UI_MUNDANE

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

// Start of various cum research options, for squad sluts, or for med researchers

/datum/chemical_reaction/milkresearch
	results = null
	required_reagents = list(/datum/reagent/consumable/milk/human = 10)
	required_catalysts = list(/datum/reagent/medicine/lemoline = 5)

/datum/chemical_reaction/milkresearch/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.get_holder())
	new /obj/item/research_resource/humancum(location)

/datum/chemical_reaction/girlresearch
	results = null
	required_reagents = list(/datum/reagent/consumable/nutriment/cum/girl = 10)
	required_catalysts = list(/datum/reagent/medicine/lemoline = 5)

/datum/chemical_reaction/girlresearch/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.get_holder())
	new /obj/item/research_resource/humancum(location)

/datum/chemical_reaction/boyresearch
	results = null
	required_reagents = list(/datum/reagent/consumable/nutriment/cum = 10)
	required_catalysts = list(/datum/reagent/medicine/lemoline = 5)

/datum/chemical_reaction/boyresearch/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.get_holder())
	new /obj/item/research_resource/humancum(location)

/datum/chemical_reaction/xoyresearch
	results = null
	required_reagents = list(/datum/reagent/consumable/nutriment/cum/xeno/strong = 30)
	required_catalysts = list(/datum/reagent/medicine/lemoline = 5)

/datum/chemical_reaction/xoyresearch/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.get_holder())
	new /obj/item/research_resource/xenocum(location)

/datum/chemical_reaction/xirlresearch
	results = null
	required_reagents = list(/datum/reagent/consumable/milk/xeno = 30)
	required_catalysts = list(/datum/reagent/medicine/lemoline = 5)

/datum/chemical_reaction/xirlresearch/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.get_holder())
	new /obj/item/research_resource/xenocum(location)

// End of various cum based researches

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
	to_chat(L, span_userdanger("You feel a burst of energy as the adrenaline courses through you!!"))

	if(L.health < L.health_threshold_crit && volume >= 3)
		to_chat(L, span_userdanger("Power flows through your veins!"))
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

//aphrotoxin
/datum/reagent/toxin/xeno_aphrotoxin
	name = "Aphrotoxin"
	description = "An aphrodisiac made naturally by some xenos, it is used to disorient hosts and eventually break their minds on sustained use. Very dangerous and slow to metabolise."
	reagent_state = LIQUID
	color = COLOR_TOXIN_APHROTOXIN
	overdose_threshold = 10000
	scannable = TRUE
	custom_metabolism = REAGENTS_METABOLISM*0.2
	toxpwr = 0
	var/mob/living/carbon/debuff_owner
	var/obj/effect/abstract/particle_holder/particle_holder
	var/mob/living/carbon/human/debuff_ownerhuman
	var/clothesundoed = 0

/particles/aphrodisiac
	icon = 'ntf_modular/icons/effects/particles/generic_particles.dmi'
	icon_state = "heart"
	width = 100
	height = 100
	count = 1000
	spawning = 4
	lifespan = 9
	fade = 10
	grow = 0.2
	velocity = list(0, 0)
	position = generator(GEN_SPHERE, 10, 10, NORMAL_RAND)
	drift = generator(GEN_VECTOR, list(0, -0.15), list(0, 0.15))
	gravity = list(0, 0.4)
	scale = generator(GEN_VECTOR, list(0.3, 0.3), list(0.9,0.9), NORMAL_RAND)
	rotation = 0
	color = "#b002db"

/datum/reagent/toxin/xeno_aphrotoxin/on_mob_life(mob/living/L, metabolism)
	if(debuff_owner)
		particle_holder.particles.spawning = 1 + round(debuff_owner.reagents.get_reagent_amount(/datum/reagent/toxin/xeno_aphrotoxin) / 4)
	var/arousal_to_add = 5
	if(L.sexcon)
		arousal_to_add += min(25, (L.reagents.get_reagent_amount(/datum/reagent/toxin/xeno_aphrotoxin)))
		switch(L.sexcon.arousal)
			if(1 to 50)
				if(prob(15))
					to_chat(L, span_warning("You feel your [L.gender==MALE ? "cock throb a little," : "vagina get a bit wet,"] distracting you.") )
			if(51 to 100)
				if(prob(15))
					to_chat(L, span_warning("You feel your [L.gender==MALE ? "cock harden and throb." : "vagina drip down your legs."] your knees feel weak!") )
			if(101 to 150)
				if(prob(15))
					L.emote("blush")
					L.AdjustConfused(1 SECONDS)
				if(prob(15))
					to_chat(L, span_warning("You feel your [L.gender==MALE ? "cock throb with need!" : "vagina is dripping a trail!"] Your legs tremble, too weak to walk for a moment.") )
				L.adjustStaminaLoss(5)
			if(151 to MAX_AROUSAL)
				if(prob(15))
					L.emote("moan")
					L.AdjustConfused(2 SECONDS)
				if(prob(15))
					to_chat(L, span_warning("You feel your [L.gender==MALE ? "cock throb hard as steel!" : "vagina is dripping like a waterfall!"] your legs almost give up as you come near orgasm!") )
				L.adjustStaminaLoss(5)
	if(L.sexcon.arousal + arousal_to_add < (MAX_AROUSAL - 40))
		L.sexcon.adjust_arousal(arousal_to_add)
	else
		if(prob(5))
			to_chat(L, span_warning("You HAVE to [L.gender==MALE ? "fuck!" : "get fucked!"] you are going crazy with need!") )
			L.sexcon.adjust_arousal(5) //slow creep of cooming
	return ..()

/// Called when the debuff's owner uses the Resist action for this debuff.
/datum/reagent/toxin/xeno_aphrotoxin/proc/call_resist_debuff()
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(resist_debuff)) // grilled cheese sandwich

/// Resisting the debuff will allow the debuff's owner to remove some stacks from themselves.
/datum/reagent/toxin/xeno_aphrotoxin/proc/resist_debuff()
	var/channel = SSsounds.random_available_channel()
	if(length(debuff_owner.do_actions))
		return
	if(clothesundoed != 1)
		if(debuff_ownerhuman.w_uniform)
			debuff_ownerhuman.visible_message(span_warning("[debuff_ownerhuman] begins to undo [debuff_ownerhuman.p_their()] clothes and expose [debuff_ownerhuman.p_their()] [debuff_ownerhuman.gender==MALE ? "cock" : "pussy"]!"), span_warning("You begin to undo your clothes and expose your [debuff_ownerhuman.gender==MALE ? "cock" : "pussy"]."), span_warning("You hear ruffling."), 5)
			if(!do_after(debuff_owner, 1.5 SECONDS, TRUE, debuff_owner, BUSY_ICON_CLOCK))
				debuff_owner?.balloon_alert(debuff_owner, "Interrupted")
				return
	clothesundoed = 1
	playsound(debuff_owner, "sound/effects/squelch2.ogg", 30, channel = channel)
	debuff_ownerhuman.visible_message(span_warning("[debuff_ownerhuman] begins to [debuff_ownerhuman.gender==MALE ? "jack off" : "rub her slit"]!"), span_warning("You begin to [debuff_ownerhuman.gender==MALE ? "jack off" : "rub your vagina"]."), span_warning("You hear slapping."), 5)
	if(!do_after(debuff_owner, 10 SECONDS, TRUE, debuff_owner, BUSY_ICON_GENERIC))
		debuff_owner?.balloon_alert(debuff_owner, "Interrupted.")
		debuff_owner.stop_sound_channel(channel)
		clothesundoed = 0
		return
	if(!debuff_owner)
		usr.stop_sound_channel(channel)
		return
	debuff_owner.emote("moan")
	debuff_owner.visible_message(span_warning("[debuff_owner] cums on the floor!"), span_warning("You cum on the floor."), span_warning("You hear a splatter."), 5)
	debuff_owner.balloon_alert(debuff_owner, "Orgasmed.")
	debuff_owner.adjustStaminaLoss(75)

	playsound(usr.loc, "sound/effects/splat.ogg", 30)
	debuff_owner.update_eye_blur()
	debuff_owner.reagents.remove_reagent(/datum/reagent/toxin/xeno_aphrotoxin, 20)
	debuff_owner.sexcon?.ejaculate(debuff_owner)
	if(debuff_owner.getStaminaLoss() > 120)
		if(prob(5))
			debuff_owner.visible_message(span_warning("[debuff_owner] manages to black out from cumming too hard..."), 4)
			debuff_owner.SetUnconscious(8 SECONDS)
	if(debuff_owner.reagents.get_reagent_amount(/datum/reagent/toxin/xeno_aphrotoxin) > 0)
		resist_debuff() // We repeat ourselves as long as the debuff persists.
		return
	clothesundoed = 0

/datum/reagent/toxin/xeno_aphrotoxin/on_mob_add(mob/living/L)
	if(L.status_flags & GODMODE)
		qdel(src)
		return
	if(isxeno(L))
		qdel(src)
		return
	. = ..()
	debuff_ownerhuman = L
	debuff_owner = L
	RegisterSignal(L, COMSIG_LIVING_DO_RESIST, PROC_REF(call_resist_debuff))
	L.balloon_alert(L, "Aphrotoxin")
	particle_holder = new(L, /particles/aphrodisiac)
	particle_holder.particles.spawning = 1 + round(debuff_owner.reagents.get_reagent_amount(/datum/reagent/toxin/xeno_aphrotoxin) / 2)
	particle_holder.pixel_x = -2
	particle_holder.pixel_y = 0
	if(HAS_TRAIT(debuff_owner, TRAIT_INTOXICATION_RESISTANT) || (debuff_owner.get_soft_armor(BIO) >= 65))
		custom_metabolism = REAGENTS_METABOLISM

/datum/reagent/toxin/xeno_aphrotoxin/on_mob_delete()
	UnregisterSignal(debuff_owner, COMSIG_LIVING_DO_RESIST)
	debuff_owner = null
	QDEL_NULL(particle_holder)
	return ..()

/datum/chemical_reaction/aphrotojelly
	results = list(/datum/reagent/consumable/larvajelly = 2.5)
	required_reagents = list(/datum/reagent/toxin/xeno_aphrotoxin = 5)
	required_catalysts = list(/datum/reagent/consumable/nutriment/cum/xeno = 5)

//acid hugger stuff
/datum/reagent/toxin/acid/potent_xenocum
	name = "High-Corrosive Acidic Sperm"
	description = "A very corrosive acid cum, get it out quick."
	color = COLOR_TOXIN_ACID
	custom_metabolism = REAGENTS_METABOLISM //drips i guess
	toxpwr = 1
	meltprob = 5
	taste_description = "acid"

/datum/reagent/toxin/acid/potent_xenocum/on_mob_life(mob/living/L, metabolism)
	L.take_limb_damage(0, 1.5*effect_str)
	return ..()
