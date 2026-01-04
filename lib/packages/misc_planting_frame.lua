---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_planting_frame = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_planting_frame.init()

    return {
        description = "Planting frame",
        notes = "Used for planting hops seeds. Place the frame on a suitable soil node, then" ..
                " while wielding the seed, punch the frame",
        depends = "item_stick_ordinary",
    }

end

function unilib.pkg.misc_planting_frame.exec()

    local c_stick = "unilib:item_stick_ordinary"

    unilib.register_node("unilib:misc_planting_frame", "beer_test:crop", mode, {
        -- From beer_test:crop
        description = S("Planting Frame"),
        tiles = {"unilib_misc_planting_frame.png"},
        -- N.B. Removed chopspy = 2 from original code
        groups = {flammable = 2, oddly_breakable_by_hand = 3, plant = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "plantlike",
        paramtype = "light",
        paramtype2 = "facedir",
        walkable = false,

        on_punch = function(pos, node, puncher)

            local wielded = puncher:get_wielded_item():get_name()
            if wielded and wielded == "unilib:crop_hops_seed" then

                node.name = "unilib:crop_hops_grow_1"
                core.set_node(pos, node)
                puncher:get_inventory():remove_item("main", ItemStack(wielded))

            elseif wielded and wielded == "unilib:crop_oat_brewer_seed" then

                node.name = "unilib:crop_oat_brewer_grow_1"
                core.set_node(pos, node)
                puncher:get_inventory():remove_item("main", ItemStack(wielded))

            end

        end,
    })
    unilib.register_craft({
        -- From beer_test:crop
        output = "unilib:misc_planting_frame 2",
        recipe = {
            {c_stick, "", c_stick},
            {c_stick, "", c_stick},
        },
    })

end
