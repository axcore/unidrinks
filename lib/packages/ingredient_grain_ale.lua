---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_grain_ale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_grain_ale.init()

    return {
        description = "Mixed ale grain",
        depends = {
            "crop_oat_brewer",
            "ingredient_grain_malt_black",
            "ingredient_grain_malt_crystallised",
            "ingredient_grain_malt_normal",
            "ingredient_yeast_ale",
        },
    }

end

function unilib.pkg.ingredient_grain_ale.exec()

    unilib.register_craftitem("unilib:ingredient_grain_ale", "beer_test:mixed_ale_grain", mode, {
        -- From beer_test:mixed_ale_grain
        description = S("Mixed Ale Grain"),
        inventory_image = "unilib_ingredient_grain_ale.png",
    })
    unilib.register_craft({
        -- From beer_test:mixed_ale_grain
        type = "shapeless",
        output = "unilib:ingredient_grain_ale",
        recipe = {
            "unilib:ingredient_grain_malt_normal",
            "unilib:ingredient_grain_malt_crystallised",
            "unilib:ingredient_grain_malt_black",
            "unilib:ingredient_yeast_ale",
            "unilib:crop_oat_brewer_harvest",
            "unilib:crop_oat_brewer_harvest",
        },
    })

end
