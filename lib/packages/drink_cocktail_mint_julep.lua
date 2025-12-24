---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    wine
-- Code:    MIT
-- Media:   CC BY 3.0/CC BY-SA 3.0/CC BY-SA 3.0/CC0
---------------------------------------------------------------------------------------------------

unilib.pkg.drink_cocktail_mint_julep = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.wine.add_mode

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.drink_cocktail_mint_julep.init()

    return {
        description = "Mint julep",
        depends = "shared_wine",
        optional = {"crop_mint_normal", "drink_spirit_bourbon"},
        suggested = {
            "ingredient_sugar_normal",          -- group:food_sugar
        },
        adult_flag = true,
    }

end

function unilib.pkg.drink_cocktail_mint_julep.exec()

    unilib.pkg.shared_wine.register_drink({
        -- From wine:glass_mint, wine:bottle_mint. Produces unilib:drink_cocktail_mint_julep_glass,
        --      unilib:drink_cocktail_mint_julep_bottle
        part_name = "cocktail_mint_julep",
        glass_description = S("Glass of Mint Julep"),
        glass_orig_name = "wine:glass_mint",
        value_alcohol = 1,
        value_hunger = 4,
        value_thirst = 3,

        bottle_description = S("Bottle of Mint Julep"),
        bottle_orig_name = "wine:bottle_mint",
        brew_msg = nil,
    })

    if unilib.global.pkg_executed_table["crop_mint_normal"] ~= nil and
            unilib.global.pkg_executed_table["drink_spirit_bourbon"] ~= nil then

        local c_mint = "unilib:crop_mint_normal_harvest"

        unilib.register_craft({
            -- From wine:glass_mint
            output = "unilib:drink_cocktail_mint_julep_glass",
            recipe = {
                {c_mint, c_mint, c_mint},
                {"unilib:drink_spirit_bourbon_glass", "group:food_sugar", ""},
            },
        })

    end

end
