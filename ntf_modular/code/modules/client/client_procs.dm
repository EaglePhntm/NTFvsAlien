/client/proc/ask_reclone()
	var/the_question = "You can now reclone, All your equipment will be with you if you do. If you choose to stay, you can pop this up again by trying to ghost while nested. You can still freely ghost around and return to your body."
	if(world.time < (nested_time + NESTED_RECLONE_TIME))
		the_question = "A new body is growing, You will be able to reclone in [round((nested_time + NESTED_RECLONE_TIME) - world.time)], keeping your equipment, You can choose to stay for now or ghost and re-enter your body freely... You can pop this up again by trying to ghost."
	var/choice = tgui_input_list(src, the_question, "Recloning", list("Reclone","Ghost","Stay in body"), "Stay in body")
	switch(choice)
		if("Reclone")
			if(world.time < (nested_time + NESTED_RECLONE_TIME))
				to_chat(src, span_warning("You need to wait [round((nested_time + NESTED_RECLONE_TIME) - world.time)]."))
				return
			for(var/mob/living/carbon/xenomorph/larva/implanted in mob.contents)
				to_chat(src, span_warning("(N-UI) ALERT: Developed foreign body and psychic interference detected, can not proceed... Try again later."))
				return

			if(!length(GLOB.reclone_tp_spots))
				to_chat(src, span_warning("No teleport spots found, report this to an admin!"))
				return

			if(istype(mob, /mob/dead/observer))
				var/mob/dead/observer/gost = mob
				gost.reenter_corpse()

			var/mob/living/doppleganger = new mob.type(mob.loc)
			prefs.copy_to(doppleganger)
			doppleganger.name = mob.name

			for(var/obj/item/clothing/cloth in mob.contents) //duplicate outfit, only clothes tho.
				var/lecloth = new cloth.type(doppleganger.loc)
				doppleganger.equip_to_appropriate_slot(lecloth, TRUE)

			//replace nested with doppleganger
			if(istype(mob.buckled, /obj/structure/bed/nest/wall))

				var/obj/structure/bed/nest/wall/applicable_nest = new(get_turf(doppleganger))
				applicable_nest.dir = mob.dir
				if(!applicable_nest.buckle_mob(doppleganger, src))
					qdel(applicable_nest)
			else
				for(var/obj/structure/bed/nest/preexisting_nest in get_turf(doppleganger))
					preexisting_nest.buckle_mob(doppleganger, TRUE, FALSE)
			var/turf/thespot = pick(GLOB.latejoinsurvivor) //gl
			switch(mob.faction)
				if(FACTION_CLF)
					thespot = pick(GLOB.latejoinclf)
				if(FACTION_SOM)
					thespot = pick(GLOB.latejoinsom)
				if(FACTION_VSD)
					thespot = pick(GLOB.latejoinsurvivor)
				if(FACTION_MOTHELLIAN)
					thespot = pick(GLOB.latejoinmoff)
				if(FACTION_NANOTRASEN,FACTION_TERRAGOV)
					thespot = pick(GLOB.reclone_tp_spots)
			doppleganger.death(FALSE, "shudders for a moment and goes limp, something beeps at the back of their neck momentarily.")
			if(ishuman(doppleganger))
				var/mob/living/carbon/human/hdop = doppleganger
				hdop.set_undefibbable()
			if(iscarbon(mob))
				var/mob/living/carbon/cmob = mob
				if(ishuman(cmob) && cmob.faction)
					for(var/mob/living/carbon/human/human AS in GLOB.alive_human_list)
						if((human.faction == cmob.faction) || (GLOB.faction_to_iff[human.faction] & GLOB.faction_to_iff[cmob.faction]))
							to_chat(human, span_green("(N-UI) Medical Alert: '[cmob]' have been recloned."))
				cmob.revive()
				cmob.set_nutrition(0)
				cmob.AdjustSleeping(1 MINUTES)
				to_chat(cmob, span_warning("You feel weak, your body strange, you are in a new yourself again it seems. How did you get here..? Who took your body here?"))
			mob.forceMove(thespot.loc)
		if("Ghost")
			var/mob/dead/observer/ghost = mob.ghostize(TRUE, TRUE) //aghost
			log_admin("[key_name(ghost)] nest-ghosted at [AREACOORD(ghost)].")
		if("Stay in body")
			return
