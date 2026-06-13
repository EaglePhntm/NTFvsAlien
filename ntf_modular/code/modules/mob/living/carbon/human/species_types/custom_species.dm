/datum/species/resurgentis
	name = "Resurgentis"
	icobase = BODYPART_ICON_HUMAN
	unarmed_type = /datum/unarmed_attack/punch/medium
	species_flags = HAS_LIPS|HAS_UNDERWEAR|HAS_SKIN_COLOR
	count_human = TRUE
	joinable_roundstart = TRUE
	has_genital_selection = TRUE
	limb_type = SPECIES_LIMB_SPLURT
	splurt_limb_prefix = "human"
	screams = list(MALE = SFX_MALE_SCREAM, FEMALE = SFX_FEMALE_SCREAM)
	paincries = list(MALE = SFX_MALE_PAIN, FEMALE = SFX_FEMALE_PAIN)
	goredcries = list(MALE = SFX_MALE_GORED, FEMALE = SFX_FEMALE_GORED)
	gasps = list(MALE = SFX_MALE_GASP, FEMALE = SFX_FEMALE_GASP)
	chokes = list(FEMALE = SFX_FEMALE_CHOKE)
	coughs = list(MALE = SFX_MALE_COUGH, FEMALE = SFX_FEMALE_COUGH)
	groans = list(FEMALE = SFX_FEMALE_GROAN)
	chokes = list(FEMALE = SFX_FEMALE_CHOKE)
	sexymoanlights = list(FEMALE = SFX_FEMALE_SEXYMOANLIGHT)
	sexymoanhvys = list(FEMALE = SFX_FEMALE_SEXYMOANHVY)
	burstscreams = list(MALE = SFX_MALE_PREBURST, FEMALE = SFX_FEMALE_PREBURST)
	warcries = list(MALE = SFX_MALE_WARCRY, FEMALE = SFX_FEMALE_WARCRY)
	special_death_message = "<big>You have perished.</big><br><small>But it is not the end of you yet... if you still have your body with your head still attached, wait until somebody can resurrect you...</small>"
	flesh_color = "#780064"
	total_health = 115
	brute_mod = 0.9
	burn_mod = 1.1
	taste_sensitivity = TASTE_SENSITIVE
	species_description = "<br /><br /><b>Lore</b>:<br /><br /> \
	The Resurgentis are one of the oldest species of humanoids after humans, they are the primary population of phantom city, the now biggest free city of the new world.<br /><br /> \
	They have been allegedly, ancestrally created by the death god, from altered semi-undead humans who were supposed to be the superior race...<br /><br /> \
	While their ancestors are semi-undead, their offspring, therefore entirety of the race except the tree originals are entirely living.<br /><br /> \
	They usually aren't happy to hear about the racist remark towards them, 'reapers' to shorten their species name, for the reason their ancestors have been associated with cannibalism,<br /><br /> \
	alongside certain cannibal tribes in 'middle ages' of the New World and even todays in no mans land.<br /><br /><br /><br /> \
	<b>Physiology</b>:<br /><br /> \
	Due to their allegedly designed physiology, they have a greater tolerance to pain and damage, mostly due to their denser muscles, slightly larger size and unique blood.<br /><br /> \
	However they are also more vulnerable to burning damage due to their poor body insulation and temperature regulation due to larger size and also due to their blood. <br /><br /> \
	They are also known for their purple skin and unique glowing neon colored 'essence' (or the mentioned blood) of many colors, which determine the color of their glowing hair, glowing iris-invisible eyes, (and glowing nipples, inner vagina) colors, their blood is oddly compatible with humans given the types match as usual (although resurgentis have more blood types than humans).<br /><br /><br /><br /> \
	The luminosity of their blood is lost shortly after upon exiting their circulatory system, as if indicating life force, similiarly older resurgentis tend to have a dimmer glow. <br /><br />\
	Resurgentis males' muscles are naturally built to be stronger while female are more wired for agility and dexterity while still being slightly stronger than the average human. <br /><br /> \
	Mismatched color of glowing parts are a rare sight but not unheard of, though some people may call them murk blood or mutants, there is no evidence to support these claims. <br /><br /> \
	Crossbreeds with resurgentis are usually sterile and with potential for disabilities such as muteness or else, due to the strange genes of resurgentis, and the said dominant genes make the crossbreeds \
	result in largely resurgentis-appearing offspring with features from the other race. <br /><br />\
	The resurgentis have extremely low birth rate due to the short lifespan of eggs of females and scarcer ovulation cycles, therefore putting their species at risk of extinction due to the high violence of Phantom City and overall the world, but their high libido is a compensation for such problem, barely.<br /><br /><br /><br /> \
	They can't have black essence color, and white is considered extremely rare, being more resillient to psionics and mind control for unknown reasons and is seen as a gift from the death god, made to protect themselves from the corruption in the world.<br /><br /> \
	<b>Psychology</b>:<br /><br /> \
	They are largely human-like behaving although slightly more unhinged in terms of lewdity and more inclined to act on their impulses if not conditioned against it mentally.<br /><br /> \
	Cryostatis is more disorienting to resurgentis than to other species, mentally and physically.<br /><br /> \
	Resurgentis are the prime prey of Corrupted (the shadowy monsters that started emerging after the great war.), they are able to be corrupted into one of them through 'mind flayers' fog, except the white essence resurgentis, phantom city had to fight sieges of those things in the past.<br /><br />\
	They are known for their aggressive behavior and tendency to go into a berserk rage when injured or provoked, especially if they are of weak will.<br /><br /><br /><br /> \
	<img src=https://images2.imgbox.com/eb/ed/Ej1joSvd_o.png width=100 height=150/> <img src=https://images2.imgbox.com/a1/a1/CRPdB4Ir_o.png width=100 height=150/><br /><img src=https://images2.imgbox.com/3e/34/Grph56ZU_o.png width=100 height=150/> <img src=https://images2.imgbox.com/83/96/oDGu3zmO_o.png width=100 height=150/><br /><img src=https://images2.imgbox.com/66/71/1633KcMb_o.png width=100 height=150/>"
	//need force emissive on eye, hair, nipples and vaginas somehow
	inherent_actions = list(/datum/action/ability/last_stand)

