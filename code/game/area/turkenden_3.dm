#define AMBIENT_LV759_OUTDOORS list('sound/effects/urban/outdoors/wind4.ogg','sound/effects/urban/outdoors/wind5.ogg','sound/effects/urban/outdoors/wind6.ogg','sound/effects/urban/outdoors/wind7.ogg','sound/effects/urban/outdoors/wind8.ogg','sound/effects/urban/outdoors/wind9.ogg','sound/effects/urban/outdoors/wind10.ogg','sound/effects/urban/outdoors/wind11.ogg','sound/effects/urban/outdoors/wind12.ogg','sound/effects/urban/outdoors/wind13.ogg','sound/effects/urban/outdoors/wind14.ogg','sound/effects/urban/outdoors/wind15.ogg','sound/effects/urban/outdoors/wind16.ogg','sound/effects/urban/outdoors/wind17.ogg','sound/effects/urban/outdoors/wind18.ogg','sound/effects/urban/outdoors/wind19.ogg','sound/effects/urban/outdoors/wind20.ogg','sound/effects/urban/outdoors/wind21.ogg','sound/effects/urban/outdoors/wind22.ogg','sound/effects/urban/outdoors/wind23.ogg','sound/effects/urban/outdoors/wind24.ogg','sound/effects/urban/outdoors/wind25.ogg','sound/effects/urban/outdoors/wind26.ogg','sound/effects/urban/outdoors/wind27.ogg','sound/effects/urban/outdoors/wind28.ogg',)
#define AMBIENT_LV759_INDOORS list('sound/effects/urban/indoors/indoor_wind.ogg','sound/effects/urban/indoors/indoor_wind2.ogg','sound/effects/urban/indoors/vent_1.ogg','sound/effects/urban/indoors/vent_2.ogg','sound/effects/urban/indoors/vent_3.ogg','sound/effects/urban/indoors/vent_4.ogg','sound/effects/urban/indoors/vent_5.ogg','sound/effects/urban/indoors/vent_6.ogg','sound/effects/urban/indoors/vent_7.ogg','sound/effects/urban/indoors/vent_6.ogg','sound/effects/urban/indoors/distant_sounds_1.ogg','sound/effects/urban/indoors/distant_sounds_2.ogg','sound/effects/urban/indoors/distant_sounds_3.ogg','sound/effects/urban/indoors/distant_sounds_4.ogg','sound/effects/urban/indoors/distant_sounds_5.ogg','sound/effects/urban/indoors/distant_sounds_6.ogg','sound/effects/urban/indoors/distant_sounds_7.ogg','sound/effects/urban/indoors/distant_sounds_8.ogg','sound/effects/urban/indoors/distant_sounds_9.ogg','sound/effects/urban/indoors/distant_sounds_10.ogg','sound/effects/engamb1.ogg','sound/effects/engamb2.ogg','sound/effects/engamb3.ogg','sound/effects/engamb4.ogg','sound/effects/engamb5.ogg','sound/effects/engamb6.ogg','sound/effects/engamb7.ogg',)
#define AMBIENT_LV759_DERELICTSHIP list('sound/effects/urban/indoors/derelict1.ogg','sound/effects/urban/indoors/derelict_ambience.ogg','sound/effects/urban/indoors/urban_interior.ogg','sound/effects/urban/indoors/derelict2.ogg','sound/effects/urban/indoors/derelict3.ogg','sound/effects/urban/indoors/derelict4.ogg','sound/effects/urban/indoors/derelict5.ogg','sound/effects/urban/indoors/derelict6.ogg','sound/effects/urban/indoors/derelict7.ogg','sound/effects/urban/indoors/derelict8.ogg')

//turkenden3excluzone AREAS--------------------------------------//

/area/turkenden3excluzone
	name = "Turkenden-3 Exclusion Zone"
	icon = 'icons/turf/turkenden_3.dmi'
	icon_state = "turkenden3excluzone"

//parent types

/area/turkenden3excluzone/indoors
	name = "Turkenden-3 Excluzone - Indoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_METAL
	outside = FALSE
	always_unpowered = FALSE
	minimap_color = MINIMAP_AREA_LIVING
	ambience = AMBIENT_LV759_INDOORS

