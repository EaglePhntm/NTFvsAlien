//gleichseitig16 AREAS--------------------------------------//

/area/gleichseitig16
	name = "Gleichseitig-16 Flashpoints"
	icon = 'icons/turf/gleichseitig_16.dmi'
	icon_state = "gleichseitig_16_flashpoints"

//parent types

/area/gleichseitig16/indoors
	name = "Gleichseitig-16 - Indoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_METAL
	outside = FALSE
	always_unpowered = FALSE
	minimap_color = MINIMAP_AREA_LIVING
	ambience = list('sound/ambience/gleichseitig16iambience1.ogg',
	'sound/ambience/gleichseitig16iambience2.ogg',
	'sound/ambience/gleichseitig16iambience3.ogg',
	'sound/ambience/gleichseitig16iambience4.ogg',
	)

/area/gleichseitig16/outdoors
	name = "Gleichseitig-16 - Outdoors"
	icon_state = "cliff_blocked"//because this is a PARENT TYPE and you should not be using it and should also be changing the icon!!!
	ceiling = CEILING_NONE
	always_unpowered = TRUE
	ambience = list('sound/ambience/gleichseitig16oambience1.ogg',
	'sound/ambience/gleichseitig16oambience2.ogg',
	'sound/ambience/gleichseitig16oambience3.ogg',
	'sound/ambience/gleichseitig16oambience4.ogg',
	)

/area/gleichseitig16/oob
	name = "Out Of Bounds"
	icon_state = "oob"
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE
	always_unpowered = TRUE

// Landing Zone 1
/area/gleichseitig16/outdoors/landing_zone_1
	name = "Gleichseitig-16 - LZ1"
	icon_state = "v8w_lz2site"
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	always_unpowered = FALSE

/area/gleichseitig16/outdoors/landing_zone_1/unionspaceport
	name = "Gleichseitig-16 - LZ1 - EHR-Union Spaceport"
	icon_state = "g16f_lz1_spcport"
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE

/area/gleichseitig16/indoors/landing_zone_1/flight_control_room
	name = "Gleichseitig-16 - LZ1 - Flight Control Building"
	icon_state = "g16f_lz1_flight_ctrl"
	ceiling = CEILING_METAL

/area/gleichseitig16/indoors/landing_zone_1/lz1_console
	name = "Gleichseitig-16 - LZ1 - Dropship Normandy Console"
	icon_state = "g16f_lz1_console"
	requires_power = FALSE
	ceiling = CEILING_METAL

// Landing Zone 2
/area/gleichseitig16/outdoors/landing_zone_2
	name = "Gleichseitig-16 - LZ1 - Apartment Courtyard"
	icon_state = "g16f_lz2_apts"
	minimap_color = MINIMAP_AREA_LZ
	ceiling = CEILING_NONE
	area_flavor = AREA_FLAVOR_URBAN

/area/gleichseitig16/outdoors/landing_zone_2/parking
	name = "Gleichseitig-16 - LZ1 - Apartment Parking Lot"
	icon_state = "g16f_lz2_apts_parking"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_COLONY
	area_flavor = AREA_FLAVOR_URBAN

/area/gleichseitig16/indoors/landing_zone_2/frontdesk
	name = "Gleichseitig-16 - LZ2 - Apartment Front Desk"
	icon_state = "g16f_lz2_apts_reception"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/landing_zone_2/apartment1
	name = "Gleichseitig-16 - LZ2 - Apartment 1"
	icon_state = "g16f_lz2_apt1"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/landing_zone_2/apartment2
	name = "Gleichseitig-16 - LZ2 - Apartment 2"
	icon_state = "g16f_lz2_apt2"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/landing_zone_2/apartment3
	name = "Gleichseitig-16 - LZ2 - Apartment 3"
	icon_state = "g16f_lz2_apt3"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/landing_zone_2/apartment4
	name = "Gleichseitig-16 - LZ2 - Apartment 4"
	icon_state = "g16f_lz2_apt4"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/landing_zone_2/apartment5
	name = "Gleichseitig-16 - LZ2 - Apartment 5"
	icon_state = "g16f_lz2_apt5"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/landing_zone_2/apartment6
	name = "Gleichseitig-16 - LZ2 - Apartment 6"
	icon_state = "g16f_lz2_apt6"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/landing_zone_2/lz2_console
	name = "Gleichseitig-16 - Dropship Alamo Console"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_LIVING

//Central

/area/gleichseitig16/outdoors/central
	name = "Gleichseitig-16 - Central"
	icon_state = "v8se_lz1site"
	ceiling = CEILING_NONE

/area/gleichseitig16/indoors/central
	name = "Gleichseitig-16 - Central"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/indoors/central/consulate
	name = "Gleichseitig-16 - Central - Consulate"
	icon_state = "g16f_consulate"
	minimap_color = MINIMAP_AREA_COMMAND

/area/gleichseitig16/indoors/central/consulate/lobby
	name = "Gleichseitig-16 - Central - Consulate Lobby"
	icon_state = "g16f_consulate_lobby"

/area/gleichseitig16/indoors/central/consulate/ehall
	name = "Gleichseitig-16 - Central - Consulate East Hall"
	icon_state = "g16f_consulate_ehall"

/area/gleichseitig16/indoors/central/consulate/whall
	name = "Gleichseitig-16 - Central - Consulate West Hall"
	icon_state = "g16f_consulate_whall"

/area/gleichseitig16/indoors/central/consulate/courtyard
	name = "Gleichseitig-16 - Central - Consulate Courtyard"
	icon_state = "g16f_consulate_courtyard"

/area/gleichseitig16/outdoors/central/consulate/courtyard
	name = "Gleichseitig-16 - Central - Consulate Courtyard"
	icon_state = "g16f_consulate_courtyard"

/area/gleichseitig16/indoors/central/consulate/breakroom
	name = "Gleichseitig-16 - Central - Consulate Breakroom"
	icon_state = "g16f_consulate_breakroom"

/area/gleichseitig16/indoors/central/consulate/conference
	name = "Gleichseitig-16 - Central - Consulate Conference"
	icon_state = "g16f_consulate_conference"

/area/gleichseitig16/indoors/central/consulate/meeting
	name = "Gleichseitig-16 - Central - Consulate Meeting Room"
	icon_state = "g16f_consulate_meeting"

