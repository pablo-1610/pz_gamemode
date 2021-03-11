---@class PZServer
PZServer = {}

---toClient
---@public
---@return void
PZServer.toClient = function(eventName, targetId, ...)
    TriggerServerEvent("pz:" .. PZShared.hash(eventName), targetId, ...)
end
