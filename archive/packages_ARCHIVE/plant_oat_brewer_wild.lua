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
minetest.register_node("beer_test:wild_oats", {
    description = "Wild Oats",
    paramtype = "light",
    walkable = false,
    drop = "beer_test:seed_oats",
    drawtype = "plantlike",
    paramtype2 = "facedir",
    tiles = {"beer_test_oats_8.png"},
    groups = {chopspy=2, oddly_breakable_by_hand=3, flammable=2, plant=1},
    sounds = default.node_sound_wood_defaults(),
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}, -- side f
        },
    },
})
]]--
