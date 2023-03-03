local funcs = {}
json = require "json"
-- listOfFluids = dofile("config.lua")

function funcs.saveTable(table)
    local test = assert(io.open("listOfItems.json", "w"))
    local result = json.encode(table)
    test:write(result)
    test:close()
end

function funcs.getTable()
    local test = io.open("listOfItems.json", "r")
    local readjson = test:read("*a")
    print(readjson)
    local table = json.decode(readjson)
    test:close()
    return table
end

function funcs.initTable()
    local listOfItems = dofile("config.lua")
    local test = assert(io.open("listOfItems.json", "w"))
    local result = json.encode(listOfItems)
    test:write(result)
    test:close()
end

return funcs