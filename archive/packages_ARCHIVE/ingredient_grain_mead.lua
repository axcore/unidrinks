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
minetest.register_craftitem("beer_test:mixed_mead_grain", {
    description = "Mixed Apple Mead Grain",
    inventory_image = "beer_test_mixed_mead.png",
})
    minetest.register_craft({
        output = "beer_test:mixed_mead_grain",
        type = "shapeless",
        recipe = {"default:apple","default:apple","default:apple","default:apple","beer_test:yeast","beer_test:sugar","beer_test:sugar","beer_test:sugar","beer_test:sugar"},
    })
]]--