/area/turkenden3excluzone/outdoors
	name = "Turkenden-3 Excluzone - Outdoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_NONE
	always_unpowered = TRUE
	ambience = AMBIENT_LV759_OUTDOORS

/area/turkenden3excluzone/oob
	name = "Out Of Bounds"
	icon_state = "oob"
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE
	always_unpowered = TRUE

// Landing Zone 1
/area/turkenden3excluzone/outdoors/landing_zone_1
	name = "Turkenden-3 Excluzone - Northeast - Landing Zone One"
	icon_state = "t3esw_lz1"
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	area_flavor = AREA_FLAVOR_URBAN

/area/turkenden3excluzone/indoors/landing_zone_1/hangars
	icon_state = "t3esw_lz1"
	minimap_color = MINIMAP_AREA_ESCAPE

/area/turkenden3excluzone/indoors/landing_zone_1/air_control_room
	name = "Turkenden-3 Excluzone - Southwest - Air Control Room"
	icon_state = "t3esw_lz1_ac"

/area/turkenden3excluzone/indoors/landing_zone_1/lz1_console
	name = "Turkenden-3 Excluzone - Southwest - Dropship Alamo Console"
	requires_power = FALSE

// Landing Zone 2
/area/turkenden3excluzone/outdoors/landing_zone_2
	name = "Turkenden-3 Excluzone - Northeast - LZ2"
	icon_state = "t3ene_lz2"
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	always_unpowered = FALSE

/area/turkenden3excluzone/indoors/landing_zone_2/flight_control_room
	name = "Turkenden-3 Excluzone - Northeast - Air Control Building"
	icon_state = "t3ene_lz2_ac"
	ceiling = CEILING_METAL

/area/turkenden3excluzone/indoors/landing_zone_2/lz2_console
	name = "Turkenden-3 Excluzone - Northeast - Dropship Normandy Console"
	icon_state = "t3ene_lz2"
	requires_power = FALSE
	ceiling = CEILING_METAL

// Merchant Road
/area/turkenden3excluzone/outdoors/roadsw
	name = "Turkenden-3 Excluzone - Southwest Road"
	icon_state = "t3esw_roads"
	ceiling = CEILING_NONE

/area/turkenden3excluzone/outdoors/roadw
	name = "Turkenden-3 Excluzone - West Road"
	icon_state = "t3ew_roads"
	ceiling = CEILING_NONE

/area/turkenden3excluzone/outdoors/desertsw
	name = "Turkenden-3 Excluzone - Southwest Desert"
	icon_state = "t3esw_desert"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_LZ

/area/turkenden3excluzone/outdoors/desertw
	name = "Turkenden-3 Excluzone - West Desert"
	icon_state = "t3ew_desert"
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE

/area/turkenden3excluzone/indoors/biltongshop
	name = "Turkenden-3 Excluzone - Southwest - Biltong Shop"
	icon_state = "t3esw_biltong_shop"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/liquorstore
	name = "Turkenden-3 Excluzone - Southwest - Liquor Store"
	icon_state = "t3esw_liquorstore"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/goldandsilver
	name = "Turkenden-3 Excluzone - Southwest - Silver & Gold Exchange"
	icon_state = "t3esw_goldandsilver"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/producemarket
	name = "Turkenden-3 Excluzone - Southwest - Produce Market"
	icon_state = "t3esw_produce_shop"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/foodkiosk
	name = "Turkenden-3 Excluzone - West - Food Kiosk"
	icon_state = "t3ew_foodkiosk"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/farmhouse
	name = "Turkenden-3 Excluzone - Southwest - Farmhouse"
	icon_state = "t3esw_farmhouse"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/miningshack
	name = "Turkenden-3 Excluzone - West - Mining Shack"
	icon_state = "t3ew_mineshack"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/kiosks
	name = "Turkenden-3 Excluzone - West - Kiosks"
	icon_state = "t3ew_kiosks"

/area/turkenden3excluzone/indoors/westouthouses
	name = "Turkenden-3 Excluzone - West - Outhouse"
	icon_state = "t3ew_outhouse"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/westresidencies
	name = "Turkenden-3 Excluzone - West - Civilian Housing"
	icon_state = "t3ew_civhousing"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/swresidencies
	name = "Turkenden-3 Excluzone - Southwest - Civilian Housing"
	icon_state = "t3esw_civhousing"
	minimap_color = MINIMAP_AREA_LIVING

