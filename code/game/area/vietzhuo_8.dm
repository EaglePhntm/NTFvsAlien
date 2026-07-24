#define AMBIENT_LV759_OUTDOORS list('sound/effects/urban/outdoors/wind4.ogg','sound/effects/urban/outdoors/wind5.ogg','sound/effects/urban/outdoors/wind6.ogg','sound/effects/urban/outdoors/wind7.ogg','sound/effects/urban/outdoors/wind8.ogg','sound/effects/urban/outdoors/wind9.ogg','sound/effects/urban/outdoors/wind10.ogg','sound/effects/urban/outdoors/wind11.ogg','sound/effects/urban/outdoors/wind12.ogg','sound/effects/urban/outdoors/wind13.ogg','sound/effects/urban/outdoors/wind14.ogg','sound/effects/urban/outdoors/wind15.ogg','sound/effects/urban/outdoors/wind16.ogg','sound/effects/urban/outdoors/wind17.ogg','sound/effects/urban/outdoors/wind18.ogg','sound/effects/urban/outdoors/wind19.ogg','sound/effects/urban/outdoors/wind20.ogg','sound/effects/urban/outdoors/wind21.ogg','sound/effects/urban/outdoors/wind22.ogg','sound/effects/urban/outdoors/wind23.ogg','sound/effects/urban/outdoors/wind24.ogg','sound/effects/urban/outdoors/wind25.ogg','sound/effects/urban/outdoors/wind26.ogg','sound/effects/urban/outdoors/wind27.ogg','sound/effects/urban/outdoors/wind28.ogg',)
#define AMBIENT_LV759_INDOORS list('sound/effects/urban/indoors/indoor_wind.ogg','sound/effects/urban/indoors/indoor_wind2.ogg','sound/effects/urban/indoors/vent_1.ogg','sound/effects/urban/indoors/vent_2.ogg','sound/effects/urban/indoors/vent_3.ogg','sound/effects/urban/indoors/vent_4.ogg','sound/effects/urban/indoors/vent_5.ogg','sound/effects/urban/indoors/vent_6.ogg','sound/effects/urban/indoors/vent_7.ogg','sound/effects/urban/indoors/vent_6.ogg','sound/effects/urban/indoors/distant_sounds_1.ogg','sound/effects/urban/indoors/distant_sounds_2.ogg','sound/effects/urban/indoors/distant_sounds_3.ogg','sound/effects/urban/indoors/distant_sounds_4.ogg','sound/effects/urban/indoors/distant_sounds_5.ogg','sound/effects/urban/indoors/distant_sounds_6.ogg','sound/effects/urban/indoors/distant_sounds_7.ogg','sound/effects/urban/indoors/distant_sounds_8.ogg','sound/effects/urban/indoors/distant_sounds_9.ogg','sound/effects/urban/indoors/distant_sounds_10.ogg','sound/effects/engamb1.ogg','sound/effects/engamb2.ogg','sound/effects/engamb3.ogg','sound/effects/engamb4.ogg','sound/effects/engamb5.ogg','sound/effects/engamb6.ogg','sound/effects/engamb7.ogg',)
#define AMBIENT_LV759_DERELICTSHIP list('sound/effects/urban/indoors/derelict1.ogg','sound/effects/urban/indoors/derelict_ambience.ogg','sound/effects/urban/indoors/urban_interior.ogg','sound/effects/urban/indoors/derelict2.ogg','sound/effects/urban/indoors/derelict3.ogg','sound/effects/urban/indoors/derelict4.ogg','sound/effects/urban/indoors/derelict5.ogg','sound/effects/urban/indoors/derelict6.ogg','sound/effects/urban/indoors/derelict7.ogg','sound/effects/urban/indoors/derelict8.ogg')

//vietzhuo8 AREAS--------------------------------------//

/area/vietzhuo8
	name = "Vietzhuo 8 Region"
	icon = 'icons/turf/vietzhuo_8.dmi'
	icon_state = "vietzhuo8"

//parent types

/area/vietzhuo8/indoors
	name = "Vietzhuo8 - Indoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_METAL
	outside = FALSE
	always_unpowered = FALSE
	minimap_color = MINIMAP_AREA_LIVING
	ambience = AMBIENT_LV759_INDOORS

/area/vietzhuo8/outdoors
	name = "Vietzhuo8 - Outdoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_NONE
	always_unpowered = TRUE
	ambience = AMBIENT_LV759_OUTDOORS

/area/vietzhuo8/oob
	name = "Out Of Bounds"
	icon_state = "oob"
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE
	always_unpowered = TRUE

// Landing Zone 2
/area/vietzhuo8/outdoors/landing_zone_2
	name = "Vietzhuo-8 West - Landing Zone Two"
	icon_state = "v8w_lz2site"
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	always_unpowered = FALSE

