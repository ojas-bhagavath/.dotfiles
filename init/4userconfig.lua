#!/usr/bin/env lua

local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])") or "./"
local dotfiles_root = script_dir .. "../"

local status, packages = pcall(dofile, script_dir .. "packages.lua")
if not status or not packages then
	print("Error: packages.lua not found or failed to load.")
	os.exit(1)
end

if not os.execute("command -v stow >/dev/null 2>&1") then
	print("stow not found. Installing GNU stow...")
	os.execute("sudo pacman -S --needed --noconfirm stow")
end

local stow_items = {}
for _, item in ipairs(packages.aur) do
	if type(item) == "table" and type(item.config) == "string" then
		table.insert(stow_items, item.config)
	end
end
for _, item in ipairs(packages.flatpak) do
	if type(item) == "table" and type(item.config) == "string" then
		table.insert(stow_items, item.config)
	end
end

if #stow_items == 0 then
	print("No config items found in packages.lua, skipping stow.")
	os.exit(0)
end

local stow_list = table.concat(stow_items, " ")
print("stowing: " .. stow_list)
os.execute("cd " .. dotfiles_root .. "; stow -R " .. stow_list)
