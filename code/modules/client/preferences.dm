GLOBAL_LIST_EMPTY(preferences_datums)


/datum/preferences
	var/client/parent

	//Basics
	var/path
	var/default_slot = 1
	var/savefile_version = 0

	//Admin
	var/muted = NONE
	var/last_ip
	var/last_id
	var/updating_icon = FALSE

	//Game preferences
	var/lastchangelog = ""	//Hashed changelog
	var/ooccolor = "#b82e00"
	var/be_special = BE_SPECIAL_DEFAULT	//Special role selection
	var/ui_style = "Midnight"
	var/ui_style_color = "#ffffff"
	var/ui_style_alpha = 230
	var/tgui_lock = FALSE
	var/ui_scale = TRUE
	var/tgui_input = TRUE
	var/tgui_input_big_buttons = FALSE
	var/tgui_input_buttons_swap = FALSE
	var/toggles_deadchat = TOGGLES_DEADCHAT_DEFAULT
	var/toggles_chat = TOGGLES_CHAT_DEFAULT
	var/toggles_sound = TOGGLES_SOUND_DEFAULT
	var/toggles_gameplay = TOGGLES_GAMEPLAY_DEFAULT

	var/ghost_hud = TOGGLES_GHOSTHUD_DEFAULT
	var/ghost_vision = TRUE
	var/ghost_orbit = GHOST_ORBIT_CIRCLE
	var/ghost_form = GHOST_DEFAULT_FORM
	var/ghost_others = GHOST_OTHERS_DEFAULT_OPTION

	var/show_typing = TRUE
	var/windowflashing = TRUE
	var/clientfps = 60

	// Custom Keybindings
	var/list/key_bindings = null

	// Custom emotes list
	var/list/custom_emotes = list()

	/// Current tab index of the game preferences ui
	var/tab_index = CHARACTER_CUSTOMIZATION

	///Saves chemical recipes based on client so they persist through games
	var/list/chem_macros = list()

	//Synthetic specific preferences
	var/synthetic_name = "Undefined"
	var/synthetic_type = "Synthetic"
	var/synthetic_body_base = "Human"

	//Robot specific preferences
	var/robot_type = "Basic"
	var/robot_body_base = "Combat Robot"
	var/robot_head_base = "Combat Robot"

	//Prototype supersoldier appearance preferences
	var/custom_supersoldier_parts = FALSE
	var/supersoldier_body_base = "Human"
	var/supersoldier_head_base = "Human"

	//AI specific preferences
	var/ai_name = "ARES v3.2"

	//Character preferences
	var/real_name = ""
	var/random_name = FALSE
	var/gender = MALE
	///for humans, will display this body type
	var/physique = USE_GENDER
	var/age = 20
	var/species = "Human"
	var/ethnicity = "Western"
	var/good_eyesight = TRUE
	var/preferred_squad = "None"
	///Your preferred squad, when playing SOM
	var/preferred_squad_som = "None"
	var/alternate_option = RETURN_TO_LOBBY
	///Quick equip slots, up to [MAX_QUICK_EQUIP_SLOTS]. One per quick equip hotkey.
	var/list/quick_equip = list()
	var/list/gear
	var/list/job_preferences = list()

	/*NTF removal
	//Clothing
	var/underwear = 1
	var/undershirt = 1
	*/
	var/backpack = BACK_SATCHEL

	//Hair style
	var/h_style = "Bald"
	var/r_hair = 0
	var/g_hair = 0
	var/b_hair = 0

	var/grad_style = "None"
	var/r_grad = 0
	var/g_grad = 0
	var/b_grad = 0

	//Facial hair
	var/f_style = "Shaved"
	var/r_facial = 0
	var/g_facial = 0
	var/b_facial = 0

	//Eyes
	var/r_eyes = 0
	var/g_eyes = 0
	var/b_eyes = 0

	/// Genitalia overlay system
	var/genitalia_ass = null
	var/genitalia_ass_size = 2
	var/genitalia_ass_color = "#FFFFFF"
	var/list/genitalia_ass_emissive = list(FALSE, FALSE, FALSE)
	var/genitalia_boobs = null
	var/genitalia_boobs_size = 3
	var/genitalia_boobs_color = "#FFFFFF"
	var/genitalia_boobs_color_secondary = "#d98fa3"
	var/list/genitalia_boobs_emissive = list(FALSE, FALSE, FALSE)
	var/genitalia_cock = null
	var/genitalia_cock_size = 3
	var/genitalia_cock_color = "#FFFFFF"
	var/list/genitalia_cock_emissive = list(FALSE, FALSE, FALSE)
	var/genitalia_vagina = null
	var/genitalia_vagina_color = "#FFFFFF"
	var/list/genitalia_vagina_emissive = list(FALSE, FALSE, FALSE)
	var/genitalia_belly = null
	var/genitalia_belly_size = 0
	var/genitalia_belly_color = "#FFFFFF"
	var/list/genitalia_belly_emissive = list(FALSE, FALSE, FALSE)
	var/genitalia_testicles = null
	var/genitalia_testicles_size = 2
	var/genitalia_testicles_color = "#FFFFFF"
	var/genitalia_testicles_color_secondary = "#d98fa3"
	var/list/genitalia_testicles_emissive = list(FALSE, FALSE, FALSE)

	//Species specific
	var/moth_wings = "Plain"
	var/allow_mismatched_parts = FALSE
	var/use_genital_size_controls = FALSE
	var/allow_emissives = FALSE

	// Universal body part system
	var/tail = "None"
	var/tail_color = "#FFFFFF"
	var/tail_color_secondary = "#FFFFFF"
	var/tail_color_tertiary = "#FFFFFF"
	var/list/tail_emissive = list(FALSE, FALSE, FALSE)
	var/snout = "None"
	var/snout_color = "#FFFFFF"
	var/snout_color_secondary = "#FFFFFF"
	var/snout_color_tertiary = "#FFFFFF"
	var/list/snout_emissive = list(FALSE, FALSE, FALSE)
	var/ears = "None"
	var/ears_color = "#FFFFFF"
	var/ears_color_secondary = "#FFFFFF"
	var/ears_color_tertiary = "#FFFFFF"
	var/list/ears_emissive = list(FALSE, FALSE, FALSE)
	var/horns = "None"
	var/horns_color = "#FFFFFF"
	var/horns_color_secondary = "#FFFFFF"
	var/horns_color_tertiary = "#FFFFFF"
	var/list/horns_emissive = list(FALSE, FALSE, FALSE)
	var/wings = "None"
	var/wings_color = "#FFFFFF"
	var/wings_color_secondary = "#FFFFFF"
	var/wings_color_tertiary = "#FFFFFF"
	var/list/wings_emissive = list(FALSE, FALSE, FALSE)
	var/synth_antenna = "None"
	var/synth_antenna_color = "#FFFFFF"
	var/synth_antenna_color_secondary = "#FFFFFF"
	var/synth_antenna_color_tertiary = "#FFFFFF"
	var/list/synth_antenna_emissive = list(FALSE, FALSE, FALSE)
	var/fluff = "None"
	var/fluff_color = "#FFFFFF"
	var/fluff_color_secondary = "#FFFFFF"
	var/fluff_color_tertiary = "#FFFFFF"
	var/list/fluff_emissive = list(FALSE, FALSE, FALSE)
	var/digitigrade_legs = "Normal"
	var/body_color = "#FFFFFF"
	var/spines = "None"
	var/list/body_markings = list()

	//Lore
	var/citizenship = "Phantom City (Earth)"
	var/blood_type = "A+"
	var/religion = "None"
	var/flavor_text = ""
	var/med_record = ""
	var/sec_record = ""
	var/gen_record = ""
	var/exploit_record = ""
	var/profile_pic = ""
	var/nsfwprofile_pic = ""
	var/xenoprofile_pic = ""
	var/xenogender = 1
	var/harmful_sex_flags = HARMFUL_SEX_ALL
	var/burst_screams_enabled = TRUE

	var/list/exp = list()
	var/list/menuoptions = list()

	/// List of keys we are ignoring in global OOC
	var/list/ignoring = list()
	//Xenomorph specific preferences
	var/xeno_name = "Undefined"
	var/xeno_desc = ""
	var/xeno_edible_jelly_name = ""
	var/xeno_edible_jelly_desc = ""
	var/xeno_edible_jelly_flavors = ""
	// Purplish color for the jelly
	// hex code #9b09ef
	var/r_jelly = 155
	var/g_jelly = 9
	var/b_jelly = 239

	// Hud tooltip
	var/tooltips = TRUE

	///Whether to mute goonchat combat messages when we are the source, such as when we are shot.
	var/mute_self_combat_messages = FALSE
	///Whether to mute goonchat combat messages from others, such as when they are shot.
	var/mute_others_combat_messages = FALSE
	///Whether to mute xeno health alerts from when other xenos are badly hurt.
	var/mute_xeno_health_alert_messages = TRUE
	///Whether we generate a xeno name to show in the chatbox and on the mob.
	var/show_xeno_rank = TRUE

	///whether the user wants to hear tts
	var/sound_tts = TTS_SOUND_ENABLED
	///What tts voice should be used
	var/tts_voice = "Male 01"
	///how much to pitch the tts voice up and down
	var/tts_pitch = 0
	///Volume to use for tts
	var/volume_tts = 100
	///Which types of comms the user wants to hear TTS from
	var/radio_tts_flags = RADIO_TTS_SL | RADIO_TTS_SQUAD | RADIO_TTS_COMMAND | RADIO_TTS_HIVEMIND

	/// Preference for letting people make TGUI windows use more accessible (basically, default) themes, where needed/possible.
	/// Example application: health analyzers using this to choose between default themes or the NtOS themes.
	var/accessible_tgui_themes = FALSE
	/// If we can be shown a health scan by friends with right click
	var/allow_being_shown_health_scan = TRUE

	/// Chat on map
	var/chat_on_map = TRUE
	var/see_chat_non_mob = FALSE
	var/max_chat_length = CHAT_MESSAGE_MAX_LENGTH
	///Whether emotes will be displayed on runechat. Requires chat_on_map to have effect.
	var/see_rc_emotes = TRUE

	///Should we automatically fit the viewport?
	var/auto_fit_viewport = TRUE

	var/parallax

	///The loadout manager
	var/datum/loadout_manager/loadout_manager
	///Should we be in the widescreen mode set by the config?
	var/widescreenpref = TRUE
	///What size should pixels be displayed as? 0 is strech to fit
	var/pixel_size = 0
	///What scaling method should we use? Distort means nearest neighbor
	var/scaling_method = SCALING_METHOD_NORMAL
	///If the game is in fullscreen mode
	var/fullscreen_mode = FALSE
	///Hide status bar (bottom left)
	var/show_status_bar = TRUE
	///ambient occlusion, or the shadows drawn below objects
	var/ambient_occlusion = TRUE
	///whether we want to use multi-z parallax. performance option
	var/multiz_parallax = TRUE
	///performance setting for multiz
	var/multiz_performance = -1

	///Whether or not the MC tab of the Stat Panel refreshes fast. This is expensive so make sure you need it.
	var/fast_mc_refresh = FALSE
	///When enabled, will split the 'Admin' panel into several tabs.
	var/split_admin_tabs = TRUE
	///When enabled, can hear OOC channels from anywhere in any situation.
	///Ex: mentors/admins being able to hear XOOC as a human, or LOOC when not nearby the speaker.
	var/hear_ooc_anywhere_as_staff = TRUE

	/// New TGUI Preference preview
	var/map_name = "player_pref_map"
	var/atom/movable/screen/map_view/preference_preview/screen_main
	var/preference_preview_dir = SOUTH

	/// If unique action will only act on the item in the active hand. If false, it will try to act on the item on the inactive hand as well in certain conditions.
	var/unique_action_use_active_hand = TRUE

	///What outfit typepaths we've favorited in the SelectEquipment menu
	var/list/favorite_outfits = list()

	/// list("sequencename" = list(uid, uid, uid))
	var/list/stim_sequences = list()

	///List of slot_draw_order
	var/list/slot_draw_order_pref = list()

	///State tracking of hive status toggles
	var/status_toggle_flags = HIVE_STATUS_DEFAULTS

	///Bump attacking preference
	var/toggle_bump_attacking = TRUE

