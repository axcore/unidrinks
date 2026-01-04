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
minetest.register_craftitem("beer_test:oat_grain", {
    description = "Oat Grain",
    inventory_image = "beer_test_oat_grain.png",
})
minetest.register_craft({
    type = "cooking",
    output = "beer_test:oat_grain",
    recipe = "beer_test:oats",
})
]]--
