---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.vessel_tankard_empty = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.vessel_tankard_empty.init()

    return {
        description = "Empty tankard",
        depends = {"metal_steel", "shared_beer_test"},
    }

end

function unilib.pkg.vessel_tankard_empty.exec()

    local c_steel = "unilib:metal_steel_ingot"

    unilib.register_node("unilib:vessel_tankard_empty", "beer_test:tankard", mode, {
        -- From beer_test:tankard
        description = unilib.utils.brackets(S("Tankard"), S("Empty")),
        tiles = {
            "unilib_vessel_tankard_top.png",
            "unilib_vessel_tankard_top.png",
            "unilib_vessel_tankard_side.png",
        },
        groups = {cracky = 3, dig_immediate = 3},
        sounds = unilib.pkg.shared_beer_test.get_tankard_sounds(),

        drawtype = "nodebox",
        inventory_image = "unilib_vessel_tankard_empty_inv.png",
        node_box = unilib.pkg.shared_beer_test.tankard_base_table,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = unilib.pkg.shared_beer_test.tankard_selection_table,
        stack_max = 16,
        wield_image = "unilib_vessel_tankard_empty_inv.png",
    })
    unilib.register_craft({
        -- From beer_test:tankard
        output = "unilib:vessel_tankard_empty",
        -- N.B. Original code used unilib:tree_apple_wood
        recipe = {
            {"group:wood", "group:wood", c_steel},
            {c_steel, "", c_steel},
            {c_steel, c_steel, c_steel},
        },
    })

end
