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
minetest.register_node("beer_test:barrel", {
    description = "Barrel",
    drawtype = "nodebox",
    tiles = {"beer_test_barrel_top.png", "beer_test_barrel_top.png", "beer_test_barrel_side_2.png",
    "beer_test_barrel_side_2.png", "beer_test_barrel_side_2.png", "beer_test_barrel_side_2.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky=2},
    sounds = default.node_sound_wood_defaults(),
    on_punch = function(pos, node, puncher)
        local tool = puncher:get_wielded_item():get_name()
        if tool and tool == "beer_test:mixed_beer_grain" then
            node.name = "beer_test:barrel_mixed_beer_grain"
            minetest.env:set_node(pos, node)
            puncher:get_inventory():remove_item("main", ItemStack("beer_test:mixed_beer_grain"))
        end

        local tool = puncher:get_wielded_item():get_name()
        if tool and tool == "beer_test:mixed_ale_grain" then
            node.name = "beer_test:barrel_mixed_ale_grain"
            minetest.env:set_node(pos, node)
            puncher:get_inventory():remove_item("main", ItemStack("beer_test:mixed_ale_grain"))

        end

        local tool = puncher:get_wielded_item():get_name()
        if tool and tool == "beer_test:mixed_mead_grain" then
            node.name = "beer_test:barrel_mixed_mead_grain"
            minetest.env:set_node(pos, node)
            puncher:get_inventory():remove_item("main", ItemStack("beer_test:mixed_mead_grain"))

        end
    end,
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("infotext", "Barrel")
    end,
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.5, 0.5, 0.5, 0.35}, -- side f
            {-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}, -- bottom
            {-0.5, -0.5, -0.5, -0.35, 0.5, 0.5}, -- side l
            {0.35, -0.5, -0.5, 0.5, 0.5, 0.5},  -- side r
            {-0.5, -0.5, -0.35, 0.5, 0.5, -0.5}, -- frount

        },
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
        },
    },

})
 minetest.register_craft({
    output = "beer_test:barrel 6",
    recipe = {
        {"default:wood","default:wood", "default:wood"},
        {"default:steel_ingot","default:steel_ingot", "default:steel_ingot"},
        {"default:wood","default:wood", "default:wood"},
    }
})
]]--