/area/vietzhuo8/outdoors/landing_zone_2/customs
	name = "Vietzhuo-8 West - Landing Zone Two - Customs"
	icon_state = "v8w_lz2customs"
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE

/area/vietzhuo8/indoors/landing_zone_2/flight_control_room
	name = "Vietzhuo-8 West - Customs Landing Zone Two - Air Control Building"
	icon_state = "v8w_lz2acb"
	ceiling = CEILING_METAL

/area/vietzhuo8/indoors/landing_zone_2/lz2_console
	name = "Vietzhuo-8 West - Customs Landing Zone Two - Dropship Normandy Console"
	icon_state = "v8w_lz2site"
	requires_power = FALSE
	ceiling = CEILING_METAL

// Landing Zone 1
/area/vietzhuo8/outdoors/landing_zone_1
	name = "Vietzhuo-8 Southeast NTC Airfield - Landing Zone One"
	icon_state = "v8se_lz1site"
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	area_flavor = AREA_FLAVOR_URBAN

/area/vietzhuo8/indoors/landing_zone_1/
	icon_state = "v8se_lz1site"
	minimap_color = MINIMAP_AREA_LZ

/area/vietzhuo8/indoors/landing_zone_1/hangars
	icon_state = "v8se_lz1hangars"
	minimap_color = MINIMAP_AREA_ESCAPE

/area/vietzhuo8/indoors/landing_zone_1/air_control_room
	name = "Vietzhuo-8 Southeast NTC Airfield - Air Control Room"
	icon_state = "v8se_lz1acb"

/area/vietzhuo8/indoors/landing_zone_1/lz1_console
	name = "Vietzhuo-8 Southeast NTC Airfield - Dropship Alamo Console"
	requires_power = FALSE

//NTC Airfield Quarters & Amenities

/area/vietzhuo8/outdoors/v8sentaf/corporatewalkwaysnorth
	name = "Vietzhuo-8 Southeast NTC Airfield - Corporate Walkways North"
	icon_state = "v8se_ntcwalkway"

/area/vietzhuo8/outdoors/v8sentaf/corporatewalkwaysouth
	name = "Vietzhuo-8 Southeast NTC Airfield - Corporate Walkways South"
	icon_state = "v8se_ntcwalkway"

/area/vietzhuo8/indoors/v8sentaf/corporate_dorms
	name = "Vietzhuo-8 Southeast NTC Airfield - Corporate Dorms"
	icon_state = "v8se_dorms"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/indoors/v8sentaf/restrooms
	name = "Vietzhuo-8 Southeast NTC Airfield - Restrooms"
	icon_state = "v8se_restroom"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/indoors/v8sentaf/substation
	name = "Vietzhuo-8 Southeast NTC Airfield - Substation"
	icon_state = "v8se_powerstation"
	minimap_color = MINIMAP_AREA_ENGI

/area/vietzhuo8/indoors/v8sentaf/substation/maintenance
	name = "Vietzhuo-8 Southeast NTC Airfield - Substation - Maintenance"
	minimap_color = MINIMAP_AREA_ENGI

//NTC Airfield Corporate

/area/vietzhuo8/outdoors/v8ntc
	name = "Vietzhuo-8 Southeast NTC Airfield - Corporate Grounds"
	icon_state = "v8se_officegeneral"

/area/vietzhuo8/indoors/v8ntc
	name = "Vietzhuo-8 Southeast NTC Airfield - Office Building"
	icon_state = "v8se_offices"
	minimap_color = MINIMAP_AREA_COMMAND

/area/vietzhuo8/indoors/v8ntc/officeslobby
	name = "Vietzhuo-8 Southeast NTC Airfield - Offices Lobby"

/area/vietzhuo8/indoors/v8ntc/officesmain
	name = "Vietzhuo-8 Southeast NTC Airfield - Offices Main"

/area/vietzhuo8/indoors/v8ntc/officesmanagement
	name = "Vietzhuo-8 Southeast NTC Airfield - Offices Management"

/area/vietzhuo8/indoors/v8ntc/breakroom
	name = "Vietzhuo-8 Southeast NTC Airfield - Offices Breakroom"

/area/vietzhuo8/indoors/v8ntc/officeshalls
	name = "Vietzhuo-8 Southeast NTC Airfield - Southern Offices Halls"

/area/vietzhuo8/indoors/v8ntc/conference
	name = "Vietzhuo-8 Southeast NTC Airfield - Conference Room"

/area/vietzhuo8/indoors/v8ntc/officessecurity
	name = "Vietzhuo-8 Southeast NTC Airfield - Offices Security-Post"
	icon_state = "v8se_secpost"

