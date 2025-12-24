---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_juice_agave_sparkling = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_juice_agave_sparkling.init()

    return {
        description = "Sparkling agave juice",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "ingredient_syrup_agave", "plant_agave_blue"},
        adult_flag = false,
    }

end

function unilib.pkg.drink_juice_agave_sparkling.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["ingredient_syrup_agave"] ~= nil and
            unilib.global.pkg_executed_table["plant_agave_blue"] ~= nil then

        brew_msg = S("Brewed with agave syrup and plants")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            {
                "unilib:ingredient_syrup_agave",
                "unilib:plant_agave_blue",
                "unilib:vessel_glass_empty",
            },
            "unilib:drink_juice_agave_sparkling_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_sparkling_agave_juice, wine:bottle_sparkling_agave_juice. Produces
        --      unilib:drink_juice_agave_sparkling_glass, unilib:drink_juice_agave_sparkling_bottle
        part_name = "juice_agave_sparkling",
        glass_description = S("Glass of Sparkling Agave Juice"),
        glass_orig_name = "wine:glass_sparkling_agave_juice",
        value_alcohol = 0,
        value_hunger = 2,
        value_thirst = 4,

        bottle_description = S("Bottle of Sparkling Agave Juice"),
        bottle_orig_name = "wine:bottle_sparkling_agave_juice",
        brew_msg = brew_msg,
    })

end
