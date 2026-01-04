---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    beer_test
-- Code:    CC BY-SA 4.0
-- Media:   CC BY-SA 4.0
---------------------------------------------------------------------------------------------------

unilib.pkg.misc_barrel_brewer_beer = {}

local S = unilib.intllib
local mode = unilib.global.imported_mod_table.beer_test.add_mode

local brewing_list = {
    {
        interval = 15 * 60,
        description = S("Watery Malt"),
        barrel_name = "unilib:misc_barrel_brewer_with_beer_watery",
        tankard_name = "unilib:vessel_tankard_beer_unbrewed",
    },
    {
        interval = 10 * 60,
        description = S("Fermenting Malt"),
        barrel_name = "unilib:misc_barrel_brewer_with_beer_fermenting",
        tankard_name = "unilib:vessel_tankard_beer_unbrewed",
    },
    {
        interval = 10 * 60,
        description = S("Light Beer"),
        barrel_name = "unilib:misc_barrel_brewer_with_beer_light",
        tankard_name = "unilib:vessel_tankard_beer_light",
    },
    {
        interval = 10 * 60,
        description = S("Normal Beer"),
        barrel_name = "unilib:misc_barrel_brewer_with_beer_normal",
        tankard_name = "unilib:vessel_tankard_beer_normal",
    },
    {
        interval = 1,
        description = S("Dark Beer"),
        barrel_name = "unilib:misc_barrel_brewer_with_beer_dark",
        tankard_name = "unilib:vessel_tankard_beer_dark",
    },
}

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.misc_barrel_brewer_beer.init()

    return {
        description = "Barrel of beer",
        notes = "To brew beer, place an empty barrel, then left-click it with mixed beer grain." ..
                " The brewing process starts when you right-click the barrel with wood, thereby" ..
                " placing a \"lid\" on the barrel. The brewing process occurs in five stages," ..
                " from watery malt to dark beer, each lasting several minutes. At any stage," ..
                " left-click the barrel with an empty tankard to fill it with one of four" ..
                " types of beer. Alternatively, you can terminate the brewing process early by" ..
                " punching the barrel. When the barrel is empty, you can start a new brewing" ..
                " process (using any suitable grain). You can dig barrels and place them" ..
                " somewhere else; the amount of beer inside is preserved",
        depends = {
            "ingredient_grain_beer",
            "misc_barrel_brewer_empty",
            "shared_beer_test",
            "vessel_tankard_empty",
        },
    }

end

function unilib.pkg.misc_barrel_brewer_beer.exec()

    -- Barrels (as nodes)

    unilib.pkg.shared_beer_test.register_waiting_barrel({
        -- From beer_test:barrel_mixed_beer_grain. Creates unilib:misc_barrel_brewer_beer
        part_name = "beer",
        orig_name = "beer_test:barrel_mixed_beer_grain",
        brewing_list = brewing_list,
        ingredient = "unilib:ingredient_grain_beer",

        description = S("Barrel of Beer"),
        -- N.B. not_in_creative_inventory = 1 not in original code
        group_table = {choppy = 2, not_in_creative_inventory = 1, oddly_breakable_by_hand = 2},
        overlay_img = "unilib_misc_barrel_brewer_beer_overlay.png",
    })

    unilib.pkg.shared_beer_test.register_brewing_barrel({
        -- From beer_test:barrel_beer_brewing. Creates unilib:misc_barrel_brewer_beer_brewing
        part_name = "beer",
        orig_name = "beer_test:barrel_beer_brewing",
        brewing_list = brewing_list,

        description = S("Barrel of Beer"),
    })

    unilib.pkg.shared_beer_test.register_brewed_barrel({
        -- From beer_test:barrel_beer_brewed. Creates unilib:misc_barrel_brewer_beer_brewed
        part_name = "beer",
        orig_name = "beer_test:barrel_beer_brewed",
        brewing_list = brewing_list,
    })

    -- Barrels (as tools; tool wear preserves how full/empty the barrel node was, before being dug)

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_watery_malt. Creates unilib:misc_barrel_brewer_with_beer_watery
        full_name = "unilib:misc_barrel_brewer_with_beer_watery",
        orig_name = "beer_test:barrel_watery_malt",

        description = unilib.utils.brackets(S("Barrel of Beer"), S("Watery Malt")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_fermenting_malt. Creates
        --      unilib:misc_barrel_brewer_with_beer_fermenting
        full_name = "unilib:misc_barrel_brewer_with_beer_fermenting",
        orig_name = "beer_test:barrel_fermenting_malt",

        description = unilib.utils.brackets(S("Barrel of Beer"), S("Fermenting Malt")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_light_beer. Creates unilib:misc_barrel_brewer_with_beer_light
        full_name = "unilib:misc_barrel_brewer_with_beer_light",
        orig_name = "beer_test:barrel_light_beer",

        description = unilib.utils.brackets(S("Barrel of Beer"), S("Light Beer")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_beer. Creates unilib:misc_barrel_brewer_with_beer_normal
        full_name = "unilib:misc_barrel_brewer_with_beer_normal",
        orig_name = "beer_test:barrel_beer",

        description = unilib.utils.brackets(S("Barrel of Beer"), S("Normal Beer")),
    })

    unilib.pkg.shared_beer_test.register_tool_barrel({
        -- From beer_test:barrel_dark_beer. Creates unilib:misc_barrel_brewer_with_beer_dark
        full_name = "unilib:misc_barrel_brewer_with_beer_dark",
        orig_name = "beer_test:barrel_dark_beer",

        description = unilib.utils.brackets(S("Barrel of Beer"), S("Dark Beer")),
    })

    -- Tankards

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_unbrewed_beer. Creates unilib:vessel_tankard_beer_unbrewed
        part_name = "beer_unbrewed",
        orig_name = "beer_test:tankard_unbrewed_beer",

        description = S("Tankard of Unbrewed Beer"),
        overflowing_flag = false,
        top_img = "unilib_vessel_tankard_top_beer_unbrewed.png",
        value_alcohol = 1,
    })

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_light_beer. Creates unilib:vessel_tankard_beer_light
        part_name = "beer_light",
        orig_name = "beer_test:tankard_light_beer",

        description = S("Tankard of Light Beer"),
        -- N.B. false in original code
        overflowing_flag = true,
        top_img = "unilib_vessel_tankard_top_beer_light.png",
        value_alcohol = 1,
    })

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_beer. Creates unilib:vessel_tankard_beer_normal
        part_name = "beer_normal",
        orig_name = "beer_test:tankard_beer",

        description = S("Tankard of Normal Beer"),
        overflowing_flag = true,
        top_img = "unilib_vessel_tankard_top_beer_normal.png",
        value_alcohol = 1,
    })

    unilib.pkg.shared_beer_test.register_tankard({
        -- From beer_test:tankard_dark_beer. Creates unilib:vessel_tankard_beer_dark
        part_name = "beer_dark",
        orig_name = "beer_test:tankard_dark_beer",

        description = S("Tankard of Dark Beer"),
        overflowing_flag = true,
        top_img = "unilib_vessel_tankard_top_beer_dark.png",
        value_alcohol = 1,
    })

end
