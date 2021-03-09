PZ = {}

local function trace(str)
    print("^2[INFOS]^7 "..str)
end
PZ.trace = trace

local function warn(str)
    print("^1[WARN]^7 "..str)
end
PZ.warn = warn

local function debug(str)
    print("^3[DEBUG]^7 "..str)
end
PZ.debug = debug