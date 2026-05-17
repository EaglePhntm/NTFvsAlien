/datum/sprite_accessory/snout
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/lizard_snouts.dmi'
	var/color_count = 1
	var/color_src = ACCESSORY_COLOR_NONE
	var/icon_prefix = "m_snout"
	var/uses_color_suffixes = FALSE
	var/list/render_layers = list("ADJ")
	var/restore_body_eyes = FALSE

/datum/sprite_accessory/snout/none
	name = "None"
	icon_state = null
	render_layers = list()

/datum/sprite_accessory/snout/sharp
	name = "Sharp"
	icon_state = "sharp"

/datum/sprite_accessory/snout/round
	name = "Round"
	icon_state = "round"

/datum/sprite_accessory/snout/sharplight
	name = "Sharp + Light"
	icon_state = "sharplight"

/datum/sprite_accessory/snout/roundlight
	name = "Round + Light"
	icon_state = "roundlight"

/datum/sprite_accessory/snout/skyrat
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/snouts.dmi'
	color_count = 3
	uses_color_suffixes = TRUE

/datum/sprite_accessory/snout/synthliz
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/synthliz_snouts.dmi'
	color_count = 3
	uses_color_suffixes = TRUE

/datum/sprite_accessory/snout/synthliz/basic
	name = "Synthliz Basic"
	icon_state = "synthliz_basic"
	color_count = 1
	restore_body_eyes = TRUE

/datum/sprite_accessory/snout/synthliz/under
	name = "Synthliz Underlight"
	icon_state = "synthliz_under"
	color_count = 2

/datum/sprite_accessory/snout/synthliz/over
	name = "Synthliz Overlight"
	icon_state = "synthliz_over"
	color_count = 2

/datum/sprite_accessory/snout/synthliz/tertiary
	name = "Synthliz Tertiary"
	icon_state = "synthliz_tert"
	color_count = 2

/datum/sprite_accessory/snout/synthliz/tertiary_under
	name = "Synthliz Tertiary Underlight"
	icon_state = "synthliz_tertunder"

/datum/sprite_accessory/snout/synthliz/long
	name = "Synthliz Long"
	icon_state = "synthliz_long"
	color_count = 1
	restore_body_eyes = TRUE

/datum/sprite_accessory/snout/synthliz/thick
	name = "Synthliz Thick"
	icon_state = "synthliz_thick"
	color_count = 1
	restore_body_eyes = TRUE

/datum/sprite_accessory/snout/synthliz/thick_long
	name = "Synthliz Thick Long"
	icon_state = "synthliz_thicklong"
	color_count = 1
	restore_body_eyes = TRUE

/datum/sprite_accessory/snout/synthliz/barless_basic
	name = "Synthliz Barless Basic"
	icon_state = "synthliz_barless_basic"
	color_count = 1
	restore_body_eyes = TRUE

/datum/sprite_accessory/snout/synthliz/barless_under
	name = "Synthliz Barless Underlight"
	icon_state = "synthliz_barless_under"

/datum/sprite_accessory/snout/synthliz/barless_over
	name = "Synthliz Barless Overlight"
	icon_state = "synthliz_barless_over"

/datum/sprite_accessory/snout/synthliz/barless_tertiary
	name = "Synthliz Barless Tertiary"
	icon_state = "synthliz_barless_tert"

/datum/sprite_accessory/snout/synthliz/barless_tertiary_under
	name = "Synthliz Barless Tertiary Underlight"
	icon_state = "synthliz_barless_tertunder"

/datum/sprite_accessory/snout/synthliz/protogen
	name = "Protogen"
	icon_state = "protogen"

/datum/sprite_accessory/snout/synthliz/protogen_bolt
	name = "Protogen With Bolt"
	icon_state = "protogen_withbolt"

/datum/sprite_accessory/snout/skyrat/bird
	name = "Beak"
	icon_state = "bird"

/datum/sprite_accessory/snout/skyrat/birdsmall
	name = "Beak (Small)"
	icon_state = "birdsmall"

/datum/sprite_accessory/snout/skyrat/bigbeak
	name = "Big Beak"
	icon_state = "bigbeak"

/datum/sprite_accessory/snout/skyrat/bigbeakshort
	name = "Big Beak Short"
	icon_state = "bigbeakshort"

/datum/sprite_accessory/snout/skyrat/slimbeak
	name = "Slim Beak"
	icon_state = "slimbeak"

/datum/sprite_accessory/snout/skyrat/slimbeakshort
	name = "Slim Beak Short"
	icon_state = "slimbeakshort"

/datum/sprite_accessory/snout/skyrat/slimbeakalt
	name = "Slim Beak Alt"
	icon_state = "slimbeakalt"

/datum/sprite_accessory/snout/skyrat/hookbeak
	name = "Hook Beak"
	icon_state = "hookbeak"

/datum/sprite_accessory/snout/skyrat/hookbeakbig
	name = "Hook Beak Big"
	icon_state = "hookbeakbig"

/datum/sprite_accessory/snout/skyrat/corvidbeak
	name = "Corvid Beak"
	icon_state = "corvidbeak"

