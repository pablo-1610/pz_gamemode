---@class PZPlayer
---@field public id number
---@field public license string
---@field public rank number
---@field public rolePlayIdentity table
---@field public name string
PZPlayer = {}
PZPlayer.__index = PZPlayer

setmetatable(PZPlayer, {
    __call = function(_, src, license, rank, rolePlayIdentity)
        local self = setmetatable({}, PZPlayer)

        -- Constructor
        self.id = tonumber(src)
        self.license = license
        self.rank = rank
        self.rolePlayIdentity = rolePlayIdentity
        -- Def
        self.name = GetPlayerName(self.id)

        return self
    end
})

--- getId
---@public
---@return number
function PZPlayer:getId()
    return self.id
end

--- getName
---@public
---@return string
function PZPlayer:getName()
    return self.name
end

--- getLicense
---@public
---@return string
function PZPlayer:getLicense()
    return self.license
end

--- getRank
---@public
---@return number
function PZPlayer:getRank()
    return self.rank
end

--- getRolePlayIdentity
---@public
---@return table
function PZPlayer:getRolePlayIdentity()
    return self.rolePlayIdentity
end


--- getDimension
---@public
---@return number
function PZPlayer:getDimension()
    return GetPlayerRoutingBucket(self.id)
end

--- setDimension
---@public
---@return number
function PZPlayer:setDimension(dimID)
    SetEntityRoutingBucket(self.id, dimID)
end

--- getLicense
---@public
---@return string
function PZPlayer:getLicense()
    for k, v in pairs(GetPlayerIdentifiers(self.id)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
    return "err"
end

--- notify
---@public
---@return void
function PZPlayer:notify(str)
    PZ.serverUtils.toClient("notifyPlayer", self.id, str)
end


