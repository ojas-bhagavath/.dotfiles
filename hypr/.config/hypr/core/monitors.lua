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
	position = "16x1080", -- X=16 centers it under 1920px wide eDP-1 (at scale 1.25)
	scale = 1.25,
})
hl.monitor({
	output = "",
	mode = "highres",
	scale = 1,
	mirror = "eDP-1",
})