/datum/sprite_accessory/snout/skyrat/bug
	name = "Bug"
	icon_state = "bug"
	render_layers = list("ADJ", "FRONT")

/datum/sprite_accessory/snout/skyrat/bug_no_eyes
	name = "Bug (No Eyes)"
	icon_state = "bug_no_eyes"
	color_count = 1
	uses_color_suffixes = FALSE

/datum/sprite_accessory/snout/skyrat/elephant
	name = "Elephant"
	icon_state = "elephant"

/datum/sprite_accessory/snout/skyrat/husky
	name = "Husky"
	icon_state = "husky"

/datum/sprite_accessory/snout/skyrat/rhino
	name = "Horn"
	icon_state = "rhino"

/datum/sprite_accessory/snout/skyrat/rodent
	name = "Rodent"
	icon_state = "rodent"

/datum/sprite_accessory/snout/skyrat/lcanid
	name = "Mammal, Long"
	icon_state = "lcanid"

/datum/sprite_accessory/snout/skyrat/lcanidalt
	name = "Mammal, Long ALT"
	icon_state = "lcanidalt"

/datum/sprite_accessory/snout/skyrat/lcanidstriped
	name = "Mammal, Long, Striped"
	icon_state = "lcanidstripe"

/datum/sprite_accessory/snout/skyrat/lcanidstripedalt
	name = "Mammal, Long, Striped ALT"
	icon_state = "lcanidstripealt"

/datum/sprite_accessory/snout/skyrat/scanid
	name = "Mammal, Short"
	icon_state = "scanid"

/datum/sprite_accessory/snout/skyrat/scanidalt
	name = "Mammal, Short ALT"
	icon_state = "scanidalt"

/datum/sprite_accessory/snout/skyrat/scanidalt2
	name = "Mammal, Short ALT 2"
	icon_state = "scanidalt2"

/datum/sprite_accessory/snout/skyrat/scanidalt3
	name = "Mammal, Short ALT 3"
	icon_state = "scanidalt3"

/datum/sprite_accessory/snout/skyrat/ntajaran
	name = "Tajaran, Normal"
	icon_state = "ntajaran"

/datum/sprite_accessory/snout/skyrat/wolf
	name = "Mammal, Thick"
	icon_state = "wolf"

/datum/sprite_accessory/snout/skyrat/wolfalt
	name = "Mammal, Thick ALT"
	icon_state = "wolfalt"

/datum/sprite_accessory/snout/skyrat/otie
	name = "Otie"
	icon_state = "otie"

/datum/sprite_accessory/snout/skyrat/otiesmile
	name = "Otie Smile"
	icon_state = "otiesmile"

/datum/sprite_accessory/snout/skyrat/otter
	name = "Otter"
	icon_state = "otter"
	render_layers = list("ADJ", "FRONT")

/datum/sprite_accessory/snout/skyrat/pede
	name = "Scolipede"
	icon_state = "pede"

/datum/sprite_accessory/snout/skyrat/sergal
	name = "Sergal"
	icon_state = "sergal"

/datum/sprite_accessory/snout/skyrat/shark
	name = "Shark"
	icon_state = "shark"

/datum/sprite_accessory/snout/skyrat/hshark
	name = "hShark"
	icon_state = "hshark"

/datum/sprite_accessory/snout/skyrat/hshark_eyes
	name = "hShark and Eyes"
	icon_state = "hshark_eyes"

/datum/sprite_accessory/snout/skyrat/toucan
	name = "Toucan"
	icon_state = "toucan"

/datum/sprite_accessory/snout/skyrat/wah
	name = "WahCoon"
	icon_state = "wah"

/datum/sprite_accessory/snout/skyrat/wahalt
	name = "WahCoon ALT"
	icon_state = "wahalt"

/datum/sprite_accessory/snout/skyrat/skulldog
	name = "Skulldog"
	icon_state = "skulldog"

/datum/sprite_accessory/snout/skyrat/hanubus
	name = "Anubus"
	icon_state = "hanubus"

/datum/sprite_accessory/snout/skyrat/hpanda
	name = "Panda"
	icon_state = "hpanda"

/datum/sprite_accessory/snout/skyrat/hjackal
	name = "Jackal"
	icon_state = "hjackal"

/datum/sprite_accessory/snout/skyrat/hspots
	name = "Hyena"
	icon_state = "hspots"

/datum/sprite_accessory/snout/skyrat/hhorse
	name = "Horse"
	icon_state = "hhorse"

/datum/sprite_accessory/snout/skyrat/hzebra
	name = "Zebra"
	icon_state = "hzebra"

/datum/sprite_accessory/snout/skyrat/shark_light
	name = "Shark Light"
	icon_state = "sharkblubber"

/datum/sprite_accessory/snout/skyrat/rat
	name = "Rat"
	icon_state = "rat"

/datum/sprite_accessory/snout/skyrat/stubby
	name = "Stubby"
	icon_state = "stubby"

/datum/sprite_accessory/snout/skyrat/leporid
	name = "Leporid"
	icon_state = "leporid"

/datum/sprite_accessory/snout/skyrat/acrador
	name = "Acrador (Short)"
	icon_state = "acrador_short"

