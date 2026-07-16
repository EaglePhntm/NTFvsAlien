/obj/item/advmining_drill
	name = "L1 Basic Mining Drillhead - Surface"
	desc = "A drillhead so basic and generic, that it's available in abudant qualities even during the new wave of the Pioneer drill's resurgence, easily manufactured by just about everyone and anyone with basic machines."
	icon = 'icons/obj/mining.dmi'
	icon_state = "diamonddrill"
	w_class = WEIGHT_CLASS_HUGE
	var/depthlayer = 1
	var/durability = 30 // Enough for 30 cycles under normal circumstances
	var/speedmod = 1 //Amount of time between cycles
	var/progressmod = 1 //Amount of depth when cycle ticks
	var/yieldmod = 1 //Amount of resources of the current depth when cycle ticks
	var/powermod = 1 //Modified for power used
	var/surfaceOK = TRUE
	var/deepOK = TRUE
	var/list/extra_loot = null
	var/exclusive_ore = null

/obj/item/advmining_drill/examine(mob/user)
	. = ..()
	if(!ishuman(user) && !isobserver(user))
		return
	. += span_info("Fit for 'Pioneer' drills currently at [depthlayer]# layer.")
	. += span_info("It looks like it will withstand [durability] more operational cycles.")

/obj/item/advmining_drill/rush
	name = "L1-S 'Rusher' Mining Drillhead"
	desc = "A drillhead for skipping what is lovingly labeled as 'trash' and getting straight into the good stuff! This drillhead's designed to quickly go through the surface layer, disregarding the amount of ore wasted and rendered unusable in the process. Unfortunately, it lacks durability, an average operation to the middling layer taking a second drillhead, and the process considerably increases power usage as well."
	durability = 10
	speedmod = 1
	progressmod = 2
	yieldmod = 0.2
	powermod = 2

/obj/item/advmining_drill/commoner
	name = "L1-Y 'Commoner' Mining Drillhead"
	desc = "A drillhead designed to milk the surface level, common minerals dry. Excellent yield, at a decent speed, but at increased power usage, and the drillhead itself costing a pretty penny as well, making it a situational choice, for when you really want to flood the market with sand."
	yieldmod = 2
	powermod = 1.5

/obj/item/advmining_drill/mid
	name = "L2 Basic Mining Drillhead - Middling Depth"
	depthlayer = 2

/*/obj/item/advmining_drill/gold
	name = "L2-EX GOLD 'Digger'"
	desc = "A drillhead that, if used on a deposit that contains gold, will dig up only gold."
	depthlayer = 2
	exclusive_ore = /obj/item/ore/gold*/

/obj/item/advmining_drill/dworf
	name = "L3-D 'Dworf' Mining Drillhead"
	desc = "A drillhead excellent for tapping into the deepest depths of a resource deposit. While the yield is average, it is a very dependable drillhead."
	depthlayer = 3
	durability = 60

/obj/item/advmining_drill/ntcphoron
	name = "L3-NTC PHORON 'Tapper' Drillhead"
	desc = "A tapper drillhead manufactured by Ninetails, this one seeks to recreate a semblence of a steady flow of resources for their supply chains. Can be exclusively used on a surface deposit, to guarantee a steady flow of extra phoron every cycle, at the cost of extra power."
	deepOK = FALSE
	depthlayer = 3
	powermod = 2
	extra_loot = list(/obj/item/ore/phoron = 2000)

/obj/item/advmining_drill/ntcplat
	name = "L3-NTC PLATINUM 'Tapper' Drillhead"
	desc = "A tapper drillhead manufactured by Ninetails, this one seeks to recreate a semblence of a steady flow of resources for their supply chains. Can be exclusively used on a deep deposit, to guarantee a steady flow of extra platinum every cycle, at the cost of extra power."
	surfaceOK = FALSE
	depthlayer = 3
	powermod = 3
	extra_loot = list(/obj/item/ore/osmium = 2000)

/obj/item/advmining_drill/somsixteen
	name = "L3-SOM 16-TON 'Tapper' Drillhead"
	desc = "A tapper drillhead haphazardly thrown together from scrap and low quality materials, this drillhead is the result of desperation and resiliance. Despite it's rough conditions of manufactury, it has been expertly designed to dig up mass quantities of coal, in addition to what it otherwise already would."
	depthlayer = 3
	durability = 10
	extra_loot = list(/obj/item/ore/coal = 20000)

/obj/item/advmining_drill/somlaser
	name = "L3-SOM Laser Drillhead Drillhead"
	desc = "A Laser Drillhead used widely by the Sons of Mars mining forces. Unlike other drillheads, this one doesn't grow dull and broken, but still needs to be recalibrated every now and then."
	depthlayer = 3
	durability = 30
	powermod = 2

/obj/item/advmining_drill/somlaser/attack_self(mob/user)
	. = ..()
	balloon_alert(user, "Recalibrating laser...")
	if(!do_after(user,30 SECONDS / (user.skills.engineer + 1),TRUE,src,BUSY_ICON_BUILD))
		return
	durability = 30
