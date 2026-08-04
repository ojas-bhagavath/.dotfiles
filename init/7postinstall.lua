#!/usr/bin/env lua

local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])") or "./"

local status, packages = pcall(dofile, script_dir .. "packages.lua")
if not status or not packages then
	print("Error: packages.lua not found or failed to load.")
	os.exit(1)
end

print("Running post install scripts...")
for _, collection in pairs(packages) do
	if type(collection) == "table" then
		for _, item in ipairs(collection) do
			if type(item) == "table" then
				if type(item.post_install) == "string" then
					os.execute(item.post_install)
				end
			end
		end
	end
end
