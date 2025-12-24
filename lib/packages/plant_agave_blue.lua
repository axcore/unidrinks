---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.plant_agave_blue = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

local spread_time = 17
-- N.B. The same list of sand nodes appears in the "deco_wine_plant_agave_blue" package
local sand_list = {"unilib:sand_desert", "default:desert_sand"}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.plant_agave_blue.init()

    return {
        description = "Blue agave plant",
        notes = "Spreads on desert sands",
        depends = "sand_desert",
        optional = {"dye_basic", "item_paper_ordinary"},
    }

end

function unilib.pkg.plant_agave_blue.exec()

    unilib.register_node("unilib:plant_agave_blue", "wine:blue_agave", mode, {
        -- From wine:blue_agave
        description = S("Blue Agave"),
        tiles = {"unilib_plant_agave_blue.png"},
        -- N.B. In the original code, the eatable/flammable groups are not added until the call to
        --      wine.add_eatable()
        groups = {attached_node = 1, eatable = 2, flammable = 2, plant = 1, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_plant_agave_blue.png",
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.2, -0.5, -0.2, 0.2, 0.3, 0.2},
        },
        sunlight_propagates = true,
        visual_scale = 0.8,
        walkable = false,
        wield_image = "unilib_plant_agave_blue.png",

        on_construct = function(pos)
            core.get_node_timer(pos):start(spread_time)
        end,

        on_timer = function(pos)

            local light = core.get_node_light(pos)

            if not light or light < 13 or math.random() > 1/76 then
                return true
            end

            local n = core.find_nodes_in_area_under_air(
                {x = pos.x + 2, y = pos.y + 1, z = pos.z + 2},
                {x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
                {"unilib:plant_agave_blue"}
            )

            if n and #n > 2 then

                -- Too crowded, we'll wait for another iteration
                return true

            end

            -- Find desert sand nodes with air above (grow across and down only)
            n = core.find_nodes_in_area_under_air(
                {x = pos.x + 1, y = pos.y - 1, z = pos.z + 1},
                {x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
                sand_list
            )

            if n and #n > 0 then

                --Place blue agave
                local new_pos = n[math.random(#n)]
                new_pos.y = new_pos.y + 1

                core.set_node(new_pos, {name = "unilib:plant_agave_blue"})

            end

            return true

        end,

        on_use = unilib.cuisine.eat_on_use("unilib:plant_agave_blue", 2),
    })
    unilib.register_craft({
        -- From wine:blue_agave
        type = "fuel",
        recipe = "unilib:plant_agave_blue",
        burntime = 10,
    })
    if unilib.global.pkg_executed_table["dye_basic"] ~= nil then

        unilib.register_craft({
            -- From wine:blue_agave
            output = "unilib:dye_cyan 4",
            recipe = {
                {"unilib:plant_agave_blue"},
            },
        })

    end
    if unilib.global.pkg_executed_table["item_paper_ordinary"] ~= nil then

        unilib.register_craft({
            -- From wine:blue_agave
            output = "unilib:item_paper_ordinary 3",
            recipe = {
                {"unilib:plant_agave_blue", "unilib:plant_agave_blue", "unilib:plant_agave_blue"},
            },
        })

    end

    --Add lbm to start agave timers
    unilib.register_lbm({
        -- From wine/agave.lua
        label = "Spread blue agave on desert sand [plant_agave_blue]",
        name = "unilib:lbm_plant_agave_blue",
        nodenames = {"unilib:plant_agave_blue"},

        run_at_every_load = false,

        action = function(pos)
            core.get_node_timer(pos):start(spread_time)
        end
    })

    unilib.register_decoration_generic("wine_plant_agave_blue", {
        -- From wine/agave.lua
        deco_type = "simple",
        decoration = "unilib:plant_agave_blue",

        fill_ratio = 0.001,
        sidelen = 16,
    })

end
