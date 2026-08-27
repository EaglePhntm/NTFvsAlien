/datum/ai_behavior/human/g16separatism
	sidestep_prob = 5
	new_move_chat = list("I'm going.", "Cover me, I'm moving.", "Let me move.", "I need to move.", "I'll move!", "Keep distance apart!", "We gotta' go!", "Moving!", "Go go go!!", "Let's  go.", "I'm leaving.", "I'm running.")
	new_follow_chat = list("Following.", "Following you.", "I'm right behind you!", "Take the lead.", "Let's move!", "Let's go!", "Stay together!", "In formation.", "Where to?",)
	new_target_chat = list("Get out of here!!", "Fuck off!!", "Holy shit!", "Oh fuck!", "Federal troops!", "What the-", "I need backup!", "The enemy has arrived!", "Importiert fuck off!", "Aw shit.", "Take 'em out!", "This is our home!!", "We're under attack!", "Scheisse!!", "Get away!!", "Run!!")
	retreating_chat = list("I'm fucking hurt!", "Shit, I'm bleeding!", "Augh shit!!", "I'm hit!", "Somebody fucking help me!", "Fuck this, man!", "Help me!", "Need help here!", "I'm getting the fuck outta' here!", "Oh no.", "I'm getting hit!", "I'm getting shot at!", "Run for it!")
	non_aggressive = FALSE
	medical_rating = AI_MED_DEFAULT
	base_action = MOVING_TO_NODE
	human_ai_behavior_flags = HUMAN_AI_SELF_HEAL|HUMAN_AI_USE_WEAPONS|HUMAN_AI_NO_FF|HUMAN_AI_AVOID_HAZARDS
	human_ai_state_flags = HUMAN_AI_NEED_WEAPONS
	minimum_health = 0.3
	registered_for_node_pathfinding = TRUE

/datum/ai_behavior/human/g16separatism/medic
	medical_rating = AI_MED_DOCTOR

/datum/ai_behavior/human/g16separatism/sapper
	engineer_rating = AI_ENGIE_EXPERT

/datum/ai_behavior/human/g16separatism/deserter
	minimum_health = 0.4
	new_move_chat = list("I'm going.", "Cover me, I'm moving.", "Let me move.", "I need to move.", "I'll move!", "Keep distance apart!", "We gotta' go!", "Moving!", "Go go go!!", "Let's  go.", "I'm leaving.", "I'm running.")
	new_follow_chat = list("Following.", "Following you.", "Gehen sie voran.", "Ubernimm die fuhrung.", "Bewegen!", "Let's go!", "Stay together!", "In formation.", "Where to?",)
	new_target_chat = list("Get out of here!!", "Fuck off!!", "Holy shit!", "Oh fuck!", "Federal troops!", "What the-", "I need backup!", "The enemy has arrived!", "Importiert fuck off!", "Aw shit.", "Take 'em out!", "This is our home!!", "We're under attack!", "Scheisse!!", "Retreat!!", "Run!!")
	retreating_chat = list("I'm fucking hurt!", "Scheisse, ich blute!!", "Fick!!", "I'm hit!", "Somebody fucking help me!", "Augh fick, ich hau ab!", "Hilf mir!", "Need help here!", "I'm getting the fuck outta' here!", "Oh no.", "I'm getting hit!", "I'm getting shot at!", "Run for it!")
	medical_rating = AI_MED_DOCTOR
	engineer_rating = AI_ENGIE_EXPERT

