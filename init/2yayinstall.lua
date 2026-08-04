#!/usr/bin/env lua

if os.execute("command -v yay >/dev/null 2>&1") then
	print("yay is already installed, proceeding to package installation...")
else
	print("yay not found. Installing yay...")
	local yay_dir = "/tmp/yay"

	print("Installing base-devel and git...")
	os.execute("sudo pacman -S --needed --noconfirm base-devel git")

	print("Cloning yay repository...")
	os.execute("rm -rf " .. yay_dir)
	os.execute("git clone https://aur.archlinux.org/yay.git " .. yay_dir)

	print("Building and installing yay...")
	os.execute("cd " .. yay_dir .. " && makepkg -si --noconfirm")

	print("Cleaning up...")
	os.execute("rm -rf " .. yay_dir)
end

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

if #names > 0 then
	local pkgs = table.concat(names, " ")
	print("Installing AUR packages: " .. pkgs)
	os.execute("yay -S --needed --noconfirm " .. pkgs)
else
	print("No AUR packages found in packages.lua.")
end
