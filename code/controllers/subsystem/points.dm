// points per minute
#define DROPSHIP_POINT_RATE 5 * (GLOB.current_orbit/3)
#define SUPPLY_POINT_RATE 5 * (GLOB.current_orbit/3)
#define HUMAN_FACTION_MAX_POINTS 15000
#define HUMAN_FACTION_ABSOLUTE_MAX_POINTS 30000
#define HUMAN_FACTION_MAX_DROPSHIP_POINTS 15000
#define HUMAN_FACTION_ABSOLUTE_MAX_DROPSHIP_POINTS 30000
#define XENO_FACTION_MAX_POINTS 5000

SUBSYSTEM_DEF(points)
	name = "Points"

	priority = FIRE_PRIORITY_POINTS
	flags = SS_KEEP_TIMING|SS_NO_FIRE

	//wait = 10 SECONDS
	var/dropship_points = list()
	///Assoc list of supply points
	var/supply_points = list()
	///Assoc list of xeno strategic points: xeno_strategic_points_by_hive["hivenum"]
	var/list/xeno_strategic_points_by_hive = list()
	///Assoc list of xeno tactical points: xeno_tactical_points_by_hive["hivenum"]
	var/list/xeno_tactical_points_by_hive = list()
	/// Association list of xeno biomass points: xeno_biomass_points_by_hive["hivenum"]
	var/list/xeno_biomass_points_by_hive = list()

	var/ordernum = 1					//order number given to next order

	var/list/supply_packs = list()
	///Assoc list of item ready to be sent, categorised by faction
	var/list/shoppinglist = list()
	var/list/shopping_history = list()
	var/list/shopping_cart = list()
	var/list/export_history = list()
	var/list/requestlist = list()
	var/list/deniedrequests = list()
	var/list/approvedrequests = list()

	var/list/request_shopping_cart = list()

/datum/controller/subsystem/points/Recover()
	ordernum = SSpoints.ordernum
	supply_packs = SSpoints.supply_packs
	shoppinglist = SSpoints.shoppinglist
	shopping_history = SSpoints.shopping_history
	shopping_cart = SSpoints.shopping_cart
	export_history = SSpoints.export_history
	requestlist = SSpoints.requestlist
	deniedrequests = SSpoints.deniedrequests
	approvedrequests = SSpoints.approvedrequests
	request_shopping_cart = SSpoints.request_shopping_cart

/datum/controller/subsystem/points/Initialize()
	ordernum = rand(1, 9000)
	return SS_INIT_SUCCESS

/// Prepare the global supply pack list at the gamemode start
/datum/controller/subsystem/points/proc/prepare_supply_packs_list(is_human_req_only = FALSE)
	for(var/pack in subtypesof(/datum/supply_packs))
		var/datum/supply_packs/P = pack
		if(!initial(P.cost))
			continue
		if(is_human_req_only && initial(P.available_against_xeno_only))
			continue
		P = new pack()
		if(!P.contains)
			continue
		supply_packs[pack] = P
		var/list/containsname = list()
		for(var/i in P.contains)
			var/atom/movable/path = i
			if(!path)	continue
			if(!containsname[path])
				containsname[path] = list("name" = initial(path.name), "count" = 1)
			else
				containsname[path]["count"]++

/datum/controller/subsystem/points/fire(resumed = FALSE)
	for(var/key in dropship_points)
		add_dropship_points(key, DROPSHIP_POINT_RATE / (1 MINUTES / wait))

	for(var/key in supply_points)
		add_supply_points(key, SUPPLY_POINT_RATE / (1 MINUTES / wait))

///Add amount of strategic psy points to the selected hive only if the gamemode support psypoints
/datum/controller/subsystem/points/proc/add_strategic_psy_points(hivenumber, amount)
	if(!CHECK_BITFIELD(SSticker.mode.round_type_flags, MODE_PSY_POINTS))
		return
	xeno_strategic_points_by_hive[hivenumber] += amount

