-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080",
	position = "auto",
	scale = 1,
})
hl.monitor({
	output = "IPAD",
	mode = "2360x1640",
	position = "auto-center-down",
	scale = 1.5,
})
hl.monitor({
	output = "",
	mode = "highres",
	scale = 1,
	mirror = "eDP-1",
})
