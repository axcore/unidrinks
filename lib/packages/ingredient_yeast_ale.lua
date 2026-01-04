---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.ingredient_yeast_ale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.ingredient_yeast_ale.init()

    return {
        description = "Ale yeast",
        depends = "crop_wheat",
    }

end

function unilib.pkg.ingredient_yeast_ale.exec()

    unilib.register_craftitem("unilib:ingredient_yeast_ale", "beer_test:yeast", mode, {
        -- From beer_test:yeast
        description = S("Ale Yeast"),
        inventory_image = "unilib_ingredient_yeast_ale.png",
    })
    unilib.register_craft({
        -- From beer_test:yeast
        type = "cooking",
        output = "unilib:ingredient_yeast_ale",
        recipe = "unilib:crop_wheat_harvest",
    })

end
