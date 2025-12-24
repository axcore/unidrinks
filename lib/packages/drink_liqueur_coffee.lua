---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_liqueur_coffee = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_liqueur_coffee.init()

    return {
        description = "Coffee liqueur",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "drink_spirit_rum", "produce_coffee"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_liqueur_coffee.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["drink_spirit_rum"] ~= nil and
            unilib.global.pkg_executed_table["produce_coffee"] ~= nil then

        brew_msg = S("Brewed with coffee and rum")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            {"unilib:drink_spirit_rum_glass", "unilib:produce_coffee_harvest"},
            "unilib:drink_liqueur_coffee_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_coffee_liquor, wine:bottle_coffee_liquor. Produces
        --      unilib:drink_liqueur_coffee_glass, unilib:drink_liqueur_coffee_bottle
        part_name = "liqueur_coffee",
        glass_description = S("Glass of Coffee Liqueur"),
        glass_orig_name = "wine:glass_coffee_liquor",
        value_alcohol = 1,
        value_hunger = 3,
        value_thirst = 4,

        bottle_description = S("Bottle of Coffee Liqueur"),
        bottle_orig_name = "wine:bottle_coffee_liquor",
        brew_msg = brew_msg,
    })

end
