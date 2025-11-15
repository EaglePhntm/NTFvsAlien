//Big Red V3 - NTF AREAS

///
//Outside Regions
///

// Note: All "Do Not Use" beginning assests are placeholders and used to simplfy the /area, use all assests below the beginning for mapping.

/area/bigredv3/outside
	name = "Unknown Colony Outside Grounds"
	icon = 'icons/turf/areas.dmi'
	icon_state = "red"
	outside = TRUE
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_NTF_OUTSIDE

/area/bigredv3/inside
	name = "Unknown Colony Inside Grounds"
	icon = 'icons/turf/areas.dmi'
	icon_state = "red"
	outside = FALSE
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_NTF_INSIDE

/area/bigredv3/inside/wall
	name = "Enclosed Wall"
	icon_state = "transparent"


///
// Outside Directions
///

/// Central, North, South, West, East.

/area/bigredv3/outside/directions
	name = "Do Not Use"
	icon = 'icons/turf/areas.dmi'
	icon_state = "red"
	outside = TRUE
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_NTF_DIRECT

/area/bigredv3/outside/directions/central
	name = "Central Colony Grounds"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "central"

/area/bigredv3/outside/directions/n
	name = "Northern Colony Grounds"
	icon_state = "north2"

/area/bigredv3/outside/directions/s
	name = "Southern Colony Grounds"
	icon_state = "south2"

/area/bigredv3/outside/directions/w
	name = "Western Colony Grounds"
	icon_state = "west3"

/area/bigredv3/outside/directions/e
	name = "Eastern Colony Grounds"
	icon_state = "east2"

/// NE, SE, NW, SW.

/area/bigredv3/outside/directions/ne
	name = "Northeast Colony Grounds"
	icon_state = "northeast2"

/area/bigredv3/outside/directions/nw
	name = "Northwest Colony Grounds"
	icon_state = "northwest2"

/area/bigredv3/outside/directions/se
	name = "Southeast Colony Grounds"
	icon_state = "southeast2"

/area/bigredv3/outside/directions/sw
	name = "Southwest Colony Grounds"
	icon_state = "southwest2"



///
//Cave Regions
///

/area/bigredv3/caves
	name = "Unknown Area"
	icon = 'icons/turf/areas.dmi'
	icon_state = "bluenew"
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE
	ambience = list('sound/ambience/ambicave.ogg', 'sound/ambience/ambilava1.ogg', 'sound/ambience/ambilava2.ogg', 'sound/ambience/ambilava3.ogg')
	minimap_color = MINIMAP_AREA_CAVES
	always_unpowered = TRUE

/area/bigredv3/caves/rock
	name = "Enclosed Area"
	icon_state = "transparent"
	area_flags = CANNOT_NUKE

// Caves N, S, W, E.

/area/bigredv3/caves/north
	name = "Northern Caves"
	icon_state = "north"
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/south
	name = "Southern Caves"
	icon_state = "south"
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/east
	name = "Eastern Caves"
	icon_state = "east"
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/west
	name = "Western Caves"
	icon_state = "west"
	ceiling = CEILING_UNDERGROUND

/// Caves NW, SW, NE, SE.

/area/bigredv3/caves/northwest
	name = "Northwestern Caves"
	icon_state = "northwest"
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/northeast
	name = "Northeastern Caves"
	icon_state = "northeast"
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/southwest
	name = "Southwestern Caves"
	icon_state = "southwest"
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/southeast
	name = "Southeastern Caves"
	icon_state = "southeast"
	ceiling = CEILING_UNDERGROUND

///Caves Garbled Radio

/area/bigredv3/caves/north/garbledradio
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/south/garbledradio
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/west/garbledradio
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/east/garbledradio
	ceiling = CEILING_UNDERGROUND

///Caves Garbled Radio NW, SW, NE, SE.

/area/bigredv3/caves/northwest/garbledradio
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/southwest/garbledradio
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/northeast/garbledradio
	ceiling = CEILING_UNDERGROUND

/area/bigredv3/caves/southeast/garbledradio
	ceiling = CEILING_UNDERGROUND



///
// Big Red Departments & Sub Departments
///


///
// Cargo Dept.
///

/area/bigredv3/inside/cargo
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_NTF_CARGO

/area/bigredv3/outside/cargo
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use"
	outside = TRUE
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_NTF_CARGO

/area/bigredv3/inside/cargo/cargobay
	name = "Cargo Bay"
	icon_state = "do_not_use"

