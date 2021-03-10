PZ.utils = {
    requestModel = function(notHashedModel)
        local model = GetHashKey(notHashedModel)
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(1) end
    end,

    hash = function(notHashedModel)
        return GetHashKey(notHashedModel)
    end
}