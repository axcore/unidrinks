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
minetest.register_craftitem("beer_test:mixed_beer_grain", {
    description = "Mixed Beer Grain",
    inventory_image = "beer_test_mixed_malt.png",
})
minetest.register_craft({
    output = "beer_test:mixed_beer_grain",
    type = "shapeless",
    recipe = {"beer_test:malt_grain_malt","beer_test:malt_grain_crystalised_malt","beer_test:malt_grain_black_malt","beer_test:hops_dried_2","beer_test:hops_dried_2","beer_test:hops_dried_2"},
    replacements = {
        {"beer_test:malt_tray_malt", "beer_test:tray"},
    }
})
]]--
