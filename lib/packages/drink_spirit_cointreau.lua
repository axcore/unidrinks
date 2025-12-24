---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_spirit_cointreau = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_spirit_cointreau.init()

    return {
        description = "Cointreau",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "fruit_orange"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_spirit_cointreau.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["fruit_orange"] ~= nil then

        brew_msg = S("Brewed with oranges")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            "unilib:fruit_orange", "unilib:drink_spirit_cointreau_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_cointreau, wine:bottle_cointreau. Produces
        --      unilib:drinkspirit_cointreau_glass, unilib:drink_spirit_cointreau_bottle
        part_name = "spirit_cointreau",
        glass_description = S("Glass of Cointreau"),
        glass_orig_name = "wine:glass_cointreau",
        value_alcohol = 1,
        value_hunger = 2,
        value_thirst = 3,

        bottle_description = S("Bottle of Cointreau"),
        bottle_orig_name = "wine:bottle_cointreau",
        brew_msg = brew_msg,
    })

end
