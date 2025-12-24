---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
wine:add_drink("wine", "Wine", true, 2, 5, 1)

wine:add_item({
    {"farming:grapes", "wine:glass_wine"},
})

-- quick override to add wine to food group
minetest.override_item("wine:glass_wine", {
    groups = {
        food_wine = 1, vessel = 1, dig_immediate = 3,
        attached_node = 1, alcohol = 1, drink = 1
    }
})
]]--