/datum/sprite_accessory/snout/skyrat/acrador_1
	name = "Acrador 1 (Normal)"
	icon_state = "acrador_1"

/datum/sprite_accessory/snout/skyrat/acrador_2
	name = "Acrador 2 (Normal)"
	icon_state = "acrador_2"

/datum/sprite_accessory/snout/skyrat/acrador_3
	name = "Acrador 3 (Normal)"
	icon_state = "acrador_3"

/datum/sprite_accessory/snout/skyrat/acrador_4
	name = "Acrador 4 (Normal)"
	icon_state = "acrador_4"

/datum/sprite_accessory/snout/skyrat/renamon
	name = "Cyvian"
	icon_state = "renamon"

/datum/sprite_accessory/snout/skyrat/exsharp
	name = "Extra Sharp"
	icon_state = "exsharp"

/datum/sprite_accessory/snout/skyrat/masked
	name = "Masked Wing"
	icon_state = "masked"
	color_count = 1
	uses_color_suffixes = FALSE
	render_layers = list("ADJ", "FRONT")

/datum/sprite_accessory/snout/skyrat/top
	render_layers = list("FRONT")

/datum/sprite_accessory/snout/skyrat/top/fbird
	name = "Beak (Top)"
	icon_state = "fbird"

/datum/sprite_accessory/snout/skyrat/top/fbigbeak
	name = "Big Beak (Top)"
	icon_state = "fbigbeak"

/datum/sprite_accessory/snout/skyrat/top/fbug
	name = "Bug (Top)"
	icon_state = "fbug"
	render_layers = list("ADJ", "FRONT")

/datum/sprite_accessory/snout/skyrat/top/felephant
	name = "Elephant (Top)"
	icon_state = "felephant"

/datum/sprite_accessory/snout/skyrat/top/frhino
	name = "Horn (Top)"
	icon_state = "frhino"

/datum/sprite_accessory/snout/skyrat/top/fhusky
	name = "Husky (Top)"
	icon_state = "fhusky"

/datum/sprite_accessory/snout/skyrat/top/flcanid
	name = "Mammal, Long (Top)"
	icon_state = "flcanid"

/datum/sprite_accessory/snout/skyrat/top/flcanidalt
	name = "Mammal, Long ALT (Top)"
	icon_state = "flcanidalt"

/datum/sprite_accessory/snout/skyrat/top/flcanidstriped
	name = "Mammal, Long, Striped (Top)"
	icon_state = "flcanidstripe"

/datum/sprite_accessory/snout/skyrat/top/flcanidstripedalt
	name = "Mammal, Long, Striped ALT (Top)"
	icon_state = "flcanidstripealt"

/datum/sprite_accessory/snout/skyrat/top/fscanid
	name = "Mammal, Short (Top)"
	icon_state = "fscanid"

/datum/sprite_accessory/snout/skyrat/top/fscanidalt
	name = "Mammal, Short ALT (Top)"
	icon_state = "fscanidalt"

/datum/sprite_accessory/snout/skyrat/top/fscanidalt2
	name = "Mammal, Short ALT 2 (Top)"
	icon_state = "fscanidalt2"

/datum/sprite_accessory/snout/skyrat/top/fscanidalt3
	name = "Mammal, Short ALT 3 (Top)"
	icon_state = "fscanidalt3"

/datum/sprite_accessory/snout/skyrat/top/fwolf
	name = "Mammal, Thick (Top)"
	icon_state = "fwolf"

/datum/sprite_accessory/snout/skyrat/top/fwolfalt
	name = "Mammal, Thick ALT (Top)"
	icon_state = "fwolfalt"

/datum/sprite_accessory/snout/skyrat/top/fotie
	name = "Otie (Top)"
	icon_state = "fotie"

/datum/sprite_accessory/snout/skyrat/top/fotiesmile
	name = "Otie Smile (Top)"
	icon_state = "fotiesmile"

/datum/sprite_accessory/snout/skyrat/top/frodent
	name = "Rodent (Top)"
	icon_state = "frodent"

/datum/sprite_accessory/snout/skyrat/top/fpede
	name = "Scolipede (Top)"
	icon_state = "fpede"

/datum/sprite_accessory/snout/skyrat/top/fsergal
	name = "Sergal (Top)"
	icon_state = "fsergal"

/datum/sprite_accessory/snout/skyrat/top/fshark
	name = "Shark (Top)"
	icon_state = "fshark"

/datum/sprite_accessory/snout/skyrat/top/ftoucan
	name = "Toucan (Top)"
	icon_state = "ftoucan"

/datum/sprite_accessory/snout/skyrat/top/fwah
	name = "WahCoon (Top)"
	icon_state = "fwah"

/datum/sprite_accessory/snout/skyrat/top/fcorvidbeak
	name = "Corvid Beak (Top)"
	icon_state = "fcorvidbeak"

/datum/sprite_accessory/snout/vox
	name = "Vox Snout"
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/vox_snouts.dmi'
	icon_state = "vox"
	color_count = 1
	uses_color_suffixes = FALSE
