---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_grain_malt_normal = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_grain_malt_normal.init()

    return {
        description = "Normal malt grain",
        depends = "misc_tray_brewer",
    }

end

function unilib.pkg.ingredient_grain_malt_normal.exec()

    unilib.register_craftitem(
        -- From beer_test:malt_grain_malt
        "unilib:ingredient_grain_malt_normal",
        "beer_test:malt_grain_malt",
        mode,
        {
            description = S("Normal Malt Grain"),
            inventory_image = "unilib_ingredient_grain_malt_normal.png",
        }
    )
    unilib.register_craft({
        -- From beer_test:malt_grain_malt
        type = "shapeless",
        output = "unilib:ingredient_grain_malt_normal",
        recipe = {"unilib:misc_tray_brewer_malt_normal"},
        replacements = {
            {"unilib:misc_tray_brewer_malt_normal", "unilib:misc_tray_brewer_empty"},
        },
    })

end
