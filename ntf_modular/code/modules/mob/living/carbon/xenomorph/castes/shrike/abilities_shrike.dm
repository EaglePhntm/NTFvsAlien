/datum/action/ability/xeno_action/place_acidwell
	action_icon_state = "5"
	action_icon = 'icons/Xeno/acid_well.dmi'
	var/obj/structure/xeno/acidwell/well_type = /obj/structure/xeno/acidwell


GLOBAL_LIST_INIT(acid_well_type_images_list, list(
	/obj/structure/xeno/acidwell = image('icons/Xeno/acid_well.dmi', icon_state = "5"),
	/obj/structure/xeno/acidwell/neuro = image('ntf_modular/icons/Xeno/neuro_well.dmi', icon_state = "5"),
	/obj/structure/xeno/acidwell/aphro = image('ntf_modular/icons/Xeno/aphro_well.dmi', icon_state = "5"),
))

/datum/action/ability/xeno_action/place_acidwell/alternate_action_activate()
	ASYNC
		var/choice = show_radial_menu(usr, usr?.client?.eye, GLOB.acid_well_type_images_list)
		if(choice)
			well_type = choice
		update_button_icon()

/datum/action/ability/xeno_action/place_acidwell/update_button_icon()
	if(!button)
		return
	if(QDELETED(owner))
		return FALSE
	action_icon = initial(well_type.icon)
	name = "Place [initial(well_type.name)]"
	desc = initial(well_type.action_desc)
	. = ..()
