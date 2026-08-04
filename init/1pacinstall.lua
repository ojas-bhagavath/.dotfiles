#!/usr/bin/env lua

local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])") or "./"

local status, packages = pcall(dofile, script_dir .. "packages.lua")
if not status or not packages or not packages.aur then
	print("Error loading packages.lua or 'aur' section missing.")
	os.exit(1)
end

local names = {}
for _, item in ipairs(packages.aur) do
	if item.name then
		table.insert(names, item.name)
	end
end

print("Installing pacman packages...")
if #names > 0 then
	local pkgs = table.concat(names, "\\n")
	local cmd = string.format(
		"sudo pacman -S --needed --noconfirm $(comm -12 <(pacman -Slq | sort) <(printf '%s\\n' | sort))",
		pkgs
	)
	os.execute(cmd)
else
	print("No pacman packages found in packages.lua.")
end