/area/gleichseitig16/indoors/central/consulate/restrooms
	name = "Gleichseitig-16 - Central - Consulate Restrooms"
	icon_state = "g16f_consulate_restrooms"

/area/gleichseitig16/indoors/central/consulate/woffices
	name = "Gleichseitig-16 - Central - Consulate West Offices"
	icon_state = "g16f_consulate_woffices"

/area/gleichseitig16/indoors/central/consulate/eoffices
	name = "Gleichseitig-16 - Central - Consulate East Offices"
	icon_state = "g16f_consulate_eoffices"

/area/gleichseitig16/indoors/central/consulate/maints
	name = "Gleichseitig-16 - Central - Consulate Maintenance"
	icon_state = "g16f_consulate_maints"
	minimap_color = MINIMAP_AREA_ENGI

/area/gleichseitig16/indoors/central/consulate/secpost
	name = "Gleichseitig-16 - Central - Consulate SECPOST"
	icon_state = "g16f_consulate_secpost"
	minimap_color = MINIMAP_AREA_SEC

/area/gleichseitig16/indoors/central/consulate/pastry
	name = "Gleichseitig-16 - Central - Consulate Pastry Shop"
	icon_state = "g16f_consulate_pastrys"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/central/consulate/steakhouse
	name = "Gleichseitig-16 - Central - Consulate Steak House"
	icon_state = "g16f_consulate_steakhouse"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/outdoors/central/consulate/wparking
	name = "Gleichseitig-16 - Central - Consulate West Parking"
	icon_state = "g16f_consulate_wparking"
	requires_power = FALSE

/area/gleichseitig16/outdoors/central/consulate/eparking
	name = "Gleichseitig-16 - Central - Consulate East Parking"
	icon_state = "g16f_consulate_eparking"

/area/gleichseitig16/outdoors/central/consulate/ealley
	name = "Gleichseitig-16 - Central - Consulate East Alleyway"
	icon_state = "g16f_consulate_ealley"

/area/gleichseitig16/outdoors/central/consulate/walley
	name = "Gleichseitig-16 - Central - Consulate West Alleyway"
	icon_state = "g16f_consulate_walley"

//North

/area/gleichseitig16/outdoors/north
	name = "Gleichseitig-16 - North"
	icon_state = "v8se_lz1site"
	ceiling = CEILING_NONE

/area/gleichseitig16/indoors/north
	name = "Gleichseitig-16 - North"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/outdoors/north/clearings
	name = "Gleichseitig-16 - North - Clearings"
	icon_state = "g16f_nclearing"

/area/gleichseitig16/indoors/north/crawlergarages
	name = "Gleichseitig-16 - North - Crawler Garages"
	icon_state = "g16f_ncrawler_garages"

/area/gleichseitig16/outdoors/north/phoronex/yard
	name = "Gleichseitig-16 - North - PhoronEX Yard"
	icon_state = "g16f_nphoronex_yard"

/area/gleichseitig16/indoors/north/phoronex/pod1
	name = "Gleichseitig-16 - North - PhoronEX Pod 1"
	icon_state = "g16f_nphoronex_pod1"

/area/gleichseitig16/indoors/north/phoronex/pod2
	name = "Gleichseitig-16 - North - PhoronEX Pod 2"
	icon_state = "g16f_nphoronex_pod2"

/area/gleichseitig16/indoors/north/phoronex/garage
	name = "Gleichseitig-16 - North - PhoronEX Garage"
	icon_state = "g16f_nphoronex_storage"

/area/gleichseitig16/indoors/north/guardianmotorpost
	name = "Gleichseitig-16 - North - Guardian Outpost"
	icon_state = "g16f_ehrmil_ngmo"
	minimap_color = MINIMAP_AREA_SEC
	ceiling = CEILING_DEEP_UNDERGROUND

/area/gleichseitig16/indoors/north/gasstation
	name = "Gleichseitig-16 - North - Gas Station"
	icon_state = "g16f_gas_nstation"
	minimap_color = MINIMAP_AREA_ENGI

/area/gleichseitig16/indoors/north/gasstation/pumps
	name = "Gleichseitig-16 - North - Gas Station Pumps"
	icon_state = "g16f_gas_nstation_pumps"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/indoors/north/mechanic
	name = "Gleichseitig-16 - North - Mechanic Autoshop"
	icon_state = "g16f_nmechanic_shop"
	minimap_color = MINIMAP_AREA_ENGI

//East

/area/gleichseitig16/outdoors/east
	name = "Gleichseitig-16 - East"
	icon_state = "v8se_lz1site"
	ceiling = CEILING_NONE

/area/gleichseitig16/indoors/east
	name = "Gleichseitig-16 - East"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/outdoors/east/sinitsynhospital/alleys
	name = "Gleichseitig-16 - East - Sinitsyn Hospital Alleys"
	icon_state = "g16f_sinitsyn_hospital_ealley"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/east/sinitsynhospital/parking
	name = "Gleichseitig-16 - East - Sinitsyn Hospital Parking"
	icon_state = "g16f_sinitsyn_hospital_eparking"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/indoors/east/sinitsynhospital
	name = "Gleichseitig-16 - East - Sinitsyn Hospital"
	icon_state = "g16f_sinitsyn_ehospital"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/gleichseitig16/indoors/east/sinitsynhospital/warehouses
	name = "Gleichseitig-16 - East - Sinitsyn Hospital Warehouses"
	icon_state = "g16f_sinitsyn_hospital_ewareh"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/gleichseitig16/indoors/east/ehrmilmaso/facilities
	name = "Gleichseitig-16 - East - EHR-MIL M.A.S.O Facilities"
	icon_state = "g16f_ehrmil_emaso"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/gleichseitig16/outdoors/east/ehrmilmaso/yard
	name = "Gleichseitig-16 - East - EHR-MIL M.A.S.O Yard"
	icon_state = "g16f_ehrmil_emasoyard"

/area/gleichseitig16/outdoors/east/ehrmilmaso/landpad
	name = "Gleichseitig-16 - East - EHR-MIL M.A.S.O Landing Pads"
	icon_state = "g16f_ehrmil_emasolp"
	minimap_color = MINIMAP_AREA_LZ

