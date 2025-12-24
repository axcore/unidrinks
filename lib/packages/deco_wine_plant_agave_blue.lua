---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.deco_wine_plant_agave_blue = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

-- N.B. The same list of sand nodes appears in the "plant_agave_blue" package
local sand_list = {"unilib:sand_desert", "default:desert_sand"}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.deco_wine_plant_agave_blue.init()

    return {
        description = "Blue agave (as decoration)",
        depends = {"plant_agave_blue", "sand_desert"},
    }

end

function unilib.pkg.deco_wine_plant_agave_blue.post()

    unilib.register_decoration_complete("wine_plant_agave_blue", nil, {
        -- From wine/agave.lua
        -- Completes decoration in package "plant_agave_blue"
        -- N.B. Removed the .biomes field from the original code, so that agave can grow on desert
        --      sand in any biome
--      biomes = {"desert"},
        place_on = sand_list,
        spawn_by = sand_list,
        y_max = 50,
        y_min = 15,
    })

end
