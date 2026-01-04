---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_hops_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_hops_wild.init()

    return {
        description = "Wild hops plant",
        depends = "crop_hops",
    }

end

function unilib.pkg.plant_hops_wild.exec()

    unilib.register_node("unilib:plant_hops_wild", "beer_test:wild_hops", mode, {
        -- From beer_test:wild_hops
        description = S("Wild Hops"),
        tiles = {"unilib_crop_hops_grow_8.png"},
        -- N.B. Removed chopspy = 2 from original code
        groups = {flammable = 2, oddly_breakable_by_hand = 3, plant = 1},
        sounds = unilib.global.sound_table.wood,

        buildable_to = true,
        drawtype = "nodebox",
        drop = "unilib:crop_hops_seed",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2},
                {-0.3, -0.5, 0.2, 0.3, 0.5, 0.2},
                {-0.3, -0.5, -0.2, 0.3, 0.5, -0.2},
                {-0.2, -0.5, 0.3, -0.2, 0.5, -0.3},
                {0.2, -0.5, 0.3, 0.2, 0.5, -0.3},
                {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
            },
        },
        walkable = false,
    })

end
