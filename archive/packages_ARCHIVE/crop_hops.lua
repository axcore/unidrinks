---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
-- Original code
---------------------------------------------------------------------------------------------------

--[[
minetest.register_craftitem("beer_test:seed_hops", {
    description = "hops Seed",
    inventory_image = "beer_test_hops_seed.png",
})
minetest.register_craft({
    output = "beer_test:seed_hops",
    recipe = {
        {"beer_test:hops"},

    }
})

for i=1,8 do
    local drop = {
        items = {
            {items = {'beer_test:hops'},rarity=9-i},
            {items = {'beer_test:hops'},rarity=18-i*2},
            {items = {'beer_test:hops'},rarity=27-i*3},
            {items = {'beer_test:seed_hops'},rarity=9-i},
            {items = {'beer_test:seed_hops'},rarity=18-i*2},
            {items = {'beer_test:seed_hops'},rarity=27-i*3},
            {items = {'beer_test:crop'},rarity=1-i},
        }
    }
    minetest.register_node("beer_test:hops_"..i, {
        drawtype = "plantlike",
        tiles = {"beer_test_hops_"..i..".png^beer_test_crop.png"},
        paramtype = "light",
        walkable = false,
        is_ground_content = true,
        drop = drop,
        groups = {snappy=3,flammable=2,plant=1,hops=i,not_in_creative_inventory=1},
        sounds = default.node_sound_leaves_defaults(),
    })
end

minetest.register_node("beer_test:hops_9", {
drawtype = "nodebox",
    tiles = {"beer_test_hops_8.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drop = "beer_test:growing_rope_down",
    is_ground_content = true,
    walkable = false,
    buildable_to = true,
    groups = {cracky=2,not_in_creative_inventory=1},
    sounds = default.node_sound_wood_defaults(),
    node_box = {
            type = "fixed",
            fixed = {
                {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}, -- side f
                {-0.3, -0.5, 0.2, 0.3, 0.5, 0.2}, -- side f
                {-0.3, -0.5, -0.2, 0.3, 0.5, -0.2}, -- side f
                {-0.2, -0.5, 0.3, -0.2, 0.5, -0.3}, -- side f
                {0.2, -0.5, 0.3, 0.2, 0.5, -0.3}, -- side f
                {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1}, -- side f

            },
        },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}, -- side f
        },
    },

})

minetest.register_node("beer_test:hops_9a", {
drawtype = "nodebox",
    tiles = {"beer_test_hops_9.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    drop = "beer_test:growing_rope_down",
    is_ground_content = true,
    walkable = false,
    buildable_to = true,
    groups = {cracky=2,not_in_creative_inventory=1},
    sounds = default.node_sound_wood_defaults(),
    node_box = {
            type = "fixed",
            fixed = {
                {-0.2, -0.5, -0.2, 0.2, 0.5, 0.2}, -- side f
                {-0.3, -0.5, 0.2, 0.3, 0.5, 0.2}, -- side f
                {-0.3, -0.5, -0.2, 0.3, 0.5, -0.2}, -- side f
                {-0.2, -0.5, 0.3, -0.2, 0.5, -0.3}, -- side f
                {0.2, -0.5, 0.3, 0.2, 0.5, -0.3}, -- side f
                {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1}, -- side f

            },
        },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}, -- side f
        },
    },
    on_punch = function(pos, node, puncher)
            local tool = puncher:get_wielded_item():get_name()
            if tool and tool == "" then
                node.name = "beer_test:hops_9"
                minetest.env:set_node(pos, node)
                puncher:get_inventory():add_item("main", ItemStack("beer_test:hops"))
            end
        end
})