/area/gleichseitig16/indoors/east/calderacryogen
	name = "Gleichseitig-16 - East - Caldera Cryogenics"
	icon_state = "g16f_caldera_ecryogen"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/gleichseitig16/outdoors/east/calderacryogen/parking
	name = "Gleichseitig-16 - East - Caldera Cryogenics"
	icon_state = "g16f_caldera_ecryogen_parking"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/indoors/east/calderacryogen/lab
	name = "Gleichseitig-16 - East - Caldera Cryogenics Lab"
	icon_state = "g16f_caldera_ecryogen_lab"

/area/gleichseitig16/indoors/east/rsr
	name = "Gleichseitig-16 - East Research Facility"
	icon_state = "g16f_eastrsr_rnd"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE
	ceiling = CEILING_DEEP_UNDERGROUND

/area/gleichseitig16/indoors/east/rsr/lobby
	name = "Gleichseitig-16 - East Research Facility - Lobby"
	icon_state = "g16f_eastrsr_lobby"

/area/gleichseitig16/indoors/east/rsr/hallway
	name = "Gleichseitig-16 - East Research Facility - Hallway"
	icon_state = "g16f_eastrsr_hallway"

/area/gleichseitig16/indoors/east/rsr/monitor
	name = "Gleichseitig-16 - East Research Facility - Monitor"
	icon_state = "g16f_eastrsr_monitor"

/area/gleichseitig16/indoors/east/rsr/xenobio
	name = "Gleichseitig-16 - East Research Facility - Xenobio Observation"
	icon_state = "g16f_eastrsr_xenobio_obs"

/area/gleichseitig16/indoors/east/rsr/secpost
	name = "Gleichseitig-16 - East Research Facility - Security Post"
	icon_state = "g16f_eastrsr_secpost"
	minimap_color = MINIMAP_AREA_SEC

/area/gleichseitig16/indoors/east/rsr/rnd
	name = "Gleichseitig-16 - East Research Facility - RND"
	icon_state = "g16f_eastrsr_rnd"

/area/gleichseitig16/indoors/east/rsr/breakroom
	name = "Gleichseitig-16 - East Research Facility - Break Room"
	icon_state = "g16f_eastrsr_breakroom"

/area/gleichseitig16/indoors/east/rsr/tcomms
	name = "Gleichseitig-16 - East Research Facility - Telecommunications"
	icon_state = "g16f_eastrsr_tcomms"

/area/gleichseitig16/indoors/east/rsr/servers
	name = "Gleichseitig-16 - East Research Facility - Servers"
	icon_state = "g16f_eastrsr_servers"

/area/gleichseitig16/indoors/east/rsr/biodevroom
	name = "Gleichseitig-16 - East Research Facility - Bio-Development"
	icon_state = "g16f_eastrsr_biodevroom"

/area/gleichseitig16/indoors/east/rsr/xenoobservation
	name = "Gleichseitig-16 - East Research Facility - Xenobio OBS."
	icon_state = "g16f_eastrsr_xeno_obs"

/area/gleichseitig16/indoors/east/rsr/nmaints
	name = "Gleichseitig-16 - East Research Facility - North Maintenance"
	icon_state = "g16f_eastrsr_nmaints"

/area/gleichseitig16/indoors/east/rsr/wmaints
	name = "Gleichseitig-16 - East Research Facility - West Maintenance"
	icon_state = "g16f_eastrsr_wmaints"

/area/gleichseitig16/indoors/east/rsr/smaints
	name = "Gleichseitig-16 - East Research Facility - South Maintenance"
	icon_state = "g16f_eastrsr_smaints"

//South

/area/gleichseitig16/outdoors/south
	name = "Gleichseitig-16 - South"
	icon_state = "v8se_lz1site"
	ceiling = CEILING_NONE

/area/gleichseitig16/indoors/south
	name = "Gleichseitig-16 - South"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/indoors/south/motel/parking
	name = "Gleichseitig-16 - South - Motel Parking Lot"
	icon_state = "g16f_smotel_parking"

/area/gleichseitig16/indoors/south/motel
	name = "Gleichseitig-16 - South - Motel"
	icon_state = "g16f_smotel_reception"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/south/motel/reception
	name = "Gleichseitig-16 - South - Motel Reception"
	icon_state = "g16f_smotel_reception"

/area/gleichseitig16/indoors/south/motel/hallway
	name = "Gleichseitig-16 - South - Motel Hallway"
	icon_state = "g16f_smotel_hallway"

/area/gleichseitig16/indoors/south/motel/room1
	name = "Gleichseitig-16 - South - Motel Room 1"
	icon_state = "g16f_smotel_room1"

/area/gleichseitig16/indoors/south/motel/room2
	name = "Gleichseitig-16 - South - Motel Room 2"
	icon_state = "g16f_smotel_room2"

/area/gleichseitig16/indoors/south/motel/room3
	name = "Gleichseitig-16 - South - Motel Room 3"
	icon_state = "g16f_smotel_room3"

/area/gleichseitig16/indoors/south/pizzagalaxy
	name = "Gleichseitig-16 - South - Pizza Galaxy"
	icon_state = "g16f_sgalaxypizza"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/south/cuppajoe
	name = "Gleichseitig-16 - South - Cuppa Joe's"
	icon_state = "g16f_scuppajoe"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/south/mindfulyoga
	name = "Gleichseitig-16 - South - Mindful Yoga"
	icon_state = "g16f_smindfulyoga"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/south/militarysurplus
	name = "Gleichseitig-16 - South - EHR-MIL Storage"
	icon_state = "g16f_sehrmil_ware_surplus"
	minimap_color = MINIMAP_AREA_SEC
	ceiling = CEILING_DEEP_UNDERGROUND

/area/gleichseitig16/indoors/south/militarysurplus/qm
	name = "Gleichseitig-16 - South - EHR-MIL Storage Quartermaster"
	icon_state = "g16f_sehrmil_ware_qm"

/area/gleichseitig16/indoors/south/militarysurplus/parking
	name = "Gleichseitig-16 - South - EHR-MIL Parking Garage"
	icon_state = "g16f_sehrmil_ware_parking"

/area/gleichseitig16/indoors/south/militarysurplus/reception
	name = "Gleichseitig-16 - South - EHR-MIL Storage Reception"
	icon_state = "g16f_sehrmil_ware_reception"

/area/gleichseitig16/indoors/south/luxuryhotel
	name = "Gleichseitig-16 - South - Trio-Lux Hotel"
	icon_state = "g16_triolux_shotel"
	minimap_color = MINIMAP_AREA_LIVING