//NTC Airfield Security Assets

/area/vietzhuo8/indoors/v8sentafsec
	name = "Vietzhuo-8 Southeast NTC Airfield - Security"
	minimap_color = MINIMAP_AREA_SEC

/area/vietzhuo8/indoors/v8sentafsec/checkpoint_north
	name = "Vietzhuo-8 Southeast NTC Airfield - Security Checkpoint North"
	icon_state = "v8se_secpost"

/area/vietzhuo8/indoors/v8sentafsec/security_checkpoint_northwest
	name = "Vietzhuo-8 Southeast NTC Airfield - Security Checkpoint Northwest"
	icon_state = "v8se_secpost"

/area/vietzhuo8/indoors/v8sentafsec/security_checkpoint_west
	name = "Vietzhuo-8 Southeast NTC Airfield - Security Checkpoint West"
	icon_state = "v8se_secpost"

/area/vietzhuo8/indoors/v8sentafsec/security_dorms_central
	name = "Vietzhuo-8 Southeast NTC Airfield - Security Dorms Central"
	icon_state = "v8se_secdorms"

/area/vietzhuo8/indoors/v8sentafsec/security_dorms_west
	name = "Vietzhuo-8 Southeast NTC Airfield - Security Dorms West"
	icon_state = "v8se_secdorms"

/area/vietzhuo8/indoors/v8sentafsec/security_armory
	name = "Vietzhuo-8 Southeast NTC Airfield - Security Armory"
	icon_state = "v8se_secarmory"

//NTC Airfield Roads & Territories

/area/vietzhuo8/outdoors/v8ntcroadwest
	name = "Vietzhuo-8 Southeast NTC Airfield - Roads West"
	icon_state = "v8se_territory"

/area/vietzhuo8/outdoors/v8ntcroadnw
	name = "Vietzhuo-8 Southeast NTC Airfield - Roads Northwest"
	icon_state = "v8se_territory"

/area/vietzhuo8/outdoors/v8ntcroadnorth
	name = "Vietzhuo-8 Southeast NTC Airfield - Road North"
	icon_state = "v8se_territory"

/area/vietzhuo8/outdoors/v8ntcregionnorth
	name = "Vietzhuo-8 Southeast NTC Airfield - Region North"
	icon_state = "v8se_territory"

/area/vietzhuo8/outdoors/v8ntcregionnorthwest
	name = "Vietzhuo-8 Southeast NTC Airfield - Region Northwest"
	icon_state = "v8se_territory"

// Vietzhuo-8 Central Buffer Zone

/area/vietzhuo8/outdoors/v8central
	name = "Vietzhuo-8 Central Buffer Zone - Western Bridge"
	icon_state = "v8bz_territory"

/area/vietzhuo8/outdoors/v8central/cargo_grounds_west
	name = "Vietzhuo-8 Central Buffer Zone - Western Bridge"

/area/vietzhuo8/outdoors/v8central/cargo_grounds_east
	name = "Vietzhuo-8 Central Buffer Zone - Eastern Bridge"

/area/vietzhuo8/outdoors/v8central/cargo_grounds
	name = "Vietzhuo-8 Central Buffer Zone - Cargo Grounds"

/area/vietzhuo8/indoors/v8central/cargo_storage
	name = "Vietzhuo-8 Central Buffer Zone - Cargo Storage Hangar"
	icon_state = "v8bz_cargo"
	minimap_color = MINIMAP_AREA_REQ

/area/vietzhuo8/indoors/v8central/cargo_requisitions
	name = "Vietzhuo-8 Central Buffer Zone - Cargo Requisitions Hangar"
	icon_state = "v8bz_requisitions"
	minimap_color = MINIMAP_AREA_REQ

// Vietzhuo-8 East-Central Neutral Zone

/area/vietzhuo8/outdoors/v8eastcentral
	name = "Vietzhuo-8 East-Central Neutral Zone"
	icon_state = "v8e_neutral"
	ambience = list('sound/ambience/jungle_amb1.ogg')

// Vietzhuo-8 Northeastern Village

/area/vietzhuo8/indoors/v8ne/village
	name = "Vietzhuo-8 Northeast - Village"
	icon_state = "v8ne_territory"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/outdoors/v8ne/village
	name = "Vietzhuo-8 Northeast - Village Grounds"
	icon_state = "v8ne_territory"
	minimap_color = MINIMAP_AREA_COLONY
	ambience = list('sound/ambience/jungle_amb1.ogg',
	'sound/ambience/eastvietzhuanspeech.ogg',
	)

/area/vietzhuo8/outdoors/v8ne/village/coastalgrounds
	name = "Vietzhuo-8 Northeast - Coastal Village Grounds"
	icon_state = "v8ne_territory"
	ambience = list('sound/ambience/jungle_amb1.ogg',)

