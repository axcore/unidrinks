---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_grain_oat = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_grain_oat.init()

    return {
        description = "Oat grain",
        depends = "crop_oat_brewer",
    }

end

function unilib.pkg.ingredient_grain_oat.exec()

    unilib.register_craftitem("unilib:ingredient_grain_oat", "beer_test:oat_grain", mode, {
        -- From beer_test:oat_grain
        description = S("Oat Grain"),
        inventory_image = "unilib_ingredient_grain_oat.png",
    })
    unilib.register_craft({
        -- From beer_test:oat_grain
        type = "cooking",
        output = "unilib:ingredient_grain_oat",
        recipe = "unilib:crop_oat_brewer_harvest",
    })

end
