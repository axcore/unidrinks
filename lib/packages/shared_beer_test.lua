---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_beer_test = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

local initial_brew_time = 60
local brewing_msg = S("brewing - punch to interrupt")
local empty_msg = S("barrel is empty")

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function on_place_callback(itemstack, placer, pointed_thing)

    if pointed_thing.above then
        pos = pointed_thing.above
    else
        pos = pointed_thing
    end

    core.set_node(pos, {name = "unilib:misc_barrel_brewer_beer_brewed"})

    local meta = core.get_meta(pos)
    meta:from_table(core.deserialize(itemstack:get_metadata()))
    itemstack:take_item()

    return itemstack

end

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

-- Tankard node boxes are very similar, and selection boxes are identical
-- (They are implemented as shared variables, so that the "vessel_tankard_empty" package can use
--      them)
unilib.pkg.shared_beer_test.tankard_base_table = {
    type = "fixed",
    fixed = {
        {-0.18, -0.5, 0.125, 0.18, 0.18, 0.18},
        {0.125, -0.5, -0.18, 0.18, 0.18, 0.18},
        {-0.18, -0.5, -0.18, -0.125, 0.18, 0.18},
        {-0.18, -0.5, -0.18, 0.18, 0.18, -0.125},
        {-0.25, -0.5, -0.25, 0.25, -0.44, 0.25},
        {-0.315, -0.3, 0.04, -0.36, 0.1, -0.05},
        {-0.15, -0.0, 0.04, -0.35, 0.05, -0.05},
        {-0.15, -0.25, 0.04, -0.35, -0.2, -0.05},
    },
}

unilib.pkg.shared_beer_test.tankard_low_table =
        table.copy(unilib.pkg.shared_beer_test.tankard_base_table)
table.insert(
    unilib.pkg.shared_beer_test.tankard_low_table.fixed, {-0.18, -0.5, -0.18, 0.18, 0.1, 0.18}
)

unilib.pkg.shared_beer_test.tankard_high_table =
        table.copy(unilib.pkg.shared_beer_test.tankard_base_table)
table.insert(
    unilib.pkg.shared_beer_test.tankard_high_table.fixed, {-0.125, -0.5, -0.125, 0.125, 0.25, 0.125}
)
table.insert(
    unilib.pkg.shared_beer_test.tankard_high_table.fixed, {-0.135, -0.5, -0.135, 0.135, 0.25, 0.135}
)

unilib.pkg.shared_beer_test.tankard_selection_table = {
    type = "fixed",
    fixed = {
        {-0.125, -0.5, -0.125, 0.125, 0.18, 0.125},
        {-0.18, -0.5, -0.18, 0.18, 0.18, 0.18},
        {-0.25, -0.5, -0.25, 0.25, -0.44, 0.25},
        {-0.315, -0.3, 0.04, -0.36, 0.1, -0.05},
        {-0.15, -0.0, 0.04, -0.315, 0.05, -0.05},
        {-0.15, -0.25, 0.04, -0.315, -0.2, -0.05},
    },
}

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_beer_test.get_barrel_sounds(sound_table)

    -- Was default.node_sound_barrel_defaults()

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
            {name = "unilib_wood_footstep", gain = 0.5}
    sound_table.dug = sound_table.dug or
            {name = "unilib_barrel_break", gain = 1.0}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.pkg.shared_beer_test.get_tankard_sounds(sound_table)

    -- Was default.node_sound_tankard_defaults()

    sound_table = sound_table or {}

    sound_table.footstep = sound_table.footstep or
            {name = "unilib_wood_footstep", gain = 0.5}
    sound_table.dug = sound_table.dug or
            {name = "unilib_tankard_break", gain = 1.0}
    sound_table.place = sound_table.place or
            {name = "unilib_tankard_place", gain = 1.0}

    unilib.node_sound_defaults(sound_table)

    return sound_table

end

