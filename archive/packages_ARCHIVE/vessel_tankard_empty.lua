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
minetest.register_node("beer_test:tankard", {
    description = "Tankard",
    stack_max = 16,
    wield_image = "beer_test_tankard.png",
    inventory_image = "beer_test_tankard.png",
    tiles = {"beer_test_tankard_top.png","beer_test_tankard_top.png","beer_test_tankard_side.png",
    "beer_test_tankard_side.png","beer_test_tankard_side.png","beer_test_tankard_side.png"},
    drawtype = "nodebox",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky=3,dig_immediate=3},
    sounds = default.node_sound_tankard_defaults(),
    node_box = {
        type = "fixed",
        fixed = {
            {-0.18, -0.5, 0.125, 0.18, 0.18, 0.18},
            {0.125, -0.5, -0.18, 0.18, 0.18, 0.18},
            {-0.18, -0.5, -0.18, -0.125, 0.18, 0.18},
            {-0.18, -0.5, -0.18, 0.18, 0.18, -0.125},
            {-0.25, -0.5, -0.25, 0.25, -0.44, 0.25},
            {-0.315, -0.3, 0.04, -0.36 , 0.1, -0.05},
            {-0.15, -0.0, 0.04, -0.35 , 0.05, -0.05},
            {-0.15, -0.25, 0.04, -0.35 , -0.2, -0.05},
            -- side , top , side , side , bottom, side,

        },
    },
    selection_box = {
        type = "fixed",
        fixed = {
            --{-0.25, -0.5, -0.25, 0.25, 0.25, 0.25},
            {-0.125, -0.5, -0.125, 0.125, 0.18, 0.125},
            {-0.18, -0.5, -0.18, 0.18, 0.18, 0.18},
            {-0.25, -0.5, -0.25, 0.25, -0.44, 0.25}, -- INNER ONE --
            --{-0.25, -0.5, -0.25, 0.25, -0.125, 0.25},
            {-0.315, -0.3, 0.04, -0.36 , 0.1, -0.05},
            {-0.15, -0.0, 0.04, -0.315 , 0.05, -0.05},
            {-0.15, -0.25, 0.04, -0.315 , -0.2, -0.05},
        },
    },
})
 minetest.register_craft({
    output = "beer_test:tankard",
    recipe = {
        {"default:wood","default:wood", "default:steel_ingot"},
        {"default:steel_ingot","", "default:steel_ingot"},
        {"default:steel_ingot","default:steel_ingot", "default:steel_ingot"},
    }
})
]]--
