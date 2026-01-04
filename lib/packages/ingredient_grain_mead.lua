---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_grain_mead = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_grain_mead.init()

    return {
        description = "Mixed apple mead grain",
        depends = {"fruit_apple", "ingredient_yeast_ale"},
        suggested = {
            "ingredient_sugar_normal",          -- group:food_sugar
        },
    }

end

function unilib.pkg.ingredient_grain_mead.exec()

    unilib.register_craftitem("unilib:ingredient_grain_mead", "beer_test:mixed_mead_grain", mode, {
        -- From beer_test:mixed_mead_grain
        description = S("Mixed Apple Mead Grain"),
        inventory_image = "unilib_ingredient_grain_mead.png",
    })
    unilib.register_craft({
        -- From beer_test:mixed_mead_grain
        type = "shapeless",
        output = "unilib:ingredient_grain_mead",
        recipe = {
            "unilib:fruit_apple",
            "unilib:fruit_apple",
            "unilib:fruit_apple",
            "unilib:fruit_apple",
            "unilib:ingredient_yeast_ale",
            -- N.B. Was beer_test:sugar in original code
            "group:food_sugar",
            "group:food_sugar",
            "group:food_sugar",
            "group:food_sugar",
        },
    })

end
