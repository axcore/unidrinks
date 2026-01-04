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
minetest.register_craftitem("beer_test:malt_grain_malt", {
    description = "Malt Grain",
    inventory_image = "beer_test_malt.png",
})
 minetest.register_craft({
    type = "shapeless",
    output = "beer_test:malt_grain_malt",
    recipe = {"beer_test:malt_tray_malt"},
    replacements = {
    {"beer_test:malt_tray_malt", "beer_test:tray"}
   }
})
]]--