/area/vietzhuo8/indoors/v8ne/village/civilian_hut
	name = "Vietzhuo-8 Northeast - Village Housing"
	icon_state = "v8ne_hut"

/area/vietzhuo8/indoors/v8ne/village/civilian_farm_hut
	name = "Vietzhuo-8 Northeast - Village Farm Housing"
	icon_state = "v8ne_farmhouse"

/area/vietzhuo8/indoors/v8ne/village/civilian_tavern
	name = "Vietzhuo-8 Northeast - Village Tavern"
	icon_state = "v8ne_bar"

/area/vietzhuo8/indoors/v8ne/village/civilian_eatery
	name = "Vietzhuo-8 Northeast - Village Eatery"
	icon_state = "v8ne_eatery"

/area/vietzhuo8/indoors/v8ne/village/power_station
	name = "Vietzhuo-8 Northeast - Power Station"
	icon_state = "v8ne_generators"
	minimap_color = MINIMAP_AREA_ENGI

/area/vietzhuo8/indoors/v8ne/village/civilian_coastal_hut
	name = "Vietzhuo-8 Northeast - Village Fishing Hut"
	icon_state = "v8ne_fishinghut"

/area/vietzhuo8/indoors/v8ne/village/civilian_coastal_diner
	name = "Vietzhuo-8 Northeast - Coastal Village Diner"
	icon_state = "v8ne_coastdiner"

/area/vietzhuo8/indoors/v8ne/village/monk_temple
	name = "Vietzhuo-8 Northeast - Village Monk Temple"
	icon_state = "v8ne_temple"

/area/vietzhuo8/indoors/v8ne/village/clinic
	name = "Vietzhuo-8 Northeast - Village Clinic"
	icon_state = "v8ne_clinic"

// Vietzhuo-8 Northeastern Village Guard

/area/vietzhuo8/outdoors/v8ne/village/guard
	name = "Vietzhuo-8 Northeast - Village Guard Walkways"
	minimap_color = MINIMAP_AREA_COLONY
	icon_state = "v8ne_territory"

/area/vietzhuo8/outdoors/v8ne/village/guard/assembly
	name = "Vietzhuo-8 Northeast - Village Assembly"
	minimap_color = MINIMAP_AREA_COLONY
	ambience = list('sound/ambience/eastvietzhuanspeech.ogg',)

/area/vietzhuo8/outdoors/v8ne/village/guard/walkways
	name = "Vietzhuo-8 Northeast - Village Guard Walkways"
	minimap_color = MINIMAP_AREA_COLONY

/area/vietzhuo8/indoors/v8ne/village/guard
	name = "Vietzhuo-8 Northeast - Village Guard Building"
	minimap_color = MINIMAP_AREA_SEC
	icon_state = "v8ne_territory"

/area/vietzhuo8/indoors/v8ne/village/guard/center
	name = "Vietzhuo-8 Northeast - Village Guard Center"
	icon_state = "v8ne_barracks"

/area/vietzhuo8/indoors/v8ne/village/guard/barracks
	name = "Vietzhuo-8 Northeast - Village Guard Housing"
	icon_state = "v8ne_guardhuts"

/area/vietzhuo8/indoors/v8ne/village/guard/jail_cells
	name = "Vietzhuo-8 Northeast - Village Jail Cells"
	icon_state = "v8ne_prisoncells"

/area/vietzhuo8/indoors/v8ne/village/guard/post_south
	name = "Vietzhuo-8 Northeast - Village Guardpost South"
	icon_state = "v8ne_guardpost"

/area/vietzhuo8/indoors/v8ne/village/guard/post_southwest
	name = "Vietzhuo-8 Northeast - Village Guardpost Southwest"
	icon_state = "v8ne_guardpost"

/area/vietzhuo8/indoors/v8ne/village/guard/post_northwest
	name = "Vietzhuo-8 Northeast - Village Guardpost Northwest"
	icon_state = "v8ne_guardpost"

// Vietzhuo-8 Northeastern Warehousing

/area/vietzhuo8/indoors/v8ne/village/warehouseEC
	name = "Vietzhuo-8 Northeast - Village Warehouse East-Central"
	icon_state = "v8ne_warehouse"
	minimap_color = MINIMAP_AREA_REQ

/area/vietzhuo8/indoors/v8ne/village/warehouseWC
	name = "Vietzhuo-8 Northeast - Village Warehouse West-Central"
	icon_state = "v8ne_warehouse"
	minimap_color = MINIMAP_AREA_REQ

// Vietzhuo-8 Western City

/area/vietzhuo8/outdoors/v8west/city
	name = "Vietzhuo-8 West - City"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COLONY

