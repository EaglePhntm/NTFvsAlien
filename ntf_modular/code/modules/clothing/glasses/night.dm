/obj/item/clothing/glasses/night/m42_night_goggles/ntc_r
	name = "\improper NT 'Stalker-R' HD night-vision goggles"
	desc = "An incredibly expensive night vision goggle for high definition imagery in the dark. You can tell them you saw red when you do murder. Click it to toggle."
	icon_state = "night_vision"	//i got too lazy to make a sprite
	deactive_state = "night_vision_off"
	color_cutoffs = list(40, 0, 0) //seemingly red makes things harder to see when mixed somehow

/obj/item/clothing/glasses/night/m42_night_goggles/ntc_g
	name = "\improper NT 'Stalker-G' HD night-vision goggles"
	desc = "An incredibly expensive night vision goggle for high definition imagery in the dark. Green as gr-ass. Click it to toggle."
	icon_state = "night_vision"
	deactive_state = "night_vision_off"
	color_cutoffs = list(10, 40, 10)

/obj/item/clothing/glasses/night/m42_night_goggles/ntc_b
	name = "\improper NT 'Stalker-B' HD night-vision goggles"
	desc = "An incredibly expensive night vision goggle for high definition imagery in the dark. Blue like your balls. Click it to toggle."
	icon_state = "night_vision"
	deactive_state = "night_vision_off"
	color_cutoffs = list(0, 20, 40)

/obj/item/clothing/glasses/night/m56_goggles/vsd
	name = "\improper CM-13 night vision goggles"
	desc = "KZ's newer, clearer version of CM-12 night vision goggles, For the extra tacticool feel, Crash Core and your superior officers are not responsible for blindness and burning."
	icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "vsd_nvg"
	worn_icon_state = "vsd_nvg"
	deactive_state = "vsd_nvg_off"
	color_cutoffs = list(30, 30, 0)
	worn_layer = COLLAR_LAYER

/obj/item/clothing/glasses/night/m56_goggles/vsd/alt
	name = "\improper CM-13 night vision faceplate"
	desc = "KZ's newer, clearer version of CM-12 night vision faceplate, made for attachments to the Medium armor variant of their armor. Crash Core and your superior officers are not responsible for blindness and burning."
	icon_state = "vsd_alt"
	worn_icon_state = "vsd_alt"
	deactive_state = "vsd_alt_off"