/datum/species/resurgentis/apply_damage(damage, damagetype, def_zone, blocked, sharp, edge, updating_health, penetration, mob/living/attacker, mob/living/carbon/human/victim)
	. = ..()
	var/health = (victim.status_flags & GODMODE) ? victim.maxHealth : (victim.maxHealth - victim.getFireLoss() - victim.getBruteLoss())
	if(health <= victim.get_death_threshold())
		return
	var/datum/action/ability/last_stand/rage_ability = victim.actions_by_path[/datum/action/ability/last_stand]
	if(!rage_ability)
		return
	if(health > victim.health_threshold_crit)
		return
	if(!rage_ability.action_cooldown_finished() || !rage_ability.can_use_action(silent = TRUE))
		return
	rage_ability.action_activate()

/datum/unarmed_attack/punch/medium
	attack_verb = list("punches","busts","jabs")
	damage = 6

/datum/action/ability/last_stand
	name = "Last Stand"
	action_icon_state = "frenzy"
	desc = "Your body is wired to go into a berserk rage when you are critically injured, granting you temporary boosts to your speed and making you withstand dying out of pure rage and determination for it's short duration, but leaving you exhausted once the effect ends. Manual triggering will be less beneficial and may make you not be able to rage when you need it. <br><br> Triggers automatically when your health drops to critical. Cooldown is automatically refreshed in 5 minutes."
	cooldown_duration = 5 MINUTES
	use_state_flags = ABILITY_USE_BUCKLED|ABILITY_USE_BUSY|ABILITY_USE_HANDCUFFED|ABILITY_USE_INCAP|ABILITY_USE_LYING|ABILITY_USE_STAGGERED|ABILITY_USE_NOTTURF

//basically stolen from rav but shittier
/datum/action/ability/last_stand/can_use_action(silent, override_flags, selecting)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner)		return FALSE
	if(carbon_owner.health > (carbon_owner.maxHealth * 0.5)) //can be manually triggered below half health
		if(!silent)
			to_chat(owner, span_danger("Your health isn't low enough to rage! You must take [carbon_owner.health - (carbon_owner.maxHealth * 0.5)] more damage!"))
		return FALSE


