---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
-- add drink with bottle
function wine:add_drink(name, desc, has_bottle, num_hunger, num_thirst, alcoholic)

    -- glass
    minetest.register_node("wine:glass_" .. name, {
        description = S("Glass of " .. desc),
        drawtype = "plantlike",
        visual_scale = 0.5,
        tiles = {"wine_" .. name .. "_glass.png"},
        inventory_image = "wine_" .. name .. "_glass.png",
        wield_image = "wine_" .. name .. "_glass.png",
        paramtype = "light",
        is_ground_content = false,
        sunlight_propagates = true,
        walkable = false,
        selection_box = {
            type = "fixed", fixed = {-0.15, -0.5, -0.15, 0.15, 0, 0.15}
        },
        groups = {
            vessel = 1, dig_immediate = 3,
            attached_node = 1, drink = 1, alcohol = alcoholic
        },
        sounds = snd_g,

        on_use = function(itemstack, user, pointed_thing)

            if user then

                if thirsty_mod then
                    thirsty.drink(user, num_thirst)
                end

                return minetest.do_item_eat(num_hunger, "vessels:drinking_glass",
                        itemstack, user, pointed_thing)
            end
        end
    })

    wine.add_eatable("wine:glass_" .. name, num_hunger)

    -- bottle
    if has_bottle then

        minetest.register_node("wine:bottle_" .. name, {
            description = S("Bottle of " .. desc),
            drawtype = "plantlike",
            visual_scale = 0.7,
            tiles = {"wine_" .. name .. "_bottle.png"},
            inventory_image = "wine_" .. name .. "_bottle.png",
            paramtype = "light",
            is_ground_content = false,
            sunlight_propagates = true,
            walkable = false,
            selection_box = {
                type = "fixed", fixed = {-0.15, -0.5, -0.15, 0.15, 0.25, 0.15}
            },
            groups = {dig_immediate = 3, attached_node = 1, vessel = 1},
            sounds = snd_d,
        })

        local glass = "wine:glass_" .. name

        minetest.register_craft({
            output = "wine:bottle_" .. name,
            recipe = {
                {glass, glass, glass},
                {glass, glass, glass},
                {glass, glass, glass}
            }
        })

        minetest.register_craft({
            output = glass .. " 9",
            recipe = {{"wine:bottle_" .. name}}
        })
    end
end
]]--
