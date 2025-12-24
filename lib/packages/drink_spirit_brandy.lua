---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_spirit_brandy = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_spirit_brandy.init()

    return {
        description = "Brandy",
        depends = "shared_wine",
        optional = {"container_barrel_fermentation", "drink_wine_normal"},
        adult_flag = true,
    }

end

function unilib.pkg.drink_spirit_brandy.exec()

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_brandy, wine:bottle_brandy. Produces unilib:drink_spirit_brandy_glass,
        --      unilib:drink_spirit_brandy_bottle
        part_name = "spirit_brandy",
        glass_description = S("Glass of Brandy"),
        glass_orig_name = "wine:glass_brandy",
        value_alcohol = 1,
        value_hunger = 3,
        value_thirst = 4,

        bottle_description = S("Bottle of Brandy"),
        bottle_orig_name = "wine:bottle_brandy",
        brew_msg = nil,
        food_group = "food_brandy",
    })

    if unilib.global.pkg_executed_table["drink_wine_normal"] ~= nil then

        unilib.register_craft({
            -- From wine:glass_brandy
            type = "cooking",
            cooktime = 15,
            output = "unilib:drink_spirit_brandy_glass",
            recipe = "unilib:drink_wine_normal_glass",
        })

    end

end
