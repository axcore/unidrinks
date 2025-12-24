---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_kefir = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_kefir.init()

    return {
        description = "Kefir",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "crop_wheat"},
        adult_flag = false,
    }

end

function unilib.pkg.drink_kefir.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["crop_wheat"] ~= nil then

        brew_msg = S("Brewed with wheat and milk")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            {"group:food_milk_glass", "unilib:crop_wheat_harvest"},
            "unilib:drink_kefir_glass"
        )

        unilib.register_external_ingredient("unilib:food_porridge", {
            "group:food_milk_glass",                -- Originally mobs:glass_milk
        })

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_kefir, wine:bottle_kefir. Produces unilib:drink_kefir_glass,
        --      unilib:drink_kefir_bottle
        part_name = "kefir",
        glass_description = S("Glass of Kefir"),
        glass_orig_name = "wine:glass_kefir",
        value_alcohol = 0,
        value_hunger = 4,
        value_thirst = 4,

        bottle_description = S("Bottle of Kefir"),
        bottle_orig_name = "wine:bottle_kefir",
        brew_msg = brew_msg,
    })

end
