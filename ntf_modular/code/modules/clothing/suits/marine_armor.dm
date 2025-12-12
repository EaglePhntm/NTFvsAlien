/obj/item/clothing/suit/storage/faction/freelancer/mothellian
	name = "\improper mothellian cuirass"
	desc = "A armored protective chestplate of high quality. It keeps up remarkably well, as the craftsmanship is solid, and the design is form fitting for Mothellians."
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/instrument,
		/obj/item/storage/belt/sparepouch,
		/obj/item/storage/holster/blade,
		/obj/item/weapon/twohanded,
		/obj/item/storage/holster/belt,
		/obj/item/storage/belt/knifepouch,
		/obj/item/weapon/twohanded,
		/obj/item/tool/pickaxe/plasmacutter,
	)

/obj/item/clothing/suit/storage/faction/freelancer/mothellian/unique
	attachments_by_slot = list(
		ATTACHMENT_SLOT_STORAGE,
		ATTACHMENT_SLOT_MODULE,
	)

/obj/item/clothing/suit/storage/faction/freelancer/mothellian/unique/leader
	attachments_allowed = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer,
	)

/obj/item/clothing/suit/storage/faction/freelancer/mothellian/unique/leader/two
	attachments_allowed = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer_two,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer_two,
	)

/obj/item/clothing/suit/storage/faction/freelancer/mothellian/unique/leader/three
	attachments_allowed = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer_three,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/valkyrie_autodoc,
		/obj/item/armor_module/storage/ammo_mag/freelancer_three,
	)

/obj/item/clothing/suit/storage/faction/freelancer/mothellian/unique/medic
	attachments_allowed = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/medical/freelancer,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/medical/freelancer,
	)

/obj/item/clothing/suit/storage/faction/freelancer/mothellian/unique/engi
	attachments_allowed = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/engineering,
	)
	starting_attachments = list(
		/obj/item/armor_module/module/better_shoulder_lamp,
		/obj/item/armor_module/storage/engineering,
	)

/obj/item/clothing/suit/storage/marine/som/pilot
	name = "\improper S12-P pilot armor"
	desc = "A light piece of armor used by SOM pilots to protect themselves while flying in the cockpit. Made from tests into other armor systems for pilots."
	icon_state = "som_pilot_black"
	worn_icon_state = "som_pilot_black"
	soft_armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 35, BOMB = 40, BIO = 5, FIRE = 25, ACID = 30)
	slowdown = 0.20
	item_map_variant_flags = NONE
