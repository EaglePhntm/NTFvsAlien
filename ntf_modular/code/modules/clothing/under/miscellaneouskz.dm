/obj/item/clothing/under/marine/kzsneaking
	name = "KZ Covert Outfit"
	desc = "A costly stealth outfit devised by Kaizoku Zaibatsu Counterintelligence intended for covert operations. The uniform is created with layers of light nano-fibers, allowing the wearer to mold their body into tight spaces. Parts of the armor have light amounts of kevlar interweaving with nano-fibers, impacting the speed of the average NTF variant. The uniform allows you to walk quietly and crawl through vents with ALT-CLICK. To change the variant of the suit, ALT-RIGHTCLICK on it."
	icon = 'ntf_modular/icons/obj/clothing/uniforms/uniforms.dmi'
	icon_state = "sneak"
	armor_protection_flags = CHEST|GROIN|LEGS|ARMS|HANDS|FEET
	soft_armor = list(MELEE = 5, BULLET = 10, LASER = 5, ENERGY = 5, BOMB = 5, BIO = 10, FIRE = 10, ACID = 10)
	slowdown= -0.1
	var/variant = 1
	worn_icon_list = list(slot_w_uniform_str = 'ntf_modular/icons/mob/clothing/uniforms/marine_uniforms.dmi')
	adjustment_variants = list()
	starting_attachments = list(/obj/item/armor_module/storage/uniform/white_vest/sling)

/obj/item/clothing/under/marine/kzsneaking/equipped(mob/user, i_clothing)
	. = ..()
	ADD_TRAIT(user, TRAIT_CAN_VENTCRAWL, ARMOR_TRAIT)
	ADD_TRAIT(user, TRAIT_LIGHT_STEP, ARMOR_TRAIT)

/obj/item/clothing/under/marine/kzsneaking/unequipped(mob/unequipper, i_clothing)
	. = ..()
	REMOVE_TRAIT(unequipper, TRAIT_CAN_VENTCRAWL, ARMOR_TRAIT)
	REMOVE_TRAIT(unequipper, TRAIT_LIGHT_STEP, ARMOR_TRAIT)

/obj/item/clothing/under/marine/kzsneaking/AltRightClick(mob/user)
	. = ..()
	icon = 'ntf_modular/icons/obj/clothing/uniforms/uniforms.dmi'
	worn_icon_list = list(slot_w_uniform_str = 'ntf_modular/icons/mob/clothing/uniforms/marine_uniforms.dmi')
	variant ++
	shows_top_genital = FALSE
	shows_butt = FALSE
	shows_bottom_genital = FALSE
	if(variant == 7)
		variant = 1
	switch(variant)
		if(1)
			name = "KZ Covert Outfit"
			desc = "A costly stealth outfit devised by the Kaizoku Zaibatsu Counterintelligence intended for covert operations. The uniform is created with layers of light nano-fibers, allowing the wearer to mold their body into tight spaces. Parts of the armor have light amounts of kevlar interweaving with nano-fibers, impacting the speed of the average NTF variant. The uniform allows you to walk quietly and crawl through vents with ALT-CLICK. To change the variant of the suit, ALT-RIGHTCLICK on it."
			icon_state = "sneak"
		if(2)
			name = "KZ Counterintel Tactical T-Back Leotard"
			desc = "An extremely expensive sneaking leotard with extra skin-showing properties created by the Kaizoku Zaibatsu for high risk tasking with high risk clothes, made with several layers of a nano-fiber that, while light, molds to the wearer's body shape and hardens protecting them. This leotard allows you to walk quietly and crawl through vents with ALT-CLICK"
			icon_state = "sneak_leotard"
			shows_butt = TRUE
		if(3)
			name = "KZ Counterintel Tactical String bikini"
			desc = "An extremely expensive sneaking... string bikini? with ultra-extra skin-showing properties created by the Kaizoku Zaibatsu for high risk tasking with highest risk clothes, made with several layers of a nano-fiber that, while light-- It doesn't even matter, it practically doesn't exist, guess the sneakiest suit of all so far. This bikini allows you to walk quietly and crawl through vents with ALT-CLICK"
			icon_state = "sneak_kini"
			shows_butt = TRUE
		if(4)
			name = "executive suit"
			desc = "An extremely expensive looking formal uniform that seems to have toughened, kevlar or maybe another material fabric... Reminds you of john wick's suit but nowhere near as bulletproof."
			icon_state = "sneak_suit"
		if(5)
			name = "executive suit"
			desc = "An extremely expensive looking formal uniform with a short, side split skirt that seems to have toughened, kevlar or maybe another material fabric... Reminds you of john wick's suit but nowhere near as bulletproof."
			icon_state = "sneak_suitskirt"
		if(6)
			name = "sneaking harness"
			desc = "You are pretty much naked for maximum stealth, almost a NAKED SNAKE through the vents and all, good luck. This uniform allows you to walk quietly and crawl through vents with ALT-CLICK. To change the variant of the suit, ALT-CLICK on it."
			icon = 'ntf_modular/icons/obj/clothing/uniforms/lewdclothes.dmi'
			icon_state = "gear_harness"
			worn_icon_list = list(slot_w_uniform_str = 'ntf_modular/icons/mob/clothing/uniforms/lewdclothes.dmi')
			worn_icon_state = "gear_harness"
			shows_top_genital = TRUE
			shows_butt = TRUE
			shows_bottom_genital = TRUE
	update_icon()
	update_clothing_icon()