//West

/area/gleichseitig16/outdoors/west
	name = "Gleichseitig-16 - West"
	icon_state = "v8se_lz1site"
	ceiling = CEILING_NONE

/area/gleichseitig16/indoors/west
	name = "Gleichseitig-16 - West"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/indoors/west/studycenter
	name = "Gleichseitig-16 - West - P.E.S.C"
	icon_state = "g16f_studycenter_wlobby"

/area/gleichseitig16/indoors/west/studycenter/lobby
	name = "Gleichseitig-16 - West - P.E.S.C Lobby"
	icon_state = "g16f_studycenter_wlobby"

/area/gleichseitig16/indoors/west/studycenter/halls
	name = "Gleichseitig-16 - West - P.E.S.C Halls"
	icon_state = "g16f_studycenter_whalls"

/area/gleichseitig16/indoors/west/studycenter/restrooms
	name = "Gleichseitig-16 - West - P.E.S.C Restrooms"
	icon_state = "g16f_studycenter_wrestrooms"

/area/gleichseitig16/indoors/west/studycenter/office1
	name = "Gleichseitig-16 - West - P.E.S.C Office 1"
	icon_state = "g16f_studycenter_woffice1"

/area/gleichseitig16/indoors/west/studycenter/office2
	name = "Gleichseitig-16 - West - P.E.S.C Office 2"
	icon_state = "g16f_studycenter_woffice2"

/area/gleichseitig16/indoors/west/studycenter/office3
	name = "Gleichseitig-16 - West - P.E.S.C Office 3"
	icon_state = "g16f_studycenter_woffice3"

/area/gleichseitig16/indoors/west/studycenter/headmaster
	name = "Gleichseitig-16 - West - P.E.S.C Headmaster's Office"
	icon_state = "g16f_studycenter_whm"

/area/gleichseitig16/indoors/west/studycenter/custodian
	name = "Gleichseitig-16 - West - P.E.S.C Custodian Maintenance"
	icon_state = "g16f_studycenter_wcust"

/area/gleichseitig16/indoors/west/studycenter/lecturehall1
	name = "Gleichseitig-16 - West - P.E.S.C Lecture Hall 1"
	icon_state = "g16f_studycenter_wlecture1"

/area/gleichseitig16/indoors/west/studycenter/lecturehall2
	name = "Gleichseitig-16 - West - P.E.S.C Lecture Hall 2"
	icon_state = "g16f_studycenter_wlecture2"

/area/gleichseitig16/indoors/west/studycenter/lecturehall3
	name = "Gleichseitig-16 - West - P.E.S.C Lecture Hall 3"
	icon_state = "g16f_studycenter_wlecture3"

/area/gleichseitig16/indoors/west/rsr
	name = "Gleichseitig-16 - West RSR Facility"
	icon_state = "g16f_westrsr_lobby"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE
	ceiling = CEILING_DEEP_UNDERGROUND

/area/gleichseitig16/indoors/west/rsr/lobby
	name = "Gleichseitig-16 - West RSR Facility - Lobby"
	icon_state = "g16f_westrsr_lobby"

/area/gleichseitig16/indoors/west/rsr/custodian
	name = "Gleichseitig-16 - West RSR Facility - Custodian"
	icon_state = "g16f_westrsr_custodian"

/area/gleichseitig16/indoors/west/rsr/mhalls
	name = "Gleichseitig-16 - West RSR Facility - Main Halls"
	icon_state = "g16f_westrsr_mhalls"

/area/gleichseitig16/indoors/west/rsr/whalls
	name = "Gleichseitig-16 - West RSR Facility - West Halls"
	icon_state = "g16f_westrsr_whalls"

/area/gleichseitig16/indoors/west/rsr/moffices
	name = "Gleichseitig-16 - West RSR Facility - Main Offices"
	icon_state = "g16f_westrsr_moffices"

/area/gleichseitig16/indoors/west/rsr/mrestroom
	name = "Gleichseitig-16 - West RSR Facility - Mens Room"
	icon_state = "g16f_westrsr_mrestroom"

/area/gleichseitig16/indoors/west/rsr/lrestroom
	name = "Gleichseitig-16 - West RSR Facility - Ladies Room"
	icon_state = "g16f_westrsr_lrestroom"

/area/gleichseitig16/indoors/west/rsr/servers
	name = "Gleichseitig-16 - West RSR Facility - Server Room"
	icon_state = "g16f_westrsr_servers"

/area/gleichseitig16/indoors/west/rsr/serveroperator
	name = "Gleichseitig-16 - West RSR Facility - Server Operations"
	icon_state = "g16f_westrsr_serverop_ofc"

/area/gleichseitig16/indoors/west/rsr/xenobio
	name = "Gleichseitig-16 - West RSR Facility - Xenobio Office"
	icon_state = "g16f_westrsr_xenobio_ofc"

/area/gleichseitig16/indoors/west/rsr/xbops
	name = "Gleichseitig-16 - West RSR Facility - Xenobio Observation"
	icon_state = "g16f_westrsr_xeno_obs"

/area/gleichseitig16/indoors/west/rsr/coffices
	name = "Gleichseitig-16 - West RSR Facility - Central Offices"
	icon_state = "g16f_westrsr_coffices"

/area/gleichseitig16/indoors/west/rsr/noffices
	name = "Gleichseitig-16 - West RSR Facility - North Offices"
	icon_state = "g16f_westrsr_noffices"

/area/gleichseitig16/indoors/west/rsr/soffices
	name = "Gleichseitig-16 - West RSR Facility - South Offices"
	icon_state = "g16f_westrsr_soffices"

/area/gleichseitig16/indoors/west/rsr/breakroom
	name = "Gleichseitig-16 - West RSR Facility - Break Room"
	icon_state = "g16f_westrsr_breakroom"

/area/gleichseitig16/indoors/west/rsr/nmaints
	name = "Gleichseitig-16 - West RSR Facility - North Maintenance"
	icon_state = "g16f_westrsr_nmaints"

/area/gleichseitig16/indoors/west/rsr/garage
	name = "Gleichseitig-16 - West RSR Facility - Garage"
	icon_state = "g16f_westrsr_garage"

