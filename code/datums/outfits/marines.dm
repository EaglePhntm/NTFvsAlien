/datum/outfit/job/marine/standard
	name = SQUAD_MARINE
	jobtype = /datum/job/terragov/squad/standard

	id = /obj/item/card/id/dogtag

/datum/outfit/job/marine/engineer
	name = SQUAD_ENGINEER
	jobtype = /datum/job/terragov/squad/engineer

	id = /obj/item/card/id/dogtag/engineer

/datum/outfit/job/marine/corpsman
	name = SQUAD_CORPSMAN
	jobtype = /datum/job/terragov/squad/corpsman

	id = /obj/item/card/id/dogtag/corpsman

/datum/outfit/job/marine/smartgunner
	name = SQUAD_SMARTGUNNER
	jobtype = /datum/job/terragov/squad/smartgunner

	id = /obj/item/card/id/dogtag/smartgun

/datum/outfit/job/marine/specialist
	name = SQUAD_SPECIALIST
	jobtype = /datum/job/terragov/squad/specialist

	id = /obj/item/card/id/dogtag/specialist

/datum/outfit/job/marine/leader
	name = SQUAD_LEADER
	jobtype = /datum/job/terragov/squad/leader

	id = /obj/item/card/id/dogtag/leader

/datum/outfit/job/marine/vatgrown
	name = SQUAD_VATGROWN
	jobtype = /datum/job/terragov/squad/vatgrown
	id = /obj/item/card/id/dogtag

/datum/outfit/job/marine/slut
	name = SQUAD_SLUT
	jobtype = /datum/job/terragov/squad/slut

	id = /obj/item/card/id/dogtag

/datum/outfit/job/security_officer
	name = SECURITY_OFFICER
	jobtype = /datum/job/terragov/security/security_officer

	id = /obj/item/card/id/silver
	back = /obj/item/storage/backpack/satchel/sec
	glasses = /obj/item/clothing/glasses/sunglasses/sechud
	belt = /obj/item/storage/belt/security/tactical
	head = /obj/item/clothing/head/beret/sec
	mask = /obj/item/clothing/mask/gas/hardlight
	ears = /obj/item/radio/headset/mainship/marine/generic/sec
	w_uniform = /obj/item/clothing/under/rank/security/corp
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/bulletresistant
	shoes = /obj/item/clothing/shoes/swat
	gloves = /obj/item/clothing/gloves/swat

	belt_contents = list(
		/obj/item/weapon/telebaton = 1,
		/obj/item/restraints/handcuffs = 2,
		/obj/item/flash = 1,
	)
	backpack_contents = list(/obj/item/book/manual/marine_law = 1,)

//quik clap grenade
/obj/item/explosive/grenade/bednade
	name = "Quik-Clap Grenade"
	icon_state = "grenade_sticky_pmc"
	color = COLOR_RED
	desc = "Unfolds into a quik-clap bedroll, to be used by security forces for emergency field administration of cock upon lawbreakers. It does nothing to capture the target, though."
	hit_sound = null

/obj/item/explosive/grenade/bednade/throw_impact(atom/hit_atom, speed, bounce)
	. = ..()
	if(isliving(hit_atom))
		var/mob/living/mafaka = hit_atom
		Move(mafaka.loc) //go beneath people

/obj/item/explosive/grenade/bednade/prime()
	if(ishuman(loc))
		var/mob/living/carbon/human/idiot = loc
		var/in_hand = FALSE
		if(idiot.l_hand == src)
			in_hand = TRUE
		else if(idiot.r_hand == src)
			in_hand = TRUE
		if(in_hand)
			idiot.dropItemToGround(src, TRUE)
			loc = idiot.loc
	var/obj/structure/bed/bedroll/sec/sexbed = new /obj/structure/bed/bedroll/sec(loc)
	update_icon()
	qdel(src)
	sleep(2)
	playsound(sexbed.loc, 'sound/machines/ping.ogg', 25, 1)
