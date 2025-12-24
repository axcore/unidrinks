---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.shared_wine = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_wine.register_drink(data_table)

    -- Registers the glass and/or bottle variants of a drink drink
    --
    -- data_table compulsory fields:
    --      part_name (str): e.g. "wine_normal"
    --      glass_description (str): e.g. "Glass of Normal Wine"
    --      glass_orig_name (str): e.g. "wine:glass_wine"
    --      value_alcohol (int): e.g. 1
    --      value_hunger (int): e.g. 2
    --      value_thirst (int): e.g. 5; currently ignored (in unilib, all drinks fully quench
    --          thirst)
    --
    -- data_table optional fields:
    --      bottle_description (str): e.g. "Bottle of Normal Wine"; nil if the "wine" mod doesn't
    --          supply a bottle
    --      bottle_orig_name (str): e.g. "wine:bottle_wine"
    --      brew_msg (str): e.g. "Brewed with grapes and an empty glass"
    --      food_group (str): e.g. "food_wine". If specified, added to the glass node's .groups
    --          field with a value of one

    local part_name = data_table.part_name
    local glass_description = data_table.glass_description
    local glass_orig_name = data_table.glass_orig_name
    local value_alcohol = data_table.value_alcohol
    local value_hunger = data_table.value_hunger
    local value_thirst = data_table.value_thirst

    local bottle_description = data_table.bottle_description or nil
    local bottle_orig_name = data_table.bottle_orig_name or nil
    local brew_msg = data_table.brew_msg or nil
    local food_group = data_table.food_group or nil

    local c_glass = "unilib:drink_" .. part_name .. "_glass"
    local glass_img = "unilib_drink_" .. part_name .. "_glass.png"

    local description = glass_description
    if brew_msg ~= nil then
        description = unilib.utils.annotate(glass_description, brew_msg)
    end

    local glass_group_table = {
        alcohol = value_alcohol, attached_node = 1, dig_immediate = 3, drink = 1,
        eatable = value_hunger, flammable = 2, vessel = 1,
    }

    if food_group ~= nil then
        glass_group_table[food_group] = 1
    end

    unilib.register_node(c_glass, glass_orig_name, mode, {
        description = description,
        tiles = {glass_img},
        groups = glass_group_table,
        sounds = unilib.global.sound_table.glass,

        drawtype = "plantlike",
        inventory_image = glass_img,
        is_ground_content = false,
        paramtype = "light",
        selection_box = {
            type = "fixed",
            fixed = {-0.15, -0.5, -0.15, 0.15, 0, 0.15},
        },
        sunlight_propagates = true,
        visual_scale = 0.5,
        walkable = false,
        wield_image = glass_img,

        -- N.B. In original code, thirsty.drink() called with value_thirst
        on_use = unilib.cuisine.drink_on_use(c_glass, value_hunger),
    })

    if bottle_description ~= nil then

        local c_bottle = "unilib:drink_" .. part_name .. "_bottle"
        local bottle_img = "unilib_drink_" .. part_name .. "_bottle.png"

        unilib.register_node(c_bottle, bottle_orig_name, mode, {
            description = bottle_description,
            tiles = {bottle_img},
            groups = {attached_node = 1, dig_immediate = 3, vessel = 1},
            sounds = unilib.global.sound_table.node,

            drawtype = "plantlike",
            inventory_image = bottle_img,
            is_ground_content = false,
            paramtype = "light",
            selection_box = {
                type = "fixed",
                fixed = {-0.15, -0.5, -0.15, 0.15, 0.25, 0.15},
            },
            sunlight_propagates = true,
            visual_scale = 0.7,
            walkable = false,
        })
        unilib.register_craft_3x3({
            output = c_bottle,
            ingredient = c_glass,
        })
        unilib.register_craft({
            output = c_glass .. " 9",
            recipe = {
                {c_bottle},
            },
        })

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.shared_wine.init()

    return {
        description = "Shared functions for (mostly) alcoholic drinks (from wine mod)",
        adult_flag = false,
    }

end
