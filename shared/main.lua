---@class PZShared
PZShared = {}

PZShared.newThread = Citizen.CreateThread
PZShared.newWaitingThread = Citizen.SetTimeout
PZShared.invokeNative = Citizen.InvokeNative
Citizen.CreateThread, CreateThread, Citizen.SetTimeout, SetTimeout, InvokeNative, Citizen.InvokeNative = nil,nil,nil,nil,nil,nil

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
    if not PZConfig.devMode then return end
    print("^3[DEBUG]^7 "..message)
end

---repeatingTask
---@public
---@return void
PZShared.newRepeatingTask = function(handler, delay, interval, condition)
    if interval > 0 then Wait(interval) end
    PZShared.newThread(function()
        while condition do
            handler()
            if delay > 0 then Wait(delay) end
        end
    end)
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
