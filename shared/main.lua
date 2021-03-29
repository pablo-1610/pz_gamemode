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
    print("^2[INFOS]^7 " .. message .. "^7")
end

---warn
---@public
---@return void
PZShared.warn = function(message)
    print("^1[WARN]^7 " .. message .. "^7")
end

---debug
---@public
---@return void
PZShared.debug = function(message)
    if not PZConfig.devMode then
        return
    end
    print("^3[DEBUG]^7 " .. message .. "^7")
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

---getCurrentLang
---@public
---@return table
PZShared.getCurrentLang = function()
    return PZTranslations[PZConfig.lang:upper()] or "EN"
end

---translate
---@public
---@return string
PZShared.translate = function(index)
    return PZShared.getCurrentLang()[index]
end

---toInternal
---@public
---@return void
PZShared.toInternal = function(eventName, ...)
    TriggerEvent("pz:" .. PZShared.hash(eventName), ...)
end

local registredEvents = {}
local function isEventRegistred(eventName)
    for k,v in pairs(registredEvents) do
        if v == eventName then return true end
    end
    return false
end
---netRegisterAndHandle
---@public
---@return void
PZShared.netRegisterAndHandle = function(eventName, handler)
    local event = "pz:" .. PZShared.hash(eventName)
    if not isEventRegistred(event) then
        RegisterNetEvent(event)
        table.insert(registredEvents, event)
    end
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

---getUsage
---@public
---@return void
PZShared.getUsage = function(cmd, args)
    local sb = ""
    for _, arg in pairs(args) do
        sb = sb.." "..PZColor.reset.." <"..PZColor.yellow..arg..PZColor.reset..">"
    end
    return PZShared.translate("cmd_usage")..": "..PZColor.green..cmd..sb
end

---registerAddonLocales
---@public
---@return void
PZShared.registerAddonLocales = function(locales)
    for lang,translations in pairs(locales) do
        if PZTranslations[lang] then
            for key,translation in pairs(translations) do
                PZTranslations[lang][key] = translation
            end
        end
    end
end

---second
---@public
---@return number
PZShared.second = function(from)
    return from*1000
end