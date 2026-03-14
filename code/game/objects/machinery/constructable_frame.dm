//ported fix from cm
#define CONSTRUCTION_STATE_BEGIN 0
#define CONSTRUCTION_STATE_PROGRESS 1
#define CONSTRUCTION_STATE_FINISHED 2

/obj/machinery/constructable_frame
	name = "machine frame"
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "box_0"
	var/base_state = "box"
	density = FALSE
	anchored = TRUE
	use_power = NO_POWER_USE
	var/requirements_left
	var/obj/item/circuitboard/machine/mcircuit = null
	var/list/components = null
	var/list/req_components = null
	var/list/req_component_names = null
	var/state = CONSTRUCTION_STATE_BEGIN
	var/required_skill = SKILL_CONSTRUCTION_ADVANCED
	var/required_dismantle_skill = SKILL_ENGINEER_PLASTEEL

/obj/machinery/constructable_frame/state_2
	icon_state = "box_1"
	state = CONSTRUCTION_STATE_PROGRESS

/obj/machinery/constructable_frame/Initialize(mapload, ...)
	. = ..()
	update_desc()

/obj/machinery/constructable_frame/Destroy()
	QDEL_NULL(mcircuit)
	return ..()

/obj/machinery/constructable_frame/update_desc()
	. = ..()
	if(state == CONSTRUCTION_STATE_BEGIN)
		requirements_left = " Requires 5 lengths of cable."
	else if(state == CONSTRUCTION_STATE_PROGRESS)
		requirements_left = " Requires a circuit board."
	else if(state == CONSTRUCTION_STATE_FINISHED)
		requirements_left = " Requires "
		var/first = 1
		for(var/I in req_components)
			if(req_components[I] > 0)
				requirements_left += "[first?"":", "][num2text(req_components[I])] [req_component_names[I]]"
				first = 0
		if(first) // nothing needs to be added, then
			requirements_left += "nothing. Use a screwdriver to complete"
		requirements_left += "."
	desc = initial(desc) + span_warning(requirements_left)

/obj/machinery/constructable_frame/update_icon()
	..()
	icon_state = "[base_state]_[state]"

