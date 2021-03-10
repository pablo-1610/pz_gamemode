PZ.serverUtils = {
    hash = function(notHashedModel)
        return GetHashKey(notHashedModel)
    end,

    toClient = function(str, id, ...)
        TriggerServerEvent("pz:" .. GetHashKey(str), id, ...)
    end
}