/area/gleichseitig16/indoors/west/rsr/garagesec
	name = "Gleichseitig-16 - West RSR Facility - Garage Secpost"
	icon_state = "g16f_westrsr_garagesec"
	minimap_color = MINIMAP_AREA_SEC

/area/gleichseitig16/indoors/west/rsr/ofsec
	name = "Gleichseitig-16 - West RSR Facility - Offices Secpost"
	icon_state = "g16f_westrsr_ofcsec"
	minimap_color = MINIMAP_AREA_SEC

/area/gleichseitig16/indoors/west/rsr/gens
	name = "Gleichseitig-16 - West Research Facility - Generators"
	minimap_color = MINIMAP_AREA_ENGI

//Northeast

/area/gleichseitig16/outdoors/northeast
	name = "Gleichseitig-16 - Northeast"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/indoors/northeast
	name = "Gleichseitig-16 - Northeast"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/outdoors/northeast/parking
	name = "Gleichseitig-16 - Northeast - Industrial Parking Lot"
	icon_state = "g16f_ne_parking"

/area/gleichseitig16/indoors/northeast/storageunits
	name = "Gleichseitig-16 - Northeast - Storage Units"
	icon_state = "g16f_nestorage_units"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northeast/storageunits/one
	name = "Gleichseitig-16 - Northeast - Storage Unit 1"
	icon_state = "g16f_nestorage_unit1"

/area/gleichseitig16/indoors/northeast/storageunits/two
	name = "Gleichseitig-16 - Northeast - Storage Unit 2"
	icon_state = "g16f_nestorage_unit2"

/area/gleichseitig16/indoors/northeast/storageunits/three
	name = "Gleichseitig-16 - Northeast - Storage Unit 3"
	icon_state = "g16f_nestorage_unit3"

/area/gleichseitig16/indoors/northeast/storageunits/four
	name = "Gleichseitig-16 - Northeast - Storage Unit 4"
	icon_state = "g16f_nestorage_unit4"

/area/gleichseitig16/indoors/northeast/storageunits/five
	name = "Gleichseitig-16 - Northeast - Storage Unit 5"
	icon_state = "g16f_nestorage_unit5"

/area/gleichseitig16/indoors/northeast/storageunits/six
	name = "Gleichseitig-16 - Northeast - Storage Unit 6"
	icon_state = "g16f_nestorage_unit6"

/area/gleichseitig16/indoors/northeast/warehouse
	name = "Gleichseitig-16 - Northeast Indust. Warehouse"
	icon_state = "g16f_newarehouse"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northeast/warehouse/reception
	name = "Gleichseitig-16 - Northeast Indust. Warehouse - Reception"
	icon_state = "g16f_newarehouse_reception"

/area/gleichseitig16/indoors/northeast/warehouse/restroom
	name = "Gleichseitig-16 - Northeast Indust. Warehouse - Restroom"
	icon_state = "g16f_newarehouse_restroom"

/area/gleichseitig16/indoors/northeast/warehouse/observation
	name = "Gleichseitig-16 - Northeast Indust. Warehouse - Observation"
	icon_state = "g16f_newarehouse_observation"

/area/gleichseitig16/indoors/northeast/warehouse/storage
	name = "Gleichseitig-16 - Northeast Indust. Warehouse - Storage"
	icon_state = "g16f_newarehouse_storage"

/area/gleichseitig16/indoors/northeast/warehouse/maints
	name = "Gleichseitig-16 - Northeast Indust. Warehouse - Maintenance"
	icon_state = "g16f_newarehouse_maints"
	minimap_color = MINIMAP_AREA_ENGI

/area/gleichseitig16/indoors/northeast/cargorig/storage1
	name = "Gleichseitig-16 - Northeast - Cargo Rig Warehouse 1"
	icon_state = "g16f_newarehouse_rig1"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northeast/cargorig/storage2
	name = "Gleichseitig-16 - Northeast - Cargo Rig Warehouse 2"
	icon_state = "g16f_newarehouse_rig2"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northeast/exports
	name = "Gleichseitig-16 - Northeast Indust. Exports Center"
	icon_state = "g16f_neexports_center"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northeast/exports
	name = "Gleichseitig-16 - Northeast Indust. Exports Center"
	icon_state = "g16f_neexports_management"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northeast/botanywarehouse
	name = "Gleichseitig-16 - Northeast - Botany Warehouse"
	icon_state = "g16f_botany_newarehouse"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/northeast/powerplant
	name = "Gleichseitig-16 - Northeast - Power Plant"
	icon_state = "g16f_nepowerplant"
	minimap_color = MINIMAP_AREA_ENGI

/area/gleichseitig16/indoors/northeast/powerstation
	name = "Gleichseitig-16 - Northeast - Power Station"
	icon_state = "g16f_power_nestation"
	minimap_color = MINIMAP_AREA_ENGI

/area/gleichseitig16/indoors/northeast/spaceport
	name = "Gleichseitig-16 - Northeast Spaceport"
	icon_state = "g16f_indust_nespaceport"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northeast/spaceport/pmcship
	name = "Gleichseitig-16 - Northeast Spaceport - PMC ERT Shuttle"
	icon_state = "g16f_indust_nesp_pmcship"
	minimap_color = MINIMAP_AREA_ESCAPE

/area/gleichseitig16/indoors/northeast/factory
	name = "Gleichseitig-16 - Northeast Factory"
	icon_state = "g16f_nefactory"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northeast/factory/assembly
	name = "Gleichseitig-16 - Northeast Factory - Assembly"
	icon_state = "g16f_nefactory_assembly"

/area/gleichseitig16/indoors/northeast/factory/breakroom
	name = "Gleichseitig-16 - Northeast Factory - Break Room"
	icon_state = "g16f_nefactory_breakroom"

/area/gleichseitig16/indoors/northeast/factory/observation
	name = "Gleichseitig-16 - Northeast Factory - Observation"
	icon_state = "g16f_nefactory_obsfloor"

/area/gleichseitig16/indoors/northeast/factory/hallway
	name = "Gleichseitig-16 - Northeast Factory - Hallway"
	icon_state = "g16f_nefactory_hallway"

/area/gleichseitig16/indoors/northeast/factory/insideparking
	name = "Gleichseitig-16 - Northeast Factory - Rig Parking"
	icon_state = "g16f_nefactory_parking"

