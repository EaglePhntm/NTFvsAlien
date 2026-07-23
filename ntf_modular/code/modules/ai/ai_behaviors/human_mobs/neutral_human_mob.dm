/datum/ai_behavior/human/civilian
	sidestep_prob = 15
	new_move_chat = list("I'm going.", "I need to go.", "Let me move.", "I need to move.", "I'm gonna go.", "Personal space!", "Let's get outta' here.", "I need to get going!", "Go go go!!", "Gonna go.", "I'm leaving.", "I'm legging it.")
	new_follow_chat = list("Following.", "Following you.", "I'm right behind you!", "Take the lead.", "Let's move!", "Let's go!", "Stay together!", "In formation.", "Where to?",)
	new_target_chat = list("Get out of here!!", "Holy shit!", "Oh fuck!", "It's getting dangerous!", "What the-", "Help!", "I'm not sticking around!", "*gasp", "Aw shit.", "What is this?", "What's going on?!", "Shit!!", "Get away!!", "Run!!")
	retreating_chat = list("I'm fucking hurt!", "Augh shit!, I'm hit!", "I'm hit!", "I don't want to die!", "Fuck this, man!", "Help me!", "Need help here!", "I'm getting the fuck outta' here!", "Oh no.", "I'm getting hit!", "I'm getting shot at!", "Run for it!")
	non_aggressive = TRUE
	human_ai_behavior_flags = HUMAN_AI_NO_FF|HUMAN_AI_AVOID_HAZARDS
	medical_rating = AI_MED_DEFAULT
	minimum_health = 0.8 //cowardly

/datum/ai_behavior/human/civilian/doctor
	medical_rating = AI_MED_DOCTOR

/datum/ai_behavior/human/civilian/engineer
	engineer_rating = AI_ENGIE_EXPERT
