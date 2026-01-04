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
minetest.register_node("beer_test:wild_hops", {
drawtype = "nodebox",
description = "Wild hops",
    tiles = {"beer_test_hops_8.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drop = "beer_test:seed_hops",
    is_ground_content = true,
    walkable = false,
    buildable_to = true,
    groups = {chopspy=2, oddly_breakable_by_hand=3, flammable=2, plant=1},
    --light_source = LIGHT_MAX-1,
    sounds = default.node_sound_wood_defaults(),
    node_box = {
            type = "fixed",
            fixed = {
                {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}, -- side f
                {-0.3, -0.5, 0.2, 0.3, 0.5, 0.2}, -- side f
                {-0.3, -0.5, -0.2, 0.3, 0.5, -0.2}, -- side f
                {-0.2, -0.5, 0.3, -0.2, 0.5, -0.3}, -- side f
                {0.2, -0.5, 0.3, 0.2, 0.5, -0.3}, -- side f
                {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1}, -- side f

            },
        },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}, -- side f
        },
    },

})
]]--
