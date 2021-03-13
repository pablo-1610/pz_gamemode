PZShared.netRegisterAndHandle("pz_basicCommands:car", function(car)
    PZClient.requestModel(car)
    PZClient.spawnVehicleAndWarpPed(car, -1, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
end)