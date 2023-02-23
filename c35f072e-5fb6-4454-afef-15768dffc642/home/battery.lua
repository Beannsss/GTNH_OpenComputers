local comp = require('component')
local sides = require('sides')
local math = require('math')
local event = require('event')

local rs = comp.redstone
local buffer = comp.gt_batterybuffer
local next_rs = 0
local max = 6400000

function toggleRedstone(on) 
    if on then
        next_rs = rs.setOutput(sides.front, 15)
    else 
        next_rs = rs.setOutput(sides.front, 0)
    end
end

toggleRedstone(true)

repeat
    local bat1 = buffer.getBatteryCharge(1)
    if bat1 / max > .98 then
        toggleRedstone(false)
    elseif bat1 / max < .5 then
        toggleRedstone(true)
    end
until event.pull(1) == "interrupted" -- # change 1 to something smaller to refresh faster
