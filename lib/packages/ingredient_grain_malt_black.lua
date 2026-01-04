---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_grain_malt_black = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_grain_malt_black.init()

    return {
        description = "Black malt grain",
        depends = "misc_tray_brewer",
    }

end

function unilib.pkg.ingredient_grain_malt_black.exec()

    unilib.register_craftitem(
        -- From beer_test:malt_grain_black_malt
        "unilib:ingredient_grain_malt_black",
        "beer_test:malt_grain_black_malt",
        mode,
        {
            description = S("Black Malt Grain"),
            inventory_image = "unilib_ingredient_grain_malt_black.png",
        }
    )
    unilib.register_craft({
        -- From beer_test:malt_grain_black_malt
        type = "shapeless",
        output = "unilib:ingredient_grain_malt_black",
        recipe = {"unilib:misc_tray_brewer_malt_black"},
        replacements = {
            {"unilib:misc_tray_brewer_malt_black", "unilib:misc_tray_brewer_empty"},
        },
    })

end
