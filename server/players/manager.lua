---@class PZPlayersManager
PZPlayersManager = {}

---players
---@public
PZPlayersManager.players = {}

---create
---@public
---@return void
PZPlayersManager.create = function(playerID)
    local init = false
    PZDb.AsyncFetchAll("SELECT * FROM pz_users WHERE license = @a", {['@a'] = PZServer.getPlayerLicense(playerID)}, function(result)
        if result[1] then
            if not PZRanksManager.getRank(result[1].rank) then
                if PZRanksManager.getRank(PZConfig.base.defaultRank) then
                    result[1].rank = PZConfig.base.defaultRank
                else
                    ---@type PZRank
                    local minPermRank
                    for _, v in pairs(PZRanksManager.getRanks()) do
                        ---@type PZRank
                        local rank = v
                        if not minPermRank then
                            minPermRank = rank
                        else
                            if #minPermRank:getPermissions() > #rank:getPermissions() then
                                minPermRank = rank
                            end
                        end
                    end
                    result[1].rank = minPermRank:getId()
                end
            end
            PZPlayersManager.players[playerID] = PZPlayer(playerID, PZServer.getPlayerLicense(playerID), result[1].rank, json.decode(result[1].rolePlayIdentity))
        else
            PZPlayersManager.players[playerID] = PZPlayer(playerID, PZServer.getPlayerLicense(playerID), PZConfig.base.defaultRank, {})
            init = true
            PZShared.debug("Player isn't in the D.B")
            PZDb.AsyncExecute("INSERT INTO pz_users (license, name, rank, createdAt, updatedAt) VALUES(@a,@b,@c,@d,@e)", {
                ['a'] = PZServer.getPlayerLicense(playerID),
                ['b'] = GetPlayerName(playerID),
                ['c'] = tonumber(PZConfig.base.defaultRank),
                ['d'] = 0, -- Add timestamp
                ['e'] = 0 -- Add timestamp
            })
        end
        if init then
            PZShared.toInternal("onPlayerAccountCreated", player)
        end
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
