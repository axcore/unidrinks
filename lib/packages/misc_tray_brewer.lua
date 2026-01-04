---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_tray_brewer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

local full_node_box = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, 0.5, 0.5, 0, 0.44},
        {-0.5, -0.5, -0.5, 0.5, -0.15, 0.5},
        {-0.5, -0.5, -0.5, -0.44, 0, 0.5},
        {0.44, -0.5, -0.5, 0.5, 0, 0.5},
        {-0.5, -0.5, -0.44, 0.5, 0, -0.5},
    },
}

local sprouting_node_box = {
    type = "fixed",
    fixed = {
        {-0.5, -0.5, 0.5, 0.5, 0, 0.44},
        {-0.5, -0.5, -0.5, 0.5, -0.12, 0.5},
        {-0.5, -0.5, -0.5, -0.44, 0, 0.5},
        {0.44, -0.5, -0.5, 0.5, 0, 0.5},
        {-0.5, -0.5, -0.44, 0.5, 0, -0.5},
    },
}

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function register_tray(data_table)

    -- data_table compulsory fields:
    --      part_name (str): e.g. "wheat"
    --      orig_name (str): e.g. "beer_test:wheat_tray"
    --
    -- data_table optional fields:
    --      description (str): e.g. "Brewer's Tray (Wheat)"
    --      drop (str): e.g. "unilib:misc_tray_brewer_sprouted"
    --      group_table (table): Group table; if not specified, a default group table is used
    --      img (str): Image for the top texture; not required for an empty tray
    --      node_box (table): Node box; if not specified, a default one is one

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local description = data_table.description or S("Brewer's Tray")
    local drop = data_table.drop or nil
    local group_table = data_table.group_table or {cracky = 3, oddly_breakable_by_hand = 3}
    local img = data_table.img or nil
    local node_box = data_table.node_box or full_node_box

    local wood_img = "unilib_tree_apple_wood.png"
    local top_img = wood_img
    if img then
        top_img = top_img .. "^" .. img
    end

    unilib.register_node("unilib:misc_tray_brewer_" .. part_name, orig_name, mode, {
        description = description,
        tiles = {top_img, wood_img, wood_img, wood_img, wood_img, wood_img},
        groups = group_table,
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        drop = drop,
        node_box = node_box,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("infotext", description)

        end,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_tray_brewer.init()

    return {
        description = "Brewer's trays",
        notes = "Trays are required to make beer. Start by using empty trays and wheat to craft" ..
                " three wheat trays. Place each tray next to a water source, and wait for them " ..
                " to sprout. Then move the sprouting trays away from water  to allow them to" ..
                " dry. (The trays must be dug and then placed; replacing the water source itself" ..
                " will not work). After drying, you will have three normal malt trays. Cook two" ..
                " of the trays in a furnace to produce crystallised malt, cook one of them a" ..
                " second time to produce black malt. Place each of the three trays in your" ..
                " crafting grid, one at a time, to convert them to three types of grain. Use the" ..
                " three grains and three dried hops to produce beer grain. Punch an empty barrel" ..
                " with the beer grain to start the brewing process",
        depends = {"crop_wheat", "item_stick_ordinary"},
    }

end

function unilib.pkg.misc_tray_brewer.exec()

    local img = "unilib_tree_apple_wood.png"
    local c_wheat = "unilib:crop_wheat_harvest"

    local empty_description = unilib.utils.brackets(S("Brewer's Tray"), S("Empty"))
    unilib.register_node("unilib:misc_tray_brewer_empty", "beer_test:tray", mode, {
        -- From beer_test:tray
        description = empty_description,
        tiles = {img},
        groups = {cracky = 3, oddly_breakable_by_hand = 3},
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, 0.5, 0.5, 0, 0.44},
                {-0.5, -0.5, -0.5, 0.5, -0.44, 0.5},
                {-0.5, -0.5, -0.5, -0.44, 0, 0.5},
                {0.44, -0.5, -0.5, 0.5, 0, 0.5},
                {-0.5, -0.5, -0.44, 0.5, 0, -0.5},
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        },

        on_construct = function(pos)

            local meta = core.get_meta(pos)
            meta:set_string("infotext", empty_description)

        end,
    })
    unilib.register_craft({
        -- From beer_test:tray
        output = "unilib:misc_tray_brewer_empty",
        recipe = {
            {"unilib:item_stick_ordinary", "", "unilib:item_stick_ordinary"},
            -- N.B. In original code, unilib:tree_apple_wood
            {"group:wood", "group:wood", "group:wood"},
        },
    })

    register_tray({
        -- From beer_test:wheat_tray, creates unilib:misc_tray_brewer_wheat
        part_name = "wheat",
        orig_name = "beer_test:wheat_tray",

        description = unilib.utils.brackets(S("Brewer's Tray"), S("Wheat")),
        img = "unilib_misc_tray_brewer_wheat.png",
    })
    unilib.register_craft({
        -- From beer_test:wheat_tray
        output = "unilib:misc_tray_brewer_wheat",
        recipe = {
            {c_wheat, c_wheat, c_wheat},
            {c_wheat, c_wheat, c_wheat},
            {"", "unilib:misc_tray_brewer_empty", ""},
        },
    })
    unilib.register_craft({
        -- From beer_test:wheat_tray
        output = "unilib:misc_tray_brewer_wheat",
        recipe = {
            {c_wheat, c_wheat, c_wheat},
            {c_wheat, c_wheat, c_wheat},
            -- N.B. In original code, unilib:tree_apple_wood
            {"group:wood", "group:wood", "group:wood"},
        },
    })

    register_tray({
        -- From beer_test:sprouting_tray, creates unilib:misc_tray_brewer_sprouting
        part_name = "sprouting",
        orig_name = "beer_test:sprouting_tray",

        description = unilib.utils.brackets(S("Brewer's Tray"), S("Sprouting Wheat")),
        drop = "unilib:misc_tray_brewer_sprouted",
        -- N.B. not_in_creative_inventory = 1 not in original code
        group_table = {cracky = 3, not_in_creative_inventory = 1, oddly_breakable_by_hand = 3},
        img = "unilib_misc_tray_brewer_sprouting.png",
        node_box = sprouting_node_box,
    })

    register_tray({
        -- From beer_test:sprouting_tray_2, creates unilib:misc_tray_brewer_sprouted
        part_name = "sprouted",
        orig_name = "beer_test:sprouting_tray_2",

        description = unilib.utils.brackets(S("Brewer's Tray"), S("Sprouted Wheat")),
        img = "unilib_misc_tray_brewer_sprouting.png",
        node_box = sprouting_node_box,
    })

    register_tray({
        -- From beer_test:malt_tray_malt, creates unilib:misc_tray_brewer_malt_normal
        part_name = "malt_normal",
        orig_name = "beer_test:malt_tray_malt",

        description = unilib.utils.brackets(S("Malt Tray"), S("Normal Malt")),
        img = "unilib_misc_tray_brewer_malt_normal.png",
    })
    unilib.register_craft({
        -- From beer_test:malt_tray_malt
        type = "cooking",
        output = "unilib:misc_tray_brewer_malt_normal",
        recipe = "unilib:misc_tray_brewer_sprouting",
    })
    unilib.register_craft({
        -- From beer_test:malt_tray_malt
        type = "cooking",
        output = "unilib:misc_tray_brewer_malt_normal",
        recipe = "unilib:misc_tray_brewer_sprouted",
    })

    register_tray({
        -- From beer_test:malt_tray_crystalised_malt, creates
        --      unilib:misc_tray_brewer_malt_crystallised
        part_name = "malt_crystallised",
        orig_name = "beer_test:malt_tray_crystalised_malt",

        description = unilib.utils.brackets(S("Malt Tray"), S("Crystallised Malt")),
        img = "unilib_misc_tray_brewer_malt_crystallised.png",
    })
    unilib.register_craft({
        -- From beer_test:malt_tray_crystalised_malt
        type = "cooking",
        output = "unilib:misc_tray_brewer_malt_crystallised",
        recipe = "unilib:misc_tray_brewer_malt_normal",
    })

    register_tray({
        -- From beer_test:malt_tray_black_malt, creates unilib:misc_tray_brewer_malt_black
        part_name = "malt_black",
        orig_name = "beer_test:malt_tray_black_malt",

        description = unilib.utils.brackets(S("Malt Tray"), S("Black Malt")),
        img = "unilib_misc_tray_brewer_malt_black.png",
    })
    unilib.register_craft({
        -- From beer_test:malt_tray_black_malt
        type = "cooking",
        output = "unilib:misc_tray_brewer_malt_black",
        recipe = "unilib:misc_tray_brewer_malt_crystallised",
    })

    -- N.B. Three separate ABMs in the original code, combined into a single ABM, at the cost of
    --      using the same chance/interval for each of three processes:
    --          Convert wheat tray > sprouting tray (original chance = 20, interval = 60)
    --          Convert sprouting tray > normal malt (original chance = 20, interval = 50)
    --          Convert sprouted tray > normal malt (original chance = 20, interval = 50)
    unilib.register_abm({
        -- From beer_test
        label = "Convert brewer's trays [misc_tray_brewer]",
        nodenames = {
            "unilib:misc_tray_brewer_wheat",
            "unilib:misc_tray_brewer_sprouting",
            "unilib:misc_tray_brewer_sprouted",
            "unilib:misc_tray_brewer_malt_normal",
        },

        chance = 25,
        interval = 50,

        action = function(pos, node)

            local above_name = core.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name
            if core.registered_nodes[above_name] and core.registered_nodes[above_name].walkable then

                if node.name == "unilib:misc_tray_brewer_wheat" then
                    core.set_node(pos, {name = "unilib:misc_tray_brewer_sprouting"})
                elseif node.name == "unilib:misc_tray_brewer_sprouting" or
                        node.name == "unilib:misc_tray_brewer_sprouted" then
                    core.set_node(pos, {name = "unilib:misc_tray_brewer_malt_normal"})
                end

            end

            -- Check if there is air/water nearby
            if core.find_node_near(pos, 5, {"group:water"}) then

                if node.name == "unilib:misc_tray_brewer_wheat" then
                    core.set_node(pos, {name = "unilib:misc_tray_brewer_sprouting"})
                elseif node.name == "unilib:misc_tray_brewer_malt_normal" then
                    core.set_node(pos, {name = "unilib:misc_tray_brewer_sprouting"})
                end

            elseif core.find_node_near(pos, 5, {"air"}) then

                if node.name == "unilib:misc_tray_brewer_sprouted" then
                    core.set_node(pos, {name = "unilib:misc_tray_brewer_malt_normal"})
                end

            end

        end,
    })

end
