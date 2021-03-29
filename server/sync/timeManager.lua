---@class PZTimeSynchronizer
PZTimeSynchronizer = {}

local syncTaskID, hour, min, timeFrozen = 0, 12, 0, false

local function syncPlayersTime()
    PZServer.toAll("syncTime", {hour,min})
end

local function stopSynchronizer()
    PZShared.cancelTaskNow(syncTaskID)
end

local function onTimeElapsed()
    min = min + 1
    if min >= 60 then
        min = 0
        hour = hour + 1
        if hour > 23 then
            hour = 00
        end
    end
end

local function invokeSynchronizer()
    syncTaskID = PZShared.newRepeatingTask(function()
        onTimeElapsed()
        syncPlayersTime()
    end, function()

    end, 0, PZShared.second(5))
end

PZShared.netRegisterAndHandle("serverLoaded", function()
    invokeSynchronizer()
end)

PZShared.netHandle("requestTimeSyncNow", function(h,m)
    hour = h min = m
    syncPlayersTime()
end)

PZShared.netHandle("freezeTime", function(timeFrozen)
    if timeFrozen then
        stopSynchronizer()
    else
        invokeSynchronizer()
    end
end)