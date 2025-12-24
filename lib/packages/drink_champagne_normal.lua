---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_champagne_normal = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_champagne_normal.init()

    return {
        description = "Normal champagne",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "drink_wine_normal"},
        suggested = {
            "ingredient_sugar_normal",          -- group:food_sugar
        },
        adult_flag = true,
    }

end

function unilib.pkg.drink_champagne_normal.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["drink_wine_normal"] ~= nil then

        brew_msg = S("Brewed with sugar and normal wine")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            {"unilib:drink_wine_normal_glass", "group:food_sugar"},
            "unilib:drink_champagne_normal_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_champagne, wine:bottle_champagne. Produces
        --      unilib:drink_champagne_normal_glass, unilib:drink_champagne_normal_bottle
        part_name = "champagne_normal",
        glass_description = S("Glass of Normal Champagne"),
        glass_orig_name = "wine:glass_champagne",
        value_alcohol = 1,
        value_hunger = 4,
        value_thirst = 5,

        bottle_description = S("Bottle of Normal Champagne"),
        bottle_orig_name = "wine:bottle_champagne",
        brew_msg = brew_msg,
    })

end
