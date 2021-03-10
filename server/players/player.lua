---@class PZPlayer
---@field public id number
---@field public name string
PZPlayer = {}
PZPlayer.__index = Actor

setmetatable(PZPlayer, {
    __call = function(_, src)
        local self = setmetatable({}, PZPlayer)

        self.id = tonumber(src)
        self.name = GetPlayerName(self.id)

        return self
    end
})

---getDimension
---
--- Get current player's dimension
---
---@public
---@return number
function PZPlayer:getDimension()
    return GetPlayerRoutingBucket(self.id)
end

---setDimension
---
--- Set the current player's dimension
---
---@public
---@return number
function PZPlayer:setDimension(dimID)
    SetEntityRoutingBucket(self.id, dimID)
end

---getLicense
---
--- Get the current player's license
---
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