/datum/ai_behavior/human/g16separatism/advisor
	new_move_chat = list("Shevelis!", "Cover me, I'm moving.", "Let me move.", "I need to move.", "I'll move!", "Keep distance apart!", "We gotta' go!", "Moving!", "Go go go!!", "Let's  go.", "I'm leaving.", "I'm running.")
	new_follow_chat = list("Following.", "Following you.", "I'm right behind you!", "You go first.", "Let's move!", "Let's go!", "Do not run off!", "In formation.", "Where to?",)
	new_target_chat = list("SUKA!!", "Poshel nahui!!", "SOLFED-SOM FUCK OFF!!", "Blyat!", "The fuckers are here!", "Get this party started, ah?!", "Mount up and fight!", "Eyes forward, we have company!", "Davai davai!", "Aw shit.", "Take 'em out!", "Contakt!!", "We're under attack!", "Scheisse!!", "Get clear!!", "Fall back!!")
	retreating_chat = list("I'm fucking hurt!", "Shit, I'm bleeding!", "Ay, ack!!", "I'm hit!", "I took a hit!", "Damn you!!", "Pomogi mne!", "Need help here!", "Auck!", "Oh no.", "I'm getting hit!", "Taking fire!", "FUCK!!!")
	minimum_health = 0.5

// idle

/datum/ai_behavior/human/g16separatism/militantidle
	base_action = IDLE

/datum/ai_behavior/human/g16separatism/medicidle
	base_action = IDLE
	medical_rating = AI_MED_DOCTOR

/datum/ai_behavior/human/g16separatism/sapperidle
	base_action = IDLE
	engineer_rating = AI_ENGIE_EXPERT

/datum/ai_behavior/human/g16separatism/deserteridle
	base_action = IDLE
	minimum_health = 0.4
	new_move_chat = list("I'm going.", "Cover me, I'm moving.", "Let me move.", "I need to move.", "I'll move!", "Keep distance apart!", "We gotta' go!", "Moving!", "Go go go!!", "Let's  go.", "I'm leaving.", "I'm running.")
	new_follow_chat = list("Following.", "Following you.", "Gehen sie voran.", "Ubernimm die fuhrung.", "Bewegen!", "Let's go!", "Stay together!", "In formation.", "Where to?",)
	new_target_chat = list("Get out of here!!", "Fuck off!!", "Holy shit!", "Oh fuck!", "Federal troops!", "What the-", "I need backup!", "The enemy has arrived!", "Importiert fuck off!", "Aw shit.", "Take 'em out!", "This is our home!!", "We're under attack!", "Scheisse!!", "Retreat!!", "Run!!")
	retreating_chat = list("I'm fucking hurt!", "Scheisse, ich blute!!", "Fick!!", "I'm hit!", "Somebody fucking help me!", "Augh fick, ich hau ab!", "Hilf mir!", "Need help here!", "I'm getting the fuck outta' here!", "Oh no.", "I'm getting hit!", "I'm getting shot at!", "Run for it!")
	medical_rating = AI_MED_DOCTOR
	engineer_rating = AI_ENGIE_EXPERT

/datum/ai_behavior/human/g16separatism/advisoridle
	new_move_chat = list("Shevelis!", "Cover me, I'm moving.", "Let me move.", "I need to move.", "I'll move!", "Keep distance apart!", "We gotta' go!", "Moving!", "Go go go!!", "Let's  go.", "I'm leaving.", "I'm running.")
	new_follow_chat = list("Following.", "Following you.", "I'm right behind you!", "You go first.", "Let's move!", "Let's go!", "Do not run off!", "In formation.", "Where to?",)
	new_target_chat = list("SUKA!!", "Poshel nahui!!", "SOLFED-SOM FUCK OFF!!", "Blyat!", "The fuckers are here!", "Get this party started, ah?!", "Mount up and fight!", "Eyes forward, we have company!", "Davai davai!", "Aw shit.", "Take 'em out!", "Contakt!!", "We're under attack!", "Scheisse!!", "Get clear!!", "Fall back!!")
	retreating_chat = list("I'm fucking hurt!", "Shit, I'm bleeding!", "Ay, ack!!", "I'm hit!", "I took a hit!", "Damn you!!", "Pomogi mne!", "Need help here!", "Auck!", "Oh no.", "I'm getting hit!", "Taking fire!", "FUCK!!!")
	minimum_health = 0.5
	base_action = IDLE
