---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
function default.node_sound_barrel_defaults(table)
    table = table or {}
    table.footstep = table.footstep or
            {name="default_wood_footstep", gain=0.5}
    table.dug = table.dug or
            {name="beertest_break_barrle", gain=1.0}
    default.node_sound_defaults(table)
    return table
end

function default.node_sound_tankard_defaults(table)
    table = table or {}
    table.footstep = table.footstep or
            {name="default_wood_footstep", gain=0.5}
    table.dug = table.dug or
            {name="beertest_break_tankard", gain=1.0}
    table.place = table.place or
            {name="beertest_place_tankard", gain=1.0}
    default.node_sound_defaults(table)
    return table
end
]]--
