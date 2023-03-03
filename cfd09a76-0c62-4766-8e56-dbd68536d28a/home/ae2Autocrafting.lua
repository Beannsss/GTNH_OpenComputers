local comp = require('component')
local sides = require("sides")
local math = require("math")
local event = require('event')

local saveTable = dofile("saveTable.lua")
local listOfCraftables = saveTable.getTable()

local transposer = comp.transposer
local me = comp.me_interface
local timeToSleep = 5
-- local db = comp.database

-- function exportItem(item)
--   bus.setExportConfiguration(sides.east, db.address, item.slot)
--   for i = 2, 16 do
--     if bus.exportIntoSlot(sides.east, i) then
--       break
--     end
--   end
-- end

local allCraftables = me.getCraftables()

local craftables = {}

local function itemsAreSame(item, item2)
  return item.name == item2.name and item.label == item2.label and item.damage == item2.damage
end

local function requestCraft(item, craftable, cpus)
  for i = 1, #cpus do
      if cpus[i].busy then
        for j, activeItem in ipairs(cpus[i].cpu.activeItems()) do
          if itemsAreSame(item, activeItem) then
            return
          end
        end
        for j, pendingItem in ipairs(cpus[i].cpu.pendingItems()) do
          if itemsAreSame(item, pendingItem) then
            return
          end
        end
      end
  end
  local crafted = craftable.request(item.amountToOrder)
  if crafted.isCanceled() then
    print("FAILED: crafting " .. item.amountToOrder .. " " .. item.label)
  else
    print("SUCCESS: crafting " .. item.amountToOrder .. " " .. item.label)
  end
end

print('initializing ....')

for i, craftable in ipairs(allCraftables) do
  local item = craftable.getItemStack()
  for j, item2 in ipairs(listOfCraftables) do
    if itemsAreSame(item, item2) then
      craftables[item.label .. "|" .. tostring(item.damage)] = craftable
      break
    end
  end
end

print('initialized, crafting...')

for i, craftable in ipairs(craftables) do
  print(craftable.getItemStack().label)
end


repeat
  if comp.redstone.getInput(sides.north) == 15 then
    local itemsInNetwork = me.getItemsInNetwork({ isCraftable = true })
    local cpus = me.getCpus()
    for j, item2 in ipairs(listOfCraftables) do
      for i, item in ipairs(itemsInNetwork) do
        if itemsAreSame(item, item2) then
          if item.size < item2.amtToKeep then
            requestCraft(item2, craftables[item.label .. "|" .. tostring(item.damage)], cpus)
            break
          end
        end
      end
    end
    os.sleep(5)
  end
until event.pull(1) == "interrupted"