minetest.register_node("beer_test:hops", {
    description = "Hops",
    walkable = false,
    paramtype = "light",
    drawtype = "plantlike",
    tiles = {"beer_test_hops.png"},
    inventory_image = "beer_test_hops.png",
    groups = {snappy=3, flammable=2},
    sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("beer_test:hops_dried_1", {
    description = "Drying Hops",
    walkable = false,
    paramtype = "light",
    drawtype = "plantlike",
    tiles = {"beer_test_hops_dryed_1.png"},
    inventory_image = "beer_test_hops_dryed_1.png",
    groups = {snappy=3, flammable=2},
    sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("beer_test:hops_dried_2", {
    description = "Dryed Hops",
    walkable = false,
    paramtype = "light",
    drawtype = "plantlike",
    tiles = {"beer_test_hops_dryed_2.png"},
    inventory_image = "beer_test_hops_dryed_2.png",
    groups = {snappy=3, flammable=2},
    sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
    nodenames = {"group:hops"},
    neighbors = {"group:soil"},
    interval = 80,
    chance = 2,
    action = function(pos, node)
        -- return if already full grown
        if minetest.get_item_group(node.name, "hops") == 8 then
            return
        end

        -- check if on wet soil
        pos.y = pos.y-1
        local n = minetest.get_node(pos)
        if minetest.get_item_group(n.name, "soil") < 3 then
            return
        end
        pos.y = pos.y+1

        -- check light
        if not minetest.get_node_light(pos) then
            return
        end
        if minetest.get_node_light(pos) < 13 then
            return
        end

        -- grow
        local height = minetest.get_item_group(node.name, "hops") + 1
        minetest.set_node(pos, {name="beer_test:hops_"..height})
    end
})

minetest.register_abm({
    nodenames = {"beer_test:hops", "beer_test:hops_dried_1"},
    interval = 15,
    chance = 4,
    action = function(pos, node)
        pos.y = pos.y+1
        local nn = minetest.get_node(pos).name
        pos.y = pos.y-1
        if minetest.registered_nodes[nn] and minetest.registered_nodes[nn].walkable then
            minetest.set_node(pos, {name="beer_test:hops_dried_2"})
        end
        -- check if there is water nearby
        if minetest.find_node_near(pos, 5, {"air"}) then
            -- if it is dry soil turn it into wet soil
            if node.name == "beer_test:hops" then
                minetest.set_node(pos, {name="beer_test:hops_dried_1"})
            end
        end
    end,
})

minetest.register_abm({
    nodenames = {"beer_test:hops_8", "beer_test:hops_9"},
    interval = 15,
    chance = 5,
    action = function(pos, node)
        pos.y = pos.y+1
        local nn = minetest.get_node(pos).name
        pos.y = pos.y-1
        if minetest.registered_nodes[nn] and minetest.registered_nodes[nn].walkable then
            minetest.set_node(pos, {name="beer_test:hops_8"})
        end
        -- check if there is air nearby
        if minetest.find_node_near(pos, 5, {"air"}) then
            if node.name == "beer_test:hops_8" then
                minetest.set_node(pos, {name="beer_test:hops_9"})
            end
        end
    end,
})

minetest.register_abm({
    nodenames = {"beer_test:hops_9", "beer_test:hops_9a"},
    interval = 30,
    chance = 50,
    action = function(pos, node)
        pos.y = pos.y+1
        local nn = minetest.get_node(pos).name
        pos.y = pos.y-1
        if minetest.registered_nodes[nn] and minetest.registered_nodes[nn].walkable then
            minetest.set_node(pos, {name="beer_test:hops_9"})
        end
        -- check if there is air nearby
        if minetest.find_node_near(pos, 5, {"air"}) then
            if node.name == "beer_test:hops_9" then
                minetest.set_node(pos, {name="beer_test:hops_9a"})
            end
        end
    end,
})

minetest.register_abm({
    nodenames = {"beer_test:hops_9a"},
    neighbors = {"farming:soil_wet"},
    interval = 50,
    chance = 20,
    action = function(pos, node)
        pos.y = pos.y-1
        local name = minetest.get_node(pos).name
        if name == "farming:soil_wet" or name == "default:dirt_with_grass" or name == "farming:soil" or name == "default:dirt" then
            pos.y = pos.y+1
            local height = 0
            while minetest.get_node(pos).name == "beer_test:hops_9a" and height < 4 do
                height = height+1
                pos.y = pos.y+1
            end
            if height < 4 then
                if minetest.get_node(pos).name == "beer_test:growing_rope_down" then
                    minetest.set_node(pos, {name="beer_test:hops_9"})
                end
            end
        end
    end,
})
]]--