/area/bigredv3/inside/cargo/store
	name = "General Store"
	icon_state = "do_not_use"

/area/bigredv3/inside/cargo/cdo
	name = "Cargo Director Office"
	icon_state = "do_not_use"

///
// Colony Dept.
///

/area/bigredv3/inside/colony
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use1"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_NTF_COLONY

/area/bigredv3/inside/colony/bar
	name = "Bar"
	icon_state = "Colony_Bar"

/area/bigredv3/inside/colony/bar/recreations
	name = "Bar Recreations"
	icon_state = "Colony_Bar"

/area/bigredv3/inside/colony/kitchen
	name = "Kitchen"
	icon_state = "Colony_Kitchen"

/area/bigredv3/inside/colony/kitchen/cafe
	name = "Cafeteria"
	icon_state = "Colony_Cafeteria"

/area/bigredv3/inside/colony/hydroponics
	name = "Hydroponics"
	icon_state = "Colony_Hyrdo"

/area/bigredv3/inside/colony/library
	name = "Library"
	icon_state = "Colony_Library"

// Chapel

/area/bigredv3/inside/colony/chapel
	name = "Chapel"
	icon_state = "Colony_Chapel"

/area/bigredv3/inside/colony/chapel/office
	name = "Chapel Office"
	icon_state = "Colony_ChapelOffice"

// Dormitory

/area/bigredv3/inside/colony/dorm
	name = "Dormitories"
	icon_state = "Colony_Dorm"

/area/bigredv3/inside/colony/dorm/recreation
	name = "Recreations"
	icon_state = "Colony_Recreation"

/area/bigredv3/inside/colony/dorm/laundry
	name = "Laundry Room"
	icon_state = "Colony_Laundry"

/area/bigredv3/inside/colony/dorm/eva
	name = "EVA Storage"
	icon_state = "Colony_EVA"

/area/bigredv3/inside/colony/dorm/restroom
	name = "Unisex Restroom"
	icon_state = "Colony_Restroom"

/area/bigredv3/inside/colony/dorm/e_power
	name = "Emergency Power"
	icon_state = "Colony_Epower"



///
// Command Dept.
///

/area/bigredv3/inside/command
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use2"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_COMMAND

/area/bigredv3/inside/command/highcomm
	name = "Administration Building"
	icon_state = "Command_Highcom"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_COMMAND

/area/bigredv3/inside/command/bridge
	name = "Administration Bridge"
	icon_state = "Command_Bridge"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_COMMAND

/area/bigredv3/inside/command/cdo
	name = "Colony Directors Office"
	icon_state = "Command_Bridge"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_COMMAND

/area/bigredv3/inside/command/confrence
	name = "Confrence Room"
	icon_state = "Command_Bridge"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_COMMAND



///
// Engineering Dept.
///

/area/bigredv3/inside/engi
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use3"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_NTF_ENGI

/area/bigredv3/outside/engi
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use3"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_NTF_ENGI

/area/bigredv3/inside/engi/west
	name = "West Engineering Complex"
	icon_state = "do_not_use3"

/area/bigredv3/inside/engi/west/entry
	name = "West Engineering Entry"
	icon_state = "do_not_use3"

/area/bigredv3/inside/engi/east
	name = "East Engineering Complex"
	icon_state = "do_not_use3"

/area/bigredv3/inside/engi/locker_room
	name = "Engineering Locker Room"
	icon_state = "do_not_use3"

/area/bigredv3/inside/engi/power_plant
	name = "Power Plant"
	icon_state = "do_not_use3"

/area/bigredv3/inside/engi/ceo
	name = "Chief Engineering Office"
	icon_state = "do_not_use3"

/area/bigredv3/inside/engi/fabrication
	name = "Engineering Fabrication"
	icon_state = "do_not_use3"

/area/bigredv3/inside/engi/egen
	name = "Emergency Generators"
	icon_state = "do_not_use3"

/area/bigredv3/inside/engi/tcomms
	name = "Telecommunications"
	icon_state = "do_not_use3"

// Atmos

/area/bigredv3/inside/engi/atmos
	name = "Atmospheric Stabilizer"
	icon_state = "do_not_use3"

/area/bigredv3/inside/engi/atmos/lobby
	name = "Atmospheric Lobby"
	icon_state = "do_not_use3"

/area/bigredv3/inside/engi/atmos/filtration_plant
	name = "Filtration Plant"
	icon_state = "do_not_use3"

