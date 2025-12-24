---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_beer_wheat = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_beer_wheat.init()

    return {
        description = "Wheat beer",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "crop_wheat"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_beer_wheat.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["crop_wheat"] ~= nil then

        brew_msg = S("Brewed with wheat")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            "unilib:crop_wheat_harvest", "unilib:drink_beer_wheat_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_wheat_beer, wine:bottle_wheat_beer. Produces
        --      unilib:drink_beer_wheat_glass, unilib:drink_beer_wheat_bottle
        part_name = "beer_wheat",
        glass_description = S("Glass of Wheat Beer"),
        glass_orig_name = "wine:glass_wheat_beer",
        value_alcohol = 1,
        value_hunger = 2,
        value_thirst = 8,

        bottle_description = S("Bottle of Wheat Beer"),
        bottle_orig_name = "wine:bottle_wheat_beer",
        brew_msg = brew_msg,
    })

end
