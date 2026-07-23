/obj/effect/ai_node/spawner/xeno
	name = "Xeno AI spawner"

//////Generic xeno spawners
////////Tier ones

/obj/effect/ai_node/spawner/xeno/runnergang	// RUNNNER GANG RUNNER GANG
	spawntypes = list(/mob/living/carbon/xenomorph/runner/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/defender
	spawntypes = list(/mob/living/carbon/xenomorph/defender/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/sentinel
	spawntypes = list(/mob/living/carbon/xenomorph/sentinel/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/sentinel/retrograde
	spawntypes = list(/mob/living/carbon/xenomorph/sentinel/ai/retrograde)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/drone
	spawntypes = list(/mob/living/carbon/xenomorph/drone/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/tierones
	spawntypes = list(/mob/living/carbon/xenomorph/runner/ai, /mob/living/carbon/xenomorph/sentinel/ai, /mob/living/carbon/xenomorph/defender/ai, /mob/living/carbon/xenomorph/drone/ai, /mob/living/carbon/xenomorph/sentinel/ai/retrograde)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/////////////Tier twos

/obj/effect/ai_node/spawner/xeno/spitter
	spawntypes = list(/mob/living/carbon/xenomorph/spitter/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/spitter/globadier
	spawntypes = list(/mob/living/carbon/xenomorph/spitter/globadier/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/warrior
	spawntypes = list(/mob/living/carbon/xenomorph/warrior/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/hivelord
	spawntypes = list(/mob/living/carbon/xenomorph/hivelord/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/hunter
	spawntypes = list(/mob/living/carbon/xenomorph/hunter/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/bull
	spawntypes = list(/mob/living/carbon/xenomorph/bull/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/tiertwos
	spawntypes = list(
		/mob/living/carbon/xenomorph/hunter/ai,
		/mob/living/carbon/xenomorph/warrior/ai,
		/mob/living/carbon/xenomorph/spitter/ai,
		/mob/living/carbon/xenomorph/spitter/globadier/ai,
		/mob/living/carbon/xenomorph/bull/ai,
		/mob/living/carbon/xenomorph/carrier/ai,
		)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/carrier
	spawntypes = list(/mob/living/carbon/xenomorph/carrier/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

////////////////////Tier 3s

/obj/effect/ai_node/spawner/xeno/ravager
	spawntypes = list(/mob/living/carbon/xenomorph/ravager/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/boiler
	spawntypes = list(/mob/living/carbon/xenomorph/boiler/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/praetorian
	spawntypes = list(/mob/living/carbon/xenomorph/praetorian/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/crusher
	spawntypes = list(/mob/living/carbon/xenomorph/crusher/ai)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10


/obj/effect/ai_node/spawner/xeno/tierthrees
	spawntypes = list(/mob/living/carbon/xenomorph/crusher/ai =1, /mob/living/carbon/xenomorph/praetorian/ai =1, /mob/living/carbon/xenomorph/boiler/ai =1, /mob/living/carbon/xenomorph/ravager/ai =1)
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/////////////Tier 4s

/obj/effect/ai_node/spawner/xeno
	spawnamount = 4
	spawndelay = 10 SECONDS
	maxamount = 10

/obj/effect/ai_node/spawner/xeno/queen
	spawntypes = list(/mob/living/carbon/xenomorph/queen/ai)

/obj/effect/ai_node/spawner/xeno/king
	spawntypes = list(/mob/living/carbon/xenomorph/king/ai)

/obj/effect/ai_node/spawner/xeno/king/conqueror
	spawntypes = list(/mob/living/carbon/xenomorph/king/conqueror/ai)

/obj/effect/ai_node/spawner/xeno/shrike
	spawntypes = list(/mob/living/carbon/xenomorph/shrike/ai)

/obj/effect/ai_node/spawner/xeno/dragon
	spawntypes = list(/mob/living/carbon/xenomorph/dragon/ai)

/obj/effect/ai_node/spawner/xeno/tierfours
	spawntypes = list(/mob/living/carbon/xenomorph/queen/ai,/mob/living/carbon/xenomorph/king/ai,/mob/living/carbon/xenomorph/king/conqueror/ai,/mob/living/carbon/xenomorph/shrike/ai,/mob/living/carbon/xenomorph/dragon/ai)


/obj/effect/ai_node/spawner/xeno/facehuggers
	spawntypes = list(
		/mob/living/carbon/xenomorph/facehugger/ai,
		/mob/living/carbon/xenomorph/facehugger/combat/slash/ai,
		/mob/living/carbon/xenomorph/facehugger/chemical/neurotoxin/ai,
		/mob/living/carbon/xenomorph/facehugger/chemical/aphrotoxin/ai,
		/mob/living/carbon/xenomorph/facehugger/chemical/ozelomelyn/ai,
		/mob/living/carbon/xenomorph/facehugger/combat/acid/ai,
		/mob/living/carbon/xenomorph/facehugger/combat/resin/ai,
		)

/obj/effect/ai_node/spawner/xeno/facehuggers/less_lethal
	spawntypes = list(
		/mob/living/carbon/xenomorph/facehugger/ai,
		/mob/living/carbon/xenomorph/facehugger/chemical/neurotoxin/ai,
		/mob/living/carbon/xenomorph/facehugger/chemical/aphrotoxin/ai,
		/mob/living/carbon/xenomorph/facehugger/combat/resin/ai,
		)

/obj/effect/ai_node/spawner/xeno/facehuggers/less_lethal/alt1
	spawntypes = list(
		/mob/living/carbon/xenomorph/facehugger/ai = 3,
		/mob/living/carbon/xenomorph/facehugger/chemical/neurotoxin/ai = 1,
		/mob/living/carbon/xenomorph/facehugger/chemical/aphrotoxin/ai = 1,
		/mob/living/carbon/xenomorph/facehugger/combat/resin/ai = 1,
		)

/obj/effect/ai_node/spawner/xeno/facehuggers/less_lethal/alt2
	spawntypes = list(
		/mob/living/carbon/xenomorph/facehugger/ai = 6,
		/mob/living/carbon/xenomorph/facehugger/chemical/neurotoxin/ai = 1,
		/mob/living/carbon/xenomorph/facehugger/chemical/aphrotoxin/ai = 4,
		/mob/living/carbon/xenomorph/facehugger/combat/resin/ai = 1,
		)
