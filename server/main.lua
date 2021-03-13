---@class PZServer
PZServer = {}

PZShared.newThread(function()
    PZShared.debug("The gamemode has been instancied, loading...")
    PZShared.toInternal("serverLoaded")
end)