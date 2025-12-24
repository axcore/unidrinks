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
minetest.register_craftitem("wine:agave_syrup", {
    description = S("Agave Syrup"),
    inventory_image = "wine_agave_syrup.png",
    groups = {food_sugar = 1, vessel = 1, flammable = 3}
})
minetest.register_craft({
    type = "cooking",
    cooktime = 7,
    output = "wine:agave_syrup 2",
    recipe = "wine:blue_agave"
})
]]--
