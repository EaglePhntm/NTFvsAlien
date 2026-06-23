#define AVAILABLE_SPRAYCAN_SPACE 8
#define COLOR_NORMAL 1
#define COLOR_OVERRIDE 2
#define COLOR_COMBINED 3
#define COLOR_REMOVAL 4

//Spraycan stuff

/obj/item/toy/crayon/spraycan
	name = "exosuit painter"
	icon = 'icons/obj/items/paper.dmi'
	icon_state = "labeler1"
	var/self_contained = FALSE
	var/charges = 50
	var/pre_noise = FALSE
	var/post_noise = FALSE
	var/paint_color = null
	var/paint_mode = COLOR_NORMAL
	desc = "A metallic container containing tasty paint."
	w_class = WEIGHT_CLASS_SMALL
	self_contained = FALSE // Don't disappear when they're empty
	pre_noise = TRUE
	post_noise = FALSE

/obj/item/toy/crayon/spraycan/proc/select_mode(mob/user)
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

/obj/item/toy/crayon/spraycan/Initialize(mapload)
	. = ..()
	// If default crayon red colour, pick a more fun spraycan colour
	refill()

/obj/item/toy/crayon/spraycan/AltClick(mob/user)
	select_mode(user)

/obj/item/toy/crayon/spraycan/examine(mob/user)
	. = ..()
	if(charges)
		. += "It has [charges] use\s left."
	else
		. += "It is empty."

/obj/item/toy/crayon/spraycan/attack_self(mob/living/user as mob)
	paint_color = input(user, "Please select the main colour.", "Crayon colour") as color
//	shadeColour = input(user, "Please select the shade colour.", "Crayon colour") as color

/obj/item/toy/crayon/spraycan/afterattack(atom/target, mob/user, proximity, params)
	if(!proximity)
		return ..()

	if(!charges)
		to_chat(usr, span_warning("The spray can is empty!"))
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
			mecha.apply_paint(null)

	charges--
	if(!.)
		return FALSE

	if(pre_noise || post_noise)
		playsound(user.loc, 'sound/effects/spray.ogg', 5, 1, 5)
	user.visible_message("[user] coats [target] with spray paint!", span_notice("You coat [mecha] with spray paint."))
	return FALSE

	. = ..()

/// it checks if a color is dark, but without saturation value.
/// This uses Brightness only, without Saturation from HSV
/proc/is_color_dark_without_saturation(color, threshold = 25)
	return get_color_brightness_from_hex(color) < threshold

/// returns HSV brightness 0 to 100 by color hex
/proc/get_color_brightness_from_hex(A)
	if(!A || length(A) != length_char(A))
		return 0
	var/R = hex2num(copytext(A, 2, 4))
	var/G = hex2num(copytext(A, 4, 6))
	var/B = hex2num(copytext(A, 6, 8))
	return round(max(R, G, B)/2.55, 1)

/obj/item/toy/crayon/spraycan/proc/input_preference_color(mob/user, prompt, title, current_color, fallback = "#FFFFFF")
	var/new_color = input(user, prompt, title, sanitize_hexcolor(current_color, 6, TRUE, fallback)) as null|color
	if(!new_color)
		return null
	return sanitize_hexcolor(new_color, 6, TRUE, fallback)

/// Applies a paint color to the mech using deep HSL recoloring
/obj/vehicle/sealed/mecha/proc/apply_paint(paint_color)
	if(!paint_color)
		remove_filter("mech_paint")
		return

	// Decompose paint color into HSL components
	var/list/hsl = rgb2num(paint_color, COLORSPACE_HSL)
	var/hue = hsl[1] / 360
	var/saturation = hsl[2] / 100
	var/lightness = hsl[3] / 100

	// Base override values
	var/added_saturation = saturation * 0.75
	var/deducted_light = saturation * 0.5
	saturation = min(saturation, 1 - added_saturation)

	// Only boost for light colors that would otherwise do nothing
	// lightness > 0.6 is roughly where colors start feeling "pale"
	if(lightness > 0.6)
		var/light_boost = (lightness - 0.6) / 0.4  // 0-1 range based on how light it is
		added_saturation = min(added_saturation + light_boost * 0.3, 0.9)

	// Build HSL color matrix
	var/list/paint_matrix = list(
		0, 0, 0,                    // ignore original hue
		0, saturation, 0,           // multiply original saturation by paint's
		0, 0, 1 - deducted_light,   // reduce lightness slightly to compensate
		hue, added_saturation, 0,   // inject our hue and forced saturation
	)

	add_filter("mech_paint", 1, color_matrix_filter(paint_matrix, FILTER_COLOR_HSL))

/// Removes any applied paint, restoring the mech to its base appearance
/obj/vehicle/sealed/mecha/proc/remove_paint()
	remove_filter("mech_paint")

#undef AVAILABLE_SPRAYCAN_SPACE