// Agriculture & Faith

/area/turkenden3excluzone/outdoors/roadnw
	name = "Turkenden-3 Excluzone - Northwest Roads"
	icon_state = "t3enw_roads"
	ceiling = CEILING_NONE

/area/turkenden3excluzone/outdoors/desertnw
	name = "Turkenden-3 Excluzone - Northwest Deserts"
	icon_state = "t3enw_desert"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_LZ

/area/turkenden3excluzone/indoors/nwpowerhut
	name = "Turkenden-3 Excluzone - Northwest - Power Hut"
	icon_state = "t3enw_powerhut"

/area/turkenden3excluzone/indoors/mosque
	name = "Turkenden-3 Excluzone - Northwest - Mosque"
	icon_state = "t3enw_mosque"

/area/turkenden3excluzone/indoors/mosque/halls
	name = "Turkenden-3 Excluzone - Northwest - Mosque Halls"
	icon_state = "t3enw_mosquehalls"

/area/turkenden3excluzone/outdoors/mosque/paths
	name = "Turkenden-3 Excluzone - Northwest - Pathways"
	icon_state = "t3enw_mosquepaths"
	minimap_color = MINIMAP_AREA_COLONY

/area/turkenden3excluzone/outdoors/mosque/ground
	name = "Turkenden-3 Excluzone - Northwest - Mosque Grounds"
	icon_state = "t3enw_mosqueground"
	minimap_color = MINIMAP_AREA_COLONY

/area/turkenden3excluzone/outdoors/mosque/cemetary
	name = "Turkenden-3 Excluzone - Northwest - Mosque Cemetary"
	icon_state = "t3enw_mosquecemetary"

/area/turkenden3excluzone/indoors/mosque/tomb
	name = "Turkenden-3 Excluzone - Northwest - Mosque Tomb"
	icon_state = "t3enw_mosquetomb"

/area/turkenden3excluzone/indoors/nwgreenhouse
	name = "Turkenden-3 Excluzone - Northwest - Greenhouse"
	icon_state = "t3enw_greenhouse"

/area/turkenden3excluzone/indoors/nwouthouses
	name = "Turkenden-3 Excluzone - Northwest - Outhouse"
	icon_state = "t3enw_outhouse"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/nwplantstore
	name = "Turkenden-3 Excluzone - Northwest - Plant Store"
	icon_state = "t3enw_plantstore"

/area/turkenden3excluzone/indoors/nwresidencies
	name = "Turkenden-3 Excluzone - Northwest - Civilian Housing"
	icon_state = "t3enw_civhousing"

// Military & Residencies

/area/turkenden3excluzone/outdoors/roadn
	name = "Turkenden-3 Excluzone - Northern Roads"
	icon_state = "t3en_roads"
	ceiling = CEILING_NONE

/area/turkenden3excluzone/outdoors/desertn
	name = "Turkenden-3 Excluzone - Northern Deserts"
	icon_state = "t3en_desert"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_LZ

/area/turkenden3excluzone/outdoors/nmilitaryoutpost
	name = "Turkenden-3 Excluzone - Military Outpost"
	icon_state = "t3en_milout"

/area/turkenden3excluzone/outdoors/nmilitaryoutpost/road
	name = "Turkenden-3 Excluzone - Military Outpost - Road"
	icon_state = "t3en_milout_road"

/area/turkenden3excluzone/outdoors/nmilitaryoutpost/grounds
	name = "Turkenden-3 Excluzone - Military Outpost - Grounds"
	icon_state = "t3en_milout"
	minimap_color = MINIMAP_AREA_COLONY

/area/turkenden3excluzone/outdoors/nmilitaryoutpost/landingpad
	name = "Turkenden-3 Excluzone - Military Outpost - Landing Pad"
	icon_state = "t3en_milout_landpad"
	minimap_color = MINIMAP_AREA_LZ

/area/turkenden3excluzone/outdoors/nmilitaryoutpost/parkinglot
	name = "Turkenden-3 Excluzone - Military Outpost - Parking Lot"
	icon_state = "t3en_milout_plot"

