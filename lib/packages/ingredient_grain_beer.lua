---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_grain_beer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_grain_beer.init()

    return {
        description = "Mixed beer grain",
        depends = {
            "crop_hops",
            "ingredient_grain_malt_black",
            "ingredient_grain_malt_crystallised",
            "ingredient_grain_malt_normal",
        },
    }

end

function unilib.pkg.ingredient_grain_beer.exec()

    unilib.register_craftitem("unilib:ingredient_grain_beer", "beer_test:mixed_beer_grain", mode, {
        -- From beer_test:mixed_beer_grain
        description = S("Mixed Beer Grain"),
        inventory_image = "unilib_ingredient_grain_beer.png",
    })
    unilib.register_craft({
        -- From beer_test:mixed_beer_grain
        type = "shapeless",
        output = "unilib:ingredient_grain_beer",
        recipe = {
            "unilib:ingredient_grain_malt_normal",
            "unilib:ingredient_grain_malt_crystallised",
            "unilib:ingredient_grain_malt_black",
            "unilib:crop_hops_harvest_dried",
            "unilib:crop_hops_harvest_dried",
            "unilib:crop_hops_harvest_dried",
        },
        replacements = {
            {"unilib:misc_tray_brewer_malt_normal", "unilib:misc_tray_brewer_empty"},
        },
    })

end
