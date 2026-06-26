#define AVAILABLE_SPRAYCAN_SPACE 8
#define COLOR_NORMAL 1
#define COLOR_OVERRIDE 2
#define COLOR_COMBINED 3
#define COLOR_REMOVAL 4

//Spraycan stuff, taken from TG

/obj/item/toy/crayon/exosuit_painter
	name = "exosuit painter"
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "labeler1"
	var/self_contained = FALSE
	var/charges = 50
	var/paint_color = null
	var/paint_mode = COLOR_NORMAL
	desc = "A metallic container containing tasty paint."
	w_class = WEIGHT_CLASS_SMALL
	self_contained = FALSE // Don't disappear when they're empty

// TG does it better, but you can alt click it to set the saturation mode or remove color

/obj/item/toy/crayon/exosuit_painter/proc/select_mode(mob/user)
	var/choice = input(user, "Select the painting mode:", "Painting Mode") as null|anything in list(
		"Apply Paint",
		"Apply Paint (Override Saturation)",
		"Apply Paint (Combined)",
		"Remove Color",
	)

	switch(choice)
		if("Apply Paint")
			paint_mode = COLOR_NORMAL
		if("Apply Paint (Override Saturation)")
			paint_mode = COLOR_OVERRIDE
		if("Apply Paint (Combined)")
			paint_mode = COLOR_COMBINED
		if("Remove Color")
			paint_mode = COLOR_REMOVAL

/obj/item/toy/crayon/exosuit_painter/Initialize(mapload)
	. = ..()
	refill()

/obj/item/toy/crayon/exosuit_painter/AltClick(mob/user)
	select_mode(user)

/obj/item/toy/crayon/exosuit_painter/examine(mob/user)
	. = ..()
	if(charges)
		. += "It has [charges] use\s left."
	else
		. += "It is empty."
	. += "Alt-click the spraycan to set it's color mode."

/obj/item/toy/crayon/exosuit_painter/attack_self(mob/living/user as mob)
	paint_color = input(user, "Please select the main colour.", "Paint colour") as color

/// Ported spraycan from TG/Bee, and also ports TG's saturation code

/obj/item/toy/crayon/exosuit_painter/afterattack(atom/target, mob/user, proximity, params)
	if(!proximity)
		return ..()

	if(!charges)
		to_chat(usr, span_warning("The painter is empty!"))
		return

	if(!istype(target, /obj/vehicle/sealed/mecha/ntf))
		to_chat(usr, span_warning("This object isn't an exosuit, or isn't the correct type!"))
		return

	var/obj/vehicle/sealed/mecha/ntf/mecha = target

	switch(paint_mode)

		if(COLOR_NORMAL)
			if(is_color_dark_without_saturation(paint_color, 33))
				to_chat(usr, span_warning("A colour that dark on an object like this? Surely not..."))
				return
			mecha.add_atom_colour(paint_color, FIXED_COLOR_PRIORITY)

		if(COLOR_OVERRIDE)
			if(is_color_dark_without_saturation(paint_color, 33))
				to_chat(usr, span_warning("A colour that dark on an object like this? Surely not..."))
				return
			mecha.apply_paint(paint_color)

		if(COLOR_COMBINED)
			if(is_color_dark_without_saturation(paint_color, 33))
				to_chat(usr, span_warning("A colour that dark on an object like this? Surely not..."))
				return
			mecha.apply_paint(paint_color)
			mecha.add_atom_colour(paint_color, FIXED_COLOR_PRIORITY)

		if(COLOR_REMOVAL)
			mecha.remove_atom_colour(FIXED_COLOR_PRIORITY)
			mecha.remove_filter("mech_paint")

	charges--
	playsound(user.loc, 'sound/effects/spray.ogg', 5, 1, 5)
	user.visible_message("[user] coats [target] with spray paint!", span_notice("You coat [mecha] with spray paint."))

/proc/is_color_dark_without_saturation(color, threshold = 25)
	return get_color_brightness_from_hex(color) < threshold

/proc/get_color_brightness_from_hex(A)
	if(!A || length(A) != length_char(A))
		return 0
	var/R = hex2num(copytext(A, 2, 4))
	var/G = hex2num(copytext(A, 4, 6))
	var/B = hex2num(copytext(A, 6, 8))
	return round(max(R, G, B)/2.55, 1)

/obj/item/toy/crayon/exosuit_painter/proc/input_preference_color(mob/user, prompt, title, current_color, fallback = "#FFFFFF")
	var/new_color = input(user, prompt, title, sanitize_hexcolor(current_color, 6, TRUE, fallback)) as null|color
	if(!new_color)
		return null
	return sanitize_hexcolor(new_color, 6, TRUE, fallback)

/obj/vehicle/sealed/mecha/proc/apply_paint(paint_color)
	if(!paint_color)
		remove_filter("mech_paint")
		return

	var/list/hsl = rgb2num(paint_color, COLORSPACE_HSL)
	var/hue = hsl[1] / 360
	var/saturation = hsl[2] / 100
	var/lightness = hsl[3] / 100
	var/added_saturation = saturation * 0.75
	var/deducted_light = saturation * 0.5
	saturation = min(saturation, 1 - added_saturation)

	if(lightness > 0.6)
		var/light_boost = (lightness - 0.6) / 0.4
		added_saturation = min(added_saturation + light_boost * 0.3, 0.9)

	var/list/paint_matrix = list(
		0, 0, 0,
		0, saturation, 0,
		0, 0, 1 - deducted_light,
		hue, added_saturation, 0,
	)

	add_filter("mech_paint", 1, color_matrix_filter(paint_matrix, FILTER_COLOR_HSL))

#undef AVAILABLE_SPRAYCAN_SPACE
#undef COLOR_NORMAL
#undef COLOR_OVERRIDE
#undef COLOR_COMBINED
#undef COLOR_REMOVAL
