local antiSpamList = {}

local function checkAntiSpam(source)
    return antiSpamList[source] == nil
end

local function antiSpam(source)
    antiSpamList[source] = true
    PZShared.newWaitingThread(PZConfig.security.commands_antispam_cooldown, function()
        antiSpamList[source] = nil
    end)
end

---registerConsoleCommand
---@public
---@return void
PZServer.registerConsoleCommand = function(name, onExecute)
    RegisterCommand(name, function(source, args, cmd)
        if source ~= 0 then
            return
        end
        onExecute(source, args, cmd)
    end, false)
end

---registerCommand
---@public
---@return void
PZServer.registerCommand = function(name, onExecute)
    RegisterCommand(name, function(source, args, cmd)
        if source == 0 then
            return
        end
        if not checkAntiSpam(source) then
            return
        end
        antiSpam(source)
        onExecute(source, args, cmd)
    end, false)
end

---registerRestrictedCommand
---@public
---@return void
PZServer.registerRestrictedCommand = function(name, permission, onExecute, onNoPermissionExecute, allowFromServerConsole)
    RegisterCommand(name, function(source, args, cmd)
        if source == 0 then
            if allowFromServerConsole then
                onExecute(source, args, cmd)
            end
            return
        end
        ---@type PZPlayer
        local player = PZPlayersManager.getPlayer(source)
        local rank = player:getRank()
        if not rank:hasPermission(permission) then
            if onNoPermissionExecute then
                onNoPermissionExecute(source, args)
            else
                player:notify(PZShared.translate("no_permission_command"):format(name))
            end
            return
        end
        if not checkAntiSpam(source) then
            return
        end
        antiSpam(source)
        onExecute(source, args, cmd)
    end)
end