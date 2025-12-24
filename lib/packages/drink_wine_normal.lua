---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_wine_normal = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_wine_normal.init()

    return {
        description = "Normal wine",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "produce_grape"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_wine_normal.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["produce_grape"] ~= nil then

        brew_msg = S("Brewed with grapes")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            "unilib:produce_grape_harvest", "unilib:drink_wine_normal_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_wine, wine:bottle_wine. Produces unilib:drink_wine_normal_glass,
        --      unilib:drink_wine_normal_bottle
        part_name = "wine_normal",
        glass_description = S("Glass of Normal Wine"),
        glass_orig_name = "wine:glass_wine",
        value_alcohol = 1,
        value_hunger = 2,
        value_thirst = 5,

        bottle_description = S("Bottle of Normal Wine"),
        bottle_orig_name = "wine:bottle_wine",
        brew_msg = brew_msg,
        food_group = "food_wine",
    })

end
