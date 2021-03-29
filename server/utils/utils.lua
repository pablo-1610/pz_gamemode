PZServer.getPlayerLicense = function(source)
    for k,v in pairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
    return nil
end

---toClient
---@public
---@return void
PZServer.toClient = function(eventName, targetId, ...)
    TriggerClientEvent("pz:" .. PZShared.hash(eventName), targetId, ...)
end

---toAll
---@public
---@return void
PZServer.toAll = function(eventName, ...)
    TriggerClientEvent("pz:" .. PZShared.hash(eventName), -1, ...)
end


---@class PZColor
---@public
PZColor = {
    red = "^1",
    green = "^2",
    yellow = "^3",
    blue = "^4",
    cyan = "^5",
    orange = "",
    pink = "^6",
    reset = "^7"
}