/datum/preferences/New(client/C)
	if(!istype(C))
		return

	parent = C

	// Initialize map objects
	screen_main = new
	screen_main.preferences = src
	screen_main.generate_view(map_name)

	if(!IsGuestKey(C.key))
		load_path(C.ckey)
		loadout_manager = new
		loadout_manager.loadouts_data = load_loadout_list()
		if(load_preferences() && load_character())
			C.set_fullscreen(fullscreen_mode)
			return


	// We don't have a savefile or we failed to load them
	random_character(/datum/species/human)
	menuoptions = list()
	key_bindings = deepCopyList(GLOB.hotkey_keybinding_list_by_key) // give them default keybinds and update their movement keys
	save_keybinds()
	for(var/i in 1 to CUSTOM_EMOTE_SLOTS)
		var/datum/custom_emote/emote = new
		emote.id = i
		custom_emotes += emote
	C.set_macros()
	loadout_manager = new

/datum/preferences/can_interact(mob/user)
	return TRUE


/datum/preferences/proc/ShowChoices(mob/user)
	if(!user?.client)
		return

	update_preview_icon()
	ui_interact(user)

/datum/preferences/proc/UpdateJobPreference(mob/user, role, desiredLvl)
	if(!length(SSjob?.joinable_occupations))
		return

	var/datum/job/job = SSjob.GetJob(role)

	if(!job)
		return

	SetJobPreferenceLevel(job, desiredLvl)

	return TRUE


/datum/preferences/proc/SetJobPreferenceLevel(datum/job/job, level)
	if(!job)
		return FALSE

	if(level == JOBS_PRIORITY_HIGH)
		for(var/j in job_preferences)
			if(job_preferences[j] == JOBS_PRIORITY_HIGH)
				job_preferences[j] = JOBS_PRIORITY_MEDIUM

	job_preferences[job.title] = level
	return TRUE

///returns the physique the user wants to be using
/datum/preferences/proc/get_physique()
	if(physique == USE_GENDER)
		if(gender == FEMALE)
			return FEMALE
		else
			return MALE
	return physique
