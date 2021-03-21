---@class PZRanksManager
PZRanksManager = {}

---ranks
---@public
PZRanksManager.ranks = {}

PZShared.netHandleBasic("onMySQLReady", function()
    PZDb.AsyncFetchAll("SELECT * FROM pz_ranks", {}, function(result)
        local totalRankLoaded = 0
        for _, rank in pairs(result) do
            totalRankLoaded = totalRankLoaded + 1
            PZRanksManager.ranks[rank.id] = PZRank(rank.id,rank.identifier,rank.display,json.decode(rank.color),json.decode(rank.permissions))
        end
        PZShared.debug(("Loaded %i ranks"):format(totalRankLoaded))
    end)
end)

---getRank
---@public
---@return PZRank
---@param rankID number
PZRanksManager.getRank = function(rankID)
    return PZRanksManager.ranks[rankID]
end

---getRank
---@public
---@return table
PZRanksManager.getRanks = function()
    return PZRanksManager.ranks
end

---setPlayerRank
---@public
---@return boolean
PZRanksManager.setRank = function(playerID, rankID)
    if not PZPlayersManager.getPlayer(playerID) or not PZRanksManager.getRank(rankID) then
        return false
    end
    ---@type PZPlayer
    local player = PZPlayersManager.getPlayer(playerID)
    ---@type PZRank
    local rank = PZRanksManager.getRank(rankID)
    player:setRank(rank)
    player:notify(PZShared.translate("rank_changed")..": ~y~"..rank.display)
    PZDb.SyncExecute("UPDATE pz_users SET rank = @a WHERE license = @b", { ['a'] = rankID, ['b'] = player:getLicense() })
    return true
end

