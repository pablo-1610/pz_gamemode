PZ.serverUtils = {}

PZ.serverUtils.hash = function(notHashedModel)
    return GetHashKey(notHashedModel)
end

PZ.clientUtils.toClient = function(str, id, ...)
    TriggerServerEvent("pz:" .. GetHashKey(str), id, ...)
end