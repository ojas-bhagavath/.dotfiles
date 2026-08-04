#!/usr/bin/env lua

local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])") or "./"

local status, packages = pcall(dofile, script_dir .. "packages.lua")
if not status or not packages then
	print("Error: packages.lua not found or failed to load.")
	os.exit(1)
end

local system_services = {}
local user_services = {}

for _, collection in pairs(packages) do
	if type(collection) == "table" then
		for _, item in ipairs(collection) do
			if type(item) == "table" then
				if type(item.system_service) == "string" then
					table.insert(system_services, item.system_service)
				elseif type(item.user_service) == "string" then
					table.insert(user_services, item.user_service)
				end
			end
		end
	end
end

if #system_services == 0 and #user_services == 0 then
	print("No system or user services found in packages.lua, skipping.")
	os.exit(0)
end

if #system_services > 0 then
	print("Enabling system services...")
	for _, svc in ipairs(system_services) do
		os.execute(string.format("sudo systemctl enable --now %q", svc))
	end
end

if #user_services > 0 then
	print("Enabling user services...")
	for _, svc in ipairs(user_services) do
		os.execute(string.format("systemctl --user enable --now %q", svc))
	end
end
