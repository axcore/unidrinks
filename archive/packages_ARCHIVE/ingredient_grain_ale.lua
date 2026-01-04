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
minetest.register_craftitem("beer_test:mixed_ale_grain", {
    description = "Mixed Ale Grain",
    inventory_image = "beer_test_mixed_ale.png",
})
minetest.register_craft({
    output = "beer_test:mixed_ale_grain",
    type = "shapeless",
    recipe = {"beer_test:malt_grain_malt","beer_test:malt_grain_crystalised_malt","beer_test:malt_grain_black_malt","beer_test:yeast","beer_test:oats","beer_test:oats"},
})
]]--
