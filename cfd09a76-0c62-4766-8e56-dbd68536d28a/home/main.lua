local saveTable = dofile("saveTable.lua")
local comp = require('component')
local json = require "json"

-- saveTable.initTable()

local me = comp.me_interface

for i, item in ipairs(me.getCraftables()) do
    if string.find(item.getItemStack().name, "ae2fc") then
        print(json.encode(item.getItemStack()))
        os.sleep(5)
    end
end