function unilib.pkg.shared_beer_test.register_tankard(data_table)

    -- Original to unilib
    -- Registers the full tankard
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "beer_unbrewed"
    --      orig_name (str): e.g. "beer_test:tankard_unbrewed_beer"
    --
    -- data_table optional fields:
    --      description (str): e.g. "Tankard of Unbrewed Beer"
    --      overflowing_flag (bool): If true, use unilib.pkg.shared_beer_test.tankard_high_table as
    --          the .node_box; otherwise use unilib.pkg.shared_beer_test.tankard_low_table
    --      top_img (str): First image in the .tiles field
    --      value_alcohol (int): e.g. 1 (default is 0, representing a non-alcoholic drink). The
    --          .alcohol group is not used by unilib/unidrinks code, but is available for any code
    --          that needs it

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name

    local description = data_table.description or S("Tankard")
    local overflowing_flag = data_table.overflowing_flag or false
    local top_img = data_table.top_img or "unilib_vessel_tankard_top_beer_unbrewed.png"
    local value_alcohol = data_table.value_alcohol or 0

    local full_name = "unilib:vessel_tankard_" .. part_name
    local side_img = "unilib_vessel_tankard_side.png"
    if overflowing_flag then
        side_img = "unilib_vessel_tankard_side_" .. part_name .. ".png"
    end
    local inv_img = "unilib_vessel_tankard_empty_inv.png" ..
            "^unilib_vessel_tankard_" .. part_name .. "_inv_overlay.png"

    local node_box = unilib.pkg.shared_beer_test.tankard_low_table
    if overflowing_flag then
        node_box = unilib.pkg.shared_beer_test.tankard_high_table
    end

    -- N.B. 1 in original code; changed to 2, to match drinks imported from the "wine" mod
    local value_hunger = 2

    unilib.register_node(full_name, orig_name, mode, {
        description = description,
        tiles = {
            top_img,
            "unilib_vessel_tankard_top.png",
            side_img
        },
        -- N.B. No .alochol or .eatable groups in the original code
        groups = {alcohol = value_alcohol, cracky = 3, dig_immediate = 3, eatable = value_hunger},
        sounds = unilib.pkg.shared_beer_test.get_tankard_sounds(),

        drawtype = "nodebox",
        inventory_image = inv_img,
        node_box = node_box,
        paramtype = "light",
        paramtype2 = "facedir",
        selection_box = unilib.pkg.shared_beer_test.tankard_selection_table,
        stack_max = 1,
        wield_image = inv_img,

        -- N.B. Original code used the equivalent of unilib.cuisine.eat_on_use(); switched it for
        --      consistency with other unidrinks items
        on_use = unilib.cuisine.drink_on_use(
            full_name, value_hunger, "unilib:vessel_tankard_empty"
        ),
    })

end

function unilib.pkg.shared_beer_test.register_waiting_barrel(data_table)

    -- Original to unilib
    -- Registers the node barrel in its "waiting" stage
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "beer"
    --      orig_name (str): e.g. "beer_test:barrel_mixed_beer_grain"
    --      brewing_list (list): List of mini-lists specifying brewing stages for this drink; see
    --          the "misc_barrel_brewer_beer" package for a working example
    --      ingredient (str): e.g. "unilib:ingredient_grain_beer"
    --
    -- data_table optional fields:
    --      description (str): e.g. "Barrel of Beer"
    --      group_table (table): Default is {not_in_creative_inventory = 1}
    --      overlay_img (str): e.g. "unilib_misc_barrel_brewer_beer_overlay.png"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local brewing_list = data_table.brewing_list
    local ingredient = data_table.ingredient

    local description = data_table.description or S("Barrel")
    local group_table = data_table.group_table or {not_in_creative_inventory = 1}
    local overlay_img = data_table.overlay_img or "unilib_misc_barrel_brewer_beer_overlay.png"

    local full_name = "unilib:misc_barrel_brewer_" .. part_name
    local waiting_description = unilib.utils.brackets(description, S("Waiting"))

    unilib.register_node(full_name, orig_name, mode, {
        description = waiting_description,
        tiles = {
            "unilib_misc_barrel_brewer_top.png^" .. overlay_img,
            "unilib_misc_barrel_brewer_top.png",
            "unilib_misc_barrel_brewer_side_2.png",
        },
        groups = group_table,
        sounds = unilib.global.sound_table.wood,

        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, 0.5, 0.5, 0.5, 0.35},
                {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5},
                {-0.5, -0.5, -0.5, -0.35, 0.5, 0.5},
                {0.35, -0.5, -0.5, 0.5, 0.5, 0.5},
                {-0.5, -0.5, -0.35, 0.5, 0.5, -0.5},
                {-0.5, -0.5, -0.5, 0.5, 0.1, 0.5},
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
            meta:set_string("infotext", waiting_description)

        end,

        on_punch = function(pos, node, puncher)

            -- N.B. Punching a full barrel doesn't change the state of the barrel, but it does
            --      remove one grain item from the player's inventory
            local tool = puncher:get_wielded_item():get_name()
            if tool and tool == ingredient then

                node.name = full_name
                core.set_node(pos, node)
                puncher:get_inventory():remove_item(
                    "main", ItemStack(ingredient)
                )

            end

        end,

        on_rightclick = function(pos, node, player, itemstack, pointed_thing)

            if core.get_item_group(itemstack:get_name(), "wood") > 0 then

                itemstack:take_item(1)
                player:set_wielded_item(itemstack)

                node.name = "unilib:misc_barrel_brewer_" .. part_name .. "_brewing"
                core.set_node(pos, node)

                local meta = core.get_meta(pos)
                meta:set_int("state", 1)
                meta:set_string(
                    "infotext",
                    brewing_list[1].description .. "\n(" .. brewing_msg .. ")"
                )

                local timer = core.get_node_timer(pos)
                timer:start(initial_brew_time)

            end

        end,
    })

