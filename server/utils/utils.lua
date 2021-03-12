---@class PZServer
PZServer = {}

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
    TriggerServerEvent("pz:" .. PZShared.hash(eventName), targetId, ...)
end
