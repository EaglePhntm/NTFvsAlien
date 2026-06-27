/datum/getrev
	var/commit  // git rev-parse HEAD
	var/date
	var/originmastercommit  // git rev-parse origin/master
	var/list/testmerge = list()

/datum/getrev/New()
	testmerge = world.TgsTestMerges()
	var/datum/tgs_revision_information/revinfo = world.TgsRevision()
	#ifdef DEFINE_REVINFO_REVISION
	log_world("REVINFO: Found define revinfo: commit = [DEFINE_REVINFO_REVISION]")
	#endif
	#ifdef DEFINE_REVINFO_COMPILE_DATE
	log_world("REVINFO: Found define revinfo: date = [DEFINE_REVINFO_COMPILE_DATE]")
	#endif
	if(revinfo)
		commit = revinfo.commit
		originmastercommit = revinfo.origin_commit
		date = revinfo.timestamp
		log_world("REVINFO: Found tgs revinfo: commit = [revinfo.commit], originmastercommit = [revinfo.origin_commit], date = [revinfo.timestamp]")
	else
		commit = rustg_git_revparse("HEAD")
		originmastercommit = rustg_git_revparse("origin/master")
		log_world("REVINFO: No tgs revinfo, rust revinfo: commit = [commit], originmastercommit = [originmastercommit]")
		if(!commit)
			commit = file2text("data/revision.txt")
			log_world("REVINFO: No rust revinfo, file revinfo: commit = [commit]")
			#ifdef DEFINE_REVINFO_REVISION
			if(!commit)
				commit = DEFINE_REVINFO_REVISION
			#endif
	if(commit)
		if(!date)
			date = trim(file2text("data/compile_date.txt"))
			log_world("REVINFO: No tgs date, file date: date = [date]")
			if(!date)
				date = rustg_git_commit_date(commit)
				log_world("REVINFO: No file date, rust date: date = [date]")
				#ifdef DEFINE_REVINFO_COMPILE_DATE
				if(!date)
					date = DEFINE_REVINFO_COMPILE_DATE
				#endif
	// goes to DD log and config_error.txt
	log_world(get_log_message())

/datum/getrev/proc/load_tgs_info()
	testmerge = world.TgsTestMerges()
	var/datum/tgs_revision_information/revinfo = world.TgsRevision()
	if(revinfo)
		commit = revinfo.commit || commit || rustg_git_revparse("HEAD")
		originmastercommit = revinfo.origin_commit
		date = revinfo.timestamp || date || trim(file2text("data/compile_date.txt")) || rustg_git_commit_date(commit)

	// goes to DD log and config_error.txt
	log_world(get_log_message())

/datum/getrev/proc/get_log_message()
	var/list/msg = list()
	msg += "Running /tg/ revision: [date]"
	if(originmastercommit)
		msg += "origin/master: [originmastercommit]"

	for(var/line in testmerge)
		var/datum/tgs_revision_information/test_merge/tm = line
		msg += "Test merge active of PR #[tm.number] commit [tm.head_commit]"
		SSblackbox.record_feedback("associative", "testmerged_prs", 1, list("number" = "[tm.number]", "commit" = "[tm.head_commit]", "title" = "[tm.title]", "author" = "[tm.author]"))

	if(commit && commit != originmastercommit)
		msg += "HEAD: [commit]"
	else if(!originmastercommit)
		msg += "No commit information"

	msg += "Running rust-g version [rustg_get_version()]"

	return msg.Join("\n")

/datum/getrev/proc/GetTestMergeInfo(header = TRUE)
	if(!length(testmerge))
		return ""
	. = header ? "The following pull requests are currently test merged:<br>" : ""
	for(var/line in testmerge)
		var/datum/tgs_revision_information/test_merge/tm = line
		var/cm = tm.head_commit
		var/details = ": '" + html_encode(tm.title) + "' by " + html_encode(tm.author) + " at commit " + html_encode(copytext_char(cm, 1, 11))
		if(details && findtext(details, "\[s\]") && (!usr || !usr.client.holder))
			continue
		. += "<a href=\"[CONFIG_GET(string/githuburl)]/pull/[tm.number]\">#[tm.number][details]</a><br>"

/client/verb/showrevinfo()
	set category = "OOC"
	set name = "Show Server Revision"
	set desc = "Check the current server code revision"

	var/list/msg = list()
	// Round ID
	if(GLOB.round_id)
		msg += "<b>Round ID:</b> [GLOB.round_id]"

	msg += "<b>BYOND Version:</b> [world.byond_version].[world.byond_build]"
	if(DM_VERSION != world.byond_version || DM_BUILD != world.byond_build)
		msg += "<b>Compiled with BYOND Version:</b> [DM_VERSION].[DM_BUILD]"

	// Revision information
	var/datum/getrev/revdata = GLOB.revdata
	msg += "<b>Server revision compiled on:</b> [revdata.date]"
	var/pc = revdata.originmastercommit
	if(pc)
		msg += "Master commit: <a href=\"[CONFIG_GET(string/githuburl)]/commit/[pc]\">[pc]</a>"
	if(length(revdata.testmerge))
		msg += revdata.GetTestMergeInfo()
	if(revdata.commit && revdata.commit != revdata.originmastercommit)
		msg += "Local commit: [revdata.commit]"
	else if(!pc)
		msg += "No commit information"
	if(world.TgsAvailable())
		var/datum/tgs_version/version = world.TgsVersion()
		msg += "Server tools version: [version.raw_parameter]"
	to_chat(src, fieldset_block("Server Revision Info", span_infoplain(jointext(msg, "<br>")), "boxed_message"), type = MESSAGE_TYPE_INFO)
