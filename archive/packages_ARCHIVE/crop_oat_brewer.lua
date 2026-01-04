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
farming.register_plant("beer_test:oats", {
description = "Oat seed",
inventory_image = "beer_test_oats.png",
steps = 8,
minlight = 13,
maxlight = LIGHT_MAX,
fertility = {"grassland"}
})
 minetest.register_craft({
    output = "beer_test:seed_oats",
    recipe = {
        {"beer_test:oats"},
    }
})
]]--
