PZServer.registerRestrictedCommand("car", {"cmd.car"}, function(source, args)
    local car = args[1] or "panto"
    PZServer.toClient("pz_basicCommands:car", source, car)
end)