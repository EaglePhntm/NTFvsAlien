#define NTC_MUSIC_LIST list(\
	"ntf_modular/sound/music/war_mode/adminmusic/Red_Alert_3/Allied_Combat_1.ogg",\
	"ntf_modular/sound/music/war_mode/adminmusic/Red_Alert_3/Allied_Combat_2.ogg",\
	"ntf_modular/sound/music/war_mode/adminmusic/Red_Alert_3/Hell_March_1.ogg",\
	"ntf_modular/sound/music/war_mode/adminmusic/Red_Alert_3/Hell_March_3.ogg"\
)

#define SOM_MUSIC_LIST list(\
	"ntf_modular/sound/music/war_mode/adminmusic/Red_Alert_3/Soviet_Combat_1.ogg",\
	"ntf_modular/sound/music/war_mode/adminmusic/Red_Alert_3/Soviet_Combat_2.ogg",\
	"ntf_modular/sound/music/war_mode/adminmusic/Red_Alert_3/Hell_March_1.ogg",\
	"ntf_modular/sound/music/war_mode/adminmusic/Red_Alert_3/Hell_March_3.ogg"\
)

#define KAIZOKU_MUSIC_LIST list(\
	"ntf_modular/sound/music/war_mode/adminmusic/Red_Alert_3/Japan_Combat_1.ogg",\
	"ntf_modular/sound/music/war_mode/adminmusic/Red_Alert_3/Japan_Combat_2.ogg"\
)

#define XENO_MUSIC_LIST list(\
	"ntf_modular/sound/music/war_mode/adminmusic/Kanes_wrath/Act_on_Instinct.ogg",\
	"ntf_modular/sound/music/war_mode/adminmusic/Kanes_wrath/Mechanical_Mind.ogg"\
)

ADMIN_VERB(toggle_war_mode, R_FUN, "Toggle War Mode", "Toggles pop locks etc, use when war is happening.", ADMIN_CATEGORY_MAIN)
	if(istype(SSticker.mode, /datum/game_mode/infestation/secret_of_life))
		var/datum/game_mode/infestation/secret_of_life/gaymode = SSticker.mode
		gaymode.toggle_pop_locks()
	else
		to_chat(usr, span_notice("Need to be in SOL mode to toggle war mode."))

ADMIN_VERB(play_warmode_action_music, R_FUN, "Quick-play War Music to Factions", "Plays each faction a random fitting music.", ADMIN_CATEGORY_FUN)
	var/sound/sound_path
	var/ntmusic = pick(NTC_MUSIC_LIST)
	var/sommusic = pick(SOM_MUSIC_LIST)
	var/kaimusic = pick(KAIZOKU_MUSIC_LIST)
	var/xenomusic = pick(XENO_MUSIC_LIST)
	for(var/mob/M AS in GLOB.alive_living_list)
		if(!M.client)
			continue
		switch(M.faction)
			if(FACTION_TERRAGOV,FACTION_ICC)
				sound_path = sound(ntmusic, channel = CHANNEL_MIDI, volume = 15)
			if(FACTION_SOM)
				sound_path = sound(sommusic, channel = CHANNEL_MIDI, volume = 15)
			if(FACTION_VSD)
				sound_path = sound(kaimusic, channel = CHANNEL_MIDI, volume = 15)
			if(FACTION_XENO,FACTION_CLF)
				sound_path = sound(xenomusic, channel = CHANNEL_MIDI, volume = 15)
		if(!sound_path)
			return
		if(!isnewplayer(M) && M.client.prefs.toggles_sound & SOUND_MIDI)
			SEND_SOUND(M, sound_path)
			to_chat(M, span_notice("Random action music started for your faction by an admin. This can toggled with toggle admin music in game preferences."))

ADMIN_VERB(stop_warmode_action_music, R_FUN, "Stop War Music to Factions", "Stops war action music for all factions.", ADMIN_CATEGORY_FUN)
	for(var/mob/M AS in GLOB.alive_living_list)
		if(!isnewplayer(M) && M.client)
			M.stop_sound_channel(CHANNEL_MIDI)