/area/vietzhuo8/outdoors/v8west/city/northstreets
	name = "Vietzhuo-8 West - City - North Streets"
	icon_state = "v8w_northstreet"

/area/vietzhuo8/outdoors/v8west/city/centralstreets
	name = "Vietzhuo-8 West - City - Central Streets"
	icon_state = "v8w_centralstreet"

/area/vietzhuo8/outdoors/v8west/city/southernstreets
	name = "Vietzhuo-8 West - City - Southern Streets"
	icon_state = "v8w_southstreet"

/area/vietzhuo8/outdoors/v8west/city/warmemorial
	name = "Vietzhuo-8 West - City - Vietzhuan War Memorial"
	icon_state = "v8w_warmemorial"

/area/vietzhuo8/indoors/v8west/city/laundromat
	name = "Vietzhuo-8 West - City - Laundromat"
	icon_state = "v8w_laundromat"

/area/vietzhuo8/indoors/v8west/city/powerstation
	name = "Vietzhuo-8 West - City - Power Station"
	icon_state = "v8w_powerstation"
	minimap_color = MINIMAP_AREA_ENGI

/area/vietzhuo8/indoors/v8west/city/northhouses
	name = "Vietzhuo-8 West - City - Northern Residencies"
	icon_state = "v8w_north_houses"

/area/vietzhuo8/outdoors/v8west/city/northarea
	name = "Vietzhuo-8 West - Northern Region"
	icon_state = "v8w_territory"
	always_unpowered = TRUE

/area/vietzhuo8/outdoors/v8west/city/centralarea
	name = "Vietzhuo-8 West - Central Region"
	icon_state = "v8w_territory"
	always_unpowered = TRUE

/area/vietzhuo8/outdoors/v8west/city/southarea
	name = "Vietzhuo-8 West - Southern Region"
	icon_state = "v8w_territory"
	always_unpowered = TRUE

/area/vietzhuo8/outdoors/v8west/city/miningpit/North
	name = "Vietzhuo-8 West - Mining Pit North"
	icon_state = "v8w_miningpit"
	always_unpowered = TRUE

/area/vietzhuo8/outdoors/v8west/city/miningpit/south
	name = "Vietzhuo-8 West - Mining Pit South"
	icon_state = "v8w_miningpit"
	always_unpowered = TRUE

// Vietzhuo-8 West Hanako Hilton Motel

/area/vietzhuo8/indoors/v8west/city/hanakohilton
	name = "Vietzhuo-8 West - Hanako Hilton"
	icon_state = "v8w_hanakohilton"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/indoors/v8west/city/hanakohilton/lobby
	name = "Vietzhuo-8 West - Hanako Hilton Lobby"

/area/vietzhuo8/outdoors/v8west/hanakohilton/courtyard
	name = "Vietzhuo-8 West - Hanako Hilton Courtyard"
	icon_state = "v8w_hanakohilton"

/area/vietzhuo8/indoors/v8west/city/hanakohilton/room
	name = "Vietzhuo-8 West - Hanako Hilton Motel Room 1"

/area/vietzhuo8/indoors/v8west/city/hanakohilton/room2
	name = "Vietzhuo-8 West - Hanako Hilton Motel Room 2"

/area/vietzhuo8/indoors/v8west/city/hanakohilton/room3
	name = "Vietzhuo-8 West - Hanako Hilton Motel Room 3"

/area/vietzhuo8/indoors/v8west/city/hanakohilton/room4
	name = "Vietzhuo-8 West - Hanako Hilton Motel Room 4"

/area/vietzhuo8/indoors/v8west/city/hanakohilton/room5
	name = "Vietzhuo-8 West - Hanako Hilton Motel Room 5"

/area/vietzhuo8/indoors/v8west/city/hanakohilton/room6
	name = "Vietzhuo-8 West - Hanako Hilton Motel Room 6"

/area/vietzhuo8/indoors/v8west/city/hanakohilton/poolroom
	name = "Vietzhuo-8 West - Hanako Hilton Pool Room"

/area/vietzhuo8/indoors/v8west/city/hanakohilton/laundry
	name = "Vietzhuo-8 West - Hanako Hilton Laundry Room"

/area/vietzhuo8/indoors/v8west/city/hanakohilton/lounge
	name = "Vietzhuo-8 West - Hanako Hilton Lounge Room"

/area/vietzhuo8/indoors/v8west/city/hanakohilton/halls
	name = "Vietzhuo-8 West - Hanako Hilton Halls"

/area/vietzhuo8/indoors/v8west/city/hanakohilton/breaker
	name = "Vietzhuo-8 West - Hanako Hilton Breaker"
	minimap_color = MINIMAP_AREA_ENGI