///Add amount of tactical psy points to the selected hive only if the gamemode support psypoints
/datum/controller/subsystem/points/proc/add_tactical_psy_points(hivenumber, amount)
	if(!CHECK_BITFIELD(SSticker.mode.round_type_flags, MODE_PSY_POINTS))
		return
	xeno_tactical_points_by_hive[hivenumber] += amount

/// Add amount of biomass to the selected hive only if the gamemode support biomass.
/datum/controller/subsystem/points/proc/add_biomass_points(hivenumber, amount)
	if(!CHECK_BITFIELD(SSticker.mode.round_type_flags, MODE_BIOMASS_POINTS))
		return
	xeno_biomass_points_by_hive[hivenumber] += amount

/datum/controller/subsystem/points/proc/approve_request(datum/supply_order/O, mob/living/user)
	var/cost = 0
	for(var/i in O.pack)
		var/datum/supply_packs/SP = i
		cost += SP.cost
	if(cost > supply_points[user.faction])
		return
	var/obj/docking_port/mobile/supply_shuttle = SSshuttle.getShuttle(SHUTTLE_SUPPLY)
	if(length(shoppinglist[O.faction]) >= supply_shuttle.return_number_of_turfs())
		return
	requestlist -= "[O.id]"
	deniedrequests -= "[O.id]"
	approvedrequests["[O.id]"] = O
	O.authorised_by = user.real_name
	supply_points[user.faction] -= cost
	LAZYADDASSOCSIMPLE(shoppinglist[O.faction], "[O.id]", O)
	if(GLOB.directory[O.orderer])
		to_chat(GLOB.directory[O.orderer], span_notice("Your request [O.id] has been approved!"))
	if(GLOB.personal_statistics_list[O.orderer_ckey])
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[O.orderer_ckey]
		personal_statistics.req_points_used += cost

/datum/controller/subsystem/points/proc/deny_request(datum/supply_order/O)
	requestlist -= "[O.id]"
	deniedrequests["[O.id]"] = O
	O.authorised_by = "denied"
	if(GLOB.directory[O.orderer])
		to_chat(GLOB.directory[O.orderer], span_notice("Your request [O.id] has been denied!"))

/datum/controller/subsystem/points/proc/copy_order(datum/supply_order/O)
	var/datum/supply_order/NO = new
	NO.id = ++ordernum
	NO.orderer_ckey = O.orderer_ckey
	NO.orderer = O.orderer
	NO.orderer_rank = O.orderer_rank
	NO.faction = O.faction
	return NO

/datum/controller/subsystem/points/proc/process_cart(mob/living/user, list/cart)
	. = list()
	var/datum/supply_order/O = new
	O.id = ++ordernum
	O.orderer_ckey = user.ckey
	O.orderer = user.real_name
	O.pack = list()
	O.faction = user.faction
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		O.orderer_rank = H.get_assignment()
	var/list/access_packs = list()
	for(var/i in cart)
		var/datum/supply_packs/SP = supply_packs[i]
		for(var/num in 1 to cart[i])
			if(SP.containertype != null)
				if(SP.access)
					LAZYADD(access_packs["[SP.access]"], SP)
				else
					O.pack += SP
				continue
			var/datum/supply_order/NO = copy_order(O)
			NO.pack = list(SP)
			. += NO

	for(var/access in access_packs)
		var/datum/supply_order/AO = copy_order(O)
		AO.pack = list()
		. += AO
		for(var/pack in access_packs[access])
			AO.pack += pack

	if(length(O.pack))
		. += O
	else
		qdel(O)

/datum/controller/subsystem/points/proc/buy_cart(mob/living/user)
	var/cost = 0
	for(var/i in shopping_cart)
		var/datum/supply_packs/SP = supply_packs[i]
		cost += SP.cost * shopping_cart[i]
	if(cost > supply_points[user.faction])
		return
	var/list/datum/supply_order/orders = process_cart(user, shopping_cart)
	for(var/i in 1 to length(orders))
		orders[i].authorised_by = user.real_name
		LAZYADDASSOCSIMPLE(shoppinglist[user.faction], "[orders[i].id]", orders[i])
	supply_points[user.faction] -= cost
	shopping_cart.Cut()

