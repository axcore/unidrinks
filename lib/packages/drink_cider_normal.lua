---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_cider_normal = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_cider_normal.init()

    return {
        description = "Normal cider",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "fruit_apple"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_cider_normal.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["fruit_apple"] ~= nil then

        brew_msg = S("Brewed with apples")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            "unilib:fruit_apple", "unilib:drink_cider_normal_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_cider, wine:bottle_cider. Produces unilib:drink_cider_normal_glass,
        --      unilib:drink_cider_normal_bottle
        part_name = "cider_normal",
        glass_description = S("Glass of Normal Cider"),
        glass_orig_name = "wine:glass_cider",
        value_alcohol = 1,
        value_hunger = 2,
        value_thirst = 6,

        bottle_description = S("Bottle of Normal Cider"),
        bottle_orig_name = "wine:bottle_cider",
        brew_msg = brew_msg,
    })

end
