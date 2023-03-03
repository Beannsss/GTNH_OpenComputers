local comp = require("component")
local tps = component.list("transposer")
local sides = require('sides')
local empty = false

repeat 
for address, name in tps do
   comp.proxy(address).transferItem(sides.bottom, sides.north)
end

empty = true
for i, item in ipairs(comp.transposer.getAllStacks(sides.bottom).getAll()) do
  if item.name then
    empty = false
  end
end
until empty == true