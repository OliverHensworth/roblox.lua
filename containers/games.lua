local request = require "coro-http".request
local decode = require "json".decode
local endpoints = require "../endpoints"
local format = string.format

local api = {}

return function(id, callback)
    if type(id) ~= "number" then return error(id.." is not a number.") end
    if math.floor(id) ~= id then return error(id.." is not a full number. No decimals.") end
    local info = {}
    
    coroutine.wrap(function()
        local _,body = request("GET", format(endpoints.gameInfo, id))

        local info = decode(body)

        callback(info)
    end)()
end
