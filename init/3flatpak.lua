#!/usr/bin/env lua

local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])") or "./"

local status, packages = pcall(dofile, script_dir .. "packages.lua")
if not status or not packages or not packages.flatpak then
	print("Error loading packages.lua or 'flatpak' section missing.")
	os.exit(1)
end

if not os.execute("command -v flatpak >/dev/null 2>&1") then
	print("Flatpak utility not found. Installing flatpak via pacman...")
	os.execute("sudo pacman -S --needed --noconfirm flatpak")
end

print("Ensuring Flathub remote is configured...")
os.execute("flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo")

print("Installing Flatpaks...")
for _, item in ipairs(packages.flatpak) do
	if item.name then
		local remote = item.remote or "flathub"
		os.execute("flatpak install -y " .. remote .. " " .. item.name)
	end
end
