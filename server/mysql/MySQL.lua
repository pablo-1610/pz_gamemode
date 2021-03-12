---@class PZDb
PZDb = {}

local queriesPerSecond = 0

local function incrementQueriesPerSecond()
    queriesPerSecond = queriesPerSecond + 1
end

PZShared.newRepeatingTask(function()
    queriesPerSecond = 0
end, function()

end, 0, 1000)

RegisterCommand("qps", function(source)
    if source ~= 0 then return end
    PZShared.trace(("Actuals Q.P.S: %i"):format(queriesPerSecond))
end)

local function safeParameters(params)
    if nil == params then
        return {[''] = ''}
    end

    assert(type(params) == "table", "A table is expected")

    if next(params) == nil then
        return {[''] = ''}
    end

    return params
end

---SyncFetchAll
---@public
---@param query string
---@param params table
---@return table
PZDb.SyncFetchAll = function(query, params, func)
    incrementQueriesPerSecond()
    assert(type(query) == "string" or type(query) == "number", "The SQL Query must be a string")

    local res = {}
    local finishedQuery = false
    exports['pz_gamemode']:mysql_fetch_all(query, safeParameters(params), function (result)
        res = result
        finishedQuery = true
    end)
    repeat Citizen.Wait(0) until finishedQuery == true
    return res
end

---SyncExecute
---@public
---@param query string
---@param params table
---@return table
PZDb.SyncExecute = function(query, params)
    incrementQueriesPerSecond()
    assert(type(query) == "string" or type(query) == "number", "The SQL Query must be a string")

    local res = 0
    local finishedQuery = false
    exports['pz_gamemode']:mysql_execute(query, safeParameters(params), function (result)
        res = result
        finishedQuery = true
    end)
    repeat Citizen.Wait(0) until finishedQuery == true
    return res
end

---SyncInsert
---@public
---@param query string
---@param params table
---@return table
PZDb.SyncInsert = function(query, params)
    incrementQueriesPerSecond()
    assert(type(query) == "string" or type(query) == "number", "The SQL Query must be a string")

    local res = 0
    local finishedQuery = false
    exports['pz_gamemode']:mysql_insert(query, safeParameters(params), function (result)
        res = result
        finishedQuery = true
    end)
    repeat Citizen.Wait(0) until finishedQuery == true
    return res
end

-- Async

---AsyncFetchAll
---@public
---@param query string
---@param params table
---@return table
PZDb.AsyncFetchAll = function(query, params, func)
    incrementQueriesPerSecond()
    PZShared.debug("Fetchall")
    assert(type(query) == "string" or type(query) == "number", "The SQL Query must be a string")
    exports['pz_gamemode']:mysql_fetch_all(query, safeParameters(params), func)
end

---AsyncExecute
---@public
---@param query string
---@param params table
---@return table
PZDb.AsyncExecute = function(query, params)
    incrementQueriesPerSecond()
    assert(type(query) == "string" or type(query) == "number", "The SQL Query must be a string")
    exports['pz_gamemode']:mysql_execute(query, safeParameters(params), func)
end

---AsyncInsert
---@public
---@param query string
---@param params table
---@return table
PZDb.AsyncInsert = function(query, params)
    incrementQueriesPerSecond()
    assert(type(query) == "string" or type(query) == "number", "The SQL Query must be a string")
    exports['pz_gamemode']:mysql_insert(query, safeParameters(params), func)
end