/area/gleichseitig16/outside/northeast/factory/outsideparking
	name = "Gleichseitig-16 - Northeast Factory - Outside Parking"
	icon_state = "g16f_nefactory_oparking"

/area/gleichseitig16/indoors/northeast/phoronex
	name = "Gleichseitig-16 - Northeast - PhoronEX Trailer"
	icon_state = "g16f_nephoronex_trailer"

/area/gleichseitig16/outdoors/northeast/phoronex/yard
	name = "Gleichseitig-16 - Northeast - PhoronEX Yard"
	icon_state = "g16f_nephoronex_yard"

/area/gleichseitig16/indoors/northeast/security/checkpoint
	name = "Gleichseitig-16 - Northeast Checkpoint"
	icon_state = "g16f_newarehouse_checkpoint"
	minimap_color = MINIMAP_AREA_SEC

/area/gleichseitig16/indoors/northeast/security/checkpoint/maints
	name = "Gleichseitig-16 - Northeast Checkpoint - Maintenance"
	icon_state = "g16f_newarehouse_checkpoint_maints"

//Northwest

/area/gleichseitig16/outdoors/northwest
	name = "Gleichseitig-16 - Northwest"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/indoors/northwest
	name = "Gleichseitig-16 - Northwest"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/outdoors/northwest/storageunitstreets
	name = "Gleichseitig-16 - Northwest"
	icon_state = "g16f_nwstorage_unitstreets"

/area/gleichseitig16/indoors/northwest/storage/units
	name = "Gleichseitig-16 - Northwest - Warehouse Units"
	icon_state = "g16f_nwstorage_units"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/outdoors/northwest/wstorageunits/alley
	name = "Gleichseitig-16 - Northwest - Union Small Storage Alley"
	icon_state = "g16f_nwu_small_storagea"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/indoors/northwest/wstorageunits/one
	name = "Gleichseitig-16 - Northwest - Union Small Storage 1"
	icon_state = "g16f_nwu_small_storage1"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/wstorageunits/two
	name = "Gleichseitig-16 - Northwest - Union Small Storage 2"
	icon_state = "g16f_nwu_small_storage2"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/wstorageunits/three
	name = "Gleichseitig-16 - Northwest - Union Small Storage 3"
	icon_state = "g16f_nwu_small_storage3"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/wstorageunits/four
	name = "Gleichseitig-16 - Northwest - Union Small Storage 4"
	icon_state = "g16f_nwu_small_storage4"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/wstorageunits/five
	name = "Gleichseitig-16 - Northwest - Union Small Storage 5"
	icon_state = "g16f_nwu_small_storage5"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/wstorageunits/six
	name = "Gleichseitig-16 - Northwest - Union Small Storage 6"
	icon_state = "g16f_nwu_small_storage6"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/union/consulting
	name = "Gleichseitig-16 - Northwest - Union Consultants"
	icon_state = "g16f_union_nwconsultant"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/union/consulting/lobby
	name = "Gleichseitig-16 - Northwest - Union Consultants Lobby"
	icon_state = "g16f_union_nwconsultant_lobby"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/union/consulting/office1
	name = "Gleichseitig-16 - Northwest - Union Office 1"
	icon_state = "g16f_union_nwoffice1"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/union/consulting/office2
	name = "Gleichseitig-16 - Northwest - Union Office 2"
	icon_state = "g16f_union_nwoffice2"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/union/consulting/office3
	name = "Gleichseitig-16 - Northwest - Union Office 3"
	icon_state = "g16f_union_nwoffice3"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/union/consulting/office4
	name = "Gleichseitig-16 - Northwest - Union Office 4"
	icon_state = "g16f_union_nwoffice4"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/union/press
	name = "Gleichseitig-16 - Northwest - Union Press Building"
	icon_state = "g16f_union_nwpress"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/indoors/northwest/union/railways
	name = "Gleichseitig-16 - Northwest - Union Rail Station"
	icon_state = "g16f_union_nwrailways"
	minimap_color = MINIMAP_AREA_REQ
	ceiling = CEILING_DEEP_UNDERGROUND

/area/gleichseitig16/indoors/northwest/union/foremancorner
	name = "Gleichseitig-16 - Northwest - Foreman Rig Warehouse"
	icon_state = "g16f_union_foreman_rigs"
	minimap_color = MINIMAP_AREA_REQ
	ceiling = CEILING_DEEP_UNDERGROUND

/area/gleichseitig16/indoors/northwest/phoronex
	name = "Gleichseitig-16 - Northwest - PhoronEX Trailer"
	icon_state = "g16f_phoronex_nwtrailer"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/outdoors/northwest/phoronex/yard
	name = "Gleichseitig-16 - Northwest - PhoronEX Yard"
	icon_state = "g16f_phoronex_nwyard"

/area/gleichseitig16/indoors/northwest/radiostation
	name = "Gleichseitig-16 - Northwest - TCOMMS Center"
	icon_state = "g16f_tcomm_nwcenter"
	minimap_color = MINIMAP_AREA_ENGI

/area/gleichseitig16/indoors/northwest/union/nwstorage
	name = "Gleichseitig-16 - Northwest - Union Storage Units"
	icon_state = "g16f_nwunion_storage_units"
	minimap_color = MINIMAP_AREA_REQ

/area/gleichseitig16/outdoors/northwest/union/nwalleys
	name = "Gleichseitig-16 - Northwest - Union Storage Alleys"
	icon_state = "g16f_nwunion_storage_alleys"

//Southeast

/area/gleichseitig16/outdoors/southeast
	name = "Gleichseitig-16 - Southeast"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/indoors/southeast
	name = "Gleichseitig-16 - Southeast"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/indoors/southeast/scrubemporium
	name = "Gleichseitig-16 - Southeast - Scrub Emporium"
	icon_state = "g16f_sescrub_emporium"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southeast/kicksklub
	name = "Gleichseitig-16 - Southeast - Kicks Klub"
	icon_state = "g16f_sekicks_klub"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southeast/felixfoods
	name = "Gleichseitig-16 - Southeast - Felix Foods"
	icon_state = "g16f_sefelix_foods"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southeast/hardwarehenry
	name = "Gleichseitig-16 - Southeast - Hardware Henry"
	icon_state = "g16f_sehardware_henrys"

