---sendNotification
---@public
---@return void
---@param message string
PZClient.sendNotification = function(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(0,1)
end

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

---spawnVehicleAndWarpPed
---@public
---@param model string
---@param seat number
---@param coords table
---@param heading number
---@return table
PZClient.spawnVehicleAndWarpPed = function(model, seat, coords, heading)
    local hash = GetHashKey(model)
    local vehicle = CreateVehicle(hash, coords, heading or 0.0, true, false)
    while not vehicle do Wait(1) end
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, seat)
    return vehicle
end

---toServer
---@public
---@return void
PZClient.toServer = function(eventName, ...)
    TriggerServerEvent("pz:" .. PZShared.hash(eventName), ...)
end