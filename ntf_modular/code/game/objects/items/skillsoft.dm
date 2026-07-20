//trait giver item
/obj/item/skillsoft
	name = "skillsoft chip"
	desc = "A chip to insert directly into your brain (neural implant)"
	icon = 'icons/obj/items/capsules.dmi'
	icon_state = "capsule_blue"
	w_class = WEIGHT_CLASS_TINY
	//best not use both of those in one skillsoft.
	var/granted_trait
	var/datum/perk/granted_campaign_quirk

/obj/item/skillsoft/attack_self(mob/living/user)
	if(!granted_trait && !granted_campaign_quirk)
		CRASH("Skillsoft has no trait.")
	if(HAS_TRAIT(user, granted_trait))
		balloon_alert(user, "nothing to learn!")
		return
	if(!do_after(user, 5 SECONDS, NONE, user))
		return
	if(granted_campaign_quirk)
		if(!grant_campaign_quirk(user))
			balloon_alert(user, "Skillsoft failed to apply!")
			return //in case the quirk fails to apply for some reason, we don't want to delete the item
	if(granted_trait)
		ADD_TRAIT(user, granted_trait, "skillsoft_trait")
	user.temporarilyRemoveItemFromInventory(src)
	qdel(src)
	. = ..()

/obj/item/skillsoft/proc/grant_campaign_quirk(mob/living/user)
	var/datum/faction_stats/faction_stats = SSticker.mode.stat_list[user.faction]
	if(!faction_stats)
		return FALSE
	if(!user.ckey)
		return FALSE
	var/datum/individual_stats/player_stats = faction_stats.individual_stat_list[user.ckey]
	if(!player_stats)
		to_chat(user, span_notice("Something went wrong while using this skillsoft, tell a coder."))
		return FALSE
	var/datum/perk/perk = GLOB.campaign_perk_list[granted_campaign_quirk]
	if(!perk)
		to_chat(user, span_notice("Something went wrong while using this skillsoft, tell a coder."))
		return FALSE
	if(!player_stats.purchase_perk(perk, user, TRUE))
		return FALSE
	return TRUE

/obj/item/skillsoft/lightfooted
	name = "Skillsoft (Light Footed)"
	desc = "A skillsoft which grants a trait."
	granted_campaign_quirk = /datum/perk/trait/quiet

/obj/item/skillsoft/constitution_one
	name = "Skillsoft (Improved Constitution)"
	desc = "A skillsoft which grants a trait."
	granted_campaign_quirk = /datum/perk/trait/hp_boost

/obj/item/skillsoft/constitution_two
	name = "Skillsoft (Extreme Constitution)"
	desc = "A skillsoft which grants a trait."
	granted_campaign_quirk = /datum/perk/trait/hp_boost/two
