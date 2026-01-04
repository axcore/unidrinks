---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_oat_brewer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_oat_brewer.init()

    return {
        description = "Brewer's oats",
        notes = "Grows only on ordinary soil",
    }

end

function unilib.pkg.crop_oat_brewer.exec()

    -- N.B. "grassland" in original code
    local fertility_list = {"ordinary_soil"}

    local orig_name_list = {}
    for i = 1, 8 do
        table.insert(orig_name_list, "beer_test:oats_" .. i)
    end

    unilib.register_crop_fredo({
        -- From beer_test:oats (creates unilib:crop_oat_brewer_harvest), beer_test:seed_oats
        --      (creates unilib:crop_oat_brewer_seed), beer_test:oats_1 etc (creates
        --      unilib:crop_oat_brewer_grow_1 etc)
        part_name = "oat_brewer",
        grow_orig_name = orig_name_list,
        harvest_orig_name = "beer_test:oats",
        seed_orig_name = "beer_test:seed_oats",
        steps = 8,

        replace_mode = mode,
        fertility_list = fertility_list,
        grow_list = nil,
        harvest_description = S("Brewer's Oats"),
        harvest_group_table = nil,
        min_light = 13,
        seed_description = S("Brewer's Oats Seed"),
    })
    unilib.register_craft({
        -- From beer_test:seed_oats
        output = "unilib:crop_oat_brewer_seed",
        recipe = {
            {"unilib:crop_oat_brewer_harvest"},
        },
    })

end
