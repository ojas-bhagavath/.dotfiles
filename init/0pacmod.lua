#!/usr/bin/env lua
local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])") or "./"
local dotfiles_root = script_dir .. "../"

local status, packages = pcall(dofile, script_dir .. "packages.lua")
if not status or not packages then
	print("Error loading packages.lua:" .. tostring(packages))
	os.exit(1)
end

print("Installing reflector...")
os.execute("sudo pacman -S --needed --noconfirm reflector")

print("Customizing pacman configuration...")
for _, item in ipairs(packages.aur or {}) do
	if item.name == "pacman" and type(item.root_config) == "table" then
		for _, config in ipairs(item.root_config) do
			local sorce = dotfiles_root .. config.source
			local target = config.target
			os.execute("sudo cp -rvf " .. sorce .. " " .. target)
		end
	end
end

print("Updating mirrorlist using reflector...")
for _, item in ipairs(packages.aur or {}) do
	if item.name == "reflector" and item.post_install then
		os.execute(item.post_install)
	end
end