end

function unilib.pkg.shared_beer_test.register_brewing_barrel(data_table)

    -- Original to unilib
    -- Registers the node barrel in its "brewing" stage
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "beer"
    --      orig_name (str): e.g. "beer_test:barrel_beer_brewing"
    --      brewing_list (list): List of mini-lists specifying brewing stages for this drink; see
    --          the "misc_barrel_brewer_beer" package for a working example
    --
    -- data_table optional fields:
    --      description (str): e.g. "Barrel of Beer"

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local brewing_list = data_table.brewing_list

    local description = data_table.description or S("Barrel")

    local full_name = "unilib:misc_barrel_brewer_" .. part_name .. "_brewing"
    local brewed_name = "unilib:misc_barrel_brewer_" .. part_name .. "_brewed"
    local brewing_description = unilib.utils.brackets(description, S("Brewing"))

    unilib.register_node(full_name, orig_name, mode, {
        description = brewing_description,
        tiles = {
            "unilib_misc_barrel_brewer_top.png",
            "unilib_misc_barrel_brewer_top.png",
            "unilib_misc_barrel_brewer_side_2.png",
        },
        groups = {choppy = 2, not_in_creative_inventory = 1, oddly_breakable_by_hand = 2},
        sounds = unilib.pkg.shared_beer_test.get_barrel_sounds(),

        paramtype = "light",
        paramtype2 = "facedir",

        on_punch = function(pos, node, puncher, pointed_thing)

            local meta = core.get_meta(pos)
            local state = meta:get_int("state")
            if not state or state == 0 then
                return
            end

            local timer = core.get_node_timer(pos)
            timer:stop()

            node.name = brewed_name
            core.swap_node(pos, node)

            meta:set_int("full", 100)
            meta:set_string(
                "infotext",
                brewing_list[state].description .. "\n(" .. S("@1% full", 100) .. ")"
            )

        end,

        on_timer = function(pos, elapsed)

            local meta = core.get_meta(pos)
            local state = meta:get_int("state")
            if not state or state == 0 then
                state = 1
            end

            local next_state = state + 1
            if brewing_list[next_state] then

                meta:set_int("state", next_state)

                local timer = core.get_node_timer(pos)
                timer:start(brewing_list[next_state].interval)
                meta:set_string(
                    "infotext",
                    brewing_list[next_state].description .. "\n(" .. brewing_msg .. ")"
                )

            else

                local node = core.get_node(pos)
                node.name = brewed_name
                core.swap_node(pos, node)
                meta:set_int("full", 100)
                meta:set_string(
                    "infotext",
                    brewing_list[state].description .. "\n(" .. S("@1% full", 100) .. ")"
                )

            end

        end,
    })

