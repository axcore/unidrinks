---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.rope_brewer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.rope_brewer.init()

    return {
        description = "Brewer's ropes",
        notes = "Used to grow hops (see the instructions in the \"crop_hops\" package). To set" ..
                " up the ropes, first place two fence towers, 5 blocks high. In the gap between" ..
                " them, place suspension ropes. While wielding cultivation ropes, punch the" ..
                " suspension ropes, which places a knotted rope; beneath the knotted ropes," ..
                " place 3 more cultivation ropes",
        depends = "crop_cotton",
        optional = "item_stick_ordinary",
    }

end

function unilib.pkg.rope_brewer.exec()

    local c_cotton = "unilib:crop_cotton_harvest"

    unilib.register_node("unilib:rope_brewer_suspension", "beer_test:growing_rope", mode, {
        -- From beer_test:growing_rope
        description = S("Brewer's Suspension Rope"),
        tiles = {"unilib_rope_brewer.png", "unilib_rope_brewer.png", "unilib_rope_brewer_side.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        -- N.B. Tweaked the size of the rope so that there are no gaps between adjacent ropes, when
        --      place between fence towers (as described above)
        node_box = {
            type = "fixed",
            fixed = {
--              {-0.08, -0.08, -0.85, 0.08, 0.08, 0.85},
                {-0.08, -0.08, -1, 0.08, 0.08, 1},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        -- N.B. ...and also tweaked the selection box, so that adjacent ropes are easier to place
        selection_box = {
            type = "fixed",
            fixed = {
--              {-0.15, -0.15, -0.85, 0.15, 0.15, 0.85},
                {-0.15, -0.15, -0.5, 0.15, 0.15, 0.5},
            },
        },
        walkable = false,

        on_punch = function(pos, node, puncher)

            -- While wielding a cultivation rope, punch a suspension rope to get a knotted rope
            local wielded = puncher:get_wielded_item():get_name()
            if wielded and wielded == "unilib:rope_brewer_cultivation" then

                node.name = "unilib:rope_brewer_knotted"
                core.set_node(pos, node)
                puncher:get_inventory():remove_item("main", ItemStack(wielded))

            end

        end,
    })
    if unilib.global.pkg_executed_table["item_stick_ordinary"] == nil then

        unilib.register_craft({
            -- From beer_test:growing_rope
            output = "beer_test:growing_rope",
            recipe = {
                {c_cotton, c_cotton, c_cotton},
            },
        })

    else

        unilib.register_craft({
            -- From beer_test:growing_rope
            output = "beer_test:growing_rope",
            recipe = {
                {c_cotton, c_cotton, c_cotton},
                {"unilib:item_stick_ordinary", "", ""},
            },
        })

    end

    unilib.register_node("unilib:rope_brewer_cultivation", "beer_test:growing_rope_down", mode, {
        -- From beer_test:growing_rope_down
        description = S("Brewer's Cultivation Rope"),
        tiles = {"unilib_rope_brewer.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.06, -0.5, -0.06, 0.06, 0.5, 0.06},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
            },
        },
        walkable = false,
    })
    if unilib.global.pkg_executed_table["item_stick_ordinary"] == nil then

        unilib.register_craft({
            -- From beer_test:growing_rope_down
            output = "unilib:rope_brewer_cultivation",
            recipe = {
                {c_cotton},
                {c_cotton},
                {c_cotton},
            },
        })

    else

        unilib.register_craft({
            -- From beer_test:growing_rope_down
            output = "unilib:rope_brewer_cultivation",
            recipe = {
                {"", c_cotton},
                {"", c_cotton},
                {"unilib:item_stick_ordinary", c_cotton},
            }
        })

    end

    unilib.register_node("unilib:rope_brewer_knotted", "beer_test:growing_rope_1", mode, {
        -- From beer_test:growing_rope_1
        description = S("Knotted Brewer's Rope"),
        tiles = {"unilib_rope_brewer.png", "unilib_rope_brewer.png", "unilib_rope_brewer_side.png"},
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        drop = {
            max_items = 2,
            items = {
                {items = {"unilib:rope_brewer_cultivation"}},
                {items = {"unilib:rope_brewer_suspension"}},
            },
        },
        -- N.B. Tweaked size of the knotted rope, to match the tweaked suspension rope
        node_box = {
            type = "fixed",
            fixed = {
--              {-0.08, -0.08, -0.5, 0.08, 0.08, 0.5},
                {-0.08, -0.08, -1, 0.08, 0.08, 1},
                {-0.06, -0.5, -0.06, 0.06, 0.06, 0.06},
                {-0.12, -0.12, -0.12, 0.12, 0.12, 0.12},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.12, -0.5, -0.12, 0.12, 0.12, 0.12},
            },
        },
        walkable = false,
    })

end