/area/turkenden3excluzone/outdoors/nmilitaryoutpost/drill
	name = "Turkenden-3 Excluzone - Military Outpost - Drill Site"
	icon_state = "t3en_milout_drill"
	minimap_color = MINIMAP_AREA_COLONY

/area/turkenden3excluzone/indoors/nresidencies
	name = "Turkenden-3 Excluzone - North - Civilian Housing"
	icon_state = "t3en_civhousing"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/nmilitaryoutpost/secpoint
	name = "Turkenden-3 Excluzone - Military Outpost - Guardpost"
	icon_state = "t3en_milout_secpoint"
	minimap_color = MINIMAP_AREA_SEC

/area/turkenden3excluzone/indoors/nmilitaryoutpost/gens
	name = "Turkenden-3 Excluzone - Military Outpost - Generators"
	icon_state = "t3en_milout_gens"
	minimap_color = MINIMAP_AREA_ENGI

/area/turkenden3excluzone/indoors/nmilitaryoutpost/commandpost
	name = "Turkenden-3 Excluzone - Military Outpost - Command Post"
	icon_state = "t3en_milout_compost"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/nmilitaryoutpost/barracks1
	name = "Turkenden-3 Excluzone - Military Outpost - Barracks 1"
	icon_state = "t3en_milout_barr1"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/nmilitaryoutpost/barracks2
	name = "Turkenden-3 Excluzone - Military Outpost - Barracks 2"
	icon_state = "t3en_milout_barr2"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/nmilitaryoutpost/barracks3
	name = "Turkenden-3 Excluzone - Military Outpost - Barracks 3"
	icon_state = "t3en_milout_barr3"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/nmilitaryoutpost/messhall
	name = "Turkenden-3 Excluzone - Military Outpost - Mess Hall"
	icon_state = "t3en_milout_mess"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/militaryoutpost/fieldhospital
	name = "Turkenden-3 Excluzone - Outpost Field Hospital"
	icon_state = "t3en_milout_fhosp"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/turkenden3excluzone/indoors/militaryoutpost/fieldhospital/mo
	name = "Turkenden-3 Excluzone - Military Field Hospital - Medical Office"
	icon_state = "t3en_milout_mooffice"

/area/turkenden3excluzone/indoors/militaryoutpost/fieldhospital/surgery
	name = "Turkenden-3 Excluzone - Military Field Hospital - Surgery"
	icon_state = "t3en_milout_surgthea"

/area/turkenden3excluzone/outdoors/roadsn
	name = "Turkenden-3 Excluzone - Northern Roads"
	icon_state = "t3en_roads"

/area/turkenden3excluzone/outdoors/desertne
	name = "Turkenden-3 Excluzone - Northeastern Desert"
	icon_state = "t3ene_desert"
	minimap_color = MINIMAP_AREA_LZ

/area/turkenden3excluzone/outdoors/roadsne
	name = "Turkenden-3 Excluzone - Northeastern Roads"
	icon_state = "t3ene_roads"

// Turkenden-3 Government Servers & Residence

/area/turkenden3excluzone/outdoors/roade
	name = "Turkenden-3 Excluzone - Eastern Roads"
	icon_state = "t3ee_roads"
	ceiling = CEILING_NONE

/area/turkenden3excluzone/outdoors/deserte
	name = "Turkenden-3 Excluzone - Eastern Deserts"
	icon_state = "t3ee_desert"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_LZ

/area/turkenden3excluzone/outdoors/serverbuilding/eroad
	name = "Turkenden-3 Excluzone - TRUGOV Servers - East Road"
	icon_state = "t3ee_govserv_eroad"

/area/turkenden3excluzone/outdoors/serverbuilding/eparking
	name = "Turkenden-3 Excluzone - TRUGOV Servers - East Parking"
	icon_state = "t3ee_govserv_eplot"

/area/turkenden3excluzone/outdoors/serverbuilding/groundse
	name = "Turkenden-3 Excluzone - TRUGOV Servers - East Grounds"
	icon_state = "t3ee_govserv_groundse"
	minimap_color = MINIMAP_AREA_COLONY

/area/turkenden3excluzone/outdoors/serverbuilding/wroad
	name = "Turkenden-3 Excluzone - TRUGOV Servers - West Road"
	icon_state = "t3ee_govserv_wroad"

