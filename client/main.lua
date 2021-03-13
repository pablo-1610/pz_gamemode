---@class
PZClient = {}

-- @TODO -> To remove
RegisterCommand("setDensity", function(source, args, command)
    local density = tonumber(args[1])
    PZNpcsManager.setDensity(density)
end)