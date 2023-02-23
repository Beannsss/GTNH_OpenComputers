local comp = require('component')
local sides = require('sides')
local math = require('math')
local event = require('event')

local rs = comp.redstone
local buffer = comp.gt_batterybuffer
local next_rs = 0
local number_of_bats = 8
local side = sides.front

function toggleRedstone(on) 
    if on then
        next_rs = rs.setOutput(side, 15)
    else 
        next_rs = rs.setOutput(side, 0)
    end
end

function getTotalPower()
    local totalPower = 0
    for i = 1, number_of_bats do
        totalPower = totalPower + buffer.getMaxBatteryCharge(i)
    end
    return totalPower
end

function getCurrentPower()
    local totalPower = 0
    for i = 1, number_of_bats do
        totalPower = totalPower + buffer.getBatteryCharge(i)
    end
    return totalPower
end

toggleRedstone(true)
local max = getTotalPower()

repeat
    local bat1 = getCurrentPower()
    if bat1 / max > .8 then
        toggleRedstone(false)
    elseif bat1 / max < .3 then
        toggleRedstone(true)
    end
until event.pull(5) == "interrupted" -- # change 1 to something smaller to refresh faster
