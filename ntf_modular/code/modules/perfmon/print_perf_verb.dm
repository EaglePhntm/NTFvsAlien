ADMIN_VERB(perflog, R_SERVER, "Generate Perflog", "Logs current performance", ADMIN_CATEGORY_SERVER)
	logperf()
	message_admins("Performance log successfully logged by request of [key_name(user)]")
