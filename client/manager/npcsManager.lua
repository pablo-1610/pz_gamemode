---@class PZNpcsManager
PZNpcsManager = {}

local density = PZConfig.base.defaultDensity

---setDensity
---@public
---@return void
---@param newDensity number
PZNpcsManager.setDensity = function(newDensity)
    PZShared.debug(("Density is now -> %f"):format(newDensity))
    density = newDensity
end

PZShared.newRepeatingTask(function()
    SetPedDensityMultiplierThisFrame(density)
    SetAmbientVehicleRangeMultiplierThisFrame(density)
    SetParkedVehicleDensityMultiplierThisFrame(density)
    SetRandomVehicleDensityMultiplierThisFrame(density)
    SetVehicleDensityMultiplierThisFrame(density)
end, function()

end, 0, 1)