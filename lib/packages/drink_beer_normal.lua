---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_beer_normal = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_beer_normal.init()

    return {
        description = "Normal beer",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "crop_barley"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_beer_normal.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["crop_barley"] ~= nil then

        brew_msg = S("Brewed with barley")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            "unilib:crop_barley_harvest", "unilib:drink_beer_normal_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_beer, wine:bottle_beer. Produces unilib:drink_beer_normal_glass,
        --      unilib:drink_beer_normal_bottle
        part_name = "beer_normal",
        glass_description = S("Glass of Normal Beer"),
        glass_orig_name = "wine:glass_beer",
        value_alcohol = 1,
        value_hunger = 2,
        value_thirst = 8,

        bottle_description = S("Bottle of Normal Beer"),
        bottle_orig_name = "wine:bottle_beer",
        brew_msg = brew_msg,
    })

end
