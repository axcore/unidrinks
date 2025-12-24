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
wine:add_drink("brandy", "Brandy", true, 3, 4, 1)

minetest.register_craft({
    type = "cooking",
    cooktime = 15,
    output = "wine:glass_brandy",
    recipe = "wine:glass_wine"
})

-- quick override to add brandy to food group
minetest.override_item("wine:glass_brandy", {
    groups = {
        food_brandy = 1, vessel = 1, dig_immediate = 3,
        attached_node = 1, alcohol = 1, drink = 1
    }
})
]]--