/area/gleichseitig16/indoors/southeast/gunthersconvenience
	name = "Gleichseitig-16 - Southeast - Gunther's Convenience"
	icon_state = "g16f_segunthers_convenience"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southeast/powerstation
	name = "Gleichseitig-16 - Southeast - Power Station"
	icon_state = "g16f_power_sestation"
	minimap_color = MINIMAP_AREA_ENGI

/area/gleichseitig16/outdoors/southeast/openspace
	name = "Gleichseitig-16 - Southeast - Open Nature"
	icon_state = "g16f_seopenspace"

/area/gleichseitig16/outdoors/southeast/basketball
	name = "Gleichseitig-16 - Southeast - Basketball Court"
	icon_state = "g16f_sebasketball"

/area/gleichseitig16/indoors/southeast/dealership
	name = "Gleichseitig-16 - Southeast - Automobile Dealership"
	icon_state = "g16f_sedealership"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southeast/phoronex
	name = "Gleichseitig-16 - Southeast - PhoronEX Trailer"
	icon_state = "g16f_phoronex_setrailer"

/area/gleichseitig16/outdoors/southeast/phoronex/yard
	name = "Gleichseitig-16 - Southeast - PhoronEX Yards"
	icon_state = "g16f_phoronex_seyards"

/area/gleichseitig16/indoors/southeast/supermarket
	name = "Gleichseitig-16 - Southeast - Gust Supermarket"
	icon_state = "g16f_supermarket_se"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southeast/ganongym
	name = "Gleichseitig-16 - Southeast - Ganon's Gym"
	icon_state = "g16f_ganonsgym_se"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southeast/ganongymparking
	name = "Gleichseitig-16 - Southeast - Ganon's Gym Parking"
	icon_state = "g16f_ganonsgym_separking"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southeast/charliescredit
	name = "Gleichseitig-16 - Southeast - Charlie's Credit"
	icon_state = "g16f_secharlies_credit"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/outdoors/southeast/meierbank
	name = "Gleichseitig-16 - Southeast - Meier Bank Front"
	icon_state = "g16f_semeier_bank"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/indoors/southeast/meierbank
	name = "Gleichseitig-16 - Southeast - Meier Bank"
	icon_state = "g16f_semeier_bank"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southeast/realestateoffice
	name = "Gleichseitig-16 - Southeast - Real Estate Office"
	icon_state = "g16_realestate_seoffices"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/outdoors/southeast/kh
	name = "Gleichseitig-16 - Southeast - K&H Compound"
	icon_state = "g16f_kh_compound_se"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE

/area/gleichseitig16/indoors/southeast/kh
	name = "Gleichseitig-16 - Southeast - K&H"
	icon_state = "g16f_kh_se"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE
	ceiling = CEILING_DEEP_UNDERGROUND

/area/gleichseitig16/indoors/southeast/kh/lobby
	name = "Gleichseitig-16 - Southeast - K&H Lobby"
	icon_state = "g16f_kh_lobby_se"

/area/gleichseitig16/indoors/southeast/kh/offices
	name = "Gleichseitig-16 - Southeast - K&H Offices"
	icon_state = "g16f_kh_offices_se"

/area/gleichseitig16/indoors/southeast/kh/workshop1
	name = "Gleichseitig-16 - Southeast - K&H Workshop 1"
	icon_state = "g16f_kh_workshop1_se"

/area/gleichseitig16/indoors/southeast/kh/workshop2
	name = "Gleichseitig-16 - Southeast - K&H Workshop 1"
	icon_state = "g16f_kh_workshop2_se"

/area/gleichseitig16/indoors/southeast/kh/manager
	name = "Gleichseitig-16 - Southeast - K&H Site Management"
	icon_state = "g16f_kh_sitemanager_se"

/area/gleichseitig16/indoors/southeast/kh/station
	name = "Gleichseitig-16 - Southeast - K&H Tram Station"
	icon_state = "g16f_kh_station_se"

/area/gleichseitig16/indoors/southeast/kh/gens
	name = "Gleichseitig-16 - Southeast - K&H Generators"
	icon_state = "g16f_kh_maints_se"
	minimap_color = MINIMAP_AREA_ENGI

//Southwest

/area/gleichseitig16/outdoors/southwest
	name = "Gleichseitig-16 - Southwest"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/indoors/southwest
	name = "Gleichseitig-16 - Southwest"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/outdoors/southwest/plazaparking
	name = "Gleichseitig-16 - Southwest - Plaza Mall Parking"
	icon_state = "v8se_lz1site"

/area/gleichseitig16/indoors/southwest/plazamall
	name = "Gleichseitig-16 - Southwest - Plaza Mall"
	icon_state = "g16f_swplazamall"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southwest/plazamall/barber
	name = "Gleichseitig-16 - Southwest - Plaza Mall Barber Shop"
	icon_state = "g16f_plazamall_swbarber"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southwest/plazamall/steakgrill
	name = "Gleichseitig-16 - Southwest - Plaza Mall Steak & Grill"
	icon_state = "g16f_swplazamall_swsteakgrill"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southwest/plazamall/phones
	name = "Gleichseitig-16 - Southwest - Plaza Mall Smartphone Shop"
	icon_state = "g16f_plazamall_swphones"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southwest/plazamall/security
	name = "Gleichseitig-16 - Southwest - Plaza Mall Secpost"
	icon_state = "g16f_plazamall_swsecpost"
	minimap_color = MINIMAP_AREA_SEC

/area/gleichseitig16/outdoors/southwest/stadium/field
	name = "Gleichseitig-16 - Southwest - Leopold Stadium Field"
	icon_state = "g16f_swstadium_field"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/outdoors/southwest/stadium/parking
	name = "Gleichseitig-16 - Southwest - Leopold Stadium Parking Lots"
	icon_state = "g16f_swstadium_parking"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/indoors/southwest/stadium
	name = "Gleichseitig-16 - Southwest - Leopold Stadium"
	icon_state = "g16f_swstadium"
	minimap_color = MINIMAP_AREA_LIVING
	ceiling = CEILING_DEEP_UNDERGROUND

/area/gleichseitig16/indoors/southwest/stadium/gens
	name = "Gleichseitig-16 - Southwest - Leopold Stadium Generators"
	icon_state = "g16f_stadium_swgens"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/outdoors/southwest/ehruni/grounds
	name = "Gleichseitig-16 - Southwest - EHR-UNI Grounds"
	icon_state = "g16f_university_swgrounds"