/obj/machinery/constructable_frame/attackby(obj/item/P as obj, mob/user as mob)
	if(!ishuman(user))
		return ..()
	var/mob/living/carbon/human/huser = user
	switch(state)
		if(CONSTRUCTION_STATE_BEGIN)
			if(iscablecoil(P))
				if(huser.skills.getRating(SKILL_CONSTRUCTION) < required_skill)
					to_chat(huser, span_warning("You are not trained to build machines..."))
					return
				var/obj/item/stack/cable_coil/C = P
				if(C.get_amount() < 5)
					to_chat(huser, span_warning("You need five lengths of cable to add them to the frame."))
					return
				playsound(loc, 'sound/items/Deconstruct.ogg', 25, 1)
				huser.visible_message(span_notice("[huser] starts adding cables to [src]."),
				span_notice("You start adding cables to [src]."))
				if(do_after(huser, 20 * (-3 * huser.skills.getRating(SKILL_CONSTRUCTION)), IGNORE_HAND|IGNORE_HELD_ITEM, BUSY_ICON_BUILD) && state == 0)
					if(C && istype(C) && C.use(5))
						huser.visible_message(span_notice("[huser] adds cables to [src]."),
						span_notice("You add cables to [src]."))
						state = CONSTRUCTION_STATE_PROGRESS
						anchored = TRUE
						update_desc()
			else if(iswrench(P))
				if(huser.skills.getRating(SKILL_ENGINEER) < required_dismantle_skill)
					to_chat(huser, span_warning("You are not trained to dismantle machines..."))
					return
				playsound(src.loc, 'sound/items/Ratchet.ogg', 25, 1)
				to_chat(huser, span_notice(" You dismantle the frame..."))
				new /obj/item/stack/sheet/metal(src.loc, 5)
				qdel(src)
		if(CONSTRUCTION_STATE_PROGRESS)
			if(istype(P, /obj/item/circuitboard/machine))
				if(huser.skills.getRating(SKILL_CONSTRUCTION) < required_skill)
					to_chat(huser, span_warning("You are not trained to build machines..."))
					return
				if(!do_after(huser, 20 * (-3 * huser.skills.getRating(SKILL_CONSTRUCTION)), IGNORE_HAND|IGNORE_HELD_ITEM, BUSY_ICON_BUILD))
					return
				playsound(src.loc, 'sound/items/Deconstruct.ogg', 25, 1)
				to_chat(huser, span_notice(" You add the circuit board to the frame."))
				mcircuit = P
				if(huser.dropItemToGround(P))
					P.forceMove(src)
					state = CONSTRUCTION_STATE_FINISHED
					components = list()
					req_components = mcircuit.req_components.Copy()
					for(var/A in mcircuit.req_components)
						req_components[A] = mcircuit.req_components[A]
					req_component_names = mcircuit.req_components.Copy()
					for(var/A in req_components)
						var/obj/ct = A
						req_component_names[A] = initial(ct.name)
					if(mcircuit.frame_desc)
						requirements_left = mcircuit.frame_desc
					to_chat(huser, requirements_left)
					update_desc()

			else if(iswirecutter(P))
				if(huser.skills.getRating(SKILL_ENGINEER) < required_dismantle_skill)
					to_chat(huser, span_warning("You are not trained to dismantle machines..."))
					return
				playsound(src.loc, 'sound/items/Wirecutter.ogg', 25, 1)
				to_chat(huser, span_notice(" You remove the cables."))
				state = CONSTRUCTION_STATE_BEGIN
				var/obj/item/stack/cable_coil/A = new /obj/item/stack/cable_coil( src.loc )
				A.amount = 5

		if(CONSTRUCTION_STATE_FINISHED)
			if(iscrowbar(P))
				if(huser.skills.getRating(SKILL_ENGINEER) < required_dismantle_skill)
					to_chat(huser, span_warning("You are not trained to dismantle machines..."))
					return
				if(!do_after(huser, 20 * (-3 * huser.skills.getRating(SKILL_CONSTRUCTION)), IGNORE_HAND|IGNORE_HELD_ITEM, BUSY_ICON_BUILD))
					return
				playsound(src.loc, 'sound/items/Crowbar.ogg', 25, 1)
				state = CONSTRUCTION_STATE_BEGIN
				mcircuit.forceMove(loc)
				mcircuit = null
				if(length(components) == 0)
					to_chat(huser, span_notice("You remove the circuit board."))
				else
					to_chat(huser, span_notice("You remove the circuit board and other components."))
					for(var/obj/item/W in components)
						W.forceMove(loc)
				update_desc()
				req_components = null
				components = null
			else if(isscrewdriver(P))
				if(huser.skills.getRating(SKILL_CONSTRUCTION) < required_skill)
					to_chat(huser, span_warning("You are not trained to build machines..."))
					return
				var/component_check = 1
				for(var/R in req_components)
					if(req_components[R] > 0)
						component_check = 0
						break
				if(component_check)
					playsound(src.loc, 'sound/items/Screwdriver.ogg', 25, 1)
					var/obj/machinery/new_machine = new src.mcircuit.build_path(src.loc)
					QDEL_LIST_NULL(new_machine.component_parts)
					src.mcircuit.construct(new_machine)
					for(var/obj/O in src)
						O.forceMove(new_machine)
						LAZYADD(new_machine.component_parts, O)
					mcircuit.forceMove(new_machine)
					mcircuit = null
					new_machine.RefreshParts()
					new_machine.on_construction()
					qdel(src)
			else if(istype(P, /obj/item))
				if(huser.skills.getRating(SKILL_CONSTRUCTION) < required_skill)
					to_chat(huser, span_warning("You are not trained to build machines..."))
					return
				for(var/I in req_components)
					if(istype(P, I) && (req_components[I] > 0))
						if(!do_after(huser, 20 * (-3 * huser.skills.getRating(SKILL_CONSTRUCTION)), IGNORE_HAND|IGNORE_HELD_ITEM, BUSY_ICON_BUILD))
							return
						playsound(src.loc, 'sound/items/Deconstruct.ogg', 25, 1)
						if(istype(P, /obj/item/stack/cable_coil))
							var/obj/item/stack/cable_coil/CP = P
							if(CP.get_amount() > 1)
								var/camt = min(CP.amount, req_components[I]) // amount of cable to take, idealy amount required, but limited by amount provided
								var/obj/item/stack/cable_coil/CC = new /obj/item/stack/cable_coil(src)
								CC.amount = camt
								CC.update_icon()
								CP.use(camt)
								components += CC
								req_components[I] -= camt
								update_desc()
								break
						if(huser.dropItemToGround(P))
							P.forceMove(src)
							components += P
							req_components[I]--
							update_desc()
						break
				to_chat(huser, requirements_left)
				if(P && P.loc != src && !istype(P, /obj/item/stack/cable_coil))
					to_chat(huser, span_danger("You cannot add that component to the machine!"))
	update_icon()

#undef CONSTRUCTION_STATE_BEGIN
#undef CONSTRUCTION_STATE_PROGRESS
#undef CONSTRUCTION_STATE_FINISHED
