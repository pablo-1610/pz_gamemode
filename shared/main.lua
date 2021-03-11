---@class PZShared
PZShared = {}

---trace
---@public
---@return void
PZShared.trace = function(message)
    print("^2[INFOS]^7 "..message)
end

---warn
---@public
---@return void
PZShared.warn = function(message)
    print("^1[WARN]^7 "..message)
end

---debug
---@public
---@return void
PZShared.debug = function(message)
    if not PZ.config.devMode then return end
    print("^3[DEBUG]^7 "..message)
end

---sendInternal
---@public
---@return void
PZShared.sendInternal = function(message, ...)
    TriggerEvent("pz:"..PZShared.hash(message), ...)
end

---hash
---@public
---@return any
PZShared.hash = function(notHashedModel)
    return GetHashKey(notHashedModel)
end