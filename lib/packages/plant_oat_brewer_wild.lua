---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_oat_brewer_wild = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_oat_brewer_wild.init()

    return {
        description = "Wild brewer's oats plant",
        depends = "crop_oat_brewer",
    }

end

function unilib.pkg.plant_oat_brewer_wild.exec()

    unilib.register_node("unilib:plant_oat_brewer_wild", "beer_test:wild_oats", mode, {
        -- From beer_test:wild_oats
        description = S("Wild Brewer's Oats"),
        tiles = {"unilib_crop_oat_brewer_grow_8.png"},
        -- N.B. Removed chopspy = 2 from original code
        groups = {flammable = 2, oddly_breakable_by_hand = 3, plant = 1},
        sounds = unilib.global.sound_table.wood,

        drawtype = "plantlike",
        drop = "unilib:crop_oat_brewer_seed",
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, -0.35, 0.5},
            },
        },
        walkable = false,
    })

end
