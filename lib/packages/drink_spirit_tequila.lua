---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_spirit_tequila = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_spirit_tequila.init()

    return {
        description = "Tequila",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "plant_agave_blue"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_spirit_tequila.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["plant_agave_blue"] ~= nil then

        brew_msg = S("Brewed with blue agave")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            "unilib:plant_agave_blue", "unilib:drink_spirit_tequila_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_tequila, wine:bottle_tequila. Produces unilib:drink_spirit_tequila_glass,
        --      unilib:drink_spirit_tequila_bottle
        part_name = "spirit_tequila",
        glass_description = S("Glass of Tequila"),
        glass_orig_name = "wine:glass_tequila",
        value_alcohol = 1,
        value_hunger = 2,
        value_thirst = 3,

        bottle_description = S("Bottle of Tequila"),
        bottle_orig_name = "wine:bottle_tequila",
        brew_msg = brew_msg,
    })

end