// Vietzhuo-8 West Strip Mall Center

/area/vietzhuo8/indoors/v8west/stripmall
	name = "Vietzhuo-8 West - Strip Mall - Walkway"
	icon_state = "v8w_stripm_hallway"
	minimap_color = MINIMAP_AREA_COLONY

/area/vietzhuo8/indoors/v8west/stripmall/function
	name = "Vietzhuo-8 West - Strip Mall - Function"
	icon_state = "v8w_stripm_funct"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/indoors/v8west/stripmall/produce
	name = "Vietzhuo-8 West - Strip Mall - Produce Store"
	icon_state = "v8w_stripm_produce"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/indoors/v8west/stripmall/clothing
	name = "Vietzhuo-8 West - Strip Mall - Clothing Store"
	icon_state = "v8w_stripm_clothing"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/indoors/v8west/stripmall/dresses
	name = "Vietzhuo-8 West - Strip Mall - Dress Store"
	icon_state = "v8w_stripm_dresses"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/indoors/v8west/stripmall/confection
	name = "Vietzhuo-8 West - Strip Mall - Clear-Cut Confections"
	icon_state = "v8w_stripm_confect"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/indoors/v8west/stripmall/eatery
	name = "Vietzhuo-8 West - Strip Mall - Take-Out Eatery"
	icon_state = "v8w_stripm_eatery"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/indoors/v8west/stripmall/liquor
	name = "Vietzhuo-8 West - Strip Mall - Liquor Shop"
	icon_state = "v8w_stripm_liquor"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/indoors/v8west/stripmall/hardware
	name = "Vietzhuo-8 West - Strip Mall - Thao Hung Hardware"
	icon_state = "v8w_stripm_hardware"
	minimap_color = MINIMAP_AREA_ENGI

/area/vietzhuo8/indoors/v8west/stripmall/pharmacy
	name = "Vietzhuo-8 West - Strip Mall - Chai Lew Pharmacy"
	icon_state = "v8w_stripm_pharmacy"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/vietzhuo8/indoors/v8west/stripmall/mensrest
	name = "Vietzhuo-8 West - Strip Mall - Mens Restroom"
	icon_state = "v8w_stripm_mensrest"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/indoors/v8west/stripmall/ladiesrest
	name = "Vietzhuo-8 West - Strip Mall - Ladies Restroom"
	icon_state = "v8w_stripm_ladyrest"
	minimap_color = MINIMAP_AREA_LIVING


// Vietzhuo-8 West Gym-FIT Center

/area/vietzhuo8/indoors/v8west/city/gym
	name = "Vietzhuo-8 West - Gym-FIT Center"
	icon_state = "v8w_gym"
	minimap_color = MINIMAP_AREA_LIVING

/area/vietzhuo8/outdoors/v8west/city/gym/parkinglot
	name = "Vietzhuo-8 West - Gym-FIT Parking Lot"
	icon_state = "v8w_gym"

// Vietzhuo-8 West Cafe-Diner

/area/vietzhuo8/indoors/v8west/city/cafediner
	name = "Vietzhuo-8 West - Am Thuc Tuyet Hao Cafe-Diner"
	icon_state = "v8w_cafediner"
	minimap_color = MINIMAP_AREA_LIVING

// Vietzhuo-8 Western City Hospital

/area/vietzhuo8/indoors/v8west/city/hospital
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital"
	icon_state = "v8w_hospital"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/vietzhuo8/indoors/v8west/city/hospital/lobby
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Lobby"

/area/vietzhuo8/indoors/v8west/city/hospital/halls
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Halls"

/area/vietzhuo8/indoors/v8west/city/hospital/operatingroom
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Operating Room"

/area/vietzhuo8/indoors/v8west/city/hospital/emergencyoperatingroom
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Emergency O.R."

/area/vietzhuo8/indoors/v8west/city/hospital/morgue
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Morgue"

/area/vietzhuo8/indoors/v8west/city/hospital/triage
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Triage"

/area/vietzhuo8/indoors/v8west/city/hospital/doctorsoffice
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Doctor Office 1"

/area/vietzhuo8/indoors/v8west/city/hospital/doctorsoffice2
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Doctor Office 2"

/area/vietzhuo8/indoors/v8west/city/hospital/doctorsoffice3
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Doctor Office 3"

/area/vietzhuo8/indoors/v8west/city/hospital/breakroom
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Break Room"

/area/vietzhuo8/indoors/v8west/city/hospital/precheck
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Pre-Checkup"

/area/vietzhuo8/indoors/v8west/city/hospital/pharmacylab
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Pharmacy Lab"

/area/vietzhuo8/indoors/v8west/city/hospital/restroom
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Restroom"

