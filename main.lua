local request = require "coro-http".request
local decode = require "json".decode
local endpoints = require "./endpoints"
local format = string.format

local api = {}
local groupObject = {}

--group functions
function api:getGroup(id, callback)
    if type(id) ~= "number" then return error(id.." is not a number.") end
    if math.floor(id) ~= id then return error(id.." is not a full number. No decimals.") end

    coroutine.wrap(function()
        local _,body = request("GET", format(endpoints.groupInfo, id))
        local info = decode(body)

        callback(info)
    end)()
end

--user functions
function api:getNameFromId(id, callback)
    if type(id) ~= "number" then return error(id.." is not a number.") end
    if math.floor(id) ~= id then return error(id.." is not a full number. No decimals.") end

    coroutine.wrap(function()
        local _,body = request("GET", format(endpoints.userId, id))
        local info = decode(body).Username

        callback(info)
    end)()
end

function api:getIdFromName(name, callback)
    if type(name) ~= "string" then return error(name.." is not a string.") end

    coroutine.wrap(function()
        local _,body = request("GET", format(endpoints.username, name))
        local info = decode(body).Id

        callback(info)
    end)()
end

return api
