---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_syrup_agave = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_syrup_agave.init()

    return {
        description = "Agave syrup",
        depends = "plant_agave_blue",
    }

end

function unilib.pkg.ingredient_syrup_agave.exec()

    unilib.register_craftitem("unilib:ingredient_syrup_agave", "wine:agave_syrup", mode, {
        -- From wine:agave_syrup
        description = S("Agave Syrup"),
        inventory_image = "unilib_ingredient_syrup_agave.png",
        groups = {flammable = 3, food_sugar = 1, vessel = 1}
    })
    unilib.register_craft({
        -- From wine:agave_syrup
        type = "cooking",
        cooktime = 7,
        output = "unilib:ingredient_syrup_agave 2",
        recipe = "unilib:plant_agave_blue",
    })

end
