local comp = require("component")
local sides = require("sides")
local saveTable = dofile("saveTable.lua")
local table = require("table")
local shell = require("shell")

local args, ops = shell.parse(...)
local item = comp.inventory_controller.getAllStacks(sides.east).getAll()[1]
local items = saveTable.getTable()

-- for i = 1, 81 do
    -- if db.get(i) == nil then
local newItem = {}
newItem.name = item.name
newItem.damage = item.damage
newItem.label = item.label
-- newItem.prettyName = args[1]
newItem.amtToKeep = math.floor(tonumber(args[1]))
newItem.amountToOrder = math.floor(tonumber(args[2]))

table.insert(items, newItem)
saveTable.saveTable(items)
comp.transposer.transferItem(sides.up, sides.west, 64, 2)
--    end
-- end

return saveTable.getTable()