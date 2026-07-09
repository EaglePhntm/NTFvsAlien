//How much time it takes for one person to finish sampling a surface deposit, if uninterrupted. If interrupted, next right click + do after will pick up right where we left off, and multiple people can help drill at the same time. Deep deposits take longer! Engineering skill makes things go fast fast! 3 mins by default at one person drilling, baseline difficulty, and 0 engineering skill
#define SAMPLETIME (3 * 60 * 10)
#define YOUAREAMORON pickweight(list("Very good! Now over a mineral deposit!!!" = 10, "We require more minerals!" = 10, "What... what are we drilling exactly?" = 10, "Mgnnhnnhhhh I'm sooo hunggryyy" = 1, "Take me to minerals please" = 10, "From the moment I understood the purpose of my drill, it intrigued me. I craved the ores and minerals of deposits. I aspired to the purity of the Blessed REQ. Your kind clings to your intel, as though it will not be contested and third partied. One day, the crudge budget you call supply points will dwindle, and you will beg my kind to save you. But I am already saved, for the Reqtorio is immortal... even in work, I serve the Requistion Officer." = 1))

/obj/machinery/miningsampler
	name = "Geological Survey Sample Drill"
	desc = "A drill produced to drill into deposits, and give you a rough idea of what is deep down there"
	icon = 'ntf_modular/icons/obj/structures/advmining.dmi'
	icon_state = "sampler"
	density = TRUE
	var/progress = 0
	var/obj/structure/oredeposit/dep
	anchored = FALSE
	wrenchable = TRUE


/obj/machinery/miningsampler/attack_hand_alternate(mob/living/user)
	. = ..()
	if(progress < SAMPLETIME)
		handdrill(user)
	else
		if(dep && dep.depth == 0 && !dep.surveyed)
			var/choice = tgui_alert(user,"Would you like to prepare a sample data disk, or a survey report? The data disk can be sold for off world companies willing to buy mining rights over this deposit, while keeping the survey report will allow you to tap the vein yourselves... if you can defend it. The disk is projected to be worth [dep.value] requsition points...","Geological Survey Sample Drill",list("Data Disk", "Survey Report"))
			if(!dep || dep.depth != 0 || dep.surveyed)
				balloon_alert_to_viewers("Huh?")
				return
			if(!can_interact(user))
				balloon_alert(user,"No?")
				return
			if(choice == "Data Disk")
				var/obj/item/disk/intel_disk/new_disk = new /obj/item/disk/intel_disk(get_turf(src), dep.value, 0, user.faction, get_area(src), 0)
				balloon_alert_to_viewers("Lets out a loud ding as it finishes printing the disc!")
				var/sound/printed_ding = sound('sound/machines/ding.ogg', volume = 25)
				minor_announce("[user.faction] has printed a geological sample data disk, leaving the vein at [get_area(src)] untapped, the mining rights to be sold with the sample disk. ICAP systems estimante the vein to be worth [dep.value] requisition points worth of funds on the open market.", title = "Reactive Intelligence Network - [user.faction] Subdivision", alert = printed_ding, should_play_sound = TRUE)
				for(var/hivenumber in GLOB.hive_datums)
					var/datum/job/xeno_job = SSjob.GetJobType(GLOB.hivenumber_to_job_type[hivenumber])
					GLOB.hive_datums[hivenumber].xeno_message("A geological sample data disk has been printed at [get_area(src)]. Should we prevent the talls from defiling our lands, the Queen Mother will bless us with [floor( dep.value * INTEL_AMBROSIA_PER_SUPPLY_POINT)] ambrosia, [round( dep.value/2, 0.1)] psypoints and [round(floor( dep.value/60)/xeno_job.job_points_needed, 0.01)] burrowed larvae.", size = 3, target = new_disk, sound = printed_ding, report_distance = TRUE,
				)
				setAnchored(FALSE)
				qdel(dep)
				dep = null
				progress = 0
			else if(choice == "Survey Report")
				var/obj/item/paper/papyrus = new(get_turf(src))
				papyrus.info = "<CENTER><B>SURVEY REPORT:</B></CENTER><BR><HR>"
				if(dep.CurrentMineralContentsByLayer[1])
					papyrus.info += "<B>MINERALS AT LAYER 1</B><BR>"
					for(var/obj/item/ore/key in dep.CurrentMineralContentsByLayer[1])
						papyrus.info += key.name + " - CONCENTRATION: " + dep.CurrentMineralContentsByLayer[1][key] + "<BR>"
					papyrus.info += "<HR>"
				papyrus.info += "<B>MINERALS AT LAYER 2</B><BR>"
				for(var/obj/item/ore/key in dep.CurrentMineralContentsByLayer[2])
					papyrus.info += key.name + " - CONCENTRATION: " + dep.CurrentMineralContentsByLayer[2][key] + "<BR>"
					papyrus.info += "<HR>"
				papyrus.info += "<B>MINERALS AT LAYER 3</B><BR>"
				for(var/obj/item/ore/key in dep.CurrentMineralContentsByLayer[3])
					papyrus.info += key.name + " - CONCENTRATION: " + dep.CurrentMineralContentsByLayer[3][key] + "<BR>"
					papyrus.info += "<HR>"
				papyrus.info += "Report Concluded. Deploy a 'Pioneer' miner in order to begin extraction!"
				dep.surveyed = TRUE
				setAnchored(FALSE)
				dep = null
				progress = 0
		else
			balloon_alert(user,"The last sampled vein is already processed!")



/obj/machinery/miningsampler/proc/candrill()
	if(anchored)
		for(var/atom/a in get_turf(src))
			if(istype(a, /obj/structure/oredeposit))
				if(dep != a)
					progress = 0
					dep = a
				return TRUE
	return FALSE


/obj/machinery/miningsampler/proc/handdrill(mob/m)
	if(candrill())
		m.balloon_alert_to_viewers("Drills using the sampler", "You drill using the sampler")
		if(!do_after(m,5 SECONDS / (m.skills.engineer + 1),TRUE,src,BUSY_ICON_BUILD))
			return
		progress += ((5 SECONDS)) / dep.miningdifficulty
		if(progress >= SAMPLETIME)
			balloon_alert_to_viewers("The drill finishes!")
			return
		handdrill(m)
	else
		if(!anchored)
			balloon_alert(m,"Anchor the sampler first!")
		else
			balloon_alert(m, YOUAREAMORON )

#undef SAMPLETIME
#undef YOUAREAMORON