/datum/controller/subsystem/points/proc/submit_request(mob/living/user, reason)
	var/list/ckey_shopping_cart = request_shopping_cart[user.ckey]
	if(!length(ckey_shopping_cart))
		return
	if(length(ckey_shopping_cart) > 20)
		return
	if(NON_ASCII_CHECK(reason))
		return
	if(length(reason) > MAX_LENGTH_REQ_REASON)
		reason = copytext(reason, 1, MAX_LENGTH_REQ_REASON)
	var/list/datum/supply_order/orders = process_cart(user, ckey_shopping_cart)
	for(var/i in 1 to length(orders))
		orders[i].reason = reason
		requestlist["[orders[i].id]"] = orders[i]
	ckey_shopping_cart.Cut()

/datum/controller/subsystem/points/proc/add_supply_points(faction, amount)
	var/startingsupplypoints = supply_points[faction]
	if(startingsupplypoints > HUMAN_FACTION_ABSOLUTE_MAX_POINTS)
		return
	var/simplenewamount1 = startingsupplypoints + amount
	var/countoverflowfrom = max(HUMAN_FACTION_MAX_POINTS, startingsupplypoints)
	var/overflowamount1 = simplenewamount1 - countoverflowfrom
	if(overflowamount1 > 0)
		supply_points[faction] = countoverflowfrom
		overflowamount1 *= 0.15
		var/simplenewamount2 = countoverflowfrom + overflowamount1
		var/overflowamount2 = simplenewamount2 - HUMAN_FACTION_ABSOLUTE_MAX_POINTS
		if(overflowamount2 > 0)
			supply_points[faction] = HUMAN_FACTION_ABSOLUTE_MAX_POINTS
			minor_announce("Operational requisitions budget exceeded absolute maximum capacity, 100% of points over [HUMAN_FACTION_ABSOLUTE_MAX_POINTS] goes towards factional goals.", title = "[faction] accounting division")
		else
			supply_points[faction] = simplenewamount2
			if(startingsupplypoints < HUMAN_FACTION_MAX_POINTS)
				minor_announce("Operational requisitions budget exceeded normal maximum capacity, 85% of points over [HUMAN_FACTION_MAX_POINTS] goes towards factional goals.", title = "[faction] accounting division")
	else
		supply_points[faction] = simplenewamount1

/datum/controller/subsystem/points/proc/add_dropship_points(faction, amount)
	var/startingdropshippoints = dropship_points[faction]
	if(startingdropshippoints > HUMAN_FACTION_ABSOLUTE_MAX_DROPSHIP_POINTS)
		return
	var/simplenewamount1 = startingdropshippoints + amount
	var/countoverflowfrom = max(HUMAN_FACTION_MAX_DROPSHIP_POINTS, startingdropshippoints)
	var/overflowamount1 = simplenewamount1 - countoverflowfrom
	if(overflowamount1 > 0)
		dropship_points[faction] = countoverflowfrom
		overflowamount1 *= 0.15
		var/simplenewamount2 = countoverflowfrom + overflowamount1
		var/overflowamount2 = simplenewamount2 - HUMAN_FACTION_ABSOLUTE_MAX_DROPSHIP_POINTS
		if(overflowamount2 > 0)
			dropship_points[faction] = HUMAN_FACTION_ABSOLUTE_MAX_DROPSHIP_POINTS
			minor_announce("Operational dropship budget exceeded absolute maximum capacity, 100% of points over [HUMAN_FACTION_ABSOLUTE_MAX_DROPSHIP_POINTS] goes towards factional goals.", title = "[faction] accounting division")
		else
			dropship_points[faction] = simplenewamount2
			if(startingdropshippoints < HUMAN_FACTION_MAX_DROPSHIP_POINTS)
				minor_announce("Operational dropship budget exceeded normal maximum capacity, 85% of points over [HUMAN_FACTION_MAX_DROPSHIP_POINTS] goes towards factional goals.", title = "[faction] accounting division")
	else
		dropship_points[faction] = simplenewamount1