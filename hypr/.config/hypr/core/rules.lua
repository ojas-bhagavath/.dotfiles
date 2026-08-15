hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
})

hl.window_rule({
	match = { initial_class = "org.keepassxc.KeePassXC" },
	float = true,
	size = { 1080, 920 },
})

for i = 1, 5 do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = "eDP-1",
	})
end

for i = 6, 10 do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = "IPAD",
	})
end
