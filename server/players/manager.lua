---@class PZPlayersManager
PZPlayersManager = {}

---players
---@public
PZPlayersManager.players = {}

---create
---@public
---@return void
PZPlayersManager.create = function(playerID)
    local player
    PZDb.AsyncFetchAll("SELECT * FROM pz_users WHERE license = @a", {['@a'] = PZServer.getPlayerLicense(playerID)}, function(result)
        if result[1] then
            player = PZPlayer(playerID, PZServer.getPlayerLicense(playerID), result[1].name, json.decode(result[1].rolePlayIdentity))
        else
            PZShared.debug("Player isn't in the D.B")
            PZDb.AsyncExecute("INSERT INTO pz_users (license, name, rolePlayIdentity, createdAt, updatedAt) VALUES(@a,@b,@c,@d,@e)", {
                ['a'] = PZServer.getPlayerLicense(playerID),
                ['b'] = GetPlayerName(playerID),
                ['c'] = json.encode({}),
                ['d'] = "", -- Add timestamp
                ['e'] = "" -- Add timestamp
            })
        end
        if not player then
            player = PZPlayer(playerID, PZServer.getPlayerLicense(playerID), GetPlayerName(playerID), {})
        end
        PZPlayersManager.players[playerID] = player
        PZShared.debug("Creating a player (" .. player.id .. "), name: " .. player.name)
    end)
end

---remove
---@public
---@return void
PZPlayersManager.remove = function(playerID)
    PZPlayersManager.players[playerID] = nil
    PZShared.debug("Removed player (" .. playerID .. ")")
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
