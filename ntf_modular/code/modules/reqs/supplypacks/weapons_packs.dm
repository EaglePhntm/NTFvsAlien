/datum/supply_packs/weapons/ads
	name = "ACADS01 Air Defense System"
	contains = list(/obj/item/storage/box/crate/sentry/ads)
	cost = 300

/datum/supply_packs/weapons/ads_ammo
	name = "ACADS01 air defense system ammunition"
	contains = list(/obj/item/ammo_magazine/sentry/ads_system)
	cost = 50

/datum/supply_packs/weapons/ar18_ap
	name = "AR-18 AP magazine (10x24mm)"
	contains = list(/obj/item/ammo_magazine/rifle/standard_carbine/ap)
	cost = 25 //50? lmao that shit is too expensive

/datum/supply_packs/weapons/m412_ap
	name = "\improper PR-412 AP magazine (10x24mm)"
	contains = list(/obj/item/ammo_magazine/rifle/ap)
	cost = 25

/datum/supply_packs/weapons/apbox10x24
	name = "\improper Big ammo box (10x24mm AP)"
	contains = list(/obj/item/big_ammo_box/ap)
	cost = 200

/datum/supply_packs/weapons/dragoon
	name = "Dragoon Mk1 Rapid Engagement Rifle"
	contains = list(/obj/item/weapon/gun/rifle/dragoon)
	cost = 650

/datum/supply_packs/weapons/dragoon_ammo
	name = "Dragoon Mk1 RER stripper clip"
	contains = list(/obj/item/ammo_magazine/rifle/boltclip/dragoon)
	cost = 10

/datum/supply_packs/weapons/dragoon_ammo_pox
	name = "Dragoon Mk1 RER poxomelanin rounds stripper clip"
	contains = list(/obj/item/ammo_magazine/rifle/boltclip/dragoon/pox)
	cost = 100


//factional things down here
/datum/supply_packs/weapons/unity
	name = "NT105 Unity Revolver"
	contains = list(/obj/item/weapon/gun/pistol/xmdivider/ntc)
	faction_lock = list(FACTION_TERRAGOV)
	cost = 100

/datum/supply_packs/weapons/divider
	name = "CC/104 Divider Revolver"
	contains = list(/obj/item/weapon/gun/pistol/xmdivider)
	faction_lock = list(FACTION_VSD)
	cost = 100

/datum/supply_packs/weapons/divider_ammo_incendiary
	name = "CC/104 Divider Revolver incendiary Ammo"
	contains = list(/obj/item/ammo_magazine/pistol/xmdivider)
	faction_lock = list(FACTION_VSD)
	cost = 3

/datum/supply_packs/weapons/divider_ammo_ap
	name = "CC/104 Divider Revolver Armor Piercing Ammo"
	contains = list(/obj/item/ammo_magazine/pistol/xmdivider/ap)
	faction_lock = list(FACTION_VSD)
	cost = 3

/datum/supply_packs/weapons/g22_tranq
	name = "P-22 Custom Tranq Pistol"
	contains = list(/obj/item/weapon/gun/pistol/g22/tranq)
	faction_lock = list(FACTION_TERRAGOV)
	cost = 200

/datum/supply_packs/weapons/g22_tranq_ammo
	name = "P-22 Custom Pistol Tranq Magazine"
	contains = list(/obj/item/ammo_magazine/pistol/g22tranq)
	faction_lock = list(FACTION_TERRAGOV)
	cost = 3

/datum/supply_packs/weapons/moonbeam
	name = "NTC 'Moonbeam' tranq sniper rifle"
	contains = list(/obj/item/weapon/gun/rifle/chambered/nonlethal/fitted)
	faction_lock = list(FACTION_TERRAGOV)
	cost = 400

/datum/supply_packs/weapons/moonbeam_ammo
	name = "Moonbeam NL sniper rifle tranq magazine"
	contains = list(/obj/item/ammo_magazine/rifle/chamberedrifle/tranq)
	faction_lock = list(FACTION_TERRAGOV)
	cost = 30

/datum/supply_packs/weapons/moonbeam_ammo_bluescreen
	name = "Moonbeam NL sniper rifle bluescreen magazine"
	contains = list(/obj/item/ammo_magazine/rifle/chamberedrifle/bluescreen)
	faction_lock = list(FACTION_TERRAGOV)
	cost = 60

/datum/supply_packs/weapons/bikeautocannonammo
	name = "heavy motorbike AC-32 autocannon ammo rack (x2)"
	contains = list(/obj/item/ammo_magazine/bike_autocannon, /obj/item/ammo_magazine/bike_autocannon)
	faction_lock = list(FACTION_TERRAGOV)
	cost = 30

/datum/supply_packs/weapons/bikeminigunammo
	name = "hoverbike MG-100 Vindicator ammo rack"
	contains = list(/obj/item/ammo_magazine/bike_minigun, /obj/item/ammo_magazine/bike_minigun)
	faction_lock = list(FACTION_SOM)
	cost = 30
