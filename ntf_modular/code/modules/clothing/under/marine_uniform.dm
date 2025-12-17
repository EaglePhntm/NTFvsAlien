/obj/item/clothing/under/marine/veteran/freelancer/mothellian
	name = "mothellian fatigues"
	desc = "A set of loose fitting fatigues, perfect for a Mothellian Republican.  Smells faintly like Lavender."


/obj/item/clothing/under/marine/veteran/freelancer/mothellian/veteran
	starting_attachments = list(/obj/item/armor_module/storage/uniform/holster/vp)

/obj/item/clothing/under/dress/maid
	name = "maid costume"
	icon = 'ntf_modular/icons/obj/clothing/uniforms/uniforms.dmi'
	worn_icon_list = list(
		slot_w_uniform_str = 'ntf_modular/icons/obj/clothing/uniforms/uniforms.dmi',
	)
	desc = "Maid in China."
	icon_state = "maid"

/obj/item/clothing/under/dress/maid/sexy
	name = "sexy maid costume"
	desc = "You must be a bit risque teasing all of them in a maid uniform!"
	icon_state = "sexymaid"

/obj/item/clothing/under/som/officer/pilot
	name = "S35 SOM officer flightsuit"
	desc = "A specialized, kevlar-weaved, hazmat-tested, EMF-augmented, survival-friendly pilot flightsuit. A small label on it says it is not rated for Cordium, whatever that is."
	icon_state = "som_uniform_pilot"
	icon = 'ntf_modular/icons/obj/clothing/uniforms.dmi'
	worn_icon_state = "som_uniform_pilot"
	cold_protection_flags = ICE_PLANET_MIN_COLD_PROTECTION_TEMPERATURE
	item_map_variant_flags = null
