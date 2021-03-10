PZ = {}

PZ.trace = function(str)
    print("^2[INFOS]^7 "..str)
end

PZ.warn = function(str)
    print("^1[WARN]^7 "..str)
end

PZ.debug = function(str)
    if not PZ.config.devMode then return end
    print("^3[DEBUG]^7 "..str)
end

PZ.sendInternal = function(str, ...)
    TriggerEvent("pz:"..GetHashKey(str), ...)
end