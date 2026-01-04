---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.mapgen_beer_test = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

---------------------------------------------------------------------------------------------------
-- Local functions
---------------------------------------------------------------------------------------------------

local function make_hops(pos, size)

    for y = 0, size - 1 do

        local pos2 = {x = pos.x, y = pos.y + y, z = pos.z}
        local full_name = core.get_node(pos2).name

        if core.registered_nodes[full_name] and core.registered_nodes[full_name].buildable_to then
            core.set_node(pos2, {name = "unilib:plant_hops_wild"})
        else
            return
        end

    end

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.mapgen_beer_test.init()

    return {
        description = "Mapgen operations for beer_test. Spawns wild hops near apple trees and" ..
                " water, and wild brewer's oats on all spreading dirt-with-turfs",
        depends = {"plant_hops_wild", "plant_oat_brewer_wild", "tree_apple"},
    }

end

function unilib.pkg.mapgen_beer_test.post()

    core.register_on_generated(function(minp, maxp, seed)

        if maxp.y >= 2 and minp.y <= 0 then

            -- Generate wild hops
            local perlin1 = core.get_perlin(354, 3, 0.7, 100)
            -- Assume X and Z lengths are equal
            local divlen = 8
            local divs = (maxp.x - minp.x) / (divlen + 1)

            for divx = 0, divs - 1 do

                for divz = 0, divs - 1 do

                    local x0 = minp.x + math.floor((divx + 0) * divlen)
                    local z0 = minp.z + math.floor((divz + 0) * divlen)
                    local x1 = minp.x + math.floor((divx + 1) * divlen)
                    local z1 = minp.z + math.floor((divz + 1) * divlen)

                    -- Determine hops amount from perlin noise
                    local hops_amount = math.floor(perlin1:get_2d({x = x0, y = z0}) ^ 3 * 9)
                    -- Find random positions for hops based on this random
                    local pr = PseudoRandom(seed + 1)
                    for i = 0, hops_amount do

                        local x = pr:next(x0, x1)
                        local z = pr:next(z0, z1)
                        local full_name = core.get_node({x = x, y = 1, z = z}).name
                        -- N.B. In original code, required unilib:dirt_ordinary_with_turf
                        if core.get_item_group(full_name, "spreading_dirt") > 0 and
                                core.find_node_near(
                                    {x = x, y = 1, z = z}, 1, "unilib:tree_apple_trunk"
                                ) then
                            make_hops({x = x, y = 2, z = z}, pr:next(2, 4))
                        end

                    end

                end

            end

            -- Generate wild oats
            local perlin1 = core.get_perlin(329, 3, 0.6, 100)
            -- Assume X and Z lengths are equal
            local divlen = 16
            local divs = (maxp.x - minp.x) / (divlen + 1)

            for divx = 0, divs - 1 do

                for divz = 0, divs - 1 do

                    local x0 = minp.x + math.floor((divx + 0) * divlen)
                    local z0 = minp.z + math.floor((divz + 0) * divlen)
                    local x1 = minp.x + math.floor((divx + 1) * divlen)
                    local z1 = minp.z + math.floor((divz + 1) * divlen)
                    -- Determine grass amount from perlin noise
                    local grass_amount = math.floor(perlin1:get_2d({x = x0, y = z0}) ^ 1 * 5)
                    -- Find random positions for grass based on this random
                    local pr = PseudoRandom(seed + 1)
                    for i = 0, grass_amount do

                        local x = pr:next(x0, x1)
                        local z = pr:next(z0, z1)
                        -- Find ground level (0...15)
                        local ground_y = nil
                        for y = 30, 0, -1 do

                            if core.get_node({x = x, y = y, z = z}).name ~= "air" then

                                ground_y = y
                                break

                            end

                        end

                        if ground_y then

                            local pos2 = {x = x, y = ground_y + 1, z = z}
                            local full_name = core.get_node(pos2).name
                            -- Check if the node can be replaced
                            if core.registered_nodes[full_name] and
                                    core.registered_nodes[full_name].buildable_to then

                                full_name = core.get_node({x = x, y = ground_y, z = z}).name
                                -- If dirt with turf, add oats
                                if core.get_item_group(full_name, "spreading_dirt") > 0 then
                                    core.set_node(pos2, {name = "unilib:plant_oat_brewer_wild"})
                                end

                            end

                        end

                    end

                end

            end

        end

    end)

end
