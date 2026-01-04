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
minetest.register_node("beer_test:growing_rope", {
    description = "Growing Suspension rope",
    drawtype = "nodebox",
    tiles = {"beer_test_rope.png", "beer_test_rope.png", "beer_test_rope_side.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    is_ground_content = true,
    walkable = false,
    groups = {cracky=2},
    sounds = default.node_sound_wood_defaults(),
    node_box = {
            type = "fixed",
            fixed = {
                {-0.08, -0.08, -0.85, 0.08, 0.08, 0.85}, -- side f
                --{-0.1, -0.5, -0.1, 0.1, 0.7, 0.1}, -- floor

            },
        },
        selection_box = {
        type = "fixed",
        fixed = {
            {-0.15, -0.15, -0.85, 0.15, 0.15, 0.85}, -- side f
        },
    },
        on_punch = function(pos, node, puncher)
            local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "beer_test:growing_rope_down" then
                node.name = "beer_test:growing_rope_1"
                minetest.env:set_node(pos, node)
                puncher:get_inventory():remove_item("main", ItemStack("beer_test:growing_rope_down"))
            end
        end
    })
 minetest.register_craft({
    output = "beer_test:growing_rope",
    recipe = {
        {"farming:cotton","farming:cotton", "farming:cotton"},
    }
})
 minetest.register_craft({
    output = "beer_test:growing_rope",
    recipe = {
        {"farming:cotton","farming:cotton", "farming:cotton"},
        {"default:stick","",""},
    }
})

    minetest.register_node("beer_test:growing_rope_down", {
    description = "Growing rope",
    drawtype = "nodebox",
    tiles = {"beer_test_rope.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    is_ground_content = true,
    walkable = false,
    groups = {cracky=2},
    sounds = default.node_sound_wood_defaults(),
    node_box = {
            type = "fixed",
            fixed = {
                --{-0.1, -0.1, -0.9, 0.1, 0.1, 0.9}, -- side f
                {-0.06, -0.5, -0.06, 0.06, 0.5, 0.06}, -- floor

            },
        },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1}, -- side f
        },
    },

    })
 minetest.register_craft({
    output = "beer_test:growing_rope_down",
    recipe = {
        {"farming:cotton"},
        {"farming:cotton"},
        {"farming:cotton"},
    }
})
 minetest.register_craft({
    output = "beer_test:growing_rope_down",
    recipe = {
        {"","farming:cotton"},
        {"","farming:cotton"},
        {"default:stick","farming:cotton"},
    }
})

minetest.register_node("beer_test:growing_rope_1", {
    description = "Growing rope",
    drawtype = "nodebox",
    tiles = {"beer_test_rope.png","beer_test_rope.png","beer_test_rope_side.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    is_ground_content = true,
    walkable = false,
    groups = {cracky=2},
    sounds = default.node_sound_wood_defaults(),
    drop = {
        max_items = 2,
        items = {
            { items = {'beer_test:growing_rope_down'} },
            {items = {'beer_test:growing_rope'} },
        }
    },
    node_box = {
            type = "fixed",
            fixed = {
                {-0.08, -0.08, -0.5, 0.08, 0.08, 0.5}, -- side f
                {-0.06, -0.5, -0.06, 0.06, 0.06, 0.06}, -- floor
                {-0.12, -0.12, -0.12, 0.12, 0.12, 0.12}, -- floor

            },
        },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.12, -0.5, -0.12, 0.12, 0.12, 0.12}, -- side f
        },
    },
    })
]]--
