local comp = require("component")
local sides = require("sides")

local goNextSlot = false

for i = 2, 16 do
  local exported = component.me_exportbus.exportIntoSlot(sides.east, i)
end