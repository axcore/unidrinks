---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_cocktail_margarita = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_cocktail_margarita.init()

    return {
        description = "Margarita",
        depends = "shared_wine",
        optional = {"drink_spirit_cointreau", "drink_spirit_tequila", "fruit_lemon"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_cocktail_margarita.exec()

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_margarita. Produces Produces unilib:drink_cocktail_margarita_glass
        part_name = "cocktail_margarita",
        glass_description = S("Glass of Margarita"),
        glass_orig_name = "wine:glass_margarita",
        value_alcohol = 1,
        value_hunger = 4,
        value_thirst = 5,

        -- N.B. no bottle
        brew_msg = nil,
    })

    if unilib.global.pkg_executed_table["drink_spirit_cointreau"] ~= nil and
            unilib.global.pkg_executed_table["drink_spirit_tequila"] ~= nil and
            unilib.global.pkg_executed_table["fruit_lemon"] ~= nil then

        unilib.register_craft({
            -- From wine:glass_margarita
            output = "unilib:drink_cocktail_margarita_glass 2",
            recipe = {
                {
                    "unilib:drink_spirit_cointreau_glass",
                    "unilib:drink_spirit_tequila_glass",
                    "unilib:fruit_lemon",
                },
            },
        })

    end

end