/area/gleichseitig16/outdoors/southwest/ehruni/sparking
	name = "Gleichseitig-16 - Southwest - EHR-UNI South Parking"
	icon_state = "g16f_university_swparking_s"

/area/gleichseitig16/outdoors/southwest/ehruni/fparking
	name = "Gleichseitig-16 - Southwest - EHR-UNI Front Parking"
	icon_state = "g16f_university_swparking_f"

/area/gleichseitig16/indoors/southwest/ehruni/lobby
	name = "Gleichseitig-16 - Southwest - EHR-UNI Lobby"
	icon_state = "g16f_university_swlobby"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southwest/ehruni/sec
	name = "Gleichseitig-16 - Southwest - EHR-UNI Campus-SEC"
	icon_state = "g16f_university_swsec"
	minimap_color = MINIMAP_AREA_SEC

/area/gleichseitig16/indoors/southwest/ehruni/comms
	name = "Gleichseitig-16 - Southwest - EHR-UNI Communications"
	icon_state = "g16f_university_swcomms"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southwest/ehruni/medchem
	name = "Gleichseitig-16 - Southwest - EHR-UNI MED-CHEM"
	icon_state = "g16f_university_swmedchem"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southwest/ehruni/lab
	name = "Gleichseitig-16 - Southwest - EHR-UNI Lab"
	icon_state = "g16f_university_swchemlab"
	minimap_color = MINIMAP_AREA_MEDBAY

/area/gleichseitig16/indoors/southwest/ehruni/scitech
	name = "Gleichseitig-16 - Southwest - EHR-UNI SCI-TECH"
	icon_state = "g16f_university_swscitech"
	minimap_color = MINIMAP_AREA_RESEARCH_CAVE
	ceiling = CEILING_DEEP_UNDERGROUND

/area/gleichseitig16/indoors/southwest/ehruni/admin
	name = "Gleichseitig-16 - Southwest - EHR-UNI Administration"
	icon_state = "g16f_university_swadmin"
	minimap_color = MINIMAP_AREA_COMMAND
	ceiling = CEILING_DEEP_UNDERGROUND

/area/gleichseitig16/indoors/southwest/ehruni/restrooms
	name = "Gleichseitig-16 - Southwest - EHR-UNI Restrooms"
	icon_state = "g16f_university_restrooms"
	minimap_color = MINIMAP_AREA_LIVING

/area/gleichseitig16/indoors/southwest/milacademy/alleyparking
	name = "Gleichseitig-16 - Southwest - EHR-MIL Academy"
	icon_state = "g16f_ehrmil_swacademy_pa"
	minimap_color = MINIMAP_AREA_COLONY
	ceiling = CEILING_DEEP_UNDERGROUND

/area/gleichseitig16/indoors/southwest/milacademy
	name = "Gleichseitig-16 - Southwest - EHR-MIL Academy"
	icon_state = "g16f_ehrmil_swacademy"
	minimap_color = MINIMAP_AREA_SEC
	ceiling = CEILING_DEEP_UNDERGROUND

//General Streets, Alleys and Parking Lots

/area/gleichseitig16/outdoors/north/streets
	name = "Gleichseitig-16 - North - Streets"
	icon_state = "g16f_nstreets"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/north/alleys
	name = "Gleichseitig-16 - North - Alleys"
	icon_state = "g16f_nalleys"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/north/parking
	name = "Gleichseitig-16 - North - Parking Lot"
	icon_state = "g16f_nparking"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/east/streets
	name = "Gleichseitig-16 - East - Streets"
	icon_state = "g16f_estreets"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/east/alleys
	name = "Gleichseitig-16 - East - Alleys"
	icon_state = "g16f_ealleys"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/east/parking
	name = "Gleichseitig-16 - East - Parking Lot"
	icon_state = "g16f_eparking"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/west/streets
	name = "Gleichseitig-16 - West - Streets"
	icon_state = "g16f_wstreets"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/west/alleys
	name = "Gleichseitig-16 - West - Alleys"
	icon_state = "g16f_walleys"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/west/parking
	name = "Gleichseitig-16 - West - Parking Lot"
	icon_state = "g16f_wparking"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/south/streets
	name = "Gleichseitig-16 - South - Streets"
	icon_state = "g16f_sstreets"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/south/alleys
	name = "Gleichseitig-16 - South - Alleys"
	icon_state = "g16f_salleys"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/south/parking
	name = "Gleichseitig-16 - South - Parking Lot"
	icon_state = "g16f_sparking"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/northwest/streets
	name = "Gleichseitig-16 - Northwest - Streets"
	icon_state = "g16f_nwstreets"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/northwest/alleys
	name = "Gleichseitig-16 - Northwest - Alleys"
	icon_state = "g16f_nwalleys"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/northwest/parking
	name = "Gleichseitig-16 - Northwest - Parking Lot"
	icon_state = "g16f_nwparking"
	requires_power = FALSE
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/northeast/streets
	name = "Gleichseitig-16 - Northeast Streets"
	icon_state = "g16f_nestreets"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/northeast/alleys
	name = "Gleichseitig-16 - Northeast - Alleys"
	icon_state = "g16f_nealleys"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/northeast/parking
	name = "Gleichseitig-16 - Northeast - Parking Lot"
	icon_state = "g16f_neparking"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/southwest/streets
	name = "Gleichseitig-16 - Southwest - Streets"
	icon_state = "g16f_swstreets"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/southwest/alleys
	name = "Gleichseitig-16 - Southwest - Alleys"
	icon_state = "g16f_swalleys"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/southwest/parking
	name = "Gleichseitig-16 - Southwest - Parking Lot"
	icon_state = "g16f_swparking"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/southeast/streets
	name = "Gleichseitig-16 - Southeast - Streets"
	icon_state = "g16f_sestreets"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/southeast/alleys
	name = "Gleichseitig-16 - Southeast - Alleys"
	icon_state = "g16f_sealleys"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/outdoors/southeast/parking
	name = "Gleichseitig-16 - Southeast - Parking Lot"
	icon_state = "g16f_separking"
	minimap_color = MINIMAP_AREA_COLONY

/area/gleichseitig16/indoors/caves/rock //catchall for closed turfs we want immune to rain/easily visible to map editing tools
	name = "Enclosed Area"
	icon_state = "enclosed"
	minimap_color = null
	area_flags = CANNOT_NUKE
