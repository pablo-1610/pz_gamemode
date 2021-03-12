---@class PZRank
---@field public id number
---@field public identifier string
---@field public display string
---@field public color table
---@field public permissions table
PZRank = {}
PZRank.__index = PZRank

setmetatable(PZRank, {
    __call = function(_, id, identifier, display, color, permissions)
        local self = setmetatable({}, PZRank)

        -- Constructor
        self.id = id
        self.identifier = identifier
        self.display = display
        self.color = color
        self.permissions = permissions

        return self
    end
})

---getPermissions
---@public
---@return table
function PZRank:getPermissions()
    return self.permissions
end

---hasPermission
---@public
---@return boolean
---@param permissionToCheck string
function PZRank:hasPermission(permissionToCheck)
    for k, v in pairs(self:getPermissions()) do
        if permissionToCheck == v then
            return true
        end
    end
    return false
end

---hasPermissions
---@public
---@return boolean
---@param permissionsToCheck table
function PZRank:hasPermissions(permissionsToCheck)
    local matchingAllowedPermissions = 0
    local matchingAllowedPermissionsToReach = #permissionsToCheck
    if type(permissionsToCheck) ~= "table" then return end
    for k, rankPerms in pairs(self:getPermissions()) do
        for _,permToCheck in pairs(permissionsToCheck) do
            rankPerms = permissionsToCheck
            matchingAllowedPermissions = matchingAllowedPermissions + 1
        end
    end
    return matchingAllowedPermissions == matchingAllowedPermissionsToReach
 end