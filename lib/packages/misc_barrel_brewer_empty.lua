---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_barrel_brewer_empty = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_barrel_brewer_empty.init()

    return {
        description = "Empty brewer's barrel",
        notes = "Punch the barrel with either ale, beer or mead grain to begin the brewing process",
        depends = "metal_steel",
        optional = {"ingredient_grain_ale", "ingredient_grain_beer", "ingredient_grain_mead"},
    }

end

function unilib.pkg.misc_barrel_brewer_empty.exec()

    local c_steel = "unilib:metal_steel_ingot"

    local description = unilib.utils.brackets(S("Brewer's Barrel"), S("Empty"))
    unilib.register_node("unilib:misc_barrel_brewer_empty", "beer_test:barrel", mode, {
        -- From beer_test:barrel
        description = description,
        tiles = {
            "unilib_misc_barrel_brewer_top.png",
            "unilib_misc_barrel_brewer_top.png",
            "unilib_misc_barrel_brewer_side_2.png",
        },
        groups = {cracky = 2},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, 0.5, 0.5, 0.5, 0.35},
                {-0.5, -0.5, -0.5, 0.5, -0.35, 0.5},
                {-0.5, -0.5, -0.5, -0.35, 0.5, 0.5},
                {0.35, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-0.5, -0.5, -0.35, 0.5, 0.5, -0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
            },
        },

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("infotext", description)

        end,

        on_punch = function(pos, node, puncher)

            local tool = puncher:get_wielded_item():get_name()
            if not tool then
                return
            end

            if tool == "unilib:ingredient_grain_beer" then

                node.name = "unilib:misc_barrel_brewer_beer"
                core.set_node(pos, node)
                puncher:get_inventory():remove_item(
                    "main", ItemStack("unilib:ingredient_grain_beer")
                )

            elseif tool == "unilib:ingredient_grain_ale" then

                node.name = "unilib:misc_barrel_brewer_ale"
                core.set_node(pos, node)
                puncher:get_inventory():remove_item(
                    "main", ItemStack("unilib:ingredient_grain_ale")
                )

            elseif tool == "unilib:ingredient_grain_mead" then

                node.name = "unilib:misc_barrel_brewer_mead"
                core.set_node(pos, node)
                puncher:get_inventory():remove_item(
                    "main", ItemStack("unilib:ingredient_grain_mead")
                )

            end

        end,
    })
    unilib.register_craft({
        -- From beer_test:barrel
        output = "unilib:misc_barrel_brewer_empty 6",
        -- N.B. Original code used unilib:tree_apple_wood
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {c_steel, c_steel, c_steel},
            {"group:wood", "group:wood", "group:wood"},
        },
    })

end
