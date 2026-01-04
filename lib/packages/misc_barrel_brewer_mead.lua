---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_barrel_brewer_mead = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

local brewing_list = {
    {
        interval = 15 * 60,
        description = S("Watery Apple Mead"),
        barrel_name = "unilib:misc_barrel_brewer_with_mead_watery",
        tankard_name = "unilib:vessel_tankard_mead_unbrewed",
    },
    {
        interval = 10 * 60,
        description = S("Fermenting Apple Mead"),
        barrel_name = "unilib:misc_barrel_brewer_with_mead_fermenting",
        tankard_name = "unilib:vessel_tankard_mead_unbrewed",
    },
    {
        interval = 10 * 60,
        description = S("Light Apple Mead"),
        barrel_name = "unilib:misc_barrel_brewer_with_mead_light",
        tankard_name = "unilib:vessel_tankard_mead_light",
    },
    {
        interval = 10 * 60,
        description = S("Normal Apple Mead"),
        barrel_name = "unilib:misc_barrel_brewer_with_mead_normal",
        tankard_name = "unilib:vessel_tankard_mead_normal",
    },
    {
        interval = 1,
        description = S("Dark Apple Mead"),
        barrel_name = "unilib:misc_barrel_brewer_with_mead_dark",
        tankard_name = "unilib:vessel_tankard_mead_dark",
    },
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_barrel_brewer_mead.init()

    return {
        description = "Barrel of mead",
        notes = "Brewing mead in a brewer's barrel works much like brewing beer; see the notes" ..
                " in the \"misc_barrel_brewer_beer\" package",
        depends = {
            "ingredient_grain_mead",
            "misc_barrel_brewer_empty",
            "shared_beer_test",
            "vessel_tankard_empty",
        },
    }

end

function unilib.pkg.misc_barrel_brewer_mead.exec()

    -- Barrels (as nodes)

    unilib.pkg.shared_beer_test.register_waiting_barrel({
        -- From beer_test:barrel_mixed_mead_grain. Creates unilib:misc_barrel_brewer_mead
        part_name = "mead",
        orig_name = "beer_test:barrel_mixed_mead_grain",
        brewing_list = brewing_list,
        ingredient = "unilib:ingredient_grain_mead",

        description = S("Barrel of Mead"),
        -- N.B. not_in_creative_inventory = 1 not in original code
        group_table = {cracky = 2, not_in_creative_inventory = 1},
        overlay_img = "unilib_misc_barrel_brewer_mead_overlay.png",
    })

    unilib.pkg.shared_beer_test.register_brewing_barrel({
        -- From beer_test:barrel_mead_brewing. Creates unilib:misc_barrel_brewer_mead_brewing
        part_name = "mead",
        orig_name = "beer_test:barrel_mead_brewing",
        brewing_list = brewing_list,

        description = S("Barrel of Mead"),
    })

    unilib.pkg.shared_beer_test.register_brewed_barrel({
        -- From beer_test:barrel_mead_brewed. Creates unilib:misc_barrel_brewer_beer_brewed
        part_name = "mead",
        orig_name = "beer_test:barrel_mead_brewed",
        brewing_list = brewing_list,
    })

    -- Barrels (as tools; tool wear preserves how full/empty the barrel node was, before being dug)

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_watery_mead. Creates unilib:misc_barrel_brewer_with_mead_watery
        full_name = "unilib:misc_barrel_brewer_with_mead_watery",
        orig_name = "beer_test:barrel_watery_mead",

        description = unilib.utils.brackets(S("Barrel of Mead"), S("Watery Malt")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_fermenting_mead. Creates
        --      unilib:misc_barrel_brewer_with_mead_fermenting
        full_name = "unilib:misc_barrel_brewer_with_mead_fermenting",
        orig_name = "beer_test:barrel_fermenting_mead",

        description = unilib.utils.brackets(S("Barrel of Mead"), S("Fermenting Malt")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_light_mead. Creates unilib:misc_barrel_brewer_with_mead_light
        full_name = "unilib:misc_barrel_brewer_with_mead_light",
        orig_name = "beer_test:barrel_light_mead",

        description = unilib.utils.brackets(S("Barrel of Mead"), S("Light Apple Mead")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_mead. unilib:misc_barrel_brewer_with_mead_normal
        full_name = "unilib:misc_barrel_brewer_with_mead_normal",
        orig_name = "beer_test:barrel_mead",

        description = unilib.utils.brackets(S("Barrel of Mead"), S("Normal Apple Mead")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_dark_mead. Creates unilib:misc_barrel_brewer_with_mead_dark
        full_name = "unilib:misc_barrel_brewer_with_mead_dark",
        orig_name = "beer_test:barrel_dark_mead",

        description = unilib.utils.brackets(S("Barrel of Mead"), S("Dark Apple Mead")),
    })

    -- Tankards

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_unbrewed_mead. Creates unilib:vessel_tankard_mead_unbrewed
        part_name = "mead_unbrewed",
        orig_name = "beer_test:tankard_unbrewed_mead",

        description = S("Tankard of Unbrewed Apple Mead"),
        overflowing_flag = false,
        top_img = "unilib_vessel_tankard_top_mead_unbrewed.png",
        value_alcohol = 2,
    })

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_light_mead. Creates unilib:vessel_tankard_mead_light
        part_name = "mead_light",
        orig_name = "beer_test:tankard_light_mead",

        description = S("Tankard of Light Apple Mead"),
        overflowing_flag = false,
        top_img = "unilib_vessel_tankard_top_mead_light.png",
        value_alcohol = 2,
    })

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_mead. Creates unilib:vessel_tankard_mead_normal
        part_name = "mead_normal",
        orig_name = "beer_test:tankard_mead",

        description = S("Tankard of Normal Apple Mead"),
        overflowing_flag = false,
        top_img = "unilib_vessel_tankard_top_mead_normal.png",
        value_alcohol = 2,
    })

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_dark_mead. Creates unilib:vessel_tankard_mead_dark
        part_name = "mead_dark",
        orig_name = "beer_test:tankard_dark_mead",

        description = S("Tankard of Dark Apple Mead"),
        overflowing_flag = false,
        top_img = "unilib_vessel_tankard_top_mead_dark.png",
        value_alcohol = 2,
    })

end
