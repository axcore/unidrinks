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
minetest.register_node("beer_test:crop", {
    description = "Crop",
    paramtype = "light",
    walkable = false,
    drawtype = "plantlike",
    paramtype2 = "facedir",
    tiles = {"beer_test_crop.png"},
    groups = {chopspy=2, oddly_breakable_by_hand=3, flammable=2, plant=1},
    sounds = default.node_sound_wood_defaults(),

    on_punch = function(pos, node, puncher)
        local tool = puncher:get_wielded_item():get_name()
        if tool and tool == "beer_test:seed_hops" then
            node.name = "beer_test:hops_1"
            minetest.env:set_node(pos, node)
            puncher:get_inventory():remove_item("main", ItemStack("beer_test:seed_hops"))
        end

        local tool = puncher:get_wielded_item():get_name()
        if tool and tool == "beer_test:seed_oats" then
            node.name = "beer_test:oats_1"
            minetest.env:set_node(pos, node)
            puncher:get_inventory():remove_item("main", ItemStack("beer_test:seed_oats"))

        end
    end
})
minetest.register_craft({
    output = "beer_test:crop 2",
    recipe = {
        {"default:stick","", "default:stick"},
        {"default:stick","", "default:stick"},
    }
})
]]--
