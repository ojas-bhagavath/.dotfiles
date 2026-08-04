#!/usr/bin/env lua

local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])") or "./"
local dotfiles_root = script_dir .. "../"

local status, packages = pcall(dofile, script_dir .. "packages.lua")
if not status or not packages then
	print("Error: packages.lua not found or failed to load.")
	os.exit(1)
end

local copy_tasks = {}

for _, collection in pairs(packages) do
	if type(collection) == "table" then
		for _, item in ipairs(collection) do
			if type(item) == "table" and type(item.root_config) == "table" then
				for _, config in ipairs(item.root_config) do
					if type(config) == "table" and config.source and config.target then
						table.insert(copy_tasks, {
							source = dotfiles_root .. config.source,
							target = config.target,
						})
					end
				end
			end
		end
	end
end

if #copy_tasks == 0 then
	print("No root_config tasks found in packages.lua, skipping.")
	os.exit(0)
end

print("Copying root configurations...")
for _, task in ipairs(copy_tasks) do
	os.execute(string.format('sudo mkdir -pv "$(dirname %q)"', task.target))
	os.execute(string.format("sudo cp -vrf %q %q", task.source, task.target))
end
