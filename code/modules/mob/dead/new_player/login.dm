/mob/dead/new_player/Login()
	if(CONFIG_GET(flag/use_exp_tracking))
		client.set_exp_from_db()
		client.set_db_player_flags()
	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	..()

	var/motd = global.config.motd
	if(motd)
		to_chat(src, "<div class=\"motd\">[motd]</div>", handle_whitespace=FALSE)

	if(GLOB.admin_notice)
		to_chat(src, "<span class='notice'><b>Admin Notice:</b>\n \t [GLOB.admin_notice]</span>")

	var/spc = CONFIG_GET(number/soft_popcap)
	if(spc && living_player_count() >= spc)
		to_chat(src, "<span class='notice'><b>Server Notice:</b>\n \t [CONFIG_GET(string/soft_popcap_message)]</span>")

	sight |= SEE_TURFS

	new_player_panel()
	client.playtitlemusic()
	if(SSticker.current_state < GAME_STATE_SETTING_UP)
		var/tl = SSticker.GetTimeLeft()
		var/postfix
		if(tl > 0)
			postfix = "in about [DisplayTimeText(tl)]"
		else
			postfix = "soon"
		to_chat(src, "Please set up your character and select \"Ready\". The game will start [postfix].")

	if (!GLOB.donators[key_name(src)]) //It doesn't exist yet
		load_donator(key_name(src))

	if(!(client.get_loc_info()["country"] in list("Russia", "Ukraine", "Kazakhstan", "Belarus", "Japan", "HTTP Is Not Received")) && SSticker.current_state == GAME_STATE_PLAYING)
		to_chat(client, "<span class='danger'>Our system detected that you are probably a pendos. Admins are notified. Killing people 4NR will get you gibbed.</span>")
		message_admins("[key_name(src)] ������, �������� ������ ������..........")
