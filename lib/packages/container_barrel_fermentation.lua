---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.container_barrel_fermentation = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

local barrel_description = S("Fermentation Barrel")
local low_water_msg = S("Water Level Low")
local added_water_msg = S("Water Added")
local no_recipe_msg = S("No Valid Recipe")
local output_full_msg = S("Output Full")

-- Time (in seconds) between each cycle of the barrel's timer
local cycle_time = 5

-- List of nodes used as water inlets: potable water sources, and water inlets from pipeworks.
--      Populated in the .post() function
local water_inlet_list = {}
-- Table of items used to fill the barrel (water nodes, buckets, glasses of water, etc). Populated
--      in the .post() function. Replaces the need for the original water_check() function
local water_input_table = {
    ["default:water_source"] = {"", 20},
    ["default:river_water_source"] = {"", 20},
    ["farming:glass_water"] = {"unilib:vessel_glass_empty", 5},
}

-- List of fermentation recipes, populated by calls from other packages to
--      unilib.pkg.container_barrel_fermentation.add_recipe(()
-- List of mini-lists. Each mini-list is in the form
--      { ingredient_list, output_str }
-- ...where the items in "ingredient_list" are full_names, and the string "output_str" can be a
--      full_name like "unilib:produce_grape_harvest" or an itemstring like
--      "unilib:produce_grape_harvest 2"
local recipe_list = {}

-- Check for other mods
local pipeworks_flag = core.get_modpath("pipeworks")
local unified_inventory_flag = core.get_modpath("unified_inventory")

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function get_formspec(item_percent, brewing, water_percent)

    return "size[8,9]" ..

        -- Images
        "image[0,0;7,5;unilib_container_barrel_fermentation_formspec_bg.png]" ..
        "image[5.88,1.8;1,1;unilib_container_barrel_fermentation_icon_bg.png^[lowpart:" ..
                item_percent .. ":unilib_container_barrel_fermentation_icon.png]" ..
        "image[1.04,2.7;4.45,1.65;unilib_container_barrel_fermentation_water.png" ..
        "^[colorize:#261c0e:175^[opacity:125" ..
        "^[lowpart:" .. water_percent .. ":unilib_container_barrel_fermentation_water.png]" ..

        -- Inside barrel tinv
        "list[current_name;src;1.9,0.7;2,2;]" ..
        "list[current_name;src_w;2.4,2.95;1,1;0]" ..

        -- Outside barrel inv
        "list[current_name;dst;7,1.8;1,1;]" ..
        "list[current_player;main;0,5;8,4;]" ..

        -- Tooltips
        "tooltip[5.88,1.8;1,1;" .. brewing .. "]" ..
        "tooltip[1.05,2.7;3.495,1.45;" .. S("Water @1% Full", water_percent) .. "]" ..

        -- Shift-click
        "listring[current_name;dst]" ..
        "listring[current_player;main]" ..
        "listring[current_name;src]" ..
        "listring[current_player;main]"

end

local function get_valid_recipe(inv)

    -- Code moved the original barrel's .on_timer()

    for _, mini_list in ipairs(recipe_list) do

        -- Check every item in the ingredient_list
        local match_flag = true
        for _, full_name in pairs(mini_list[1]) do

            local item = full_name and ItemStack(full_name)
            if item and not inv:contains_item("src", item) then
            
                match_flag = false
                break

            end

        end

        if match_flag then

            -- Valid recipe found; return its ingredient list, and output
            return mini_list[1], mini_list[2]

        end

    end

    -- No valid recipe found
    return nil

end

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_barrel_fermentation.add_recipe(ingredient_list, output)

    -- Was wine:add_item()
    -- Adds a fermentation recipe
    --
    -- Args:
    --      ingredient_list (list or str): If a list, then it must contain either a vessel (for
    --          example, "unilib:vessel_glass_empty") or some item that is already in a vessel (for
    --          example, a glass of milk). Note that the MAXIMUM size of the list is 4; any
    --          additional ingredients are ignored. If a string, then the value is converted to a
    --          list, and "unilib:vessel_glass_empty" is added automatically
    --      output (str): e.g. "unilib:drink_wine_normal_glass"

    if type(ingredient_list) == "string" then

        ingredient_list = {ingredient_list, "unilib:vessel_glass_empty"}

    elseif #ingredient_list > 4 then

        -- N.B. Original code also requires no more than 4 ingredients, but does nothing to enforce
        --      this rule
        for i = 5, #ingredient_list do
            ingredient_list[i] = nil
        end

    end

    table.insert(recipe_list, {ingredient_list, output})

    if unified_inventory_flag then

        unified_inventory.register_craft({
            type = "barrel",
            items = ingredient_list,
            output = output,
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.container_barrel_fermentation.init()

    return {
        description = "Fermentation barrel",
        notes = "Used to brew various alcoholic drinks. Right-click the barrel to open the" ..
                " formspec, where you can add the ingredients. Sources of potable water (such as" ..
                " filled buckets, but also including items such as a glass of water) can be" ..
                " added directly. Alternatively, place the barrel near water (flowing water" ..
                " fills the barrel at half the rate of a water source), or next to one of the" ..
                " water inlets provided by the \"pipeworks\" mod",
        mod_optional = "pipeworks",
        depends = {"metal_steel", "vessel_glass_empty"},
        optional = "vessel_glass_with_water",
        adult_flag = false,
    }

end

function unilib.pkg.container_barrel_fermentation.exec()

    unilib.register_node("unilib:container_barrel_fermentation", "wine:wine_barrel", mode, {
        -- From wine:wine_barrel
        description = unilib.utils.annotate(
            barrel_description, S("Add ingredients, vessels and water")
        ),
        tiles = {"unilib_container_barrel_fermentation.png" },
        groups = {choppy = 2, flammable = 2, oddly_breakable_by_hand = 1},
        -- (no sounds)

        drawtype = "mesh",
        mesh = "unilib_container_barrel_fermentation.obj",
        is_ground_content = false,
        paramtype = "light",
        paramtype2 = "facedir",

        allow_metadata_inventory_move = function(
            pos, from_list, from_index, to_list, to_index, count, player
        )
            if core.is_protected(pos, player:get_player_name()) then
                return 0
            end

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()
            local stack = inv:get_stack(from_list, from_index)

            if to_list == "src" then
                return count
            elseif to_list == "dst" then
                return 0
            elseif to_list == "src_w" then
                return 0
            end

        end,

        allow_metadata_inventory_put = function(pos, listname, index, stack, player)

            if core.is_protected(pos, player:get_player_name()) then
                return 0
            end

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()

            if listname == "src" then

                return stack:get_count()

            elseif listname == "src_w" then

                local water = meta:get_int("water")

                -- Water full, return item
                if water == 100 then
                    return 0
                end

                if water_input_table[stack:get_name()] ~= nil then
                    return stack:get_count()
                else
                    return 0
                end

            elseif listname == "dst" then

                return 0

            end

        end,

        allow_metadata_inventory_take = function(pos, listname, index, stack, player)

            if core.is_protected(pos, player:get_player_name()) then
                return 0
            end

            return stack:get_count()

        end,

        can_dig = function(pos,player)

            local meta = core.get_meta(pos)
            local inv = meta:get_inventory()

            if not inv:is_empty("dst") or
                    not inv:is_empty("src") or
                    not inv:is_empty("src_w") then
                return false
            end

            return true

        end,

        on_construct = function(pos)

            local meta = core.get_meta(pos)

            meta:set_string("formspec", get_formspec(0, "", 0))
            meta:set_string("infotext", barrel_description)
            meta:set_float("status", 0)

            local inv = meta:get_inventory()

            inv:set_size("src", 4)
            inv:set_size("src_w", 1)
            inv:set_size("dst", 1)

        end,

        on_metadata_inventory_move = function(pos)

            local timer = core.get_node_timer(pos)
            if not timer:is_started() then
                core.get_node_timer(pos):start(cycle_time)
            end

        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)

            if listname == "src_w" then

                local meta = core.get_meta(pos)
                local inv = meta:get_inventory()
                local water_input_name = inv:get_stack("src_w", 1):get_name()
                local mini_list = water_input_table[water_input_name]

                if mini_list ~= nil then

                    local water_replace_name = mini_list[1]
                    local water_capacity = tonumber(mini_list[2]) or 0

                    local water = meta:get_int("water")
                    water = water + water_capacity
                    if water > 100 then
                        water = 100
                    end

                    inv:remove_item("src_w", water_input_name)

                    -- If replacement found then add to inventory
                    if water_replace_name ~= "" then
                        inv:add_item("src_w", water_replace_name)
                    end

                    local status = meta:get_float("status")

                    meta:set_int("water", water)
                    meta:set_string("formspec", get_formspec(status, added_water_msg, water))

                end

            end

            local timer = core.get_node_timer(pos)
            if not timer:is_started() then
                core.get_node_timer(pos):start(cycle_time)
            end

        end,

        on_metadata_inventory_take = function(pos)

            local timer = core.get_node_timer(pos)
            if not timer:is_started() then
                core.get_node_timer(pos):start(cycle_time)
            end

        end,

        on_timer = function(pos)

            local meta = core.get_meta(pos)
            if not meta then
                return
            end

            local inv = meta:get_inventory()
            local water = meta:get_int("water") or 0

            -- Check for potable water sources, or water inlets from pipeworks
            if water < 100 then

                if core.find_node_near(pos, 1, water_inlet_list) then

                    water = water + 20
                    if water > 100 then
                        water = 100
                    end

                    meta:set_int("water", water)

                end

            end

            -- Is the barrel empty?
            if not inv or inv:is_empty("src") then

                meta:set_float("status", 0)
                meta:set_string("infotext", barrel_description)
                meta:set_string("formspec", get_formspec(0, "", water))

                return false

            end

            -- Check the water level
            if water < 5 then

                meta:set_string(
                    "infotext", unilib.utils.brackets(barrel_description, low_water_msg)
                )
                meta:set_float("status", 0)
                meta:set_string("formspec", get_formspec(0, "(" .. low_water_msg .. ")", water))
                return false

            end

            -- If the barrel doesn't contain a valid recipe, change its status
            local current_ingredient_list, current_output_str = get_valid_recipe(inv)
            if current_ingredient_list == nil then

                meta:set_string(
                    "infotext", unilib.utils.brackets(barrel_description, no_recipe_msg)
                )
                meta:set_float("status", 0)
                meta:set_string("formspec", get_formspec(0, "(" .. no_recipe_msg .. ")", water))
                return false

            end

            -- Is there room for additional fermentation?
            if not inv:room_for_item("dst", current_output_str) then

                meta:set_string(
                    "infotext", unilib.utils.brackets(barrel_description, output_full_msg)
                )
                meta:set_string("formspec", get_formspec(0, "(" .. output_full_msg .. ")", water))
                return false

            end

            -- While fermenting, change status
            local status = meta:get_float("status")
            if status < 100 then

                local done_msg = S("@1% Done", status)

                meta:set_string("infotext", unilib.utils.brackets(barrel_description, done_msg))
                meta:set_float("status", status + 5)

                local output_full_name, _ = unilib.utils.get_item_and_multiple(current_output_str)
                local output_description = ""

                if core.registered_items[output_full_name] ~= nil then

                    output_description = unilib.utils.get_first_line(
                        core.registered_items[output_full_name].description
                    )

                end

                local brewing_msg =
                    unilib.utils.brackets(S("Brewing: @1", output_description), done_msg)
                meta:set_string("formspec", get_formspec(status, brewing_msg, water))

            else

                -- When we hit 100%, remove ingredients and generate the beverage
                for _, ingredient_name in pairs(current_ingredient_list) do
                    inv:remove_item("src", ItemStack(ingredient_name))
                end

                inv:add_item("dst", current_output_str)

                water = water - 5

                meta:set_float("status", 0)
                meta:set_int("water", water)
                meta:set_string("formspec", get_formspec(0, "", water))

            end

            if inv:is_empty("src") then

                meta:set_float("status", 0.0)
                meta:set_string("infotext", barrel_description)

            end

            return true

        end

        -- N.B. Removed as it appears to support compatibility with older versions of the "wine" mod
        --[[
        -- Punch old barrel to change to new 4x slot variant and add a little water
        on_punch = function(pos, node, puncher, pointed_thing)

            local meta = core.get_meta(pos)
            local inv = meta and meta:get_inventory()
            local size = inv and inv:get_size("src")

            if size and size < 4 then

                inv:set_size("src", 4)
                inv:set_size("src_w", 1)

                meta:set_int("water", 50)
                meta:set_string("formspec", get_formspec(0, "", 50))

            end

        end,
        ]]--
    })
    unilib.register_craft({
        output = "unilib:container_barrel_fermentation",
        recipe = {
            {"group:wood", "group:wood", "group:wood"},
            {"unilib:metal_steel_ingot", "", "unilib:metal_steel_ingot"},
            {"group:wood", "group:wood", "group:wood"},
        },
    })

    if pipeworks_flag then

        unilib.override_item("unilib:container_barrel_fermentation", {

            groups = {
                -- "standard" for the "wine" mod groups
                choppy = 2, flammable = 2, oddly_breakable_by_hand = 1,
                -- pipeworks groups
                axey = 1, tubedevice = 1, tubedevice_receiver = 1,
            },

            pipe_connections = {
                left = 1, right = 1, front = 1, back = 1,
                left_param2 = 3, right_param2 = 1, front_param2 = 2, back_param2 = 0,
            },

            after_dig_node = function(pos)
                pipeworks.scan_for_pipe_objects(pos)
            end,

            tube = function()

                return {
                    can_insert = function(pos, node, stack, direction)

                        local meta = core.get_meta(pos)
                        local inv = meta:get_inventory()

                        return inv:room_for_item("src", stack)
                    end,

                    connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1},

                    -- The default stack, from which objects will be taken
                    input_inventory = "dst",

                    -- Using a different stack from default when inserting
                    insert_object = function(pos, node, stack, direction)

                        local meta = core.get_meta(pos)
                        local inv = meta:get_inventory()
                        local timer = core.get_node_timer(pos)

                        if not timer:is_started() then
                            timer:start(cycle_time)
                        end

                        return inv:add_item("src", stack)

                    end,
                }

            end,
        })

    end

    if unified_inventory_flag then

        unified_inventory.register_craft_type("barrel", {
            description = S("Barrel"),
            icon = "unilib_container_barrel_fermentation.png",
            width = 2,
            height = 2,
        })

    end

end

function unilib.pkg.container_barrel_fermentation.post()

    -- Populate the tables of valid sources of water

    for liquid_type, data_table in pairs(unilib.global.generic_liquid_table) do

        if data_table.water_flag and data_table.potable_flag then

            -- N.B. Unlike the original mod, we accept both the source and flowing nodes
            table.insert(water_inlet_list, data_table.source_name)
            table.insert(water_inlet_list, data_table.flowing_name)

            water_input_table[data_table.source_name] = {"", 20}
            water_input_table[data_table.flowing_name] = {"", 10}

        end

    end

    -- N.B. As in the original code, we accept pipeworks water inlets
    core.after(0.1, function()

        if core.get_modpath("pipeworks") then

            for _, full_name in pairs(pipeworks.pipes_full_nodenames) do
                table.insert(water_inlet_list, full_name)
            end

            unilib.utils.show_table(pipeworks.pipes_full_nodenames)

        end

    end)

    for _, mini_list in pairs(unilib.global.potable_bucket_list) do

        -- "mini_list" in the form {full_bucket, empty_bucket}
        water_input_table[mini_list[1]] = {mini_list[2], 20}

    end

    if unilib.global.pkg_executed_table["vessel_glass_with_water"] ~= nil then
        water_input_table["unilib:vessel_glass_with_water"] = {"unilib:vessel_glass_empty", 5}
    end

    -- Sort the recipe table to fix overlaps
    -- i.e. For two recipes with grapes, make sure the one with three ingredients is checked, before
    --      the one with just two ingredients (otherwise code in get_valid_recipe() will not work
    --      predictably)
    local temp_list = {}

    -- (As mentioned above, the maximum size of the ingredient list is 4)
    for l = 4, 1, -1 do

        for n = 1, #recipe_list do

            if #recipe_list[n][1] == l then
                table.insert(temp_list, recipe_list[n])
            end
        end
    end

    recipe_list = temp_list

end
