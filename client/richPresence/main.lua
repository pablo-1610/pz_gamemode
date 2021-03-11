PZClient.richPresence = {}

---@type PZRichPresence
PZClient.richPresence.app = nil

PZClient.richPresence.updateRichPresenceMessage = function(message)
    if not PZClient.richPresence.app then return end
    PZClient.richPresence.app:updateMessage(message)
end

PZShared.netRegisterAndHandle("updateRichPresenceMessage", function(message)
    if not PZClient.richPresence.app then return end
    PZClient.richPresence.app:updateMessage(message)
end)