/datum/action/ability/last_stand/action_activate()
	var/mob/living/carbon/carbon_owner = owner
	if(!carbon_owner)		return FALSE
	var/rage_power = min(0.5, (1 - ((carbon_owner.health - carbon_owner.maxHealth) / carbon_owner.maxHealth)) * 3) // Calculate the power of our rage; scales with difference between current and max HP.
	var/rage_power_radius = CEILING(rage_power * 7, 1) //Define radius of the SFX

	carbon_owner.visible_message(span_danger("\The [carbon_owner] becomes frenzied, bellowing with a roar!"), \
	span_userdanger("You bellow as your fury overtakes you!"))
	carbon_owner.do_jitter_animation(1000)

	carbon_owner.reagents.add_reagent(/datum/reagent/medicine/adrenaline, 6, no_overdose = TRUE)
	carbon_owner.reagents.add_reagent(/datum/reagent/medicine/regen, 15, no_overdose = TRUE)
	carbon_owner.reagents.add_reagent(/datum/reagent/medicine/tramadol, 15, no_overdose = TRUE)
	carbon_owner.adjustBruteLoss(-carbon_owner.getBruteLoss(TRUE) * 0.30) //as if inaprovaline
	carbon_owner.adjustFireLoss(-carbon_owner.getFireLoss(TRUE) * 0.30)
	carbon_owner.Stun(1 SECONDS)
	carbon_owner.emote("me", 1, "slams their fist to the ground.")
	carbon_owner.health_threshold_crit = -100 //stop when u dead
	playsound(carbon_owner.loc, 'ntf_modular/sound/effects/ut-heavy-hit.ogg', 50)

	for(var/turf/affected_tiles AS in RANGE_TURFS(rage_power_radius / 2, carbon_owner.loc))
		affected_tiles.Shake(duration = 1 SECONDS) //SFX

	for(var/mob/living/affected_mob in cheap_get_living_near(carbon_owner, rage_power_radius)) //Roar that applies cool SFX
		if(affected_mob == carbon_owner)
			continue
		if(carbon_owner.get_iff_signal() == affected_mob.get_iff_signal())
			continue
		if(affected_mob.stat || affected_mob == carbon_owner) //We don't care about the dead/unconsious
			continue

		affected_mob.adjust_stagger(1 SECONDS)
		shake_camera(affected_mob, 1 SECONDS, 1)
		affected_mob.Shake(duration = 1 SECONDS) //SFX

		if(rage_power >= RAVAGER_RAGE_SUPER_RAGE_THRESHOLD && affected_mob.hud_used) //If we're super pissed it's time to get crazy
			var/atom/movable/plane_master_controller/game_plane_master_controller = affected_mob.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
			game_plane_master_controller.add_filter("rage_outcry", 2, radial_blur_filter(0.07))
			for(var/dm_filter/filt AS in game_plane_master_controller.get_filters("rage_outcry"))
				animate(filt, size = 0.12, time = 5, loop = -1)
			addtimer(CALLBACK(game_plane_master_controller, TYPE_PROC_REF(/datum, remove_filter), "rage_outcry"), 1 SECONDS)

	carbon_owner.add_filter("last_stand_outline", 5, outline_filter(1.5, COLOR_RED)) //Set our cool aura; also confirmation we have the buff

	//Too angry to be stunned/slowed/staggered/knocked down
	ADD_TRAIT(carbon_owner, TRAIT_PAIN_IMMUNE, "[type]")
	ADD_TRAIT(carbon_owner, TRAIT_STUNIMMUNE, "[type]")
	ADD_TRAIT(carbon_owner, TRAIT_SLOWDOWNIMMUNE, "[type]")
	ADD_TRAIT(carbon_owner, TRAIT_STAGGERIMMUNE, "[type]")

	addtimer(CALLBACK(src, PROC_REF(rage_warning)), RAVAGER_RAGE_DURATION * RAVAGER_RAGE_WARNING)
	addtimer(CALLBACK(src, PROC_REF(rage_deactivate)), RAVAGER_RAGE_DURATION)

	succeed_activate()
	add_cooldown()

///Warns the user when his rage is about to end.
/datum/action/ability/last_stand/proc/rage_warning()
	if(QDELETED(owner))
		return
	to_chat(owner,span_userdanger("Your rage begins to subside... [initial(name)] will only last for only [RAVAGER_RAGE_DURATION * (1-RAVAGER_RAGE_WARNING) * 0.1] more seconds!"))

///Called when we want to end the Rage effect
/datum/action/ability/last_stand/proc/rage_deactivate()
	if(QDELETED(owner))
		return
	var/mob/living/carbon/carbon_owner = owner
	carbon_owner.health_threshold_dead = initial(carbon_owner.health_threshold_dead)
	carbon_owner.health_threshold_crit = initial(carbon_owner.health_threshold_crit)
	owner.do_jitter_animation(1000)
	owner.remove_filter("last_stand_outline")
	owner.visible_message(span_warning("[owner] seems to tire out."), \
	span_userdanger("Your rage subsides and its power leaves your body, leaving you exhausted."))

	owner.remove_movespeed_modifier(MOVESPEED_ID_RAVAGER_RAGE) //Reset speed

	REMOVE_TRAIT(owner, TRAIT_PAIN_IMMUNE, "[type]")
	REMOVE_TRAIT(owner, TRAIT_STUNIMMUNE, "[type]")
	REMOVE_TRAIT(owner, TRAIT_SLOWDOWNIMMUNE, "[type]")
	REMOVE_TRAIT(owner, TRAIT_STAGGERIMMUNE, "[type]")