/area/vietzhuo8/outdoors/v8west/city/hospital/parkinglot
	icon_state = "v8w_hospital"
	name = "Vietzhuo-8 West - Jian Tran Memorial Hospital - Parking Lot"
	minimap_color = MINIMAP_AREA_COLONY

// Vietzhuo-8 West Precinct

/area/vietzhuo8/indoors/v8west/city/precinct
	name = "Vietzhuo-8 West - Precinct"
	icon_state = "v8w_police_station"
	minimap_color = MINIMAP_AREA_SEC

/area/vietzhuo8/indoors/v8west/city/precinct/lobby
	name = "Vietzhuo-8 West - Precinct - Lobby"

/area/vietzhuo8/indoors/v8west/city/precinct/dispatchoffices
	name = "Vietzhuo-8 West - Precinct - Dispatch Offices"

/area/vietzhuo8/indoors/v8west/city/precinct/records
	name = "Vietzhuo-8 West - Precinct - Records Storage"

/area/vietzhuo8/indoors/v8west/city/precinct/halls
	name = "Vietzhuo-8 West - Precinct - Halls"

/area/vietzhuo8/indoors/v8west/city/precinct/breakroom
	name = "Vietzhuo-8 West - Precinct - Mess Hall"

/area/vietzhuo8/indoors/v8west/city/precinct/kitchen
	name = "Vietzhuo-8 West - Precinct - Kitchen"

/area/vietzhuo8/indoors/v8west/city/precinct/offices
	name = "Vietzhuo-8 West - Precinct - Offices"

/area/vietzhuo8/indoors/v8west/city/precinct/chief
	name = "Vietzhuo-8 West - Precinct - Police Chief Office"

/area/vietzhuo8/indoors/v8west/city/precinct/swatarmory
	name = "Vietzhuo-8 West - Precinct - SWAT Armory"

/area/vietzhuo8/indoors/v8west/city/precinct/riotarmory
	name = "Vietzhuo-8 West - Precinct - Riot Armory"

/area/vietzhuo8/indoors/v8west/city/precinct/holdingcell
	name = "Vietzhuo-8 West - Precinct - Holding Cell"

/area/vietzhuo8/indoors/v8west/city/precinct/holdingcell
	name = "Vietzhuo-8 West - Precinct - Jail"

/area/vietzhuo8/indoors/v8west/city/precinct/restroom
	name = "Vietzhuo-8 West - Precinct - Restroom"

/area/vietzhuo8/indoors/v8west/city/precinct/breaker
	name = "Vietzhuo-8 West - Precinct - Breaker"

// Vietzhuo-8 West Border Checkpoints

/area/vietzhuo8/indoors/v8west/city/border/security
	name = "Vietzhuo-8 West - Border Security"
	icon_state = "v8w_secpost"
	minimap_color = MINIMAP_AREA_SEC

/area/vietzhuo8/indoors/v8west/city/border/security/north
	name = "Vietzhuo-8 West - BORSEC - North Checkpoint"

/area/vietzhuo8/indoors/v8west/city/border/security/central
	name = "Vietzhuo-8 West - BORSEC - Central Port"

/area/vietzhuo8/indoors/v8west/city/border/security/south
	name = "Vietzhuo-8 West - BORSEC - Southern Checkpoint"

/area/vietzhuo8/indoors/v8west/city/border/security/cells
	name = "Vietzhuo-8 West - BORSEC - Cells"
	icon_state = "v8w_bordercells"

/area/vietzhuo8/indoors/v8west/city/border/security/commpostsouth
	name = "Vietzhuo-8 West - BORSEC - COMMPOST South"
	icon_state = "v8w_seccommpost"

// Vietzhuo-8 West Embassy Buildings

/area/vietzhuo8/indoors/v8west/city/embassy
	name = "Vietzhuo-8 West - Embassy"
	icon_state = "v8w_emoffices"
	minimap_color = MINIMAP_AREA_COMMAND

/area/vietzhuo8/indoors/v8west/city/embassy/visascenter
	name = "Vietzhuo-8 West - Visas Center"
	icon_state = "v8w_emvisas"

/area/vietzhuo8/indoors/v8west/city/embassy/visascenter/lobby
	name = "Vietzhuo-8 West - Visas Center Lobby"

/area/vietzhuo8/indoors/v8west/city/embassy/offices
	name = "Vietzhuo-8 West - Embassy Office Halls"

/area/vietzhuo8/indoors/v8west/city/embassy/office1
	name = "Vietzhuo-8 West - Embassy Office 1"

/area/vietzhuo8/indoors/v8west/city/embassy/office2
	name = "Vietzhuo-8 West - Embassy Office 2"

/area/vietzhuo8/indoors/v8west/city/embassy/office3
	name = "Vietzhuo-8 West - Embassy Office 3"

