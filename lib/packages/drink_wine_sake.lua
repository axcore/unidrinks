---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_wine_sake = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_wine_sake.init()

    return {
        description = "Sake",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "crop_rice_white"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_wine_sake.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["crop_rice_white"] ~= nil then

        brew_msg = S("Brewed with white rice")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            "unilib:crop_rice_white_harvest", "unilib:drink_wine_sake_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_sake, wine:bottle_sake. Produces unilib:drink_wine_sake_glass,
        --      unilib:drink_wine_sake_bottle
        part_name = "wine_sake",
        glass_description = S("Glass of Sake"),
        glass_orig_name = "wine:glass_sake",
        value_alcohol = 1,
        value_hunger = 2,
        value_thirst = 3,

        bottle_description = S("Bottle of Sake"),
        bottle_orig_name = "wine:bottle_sake",
        brew_msg = brew_msg,
    })

end
