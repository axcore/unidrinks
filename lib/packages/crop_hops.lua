---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.crop_hops = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

local mature_node_box = {
    type = "fixed",
    fixed = {
        {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2},
        {-0.3, -0.5, 0.2, 0.3, 0.5, 0.2},
        {-0.3, -0.5, -0.2, 0.3, 0.5, -0.2},
        {-0.2, -0.5, 0.3, -0.2, 0.5, -0.3},
        {0.2, -0.5, 0.3, 0.2, 0.5, -0.3},
        {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
    },
}

local mature_selection_box = {
    type = "fixed",
    fixed = {
        {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
    },
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.crop_hops.init()

    return {
        description = "Hops",
        notes = "To grow hops, place a planting frame on some soil, then punch the frame with" ..
                " hops seeds (which can be obtained from wild hops plants). Hops has 10 growth" ..
                " stages - 8 \"normal\" ones and 2 \"mature\" ones. The planting frame is" ..
                " replaced when the \"mature\" growth stages are reached. Hops can be harvested" ..
                " at the final growth stage. In addition, hops at this stage can spread upwards," ..
                " bypassing the normal growth stages. This happens when there are brewer's" ..
                " cultivation ropes directly above the hops. The spreading hops plant can spread" ..
                " to a maximum height of 4, so you should place 3 cultivation ropes above it." ..
                " See the notes in the \"rope_brewer\" package for the correct method of rope" ..
                " placement. Harvested hops should be dried by placing it beneath a walkable" ..
                " node (such as wooden planks), with plenty of air",
        depends = {"misc_planting_frame", "rope_brewer"},
    }

end

function unilib.pkg.crop_hops.exec()

    unilib.register_craftitem("unilib:crop_hops_seed", "beer_test:seed_hops", mode, {
        -- From beer_test:seed_hops
        description = unilib.utils.hint(S("Hops Seed"), S("requires planting frame")),
        inventory_image = "unilib_crop_hops_seed.png",

    })
    unilib.register_craft({
        -- From beer_test:seed_hops
        output = "unilib:crop_hops_seed",
        recipe = {
            {"unilib:crop_hops_harvest"},
        },
    })

    -- N.B. Hops have 8 "normal" growth stages (1-8), at which the growing frame is still visible.
    --      They also have 2 "mature" growth stages (9-10), at which the growing frame is consumed
    -- Growth stage 8 will be converted into growth stage 9 if there is air nearby, but will revert
    --      back to growth stage 8 if the node above has .walkable = true (e.g. a wood node; note
    --      that brewer's ropes all have .walkable = false)
    -- Growth stages 9 and 10 are converted and reverted in exactly the same way, but this growth
    --      stage takes much longer
    -- At growth stage 10, the hops can be harvested (by punching it while wielding nothing). It
    --      also has a chance to "climb" the brewer's cultivation rope directly above, replacing the
    --      rope with a growth stage 9 hops node

    for i = 1, 8 do

        unilib.register_node("unilib:crop_hops_grow_" .. i, "beer_test:hops_" .. i, mode, {
            -- From beer_test:hops_1, etc; creates unilib:crop_hops_grow_1, et
            -- (no description)
            tiles = {"unilib_crop_hops_grow_" .. i .. ".png^unilib_misc_planting_frame.png"},
            groups = {
                flammable = 2, hops = i, not_in_creative_inventory = 1, plant = 1, snappy = 3,
            },
            sounds = unilib.global.sound_table.leaves,

            drawtype = "plantlike",
            drop = {
                items = {
                    {items = {"unilib:crop_hops_harvest"}, rarity = 9 - i},
                    {items = {"unilib:crop_hops_harvest"}, rarity = 18 - (i * 2)},
                    {items = {"unilib:crop_hops_harvest"}, rarity = 27 - (i * 3)},
                    {items = {"unilib:crop_hops_seed"}, rarity = 9 - i},
                    {items = {"unilib:crop_hops_seed"}, rarity = 18 - (i * 2)},
                    {items = {"unilib:crop_hops_seed"}, rarity = 27 - (i * 3)},
                    {items = {"unilib:misc_planting_frame"}, rarity = 1 - i},
                }
            },
            paramtype = "light",
            walkable = false,
        })

    end

    unilib.register_node("unilib:crop_hops_grow_9", "beer_test:hops_9", mode, {
        -- From beer_test:hops_9
        -- (no description)
        tiles = {"unilib_crop_hops_grow_8.png"},
        groups = {cracky = 2, not_in_creative_inventory = 1},
        -- N.B. wood in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "nodebox",
        drop = "unilib:rope_brewer_cultivation",
        node_box = mature_node_box,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = mature_selection_box,
        walkable = false,
    })

    unilib.register_node("unilib:crop_hops_grow_10", "beer_test:hops_9a", mode, {
        -- From beer_test:hops_9a
        -- (no description)
        tiles = {"unilib_crop_hops_grow_10.png"},
        groups = {cracky = 2, not_in_creative_inventory = 1},
        -- N.B. wood in original code
        sounds = unilib.global.sound_table.leaves,

        buildable_to = true,
        drawtype = "nodebox",
        drop = "unilib:rope_brewer_cultivation",
        node_box = mature_node_box,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = mature_selection_box,
        walkable = false,

        on_punch = function(pos, node, puncher)

            -- When punched by a player wielding nothing, harvest the hops
            local wielded = puncher:get_wielded_item():get_name()
            if wielded and wielded == "" then

                node.name = "unilib:crop_hops_grow_9"
                core.set_node(pos, node)
                puncher:get_inventory():add_item("main", ItemStack("unilib:crop_hops_harvest"))

            end

        end,
    })

    unilib.register_node("unilib:crop_hops_harvest", "beer_test:hops", mode, {
        -- From beer_test:hops
        description = S("Harvested Hops"),
        tiles = {"unilib_crop_hops_harvest.png"},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_crop_hops_harvest.png",
        paramtype = "light",
        walkable = false,
    })

    unilib.register_node("unilib:crop_hops_harvest_drying", "beer_test:hops_dried_1", mode, {
        -- From beer_test:hops_dried_1
        description = S("Drying Harvested Hops"),
        tiles = {"unilib_crop_hops_harvest_drying.png"},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_crop_hops_harvest_drying.png",
        paramtype = "light",
        walkable = false,
    })

    unilib.register_node("unilib:crop_hops_harvest_dried", "beer_test:hops_dried_2", mode, {
        -- From beer_test:hops_dried_2
        description = S("Dried Harvested Hops"),
        tiles = {"unilib_crop_hops_harvest_dried.png"},
        groups = {flammable = 2, snappy = 3},
        sounds = unilib.global.sound_table.leaves,

        drawtype = "plantlike",
        inventory_image = "unilib_crop_hops_harvest_dried.png",
        paramtype = "light",
        walkable = false,
    })

    unilib.register_abm({
        -- From beer_test
        label = "Grow hops [crop_hopes]",
        nodenames = {"group:hops"},
        neighbors = {"group:soil"},

        chance = 2,
--      interval = 80,
        interval = (unilib.setting.farming_grow_default / 2),

        action = function(pos, node)

            -- Return if already full grown (growth stage 8)
            if core.get_item_group(node.name, "hops") == 8 then
                return
            end

            -- Check if on wet soil
            pos.y = pos.y - 1
            local below_node = core.get_node(pos)
            if core.get_item_group(below_node.name, "soil") < 3 then
                return
            end

            -- Check light
            pos.y = pos.y + 1
            if not core.get_node_light(pos) or core.get_node_light(pos) < 13 then
                return
            end

            -- Replace this node with the next growth stage
            local height = core.get_item_group(node.name, "hops") + 1
            core.set_node(pos, {name = "unilib:crop_hops_grow_" .. height})

        end
    })

    -- N.B. Three separate ABMs in the original code, combined into a single ABM, at the cost of
    --      using the same chance/interval for each of three processes:
    --          Convert harvested crops > drying crops (original chance = 4, interval = 15)
    --          Convert growth stage 8 > 9 (original chance = 5, interval = 15)
    --          Convert growth stage 9 > 10 (original chance = 50, interval = 30)
    unilib.register_abm({
        -- From beer_test
        label = "Handle mature hops [crop_hopes]",
        nodenames = {
            "unilib:crop_hops_harvest",
            "unilib:crop_hops_harvest_drying",
            "unilib:crop_hops_grow_8",
            "unilib:crop_hops_grow_9",
            "unilib:crop_hops_grow_10",
        },

        chance = 5,
        interval = 15,

        action = function(pos, node)

            local above_name = core.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name

            if node.name == "unilib:crop_hops_harvest" or
                    node.name == "unilib:crop_hops_harvest_drying" then

                if core.registered_nodes[above_name] and
                        core.registered_nodes[above_name].walkable and
                        core.find_node_near(pos, 5, {"air"}) then

                    if node.name == "unilib:crop_hops_harvest" then
                        core.set_node(pos, {name = "unilib:crop_hops_harvest_drying"})
                    else
                        core.set_node(pos, {name = "unilib:crop_hops_harvest_dried"})
                    end

                end

            elseif core.registered_nodes[above_name] and
                    core.registered_nodes[above_name].walkable then

                -- N.B. "math.random(20) == 1" simulates the third ABM's much higher chance/
                --      interval values
                if node.name == "unilib:crop_hops_grow_9" then
                    core.set_node(pos, {name = "unilib:crop_hops_grow_8"})
                elseif node.name == "unilib:crop_hops_grow_10" and math.random(20) == 1 then
                    core.set_node(pos, {name = "unilib:crop_hops_grow_9"})
                end

            elseif core.find_node_near(pos, 5, {"air"}) then

                if node.name == "unilib:crop_hops_grow_8" then
                    core.set_node(pos, {name = "unilib:crop_hops_grow_9"})
                elseif node.name == "unilib:crop_hops_grow_9" and math.random(20) == 1 then
                    core.set_node(pos, {name = "unilib:crop_hops_grow_10"})
                end

            end

        end,
    })

    unilib.register_abm({
        -- From beer_test
        label = "Spread mature hops [crop_hopes]",
        nodenames = {"unilib:crop_hops_grow_10"},
        neighbors = {"group:soil"},

        chance = 20,
        interval = 50,

        action = function(pos, node)

            local below_name = core.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name
            if core.get_item_group(below_name, "soil") > 0 then

                local height = 0
                while core.get_node(pos).name == "unilib:crop_hops_grow_10" and height < 4 do

                    height = height + 1
                    pos.y = pos.y + 1

                end

                if height < 4 then

                    if core.get_node(pos).name == "unilib:rope_brewer_cultivation" then
                        core.set_node(pos, {name = "unilib:crop_hops_grow_9"})
                    end

                end

            end

        end,
    })

end
