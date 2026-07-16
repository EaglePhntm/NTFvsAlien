/obj/effect/landmark/miningsite
	var/deep = FALSE
	var/obj/structure/oredeposit/activedeposit = null

/obj/effect/landmark/miningsite/proc/createDeposit(datum/escalation/e)
	activedeposit = new /obj/structure/oredeposit(loc, src,e)


/obj/effect/landmark/miningsite/deep
	deep = TRUE

/obj/effect/landmark/miningsite/deep/createDeposit(datum/escalation/e)
	activedeposit = new /obj/structure/oredeposit/deep(loc, src, e)

