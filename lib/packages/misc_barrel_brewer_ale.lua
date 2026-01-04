---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_barrel_brewer_ale = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

local brewing_list = {
    {
        interval = 15 * 60,
        description = S("Watery Malt"),
        barrel_name = "unilib:misc_barrel_brewer_with_ale_watery",
        tankard_name = "unilib:vessel_tankard_ale_unbrewed",
    },
    {
        interval = 10 * 60,
        description = S("Fermenting Malt"),
        barrel_name = "unilib:misc_barrel_brewer_with_ale_fermenting",
        tankard_name = "unilib:vessel_tankard_ale_unbrewed",
    },
    {
        interval = 10 * 60,
        description = S("Light Ale"),
        barrel_name = "unilib:misc_barrel_brewer_with_ale_light",
        tankard_name = "unilib:vessel_tankard_ale_light",
    },
    {
        interval = 10 * 60,
        description = S("Normal Ale"),
        barrel_name = "unilib:misc_barrel_brewer_with_ale_normal",
        tankard_name = "unilib:vessel_tankard_ale_normal",
    },
    {
        interval = 1,
        description = S("Dark Ale"),
        barrel_name = "unilib:misc_barrel_brewer_with_ale_dark",
        tankard_name = "unilib:vessel_tankard_ale_dark",
    },
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_barrel_brewer_ale.init()

    return {
        description = "Barrel of ale",
        notes = "Brewing ale in a brewer's barrel works much like brewing beer; see the notes" ..
                " in the \"misc_barrel_brewer_beer\" package",
        depends = {
            "ingredient_grain_ale",
            "misc_barrel_brewer_empty",
            "shared_beer_test",
            "vessel_tankard_empty",
        },
    }

end

function unilib.pkg.misc_barrel_brewer_ale.exec()

    -- Barrels (as nodes)

    unilib.pkg.shared_beer_test.register_waiting_barrel({
        -- From beer_test:barrel_mixed_ale_grain. Creates unilib:misc_barrel_brewer_ale
        part_name = "ale",
        orig_name = "beer_test:barrel_mixed_ale_grain",
        brewing_list = brewing_list,
        ingredient = "unilib:ingredient_grain_ale",

        description = S("Barrel of Ale"),
        -- N.B. not_in_creative_inventory = 1 not in original code
        group_table = {cracky = 2, not_in_creative_inventory = 1},
        overlay_img = "unilib_misc_barrel_brewer_ale_overlay.png",
    })

    unilib.pkg.shared_beer_test.register_brewing_barrel({
        -- From beer_test:barrel_ale_brewing. Creates unilib:misc_barrel_brewer_ale_brewing
        part_name = "ale",
        orig_name = "beer_test:barrel_ale_brewing",
        brewing_list = brewing_list,

        description = S("Barrel of Ale"),
    })

    unilib.pkg.shared_beer_test.register_brewed_barrel({
        -- From beer_test:barrel_ale_brewed. Creates unilib:misc_barrel_brewer_beer_brewed
        part_name = "ale",
        orig_name = "beer_test:barrel_ale_brewed",
        brewing_list = brewing_list,
    })

    -- Barrels (as tools; tool wear preserves how full/empty the barrel node was, before being dug)

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_watery_ale. Create unilib:misc_barrel_brewer_with_ale_watery
        full_name = "unilib:misc_barrel_brewer_with_ale_watery",
        orig_name = "beer_test:barrel_watery_ale",

        description = unilib.utils.brackets(S("Barrel of Ale"), S("Watery Malt")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_fermenting_ale. Creates
        --      unilib:misc_barrel_brewer_with_ale_fermenting
        full_name = "unilib:misc_barrel_brewer_with_ale_fermenting",
        orig_name = "beer_test:barrel_fermenting_ale",

        description = unilib.utils.brackets(S("Barrel of Ale"), S("Fermenting Malt")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_light_ale. Creates unilib:misc_barrel_brewer_with_ale_light
        full_name = "unilib:misc_barrel_brewer_with_ale_light",
        orig_name = "beer_test:barrel_light_ale",

        description = unilib.utils.brackets(S("Barrel of Ale"), S("Light Ale")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_ale. Creates unilib:misc_barrel_brewer_with_ale_normal
        full_name = "unilib:misc_barrel_brewer_with_ale_normal",
        orig_name = "beer_test:barrel_ale",

        description = unilib.utils.brackets(S("Barrel of Ale"), S("Normal Ale")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_dark_ale. Creates unilib:misc_barrel_brewer_with_ale_dark
        full_name = "unilib:misc_barrel_brewer_with_ale_dark",
        orig_name = "beer_test:barrel_dark_ale",

        description = unilib.utils.brackets(S("Barrel of Ale"), S("Black Ale")),
    })

    -- Tankards

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_unbrewed_ale. Creates unilib:vessel_tankard_ale_unbrewed
        part_name = "ale_unbrewed",
        orig_name = "beer_test:tankard_unbrewed_ale",

        description = S("Tankard of Unbrewed Ale"),
        overflowing_flag = false,
        top_img = "unilib_vessel_tankard_top_ale_unbrewed.png",
        value_alcohol = 1,
    })

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_light_ale. Creates unilib:vessel_tankard_ale_light
        part_name = "ale_light",
        orig_name = "beer_test:tankard_light_ale",

        description = S("Tankard of Light Ale"),
        overflowing_flag = false,
        top_img = "unilib_vessel_tankard_top_ale_light.png",
        value_alcohol = 1,
    })

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_ale. Creates unilib:vessel_tankard_ale_normal
        part_name = "ale_normal",
        orig_name = "beer_test:tankard_ale",

        description = S("Tankard of Normal Ale"),
        overflowing_flag = false,
        top_img = "unilib_vessel_tankard_top_ale_normal.png",
        value_alcohol = 1,
    })

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_dark_ale. Creates unilib:vessel_tankard_ale_dark
        part_name = "ale_dark",
        orig_name = "beer_test:tankard_dark_ale",

        description = S("Tankard of Black Ale"),
        overflowing_flag = false,
        top_img = "unilib_vessel_tankard_top_ale_dark.png",
        value_alcohol = 1,
    })

end
