/obj/machinery/computer/escalation_terminal
	name = "\improper ICAP"
	desc = "\improper ICAP description"
	faction = FACTION_TERRAGOV

/obj/machinery/computer/escalation_terminal/Initialize(mapload)
	. = ..()
	name = "[faction] ICAP"
	desc = "An Intelligence Computer Access Point terminal hooked into the [faction] Intelligence Network, which is able to process intelligence from disks into various opportunities ship- and planetside."





