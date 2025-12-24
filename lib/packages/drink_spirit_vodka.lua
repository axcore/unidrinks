---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_spirit_vodka = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_spirit_vodka.init()

    return {
        description = "Vodka",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "food_potato_baked"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_spirit_vodka.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["food_potato_baked"] ~= nil then

        brew_msg = S("Brewed with baked potatoes")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            "unilib:food_potato_baked", "unilib:drink_spirit_vodka_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_vodka, wine:bottle_vodka. Produces unilib:drink_spirit_vodka_glass,
        --      unilib:drink_spirit_vodka_bottle
        part_name = "spirit_vodka",
        glass_description = S("Glass of Vodka"),
        glass_orig_name = "wine:glass_vodka",
        value_alcohol = 1,
        value_hunger = 2,
        value_thirst = 3,

        bottle_description = S("Bottle of Vodka"),
        bottle_orig_name = "wine:bottle_vodka",
        brew_msg = brew_msg,
    })

end
