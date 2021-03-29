PZShared.netRegisterAndHandle("syncTime", function(syncedTime)
    PZShared.debug("New time: "..syncedTime[1].."h"..syncedTime[2])
    NetworkOverrideClockTime(tonumber(syncedTime[1]), tonumber(syncedTime[2]), 0)
end)