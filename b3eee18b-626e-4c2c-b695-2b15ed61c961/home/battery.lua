local comp = require('component')
local sides = require('sides')
local math = require('math')
local event = require('event')

local rs = comp.redstone
local buffer = comp.gt_machine
local next_rs = 0

function toggleRedstone(on) 
    if on then
        next_rs = rs.setOutput(sides.front, 15)
    else 
        next_rs = rs.setOutput(sides.front, 0)
    end
end

function getTotalPower()
    return buffer.getEUCapacity()
end

function getCurrentPower()
    return buffer.getEUStored()
end

toggleRedstone(true)
local max = getTotalPower()

repeat
    local bat1 = getCurrentPower()
    print(bat1 / max )
    if bat1 / max > .95 then
        toggleRedstone(false)
    elseif bat1 / max < .25 then
        toggleRedstone(true)
    end
until event.pull(1) == "interrupted" -- # change 1 to something smaller to refresh faster