/area/turkenden3excluzone/outdoors/serverbuilding/wparking
	name = "Turkenden-3 Excluzone - TRUGOV Servers - West Parking"
	icon_state = "t3ee_govserv_wplot"

/area/turkenden3excluzone/outdoors/serverbuilding/groundsw
	name = "Turkenden-3 Excluzone - TRUGOV Servers - SW Grounds"
	icon_state = "t3ee_govserv_groundsw"
	minimap_color = MINIMAP_AREA_COLONY

/area/turkenden3excluzone/outdoors/serverbuilding/groundse
	name = "Turkenden-3 Excluzone - TRUGOV Servers - SE Grounds"
	icon_state = "t3ee_govserv_groundse"
	minimap_color = MINIMAP_AREA_COLONY

/area/turkenden3excluzone/outdoors/serverbuilding/groundsn
	name = "Turkenden-3 Excluzone - TRUGOV Servers - North Grounds"
	icon_state = "t3ee_govserv_groundsn"
	minimap_color = MINIMAP_AREA_COLONY

/area/turkenden3excluzone/outdoors/serverbuilding/groundss
	name = "Turkenden-3 Excluzone - TRUGOV Servers - South Grounds"
	icon_state = "t3ee_govserv_groundss"
	minimap_color = MINIMAP_AREA_COLONY

/area/turkenden3excluzone/indoors/serverbuilding/eastresidencies
	name = "Turkenden-3 Excluzone - East - Civilian Housing"
	icon_state = "t3ee_civhousing"

/area/turkenden3excluzone/indoors/serverbuilding/driveinsouth
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Drive-In South"
	icon_state = "t3ee_govserv_drvins"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/lobbysouth
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Lobby South"
	icon_state = "t3ee_govserv_lobbys"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/southhall
	name = "Turkenden-3 Excluzone - TRUGOV Servers - South Hall"
	icon_state = "t3ee_govserv_shall"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/mensrestrooms
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Mens Restroom South"
	icon_state = "t3ee_govserv_mrests"

/area/turkenden3excluzone/indoors/serverbuilding/femrestroom
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Womens Restroom South"
	icon_state = "t3ee_govserv_frests"

/area/turkenden3excluzone/indoors/serverbuilding/managementrec
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Management Reception"
	icon_state = "t3ee_govserv_managerec"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/management
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Management"
	icon_state = "t3ee_govserv_manage"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/breakroom
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Break Room"
	icon_state = "t3ee_govserv_break"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/serverbuilding/catering
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Catering"
	icon_state = "t3ee_govserv_kitchen"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/serverbuilding/custodian
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Custodian"
	icon_state = "t3ee_govserv_janitor"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/serverbuilding/servstore
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Server Storage"
	icon_state = "t3ee_govserv_servstore"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/mainoffices
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Main Offices"
	icon_state = "t3ee_govserv_officesm"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/opsoverseer
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Overseer Office"
	icon_state = "t3ee_govserv_opsovers"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/persnoffice1
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Private Office 1"
	icon_state = "t3ee_govserv_officesm"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/persnoffice2
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Private Office 2"
	icon_state = "t3ee_govserv_officesm"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/persnoffice3
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Private Office 3"
	icon_state = "t3ee_govserv_officesm"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/persnoffice4
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Private Office 4"
	icon_state = "t3ee_govserv_officesm"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/northhalls
	name = "Turkenden-3 Excluzone - TRUGOV Servers - North Halls"
	icon_state = "t3ee_govserv_nhalls"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/northoffices
	name = "Turkenden-3 Excluzone - TRUGOV Servers - North Offices"
	icon_state = "t3ee_govserv_officesn"
	minimap_color = MINIMAP_AREA_COMMAND

/area/turkenden3excluzone/indoors/serverbuilding/mensrestroomn
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Mens Restroom North"
	icon_state = "t3ee_govserv_mrestn"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/serverbuilding/femrestroomn
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Womens Restroom North"
	icon_state = "t3ee_govserv_frestn"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/serverbuilding/menscroom
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Mens Changing Room"
	icon_state = "t3ee_govserv_mcroom"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/serverbuilding/femcroom
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Womens Changing Room"
	icon_state = "t3ee_govserv_femcroom"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/serverbuilding/seccenter
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Security Center"
	icon_state = "t3ee_govserv_seccent"
	minimap_color = MINIMAP_AREA_SEC