end

function unilib.pkg.shared_beer_test.register_brewed_barrel(data_table)

    -- Original to unilib
    -- Registers the node barrel in its "brewed" stage
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "beer"
    --      orig_name (str): e.g. "beer_test:barrel_beer_brewed"
    --      brewing_list (list): List of mini-lists specifying brewing stages for this drink; see
    --          the "misc_barrel_brewer_beer" package for a working example

    local part_name = data_table.part_name
    local orig_name = data_table.orig_name
    local brewing_list = data_table.brewing_list

    local full_name = "unilib:misc_barrel_brewer_" .. part_name .. "_brewed"

    unilib.register_node(full_name, orig_name, mode, {
        -- (no description)
        tiles = {
            "unilib_misc_barrel_brewer_side_2.png",
            "unilib_misc_barrel_brewer_side_2.png",
            "unilib_misc_barrel_brewer_side.png",
            "unilib_misc_barrel_brewer_side.png",
            "unilib_misc_barrel_brewer_top.png",
            "unilib_misc_barrel_brewer_top.png",
        },
        groups = {choppy = 2, not_in_creative_inventory = 1, oddly_breakable_by_hand = 2},
        sounds = unilib.pkg.shared_beer_test.get_barrel_sounds(),

        drop = "",
        paramtype = "light",
        paramtype2 = "facedir",

        on_dig = function(pos, node, digger)

            local meta = core.get_meta(pos)
            local meta_table = meta:to_table()
            if not(meta_table and meta_table.fields and meta_table.fields.state) then

                core.set_node(pos, {name = "air"})
                return

            end

            local state = meta:get_int("state")
            local full = meta:get_int("full")
            local wear = 65536 - (full * 65536 / 100)

            local stack = ItemStack({
                name = brewing_list[state].barrel_name,
                count = 1,
                wear = wear,
                metadata = core.serialize(meta_table),
            })

            if digger and digger:is_player() then

                local inv = digger:get_inventory()
                inv:add_item("main", stack)
                core.set_node(pos, {name = "air"})

            end

        end,

        on_punch = function(pos, node, puncher)

            local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "unilib:vessel_tankard_empty" then

                local meta = core.get_meta(pos)
                if meta:get_int("full") >= 5 then

                    local state = meta:get_int("state")
                    if not state or state == 0 then
                        state = 1
                    end

                    local tankard_name = brewing_list[state].tankard_name
                    puncher:set_wielded_item(ItemStack(tankard_name))

                    new_full = meta:get_int("full") - 5
                    meta:set_int("full", new_full)
                    meta:set_string(
                        "infotext",
                        brewing_list[state].description .. "\n(" .. S("@1% full", new_full) .. ")"
                    )

                    if new_full <= 0 then

                        node.name = "unilib:misc_barrel_brewer_empty"
                        core.swap_node(pos, node)

                    end

                end

            end

        end,

        on_place = on_place_callback,
    })

end

function unilib.pkg.shared_beer_test.register_tool_barrel(data_table)

    -- Original to unilib
    -- Registers the barrel in the form of a tool, so that it can be placed and dug by a player
    --      while preserving its contents
    --
    -- data_table compulsory fields:
    --      full_name (str): e.g. "unilib:misc_barrel_brewer_with_beer_normal"
    --      orig_name (str): e.g. "beer_test:barrel_beer"
    --
    -- data_table optional fields:
    --      description (str): e.g. "Barrel of Beer (Normal Beer)"

    local full_name = data_table.full_name
    local orig_name = data_table.orig_name

    local description = data_table.description or S("Barrel")

    unilib.register_tool(full_name, orig_name, mode, {
        description = description,
        inventory_image = core.inventorycube(
            "unilib_misc_barrel_brewer_side_2.png",
            "unilib_misc_barrel_brewer_side_2.png",
            "unilib_misc_barrel_brewer_side.png"
        ),
        -- N.B. No groups in original code
        groups = {not_in_creative_inventory = 1},

        on_drop = on_place_callback,
        on_place = on_place_callback,
    })

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_beer_test.init()

    return {
        description = "Shared code for barrel/tankard sounds (from beer_test mod)",
    }

end
