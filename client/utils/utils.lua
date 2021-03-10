PZ.clientUtils = {}

PZ.clientUtils.requestModel = function(notHashedModel)
    local model = GetHashKey(notHashedModel)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
end

PZ.clientUtils.toServer = function(str, ...)
    TriggerServerEvent("pz:" .. GetHashKey(str), ...)
end

PZ.clientUtils.hash = function(notHashedModel)
    return GetHashKey(notHashedModel)
end