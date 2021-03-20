PZServer.registerRestrictedCommand("car", {"cmd.car"}, function(source, args)
    local car = args[1] or "panto"
    PZServer.toClient("pz_basicCommands:car", source, car)
end)

PZServer.registerConsoleCommand("setGroup", function(source, args)
    if #args < 1 or #args > 2 then
        PZShared.warn(PZShared.getUsage("setGroup", {"playerID", "groupID"}))
        return
    end

    local target = tonumber(args[1])
    local targetRank = tonumber(args[2])

    if not PZPlayersManager.getPlayer(target) then
        PZShared.warn(PZColor.red..PZShared.translate("player_offline"))
        return
    end

    if not PZRanksManager.getRank(targetRank) then
        PZShared.warn(PZColor.red..PZShared.translate("rank_missing"))
        return
    end
end)