/area/turkenden3excluzone/indoors/serverbuilding/secpost
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Security Post"
	icon_state = "t3ee_govserv_secpost"
	minimap_color = MINIMAP_AREA_SEC

/area/turkenden3excluzone/indoors/serverbuilding/gensroomn
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Generators North"
	icon_state = "t3ee_govserv_gensn"
	minimap_color = MINIMAP_AREA_ENGI

/area/turkenden3excluzone/indoors/serverbuilding/gensrooms
	name = "Turkenden-3 Excluzone - TRUGOV Servers - Generators South"
	icon_state = "t3ee_govserv_genss"
	minimap_color = MINIMAP_AREA_ENGI

// Turkenden-3 Factory, Cargo, Mining & Living

/area/turkenden3excluzone/outdoors/roadse
	name = "Turkenden-3 Excluzone - Southeastern Roads"
	icon_state = "t3ese_roads"
	ceiling = CEILING_NONE

/area/turkenden3excluzone/outdoors/desertse
	name = "Turkenden-3 Excluzone - Southeastern Deserts"
	icon_state = "t3ese_desert"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_LZ

/area/turkenden3excluzone/outdoors/reqcargo
	name = "Turkenden-3 Excluzone - Cargo-Factory - Req-Grounds"
	icon_state = "t3ese_req_grounds"
	ceiling = CEILING_NONE

/area/turkenden3excluzone/outdoors/reqcargo/spaceport
	name = "Turkenden-3 Excluzone - Cargo-Factory - Spaceport"
	icon_state = "t3ese_req_spaceport"
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE

/area/turkenden3excluzone/indoors/reqcargo
	name = "Turkenden-3 Excluzone - Cargo-Factory"
	icon_state = "t3ese_req_factory"
	minimap_color = MINIMAP_AREA_REQ

/area/turkenden3excluzone/indoors/reqcargo/lobby
	name = "Turkenden-3 Excluzone - Cargo-Factory - Lobby"
	icon_state = "t3ese_req_lobby"
	minimap_color = MINIMAP_AREA_REQ

/area/turkenden3excluzone/indoors/reqcargo/qmoffice
	name = "Turkenden-3 Excluzone - Cargo-Factory - QM Office"
	icon_state = "t3ese_req_qmoffice"
	minimap_color = MINIMAP_AREA_REQ

/area/turkenden3excluzone/indoors/reqcargo/qmquarters
	name = "Turkenden-3 Excluzone - Cargo-Factory - QM Quarters"
	icon_state = "t3ese_req_qmdorm"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/reqcargo/reqmaints
	name = "Turkenden-3 Excluzone - Cargo-Factory - Maintenance"
	icon_state = "t3ese_req_maint"
	minimap_color = MINIMAP_AREA_ENGI

/area/turkenden3excluzone/indoors/reqcargo/reqsec
	name = "Turkenden-3 Excluzone - Cargo-Factory - Security Post"
	icon_state = "t3ese_req_secpost"
	minimap_color = MINIMAP_AREA_SEC

/area/turkenden3excluzone/indoors/reqcargo/asrsfacility
	name = "Turkenden-3 Excluzone - Cargo-Factory - ASRS Facility"
	icon_state = "t3ese_req_asrs"
	minimap_color = MINIMAP_AREA_REQ

/area/turkenden3excluzone/indoors/reqcargo/reqstorage1
	name = "Turkenden-3 Excluzone - Cargo-Factory - Storage Unit 1"
	icon_state = "t3ese_req_store1"
	minimap_color = MINIMAP_AREA_REQ

/area/turkenden3excluzone/indoors/reqcargo/reqstorage2
	name = "Turkenden-3 Excluzone - Cargo-Factory - Storage Unit 2"
	icon_state = "t3ese_req_store2"
	minimap_color = MINIMAP_AREA_REQ

/area/turkenden3excluzone/indoors/reqcargo/reqstorage3
	name = "Turkenden-3 Excluzone - Cargo-Factory - Storage Unit 3"
	icon_state = "t3ese_req_store3"
	minimap_color = MINIMAP_AREA_REQ