ADMIN_VERB(command_report_to_faction, R_FUN, "Command Report to Faction", "Create a custom Command Report for a Faction", ADMIN_CATEGORY_FUN)
	var/faction_choice = input(usr, "Select a faction:", "Faction") as null|anything in SSticker.mode.factions

	var/customname = tgui_input_text(user, "Pick a title for the report.", "Title", "[faction_choice] Update", encode = FALSE)
	if(!customname)
		return
	var/input = tgui_input_text(user, "Please enter anything you want. Anything. Serious.", "What?", "", multiline = TRUE, encode = FALSE)
	if(!input)
		return

	faction_announce(input, customname, sound = 'sound/AI/commandreport.ogg', to_faction = faction_choice);

	log_admin("[key_name(user)] has created a command report for [faction_choice]: [input]")
	message_admins("[ADMIN_TPMONTY(user.mob)] has created a command report for [faction_choice].")

ADMIN_VERB(change_dnr_time, R_ADMIN, "Change Global DNR Time", "Change the time people can not be revived anymore", ADMIN_CATEGORY_MAIN)
	var/new_dnr_time = tgui_input_number(usr, "Enter new dnr time (Cur: [GLOB.time_before_dnr])", "DNR time", 300)
	if(!new_dnr_time)
		return
	GLOB.time_before_dnr = new_dnr_time
	to_chat(usr, span_notice("The new DNR timer is [new_dnr_time] ticks, about [new_dnr_time/60] minutes."))

/proc/daysSince(realtimev)
	return round((world.realtime - realtimev) / (24 HOURS))

ADMIN_VERB(add_bunker_bypass, R_ADMIN, "Add Bunker Bypass", "Allows a ckey to connect despite the panic bunker for a given round.", ADMIN_CATEGORY_SERVER)
	if(!check_rights(R_ADMIN))
		return

	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, "<span class='adminnotice'>The Database is not enabled!</span>")
		return
	var/ckeytobypass = tgui_input_text(usr, "Enter ckey", "CKEY", null)
	if(!ckeytobypass)
		return

	GLOB.bunker_passthrough |= ckey(ckeytobypass)
	GLOB.bunker_passthrough[ckey(ckeytobypass)] = world.realtime
	SSpersistence.SavePanicBunker() //we can do this every time, it's okay
	log_admin("[key_name(usr)] has added [ckeytobypass] to the current round's bunker bypass list.")
	message_admins("[key_name_admin(usr)] has added [ckeytobypass] to the current round's bunker bypass list.")


/datum/controller/subsystem/persistence/proc/SavePanicBunker()
	var/json_file = file("data/bunker_passthrough.json")
	var/list/file_data = list()
	file_data["data"] = GLOB.bunker_passthrough
	var/encoded_data = json_encode(file_data)
	fdel(json_file)
	WRITE_FILE(json_file, encoded_data)
	log_game("Saved bunker_passthrough: [encoded_data]")

/datum/controller/subsystem/persistence/proc/LoadPanicBunker()
	var/bunker_path = file("data/bunker_passthrough.json")
	if(fexists(bunker_path))
		var/list/json = json_decode(file2text(bunker_path))
		GLOB.bunker_passthrough = json["data"]
		log_game("loaded bunker_passthrough: [json_encode(GLOB.bunker_passthrough)]")
		for(var/ckey in GLOB.bunker_passthrough)
			if(daysSince(GLOB.bunker_passthrough[ckey]) >= 7)
				GLOB.bunker_passthrough -= ckey
				log_game("Removed [ckey] from bunker_passthrough for being added too long ago.")


///Loads data at the start of the round
/datum/controller/subsystem/persistence/Initialize()
	LoadSeasonalItems()
	LoadPanicBunker()
	return ..()

///Stores data at the end of the round
/datum/controller/subsystem/persistence/CollectData()
	SavePanicBunker()
	. = ..()

ADMIN_VERB(remove_bunker_bypass, R_ADMIN, "Remove Bunker Bypass", "Revokes a ckey's permission to bypass the panic bunker for a given round.", ADMIN_CATEGORY_SERVER)
	if(!check_rights(R_ADMIN))
		return

	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, "<span class='adminnotice'>The Database is not enabled!</span>")
		return

	var/ckeytobypass = tgui_input_text(usr, "Enter ckey", "CKEY", null)
	if(!ckeytobypass)
		return

	GLOB.bunker_passthrough -= ckey(ckeytobypass)
	SSpersistence.SavePanicBunker()
	log_admin("[key_name(usr)] has removed [ckeytobypass] from the current round's bunker bypass list.")
	message_admins("[key_name_admin(usr)] has removed [ckeytobypass] from the current round's bunker bypass list.")
