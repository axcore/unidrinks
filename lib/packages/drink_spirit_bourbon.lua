---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_spirit_bourbon = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_spirit_bourbon.init()

    return {
        description = "Bourbon",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "produce_corn_normal"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_spirit_bourbon.exec()

    local brew_msg

    if unilib.global.pkg_executed_table["container_barrel_fermentation"] ~= nil and
            unilib.global.pkg_executed_table["produce_corn_normal"] ~= nil then

        brew_msg = S("Brewed with normal corn")

        unilib.pkg.container_barrel_fermentation.add_recipe(
            "unilib:produce_corn_normal_harvest", "unilib:drink_spirit_bourbon_glass"
        )

    end

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_bourbon, wine:bottle_bourbon". Produces
        --      unilib:drink_spirit_bourbon_glass, unilib:drink_spirit_bourbon_bottle
        part_name = "spirit_bourbon",
        glass_description = S("Glass of Bourbon"),
        glass_orig_name = "wine:glass_bourbon",
        value_alcohol = 1,
        value_hunger = 2,
        value_thirst = 3,

        bottle_description = S("Bottle of Bourbon"),
        bottle_orig_name = "wine:bottle_bourbon",
        brew_msg = brew_msg,
    })

end
