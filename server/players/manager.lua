---@class PZPlayersManager
PZPlayersManager = {}

---players
---@public
PZPlayersManager.players = {}

---create
---@public
---@return void
PZPlayersManager.create = function(playerID)
    local player = PZPlayer(playerID)
    PZ.players[playerID] = player
    PZ.debug("Creating a player (" .. player.id .. "), name: " .. player.name)
end

---remove
---@public
---@return void
PZPlayersManager.remove = function(playerID)
    PZPlayersManager.players[playerID] = nil
end

---getPlayer
---@public
---@return table
PZPlayersManager.getPlayers = function()
    return PZPlayersManager.players
end

---getPlayer
---@public
---@return PZPlayer
PZPlayersManager.getPlayer = function(playerID)
    return PZPlayersManager.players[playerID]
end

---notifyAll
---@public
---@return void
PZPlayersManager.notifyAll = function(message)
    ---@param player PZPlayer
    for k, player in pairs(PZPlayersManager.players) do
        player:notify(message)
    end
end
