// Anchor plane: a plane master that draws nothing - its only job is to put the shared daylight source onto each
// viewer's screen, so the source renders and publishes its render target per-client.
#define RENDER_PLANE_DAYLIGHT 18

ADMIN_VERB(set_daylight_time, R_ADMIN, "Set Daylight Time (0-1)", "Force daylight intensity or return to auto", ADMIN_CATEGORY_FUN)
	if(!check_rights(R_ADMIN))
		return

	var/value = input(usr, "Set forced intensity (0 = night, 1 = day, -1 = auto)", "Daylight Control", -1) as num|null
	if(isnull(value))
		return

	value = clamp(value, -1, 1)
	SSdaylight.manual_time = (value < 0 ? -1 : value)
	SSdaylight.time_locked = (value >= 0)
	SSdaylight.cycle_locked = (value >= 0)

	if(value >= 0)
		var/color = SSdaylight.get_manual_light_color(value)
		SSdaylight.set_intensity_and_color(value, color, FALSE)

	log_admin("[key_name(usr)] set daylight time to [value == -1 ? "AUTO" : value]")
	message_admins(span_adminnotice("[key_name_admin(usr)] set daytime: [value == -1 ? "auto" : value]"))

ADMIN_VERB(toggle_daylight_cycle_lock, R_ADMIN, "Toggle Daylight Cycle Lock", "Lock/unlock automatic day-night cycle", ADMIN_CATEGORY_FUN)
	if(!check_rights(R_ADMIN))
		return

	SSdaylight.cycle_locked = !SSdaylight.cycle_locked
	if(!SSdaylight.cycle_locked)
		SSdaylight.time_locked = FALSE
		SSdaylight.manual_time = -1

	log_admin("[key_name(usr)] [SSdaylight.cycle_locked ? "locked" : "unlocked"] daylight cycle")
	message_admins(span_adminnotice("[key_name_admin(usr)] [SSdaylight.cycle_locked ? "locked" : "unlocked"] daylight cycle"))

ADMIN_VERB(flash_daylight, R_ADMIN, "Flash Daylight", "Temporarily flash areas with a color", ADMIN_CATEGORY_FUN)
	if(!check_rights(R_ADMIN))
		return

	var/color = input(usr, "Choose flash color", "Flash Color") as color|null
	if(isnull(color))
		return

	var/duration = input(usr, "Set flash duration in seconds", "Flash Duration", 10) as num|null
	if(isnull(duration))
		return

	var/transition_time = input(usr, "Set transition time in seconds", "Transition Time", 2) as num|null
	if(isnull(transition_time))
		return

	SSdaylight.flash(color, duration SECONDS, transition_time SECONDS)

	log_admin("[key_name(usr)] triggered daylight flash with color [color] for [duration] seconds")
	message_admins(span_adminnotice("[key_name_admin(usr)] triggered daylight flash with color [color] for [duration] seconds"))

// ================= Daylight debugging (temporary) =================
// "Status Report" - confirms the daylight SOURCE exists + is registered on your screen, and how many daylight
//   areas got their per-turf light overlays. If 0 areas are lit, run "Reapply Area Lighting". If the source isn't
//   on your screen, run "Re-register Source".

ADMIN_VERB(daylight_debug_report, R_ADMIN, "Daylight Status", "Print daylight diagnostics", ADMIN_CATEGORY_FUN)
	var/list/lines = list()
	lines += "Daylight areas registered: [length(SSdaylight.daylight_areas)]"
	var/lit = 0
	for(var/area/daylit_area as anything in SSdaylight.daylight_areas)
		if(daylit_area.daylight_lit)
			lit++
	lines += "Areas with light overlay painted: [lit]"
	var/obj/daylight_wash_source/source = SSdaylight.wash_source
	if(source)
		lines += "Daylight source: present (color [source.color], alpha [source.alpha], target [source.render_target])"
		lines += "Source on your screen: [(usr.canon_client && (source in usr.canon_client.screen)) ? "YES" : "NO"]"
	else
		lines += "Daylight source: MISSING"
	lines += "Anchor plane on your HUD: [usr.hud_used?.get_plane_master(RENDER_PLANE_DAYLIGHT) ? "YES" : "NO"]"
	to_chat(usr, span_boldnotice("== Daylight debug ==\n[lines.Join("\n")]"))



/datum/controller/subsystem/daylight/proc/reapply_lighting()
	var/count = 0
	for(var/area/daylit_area as anything in SSdaylight.daylight_areas)
		daylit_area.clear_daylight_overlay()
		daylit_area.apply_daylight_overlay()
		count++
	return count

ADMIN_VERB(daylight_debug_reapply_lighting, R_ADMIN, "Daylight Reapply Area Lighting", "Re-add the daylight light overlay to all daylight areas", ADMIN_CATEGORY_FUN)
	var/count = SSdaylight.reapply_lighting()
	to_chat(usr, span_notice("Reapplied the daylight light overlay to [count] daylight area(s)."))

ADMIN_VERB(daylight_debug_reregister_source, R_ADMIN, "Daylight Re-register Source", "Re-add the daylight source to your screen", ADMIN_CATEGORY_FUN)
	if(!SSdaylight.wash_source)
		to_chat(usr, span_warning("No daylight source exists yet."))
		return
	usr.hud_used?.register_reuse(SSdaylight.wash_source)
	to_chat(usr, span_notice("Re-registered the daylight source onto your screen."))