///
// Lambda Laboratory Dept.
///

/area/bigredv3/inside/lambda
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use4"
	ceiling = CEILING_DEEP_UNDERGROUND_METAL
	outside = FALSE
	minimap_color = MINIMAP_AREA_NTF_LAMBDA

/area/bigredv3/caves/lambda
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use4"
	ceiling = CEILING_DEEP_UNDERGROUND
	outside = FALSE
	minimap_color = MINIMAP_AREA_NTF_LAMBDA

/area/bigredv3/inside/lambda/office
	name = "Lambda Office"
	icon_state = "Lambda_Office"

/area/bigredv3/inside/lambda/fabrication
	name = "Fabrication Bay"
	icon_state = "Lambda_Office"

/area/bigredv3/inside/lambda/processing
	name = "Mining Processing Intake"
	icon_state = "Lambda_Office"

/area/bigredv3/inside/lambda/virology
	name = "Virologist Laboratory"
	icon_state = "Lambda_Office"

/area/bigredv3/inside/lambda/chemistry
	name = "Chemistry Laboratory"
	icon_state = "Lambda_Office"

/area/bigredv3/inside/lambda/ldo
	name = "Lambda Directors Office"
	icon_state = "Lambda_Office"

/area/bigredv3/inside/lambda/surgery
	name = "Surgical Bay"
	icon_state = "Lambda_Office"

/area/bigredv3/inside/lambda/surgery/theatre
	name = "Surgical Theatre"
	icon_state = "Lambda_Office"

/area/bigredv3/inside/lambda/hydroponics
	name = "Hydroponics Bay"
	icon_state = "Lambda_Office"

/area/bigredv3/inside/lambda/containment
	name = "Containment Room"
	icon_state = "Lambda_Office"

/area/bigredv3/inside/lambda/teleporter
	name = "Teleporter Room"
	icon_state = "Lambda_Office"

/area/bigredv3/inside/lambda/detainment
	name = "Detainment Facility"
	icon_state = "Lambda_Office"

/area/bigredv3/caves/lambda/external
	name = "Lambda Entry Zone"
	icon_state = "Lambda_Office"

///
// Medical Dept.
///

/area/bigredv3/inside/medical
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use5"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_NTF_MEDICAL

/area/bigredv3/outside/medical
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use5"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_NTF_MEDICAL

/area/bigredv3/inside/medical/central
	name = "Medical Central"
	icon_state = "Medical_Central"

/area/bigredv3/inside/medical/virology
	name = "Virology Laboratory"
	icon_state = "Medical_Virology"

/area/bigredv3/outside/medical/virology
	name = "Virology External"
	icon_state = "Medical_Virology"

/area/bigredv3/inside/medical/cmo
	name = "Chief Medical Office"
	icon_state = "Medical_CMO"

/area/bigredv3/inside/medical/geneticist
	name = "Genetics Laboratory"
	icon_state = "Medical_Geneticist"

/area/bigredv3/inside/medical/examination
	name = "Examination Room"
	icon_state = "Medical_Examine"

/area/bigredv3/inside/medical/morgue
	name = "Morgue Room"
	icon_state = "Medical_Morgue"

/area/bigredv3/inside/medical/cryostasis
	name = "Cryostasis Room"
	icon_state = "Medical_Cryo"

/area/bigredv3/inside/medical/chemistry
	name = "Chemistry Lab"
	icon_state = "Medical_Chems"

/area/bigredv3/inside/medical/surgery
	name = "Surgical Room"
	icon_state = "Medical_Chems"

/area/bigredv3/inside/medical/storage
	name = "Medical Storage"
	icon_state = "Medical_Chems"


///
// Research Dept.
///

/area/bigredv3/inside/science
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use6"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_NTF_RESEARCH

/area/bigredv3/outside/science
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use6"
	outside = TRUE
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_NTF_RESEARCH

/area/bigredv3/outside/science/external
	name = "Science Courtyard"
	icon_state = "Science_Outside"

/area/bigredv3/inside/science/research_office
	name = "Research Office"
	icon_state = "Science_Office"

/area/bigredv3/inside/science/rd_office
	name = "Research Director Office"
	icon_state = "Science_RDOffice"

/area/bigredv3/inside/science/server_room
	name = "Research Server Room"
	icon_state = "Science_Server"

/area/bigredv3/inside/science/observation
	name = "Observation Room"
	icon_state = "Science_Observ"

