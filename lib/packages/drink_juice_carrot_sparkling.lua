---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_juice_carrot_sparkling = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_juice_carrot_sparkling.init()

    return {
        description = "Sparkling carrot juice",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "produce_carrot_normal"},
        suggested = {
            "ingredient_sugar_normal",          -- group:food_sugar
        },
        adult_flag = false,
    }

end

function unilib.pkg.drink_juice_carrot_sparkling.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["produce_carrot_normal"] ~= nil then

        brew_msg = S("Brewed with normal carrots")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            {
                "unilib:produce_carrot_normal_harvest",
                "group:food_sugar",
                "unilib:vessel_glass_empty",
            },
            "unilib:drink_juice_carrot_sparkling_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_sparkling_carrot_juice, wine:bottle_sparkling_carrot_juice. Produces
        --      unilib:drink_juice_carrot_sparkling_glass,
        --      unilib:drink_juice_carrot_sparkling_bottle
        part_name = "juice_carrot_sparkling",
        glass_description = S("Glass of Sparkling Carrot Juice"),
        glass_orig_name = "wine:glass_sparkling_carrot_juice",
        value_alcohol = 0,
        value_hunger = 3,
        value_thirst = 4,

        bottle_description = S("Bottle of Sparkling Carrot Juice"),
        bottle_orig_name = "wine:bottle_sparkling_carrot_juice",
        brew_msg = brew_msg,
    })

end
