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
minetest.register_craftitem("beer_test:malt_grain_black_malt", {
    description = "Black Malt Grain",
    inventory_image = "beer_test_black_malt.png",
})
 minetest.register_craft({
    type = "shapeless",
    output = "beer_test:malt_grain_black_malt",
    recipe = {"beer_test:malt_tray_black_malt"},
    replacements = {
        {"beer_test:malt_tray_black_malt", "beer_test:tray"}
    }
})
]]--
