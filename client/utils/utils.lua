---@class
PZClient = {}

---requestModel
---@public
---@return void
PZClient.requestModel = function(notHashedModel)
    local model = GetHashKey(notHashedModel)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
end

---toServer
---@public
---@return void
PZClient.toServer = function(eventName, ...)
    TriggerServerEvent("pz:" .. PZShared.hash(eventName), ...)
end