/mob/living/carbon/xenomorph/facehugger/ai

/mob/living/carbon/xenomorph/facehugger/ai/Initialize(mapload)
	. = ..()
	GLOB.hive_datums[hivenumber].facehuggers -= src
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)

/mob/living/carbon/xenomorph/facehugger/combat/slash/ai

/mob/living/carbon/xenomorph/facehugger/combat/slash/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)

/mob/living/carbon/xenomorph/facehugger/chemical/neurotoxin/ai

/mob/living/carbon/xenomorph/facehugger/chemical/neurotoxin/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)

/mob/living/carbon/xenomorph/facehugger/chemical/aphrotoxin/ai

/mob/living/carbon/xenomorph/facehugger/chemical/aphrotoxin/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)

/mob/living/carbon/xenomorph/facehugger/chemical/ozelomelyn/ai

/mob/living/carbon/xenomorph/facehugger/chemical/ozelomelyn/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)

/mob/living/carbon/xenomorph/facehugger/combat/acid/ai

/mob/living/carbon/xenomorph/facehugger/combat/acid/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)

/mob/living/carbon/xenomorph/facehugger/combat/resin/ai

/mob/living/carbon/xenomorph/facehugger/combat/resin/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)

/mob/living/carbon/xenomorph/chimera/ai

/mob/living/carbon/xenomorph/chimera/ai/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)