/area/bigredv3/inside/science/xenolab
	name = "Xeno Laboratory"
	icon_state = "Science_Xenolab"

/area/bigredv3/inside/science/fabrication
	name = "Fabrication Room"
	icon_state = "Science_Fab"

/area/bigredv3/inside/science/storage
	name = "General Storage Room"
	icon_state = "Science_Storage"

// Robotics

/area/bigredv3/inside/science/robotics
	name = "Robotics Department"
	icon_state = "Science_Robotics"

/area/bigredv3/inside/science/robotics/mechbay
	name = "Robotics Mechatronics Bay"
	icon_state = "Science_Mech"



///
// Marshal/Security Dept.
///

/area/bigredv3/inside/security
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use7"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_NTF_SECURITY

/area/bigredv3/inside/security/colmo
	name = "Colonial Marshals Office"
	icon_state = "Colonial_Marshal"

/area/bigredv3/inside/security/colsupdep
	name = "Supervisory Deputy Office"
	icon_state = "Super_Deputy"

/area/bigredv3/inside/security/colcourt
	name = "Colonial Court"
	icon_state = "Colonial_Court"

/area/bigredv3/inside/security/colprison
	name = "Colonial Prison"
	icon_state = "Colonial_Prison"

/area/bigredv3/inside/security/colbrig
	name = "Colonial Brig"
	icon_state = "Colonial_Brig"

/area/bigredv3/inside/security/coloffice
	name = "Colonial Office"
	icon_state = "Colonial_Office"

/area/bigredv3/inside/security/colexecution
	name = "Execution Room"
	icon_state = "Colonial_Office"

// Armory

/area/bigredv3/inside/security/colarmory
	name = "Colonial Armory"
	icon_state = "Colonial_Armory"

/area/bigredv3/inside/security/colarmory/ntscience
	name = "Colonial Armory"
	icon_state = "Colonial_Armory"

/area/bigredv3/inside/security/colarmory/operations
	name = "Colonial Command Operations Armory"
	icon_state = "Colonial_Armory"

// Checkpoints

/area/bigredv3/inside/security/checkpoint_ntscience
	name = "Colonial Science Checkpoint"
	icon_state = "Colonial_Sec_Point1"

/area/bigredv3/inside/security/checkpoint_entrypoint
	name = "Colonial Cave Entry Checkpoint"
	icon_state = "Colonial_Sec_Point2"


///
// Secondary Locations
///

/area/bigredv3/inside/secondary
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use1"
	ceiling = CEILING_METAL

/area/bigredv3/outside/secondary
	name = "Do Not Use"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use1"
	outside = TRUE
	ceiling = CEILING_NONE

// Maintence

/area/bigredv3/inside/secondary/maintence
	name = "Maintence"
	icon_state = "Maintence"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_NTF_MAINT

/area/bigredv3/inside/secondary/maintence/lambda
	name = "Lambda Maintence"
	icon_state = "Maintence"

/area/bigredv3/inside/secondary/maintence/cargo
	name = "Cargo Maintence"
	icon_state = "Maintence"

// Office Complex

/area/bigredv3/inside/secondary/office_complex
	name = "Office Complex"
	icon_state = "do_not_use3"

// Space Port

/area/bigredv3/inside/secondary/space_port
	name = "Primary Space Port"
	icon = 'icons/turf/areas.dmi'
	icon_state = "landingzone1"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_LZ

/area/bigredv3/inside/secondary/space_port/atc
	name = "Air Traffic Control"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use6"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_LZ

/area/bigredv3/outside/secondary/space_port_two
	name = "Secondary Space Port"
	icon = 'icons/turf/areas.dmi'
	icon_state = "landingzone2"
	ceiling = CEILING_NONE
	minimap_color = MINIMAP_AREA_LZ

/area/bigredv3/outside/secondary/space_port_two/atc
	name = "Air Traffic Control"
	icon = 'ntf_modular/icons/turf/areas.dmi'
	icon_state = "do_not_use6"
	ceiling = CEILING_METAL
	minimap_color = MINIMAP_AREA_LZ

// Protected Greenry
/area/bigredv3/inside/secondary/greenry
	name = "Protected Green Zone"
	icon = 'icons/turf/areas.dmi'
	icon_state = "transparent"

// Auxillary Storage
/area/bigredv3/inside/secondary/auxstore
	name = "Auxillary Storage"
	icon_state = "Aux_Storage"
