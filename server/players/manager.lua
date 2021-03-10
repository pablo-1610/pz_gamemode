PZ.players = {}

PZ.playersManager = {
    ---@return void
    create = function(playerID)
        local player = PZPlayer(playerID)
        PZ.players[playerID] = player
        PZ.debug("Creating a player ("..player.id.."), name: "..player.name)
    end,

    ---@return void
    remove = function(playerID)
        PZ.players[playerID] = nil
    end,

    ---@return table
    getPlayers = function()
        return PZ.players
    end,

    ---@return PZPlayer
    getPlayer = function(playerID)
        return PZ.players[playerID] or {}
    end
}