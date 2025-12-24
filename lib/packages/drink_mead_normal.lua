---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_mead_normal = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_mead_normal.init()

    return {
        description = "Normal mead",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "food_honey_synthetic"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_mead_normal.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["food_honey_synthetic"] ~= nil then

        brew_msg = S("Brewed with honey")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            "unilib:food_honey_synthetic", "unilib:drink_mead_normal_glass"
        )

        -- (Support various mobs mods too)
        unilib.pkg.container_barrel_fermentation.add_recipe(
            "group:food_honey", "unilib:drink_mead_normal_glass"
        )

        unilib.register_external_ingredient("unilib:food_chicken_hot_wings_raw", {
            "group:food_honey",                     -- Originally mobs:honey
        })

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_mead, wine:bottle_mead. Produces unilib:drink_mead_normal_glass,
        --      unilib:drink_mead_normal_bottle
        part_name = "mead_normal",
        glass_description = S("Glass of Normal Mead"),
        glass_orig_name = "wine:glass_mead",
        value_alcohol = 1,
        value_hunger = 4,
        value_thirst = 5,

        bottle_description = S("Bottle of Normal Mead"),
        bottle_orig_name = "wine:bottle_mead",
        brew_msg = brew_msg,
    })

end
