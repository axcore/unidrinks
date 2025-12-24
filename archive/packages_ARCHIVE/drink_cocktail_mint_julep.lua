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
wine:add_drink("mint", "Mint Julep", true, 4, 3, 1)

minetest.register_craft({
    output = "wine:glass_mint",
    recipe = {
        {"farming:mint_leaf", "farming:mint_leaf", "farming:mint_leaf"},
        {"wine:glass_bourbon", "farming:sugar", ""}
    }
})
]]--
