/turf/closed/wall/backrooms_wall
	name = "yellow wallpapered wall"
	desc = "An old, grungy wall, covered in yellowed wallpaper. Seems to go on forever."
	icon = 'icons/turf/walls/backrooms_wallpaper_pro.dmi'
	icon_state = "wall-reinforced"
	base_icon_state = "rwall"
	opacity = TRUE
	density = TRUE

	max_integrity = 3000
	max_temperature = 6000

	/// appears to be unused
	walltype = "rwall"
	explosion_block = 4

	soft_armor = list(MELEE = 0, BULLET = 80, LASER = 80, ENERGY = 100, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
