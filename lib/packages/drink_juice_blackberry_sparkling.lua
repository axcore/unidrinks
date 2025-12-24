---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_juice_blackberry_sparkling = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_juice_blackberry_sparkling.init()

    return {
        description = "Sparkling blackberry juice",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "produce_blackberry"},
        suggested = {
            "ingredient_sugar_normal",          -- group:food_sugar
        },
        adult_flag = false,
    }

end

function unilib.pkg.drink_juice_blackberry_sparkling.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["produce_blackberry"] ~= nil then

        brew_msg = S("Brewed with blackberries")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            {
                "unilib:produce_blackberry_harvest 2",
                "group:food_sugar",
                "unilib:vessel_glass_empty",
            },
            "unilib:drink_juice_blackberry_sparkling_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_sparkling_blackberry_juice, wine:bottle_sparkling_blackberry_juice.
        --      Produces unilib:drink_juice_blackberry_sparkling_glass,
        --      unilib:drink_juice_blackberry_sparkling_bottle
        part_name = "juice_blackberry_sparkling",
        glass_description = S("Glass of Sparkling Blackberry Juice"),
        glass_orig_name = "wine:glass_sparkling_blackberry_juice",
        value_alcohol = 0,
        value_hunger = 2,
        value_thirst = 4,

        bottle_description = S("Bottle of Sparkling Blackberry Juice"),
        bottle_orig_name = "wine:bottle_sparkling_blackberry_juice",
        brew_msg = brew_msg,
    })

end