/area/turkenden3excluzone/indoors/reqcargo/reqrigstorage
	name = "Turkenden-3 Excluzone - Cargo-Factory - Rig Storage"
	icon_state = "t3ese_req_rigstore"
	minimap_color = MINIMAP_AREA_REQ

/area/turkenden3excluzone/indoors/reqcargo/generators
	name = "Turkenden-3 Excluzone - Cargo-Factory - Generators"
	icon_state = "t3ese_req_power"
	minimap_color = MINIMAP_AREA_ENGI

/area/turkenden3excluzone/indoors/miningfacility
	name = "Turkenden-3 Excluzone - Mining Facility"
	icon_state = "t3ese_minefacil"
	minimap_color = MINIMAP_AREA_REQ

/area/turkenden3excluzone/indoors/miningfacility/dorms1
	name = "Turkenden-3 Excluzone - Mining Facility - Dorms 1"
	icon_state = "t3ese_minefacil_dorms1"

/area/turkenden3excluzone/indoors/miningfacility/dorms2
	name = "Turkenden-3 Excluzone - Mining Facility - Dorms 2"
	icon_state = "t3ese_minefacil_dorms2"

/area/turkenden3excluzone/indoors/miningfacility/fmquarters
	name = "Turkenden-3 Excluzone - Mining Facility - Foreman Quarters"
	icon_state = "t3ese_minefacil_fmquarters"

/area/turkenden3excluzone/indoors/miningfacility/excavation
	name = "Turkenden-3 Excluzone - Mining Facility - Excavation Site"
	icon_state = "t3ese_minefacil_digsite"

/area/turkenden3excluzone/indoors/miningfacility/secpost
	name = "Turkenden-3 Excluzone - Mining Facility - Security Post"
	icon_state = "t3ese_minefacil_secpost"
	minimap_color = MINIMAP_AREA_SEC

/area/turkenden3excluzone/indoors/reqcargo/seresidencies
	name = "Turkenden-3 Excluzone - Southeast - Civilian Housing"
	icon_state = "t3ese_civhousing"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/diner
	name = "Turkenden-3 Excluzone - Southeast - Turkenaf-Lekkernye"
	icon_state = "t3ese_diner"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/seouthouses
	name = "Turkenden-3 Excluzone - Southeast - Outhouses"
	icon_state = "t3ese_outhouse"
	minimap_color = MINIMAP_AREA_LIVING

// Turkenden-3 Medical-Research Joint Facility & Living

/area/turkenden3excluzone/outdoors/roads
	name = "Turkenden-3 Excluzone - Southern Roads"
	icon_state = "t3es_roads"
	ceiling = CEILING_NONE

/area/turkenden3excluzone/outdoors/deserts
	name = "Turkenden-3 Excluzone - Southern Deserts"
	icon_state = "t3es_desert"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_LZ

/area/turkenden3excluzone/outdoors/medrsrgrounds
	name = "Turkenden-3 Excluzone - Med-Research - Grounds"
	icon_state = "t3es_medresr_grounds"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COLONY

/area/turkenden3excluzone/indoors/sresidencies
	name = "Turkenden-3 Excluzone - South - Civilian Housing"
	minimap_color = MINIMAP_AREA_LIVING
	icon_state = "t3es_civhousing"

/area/turkenden3excluzone/indoors/medrsr/jointfac
	name = "Turkenden-3 Excluzone - Med-Research - Joint Facility"
	icon_state = "t3es_medresr_joinfac"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE

/area/turkenden3excluzone/indoors/medrsr/meddorms
	name = "Turkenden-3 Excluzone - Med-Research - Medical Dorms"
	icon_state = "t3es_medresr_meddorm"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/medrsr/cmo
	name = "Turkenden-3 Excluzone - Med-Research - CMO Dorm"
	icon_state = "t3es_medresr_rsrhead"
	minimap_color = MINIMAP_AREA_LIVING

/area/turkenden3excluzone/indoors/medrsr/rsrdorms
	name = "Turkenden-3 Excluzone - Med-Research - Research Dorms"
	icon_state = "t3es_medresr_rsrdorm"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE

/area/turkenden3excluzone/indoors/medrsr/director
	name = "Turkenden-3 Excluzone - Med-Research - Director Dorm"
	icon_state = "t3es_medresr_rsrhead"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE

