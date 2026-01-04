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
function default.make_hops(pos, size)
    for y=0,size-1 do
        local p = {x=pos.x, y=pos.y+y, z=pos.z}
        local nn = minetest.get_node(p).name
        if minetest.registered_nodes[nn] and
            minetest.registered_nodes[nn].buildable_to then
            minetest.set_node(p, {name="beer_test:wild_hops"})
        else
            return
        end
    end
end

minetest.register_on_generated(function(minp, maxp, seed)
if maxp.y >= 2 and minp.y <= 0 then
    -- Generate hops
    local perlin1 = minetest.get_perlin(354, 3, 0.7, 100)
    -- Assume X and Z lengths are equal
    local divlen = 8
    local divs = (maxp.x-minp.x)/divlen+1;
    for divx=0,divs-1 do
    for divz=0,divs-1 do
        local x0 = minp.x + math.floor((divx+0)*divlen)
        local z0 = minp.z + math.floor((divz+0)*divlen)
        local x1 = minp.x + math.floor((divx+1)*divlen)
        local z1 = minp.z + math.floor((divz+1)*divlen)
        -- Determine hops amount from perlin noise
        local hops_amount = math.floor(perlin1:get2d({x=x0, y=z0}) ^ 3 * 9)
        -- Find random positions for hops based on this random
        local pr = PseudoRandom(seed+1)
        for i=0,hops_amount do
            local x = pr:next(x0, x1)
            local z = pr:next(z0, z1)
                if minetest.get_node({x=x,y=1,z=z}).name == "default:dirt_with_grass" and
                    minetest.find_node_near({x=x,y=1,z=z}, 1, "default:tree") then
                    default.make_hops({x=x,y=2,z=z}, pr:next(2, 4))
                end
            end
        end
    end
    local perlin1 = minetest.get_perlin(329, 3, 0.6, 100)
    -- Assume X and Z lengths are equal
    local divlen = 16
    local divs = (maxp.x-minp.x)/divlen+1;
    for divx=0,divs-1 do
    for divz=0,divs-1 do
        local x0 = minp.x + math.floor((divx+0)*divlen)
        local z0 = minp.z + math.floor((divz+0)*divlen)
        local x1 = minp.x + math.floor((divx+1)*divlen)
        local z1 = minp.z + math.floor((divz+1)*divlen)
        -- Determine grass amount from perlin noise
        local grass_amount = math.floor(perlin1:get2d({x=x0, y=z0}) ^ 1 * 5)
        -- Find random positions for grass based on this random
        local pr = PseudoRandom(seed+1)
        for i=0,grass_amount do
            local x = pr:next(x0, x1)
            local z = pr:next(z0, z1)
        -- Find ground level (0...15)
            local ground_y = nil
            for y=30,0,-1 do
                if minetest.get_node({x=x,y=y,z=z}).name ~= "air" then
                    ground_y = y
                    break
                end
            end

            if ground_y then
                local p = {x=x,y=ground_y+1,z=z}
                local nn = minetest.get_node(p).name
                -- Check if the node can be replaced
                if minetest.registered_nodes[nn] and
                    minetest.registered_nodes[nn].buildable_to then
                    nn = minetest.get_node({x=x,y=ground_y,z=z}).name
                    -- If dirt with grass, add oats
                    if nn == "default:dirt_with_grass" then
                        minetest.set_node(p,{name="beer_test:wild_oats"})
                    end
                end
            end
        end
    end
    end
end
end)
]]--
