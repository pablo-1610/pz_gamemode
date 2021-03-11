local function freezePlayer(id, bool)
    local player = id
    SetPlayerControl(player, not bool, false)

    local ped = GetPlayerPed(player)

    if not bool then
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end
        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end
        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    else
        if IsEntityVisible(ped) then
            SetEntityVisible(ped, false)
        end
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end

Citizen.CreateThread(function()
    PZShared.debug("Instance created, spawning (1/4)...")
    while not NetworkIsPlayerActive(PlayerId()) do Wait(1) end
    freezePlayer(PlayerId(), true)
    PZShared.debug("Player is active, spawning (2/4)...")
    local availableSpawns = PZ.config.base.defaultSpawns
    local selectedSpawn = availableSpawns[GetRandomIntInRange(1,#availableSpawns)]
    selectedSpawn.model = "a_m_m_socenlat_01"
    PZShared.debug("Requesting player model, spawning (3/4)...")
    PZ.clientUtils.requestModel(selectedSpawn.model)
    selectedSpawn.model = PZShared.hash(selectedSpawn.model)
    SetPlayerModel(PlayerId(), selectedSpawn.model)
    SetModelAsNoLongerNeeded(selectedSpawn.model)
    RequestCollisionAtCoord(selectedSpawn.x, selectedSpawn.y, selectedSpawn.z)
    local ped = PlayerId()
    SetEntityCoordsNoOffset(ped, selectedSpawn.x, selectedSpawn.y, selectedSpawn.z, false, false, false, true)
    NetworkResurrectLocalPlayer(selectedSpawn.x, selectedSpawn.y, selectedSpawn.z, selectedSpawn.heading, true, true, false)
    ClearPedTasksImmediately(ped)
    RemoveAllPedWeapons(ped)
    ClearPlayerWantedLevel(PlayerId())
    local time = GetGameTimer()
    while (not HasCollisionLoadedAroundEntity(ped) and (GetGameTimer() - time) < 5000) do
        Citizen.Wait(0)
    end
    ShutdownLoadingScreen()
    freezePlayer(PlayerId(), false)
    PZShared.debug("Spawn done, spawning (4/4)...")
    PZShared.sendInternal("playerSpawned")
end)