/area/turkenden3excluzone/indoors/medrsr/operatingtheatre
	name = "Turkenden-3 Excluzone - Med-Research - Operating Theatre"
	icon_state = "t3es_medresr_surgthea"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/turkenden3excluzone/indoors/medrsr/morgue
	name = "Turkenden-3 Excluzone - Med-Research - Morgue"
	icon_state = "t3es_medresr_morgue"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/turkenden3excluzone/indoors/medrsr/chemistry
	name = "Turkenden-3 Excluzone - Med-Research - Chemistry Lab"
	icon_state = "t3es_medresr_morgue"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/turkenden3excluzone/indoors/medrsr/intake
	name = "Turkenden-3 Excluzone - Med-Research - Patient Intake"
	icon_state = "t3es_medresr_patint"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/turkenden3excluzone/indoors/medrsr/lab
	name = "Turkenden-3 Excluzone - Med-Research - Laboratory"
	icon_state = "t3es_medresr_lab"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE

/area/turkenden3excluzone/indoors/medrsr/showers
	name = "Turkenden-3 Excluzone - Med-Research - Showers"
	icon_state = "t3es_medresr_showers"

/area/turkenden3excluzone/indoors/medrsr/seceast
	name = "Turkenden-3 Excluzone - Med-Research - Secpost East"
	icon_state = "t3es_medresr_seceast"
	minimap_color = MINIMAP_AREA_SEC

/area/turkenden3excluzone/indoors/medrsr/secwest
	name = "Turkenden-3 Excluzone - Med-Research - Secpost West"
	icon_state = "t3es_medresr_secwest"
	minimap_color = MINIMAP_AREA_SEC

/area/turkenden3excluzone/indoors/medrsr/generators
	name = "Turkenden-3 Excluzone - Med-Research - Generators"
	icon_state = "t3es_medresr_gens"
	minimap_color = MINIMAP_AREA_ENGI

/area/turkenden3excluzone/indoors/medrsr/breaker
	name = "Turkenden-3 Excluzone - Med-Research - Breaker Room"
	icon_state = "t3es_medresr_breaker"
	minimap_color = MINIMAP_AREA_ENGI

/area/turkenden3excluzone/indoors/southouthouse
	name = "Turkenden-3 Excluzone - South - Outhouse"
	icon_state = "t3es_outhouse"

// Turkenden-3 Ground Zero

/area/turkenden3excluzone/indoors/caves
	name = "Turkenden-3 Excluzone - Caves - Hive"
	icon_state = "t3e_ccaves"
	minimap_color = MINIMAP_AREA_CAVES

/area/turkenden3excluzone/indoors/caves/sw
	name = "Turkenden-3 Excluzone - Caves - Southwest"
	icon_state = "t3e_swcaves"

/area/turkenden3excluzone/indoors/caves/west
	name = "Turkenden-3 Excluzone - Caves - West"
	icon_state = "t3e_wcaves"

/area/turkenden3excluzone/indoors/caves/nw
	name = "Turkenden-3 Excluzone - Caves - Northwest"
	icon_state = "t3e_nwcaves"

/area/turkenden3excluzone/indoors/caves/n
	name = "Turkenden-3 Excluzone - Caves - North"
	icon_state = "t3e_ncaves"

/area/turkenden3excluzone/indoors/caves/ne
	name = "Turkenden-3 Excluzone - Caves - Northeast"
	icon_state = "t3e_necaves"

/area/turkenden3excluzone/indoors/caves/e
	name = "Turkenden-3 Excluzone - Caves - East"
	icon_state = "t3e_ecaves"

/area/turkenden3excluzone/indoors/caves/se
	name = "Turkenden-3 Excluzone - Caves - Southeast"
	icon_state = "t3e_sewcaves"

/area/turkenden3excluzone/indoors/caves/s
	name = "Turkenden-3 Excluzone - Caves - South"
	icon_state = "t3e_scaves"

/area/turkenden3excluzone/indoors/caves/c
	name = "Turkenden-3 Excluzone - Caves - Central"
	icon_state = "t3e_ccaves"

/area/turkenden3excluzone/indoors/caves/cult
	name = "Turkenden-3 Excluzone - Caves - West Cult Temple"
	icon_state = "t3ew_cult_temple"
	minimap_color = MINIMAP_AREA_LIVING
