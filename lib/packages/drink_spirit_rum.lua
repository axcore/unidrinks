---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_spirit_rum = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_spirit_rum.init()

    return {
        description = "Rum",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "plant_papyrus_ordinary"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_spirit_rum.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["plant_papyrus_ordinary"] ~= nil then

        brew_msg = S("Brewed with ordinary papyrus")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            "unilib:plant_papyrus_ordinary", "unilib:drink_spirit_rum_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_rum, wine:bottle_rum. Produces unilib:drink_spirit_rum_glass,
        --      unilib:drink_spirit_rum_bottle
        part_name = "spirit_rum",
        glass_description = S("Glass of Rum"),
        glass_orig_name = "wine:glass_rum",
        value_alcohol = 1,
        value_hunger = 2,
        value_thirst = 5,

        bottle_description = S("Bottle of Rum"),
        bottle_orig_name = "wine:bottle_rum",
        brew_msg = brew_msg,
    })

end
