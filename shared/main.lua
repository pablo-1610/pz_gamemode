---@class PZShared
PZShared = {}

PZShared.newThread = Citizen.CreateThread
PZShared.newWaitingThread = Citizen.SetTimeout
PZShared.invokeNative = Citizen.InvokeNative
Citizen.CreateThread, CreateThread, Citizen.SetTimeout, SetTimeout, InvokeNative, Citizen.InvokeNative = nil, nil, nil, nil, nil, nil

---trace
---@public
---@return void
PZShared.trace = function(message)
    print("^2[INFOS]^7 " .. message)
end

---warn
---@public
---@return void
PZShared.warn = function(message)
    print("^1[WARN]^7 " .. message)
end

---debug
---@public
---@return void
PZShared.debug = function(message)
    if not PZConfig.devMode then
        return
    end
    print("^3[DEBUG]^7 " .. message)
end

---@public
---@type table
local tasks = 0

---@public
---@type table
local activeTasks = {}

---repeatingTask
---@public
---@return number
PZShared.newRepeatingTask = function(onRun, onFinished, delay, interval)
    tasks = tasks + 1
    local taskID = tasks
    activeTasks[taskID] = true
    if delay > 0 then
        Wait(delay)
    end
    PZShared.debug(("Creating new repeating task (ID:%i)"):format(taskID))
    PZShared.newThread(function()
        while activeTasks[taskID] do
            onRun()
            if interval > 0 then
                Wait(interval)
            end
        end
        onFinished()
    end)
    return taskID
end

---cancelTaskNow
---@public
---@return void
---@param taskID number
PZShared.cancelTaskNow = function(taskID)
    if not activeTasks[taskID] then return end
    PZShared.debug(("Cancelling task (ID:%i)"):format(taskID))
    activeTasks[taskID] = nil
end

---toInternal
---@public
---@return void
PZShared.toInternal = function(eventName, ...)
    TriggerEvent("pz:" .. PZShared.hash(eventName), ...)
end

---netRegisterAndHandle
---@public
---@return void
PZShared.netRegisterAndHandle = function(eventName, handler)
    local event = "pz:" .. PZShared.hash(eventName)
    RegisterNetEvent(event)
    AddEventHandler(event, handler)
end

---netRegister
---@public
---@return void
PZShared.netRegister = function(eventName)
    local event = "pz:" .. PZShared.hash(eventName)
    RegisterNetEvent(event)
end

---netHandle
---@public
---@return void
PZShared.netHandle = function(eventName, handler)
    local event = "pz:" .. PZShared.hash(eventName)
    AddEventHandler(event, handler)
end

---netHandleBasic
---@public
---@return void
PZShared.netHandleBasic = function(eventName, handler)
    AddEventHandler(eventName, handler)
end

---hash
---@public
---@return any
PZShared.hash = function(notHashedModel)
    return GetHashKey(notHashedModel)
end