/area/vietzhuo8/indoors/v8west/city/embassy/office4
	name = "Vietzhuo-8 West - Embassy Office 4"

/area/vietzhuo8/indoors/v8west/city/embassy/officeslobby
	name = "Vietzhuo-8 West - Embassy Office Lobby"

/area/vietzhuo8/indoors/v8west/city/embassy/pressroom
	name = "Vietzhuo-8 West - Conference Room"
	icon_state = "v8w_pressroom"

// Vietzhuo-8 River & Auxillary Bridges

/area/vietzhuo8/outdoors/river/deltanorth
	name = "Vietzhuo-8 - Northern River Delta"
	icon_state = "v8_riverdelta"
	ambience = list('sound/ambience/jungle_amb1.ogg')

/area/vietzhuo8/outdoors/river/north
	name = "Vietzhuo-8 - Northern River"
	icon_state = "v8_rivernorth"
	ambience = list('sound/ambience/jungle_amb1.ogg')

/area/vietzhuo8/outdoors/river/central
	name = "Vietzhuo-8 - Central River"
	icon_state = "v8_rivercentral"
	ambience = list('sound/ambience/jungle_amb1.ogg')

/area/vietzhuo8/outdoors/river/southern
	name = "Vietzhuo-8 - Southern River"
	icon_state = "v8_riversouth"
	ambience = list('sound/ambience/jungle_amb1.ogg')

/area/vietzhuo8/outdoors/bridge/north
	name = "Vietzhuo-8 - Northern Bridge"
	icon_state = "v8_bridgenorth"
	ambience = list('sound/ambience/jungle_amb1.ogg')

/area/vietzhuo8/outdoors/bridge/centralnorth
	name = "Vietzhuo-8 - Central North Bridge"
	icon_state = "v8_bridgecnorth"
	ambience = list('sound/ambience/jungle_amb1.ogg')

/area/vietzhuo8/outdoors/bridge/centralsouth
	name = "Vietzhuo-8 - Central South Bridge"
	icon_state = "v8_bridgecsouth"
	ambience = list('sound/ambience/jungle_amb1.ogg')

/area/vietzhuo8/outdoors/bridge/south
	name = "Vietzhuo-8 - Southern Bridge"
	icon_state = "v8_bridgesouth"
	ambience = list('sound/ambience/jungle_amb1.ogg')

// Vietzhuo-8 Caverns

/area/vietzhuo8/indoors/caves
	name = "Vietzhuo-8 - Caves"
	minimap_color = MINIMAP_AREA_CAVES

/area/vietzhuo8/indoors/caves/northwest
	name = "Vietzhuo-8 - North Western Caverns"
	icon_state = "v8_cavesnw"
	ambience = list('sound/effects/urban/outdoors/windy_caverns_1.ogg',
	'sound/effects/urban/outdoors/windy_caverns_2.ogg',
	'sound/effects/urban/outdoors/windy_caverns_3.ogg',
	'sound/effects/urban/outdoors/deepcave1.ogg',
	'sound/effects/urban/outdoors/deepcave2.ogg',
	)

/area/vietzhuo8/indoors/caves/north
	name = "Vietzhuo-8 - Northern Caverns"
	icon_state = "v8_bridgenorth"
	ambience = list('sound/effects/urban/outdoors/windy_caverns_1.ogg',
	'sound/effects/urban/outdoors/windy_caverns_2.ogg',
	'sound/effects/urban/outdoors/windy_caverns_3.ogg',
	'sound/effects/urban/outdoors/deepcave1.ogg',
	'sound/effects/urban/outdoors/deepcave2.ogg',
	)

/area/vietzhuo8/indoors/caves/northeast
	name = "Vietzhuo-8 - North Eastern Caves"
	icon_state = "v8_cavesne"
	ambience = list('sound/effects/urban/outdoors/windy_caverns_1.ogg',
	'sound/effects/urban/outdoors/windy_caverns_2.ogg',
	'sound/effects/urban/outdoors/windy_caverns_3.ogg',
	'sound/effects/urban/outdoors/deepcave1.ogg',
	'sound/effects/urban/outdoors/deepcave2.ogg',
	)

/area/vietzhuo8/indoors/caves/river
	name = "Vietzhuo-8 - Cavern River"
	icon_state = "v8_rivernorth"
	ambience = list('sound/effects/urban/outdoors/windy_caverns_1.ogg',
	'sound/effects/urban/outdoors/windy_caverns_2.ogg',
	'sound/effects/urban/outdoors/windy_caverns_3.ogg',
	'sound/effects/urban/outdoors/deepcave1.ogg',
	'sound/effects/urban/outdoors/deepcave2.ogg',
	)
