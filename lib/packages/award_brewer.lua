---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unidrinks
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_brewer = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.unidrinks.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_brewer.vocation_name = "unidrinks_brewer"

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_brewer.on_fill_tankard(player, full_name)

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not full_name then
        return
    end

    unilib.awards.handle_complex_trigger(player, "brewer_select_fill", full_name, 1)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_brewer.init()

    return {
        description = "Awards for the \"beer_test\" remix (\"Home Brewer\")",
        notes = "Requires the unidrinks expansion pack",
    }

end

function unilib.pkg.award_brewer.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "brewer_select_fill",
        trigger_type = "complex",
        hint_list = {"Fill one tankard", "Fill @1 tankards"},
        progress_list = {"Fill one tankard", "Fill @1/@2 tankards"},
    })

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes the "beer_test" remix, providing a score of 210 for step-by-step achievements and
    --      450 for brewing achievements (total 660)
    unilib.awards.register_vocation({
        name = unilib.pkg.award_brewer.vocation_name,

        title = S("Home Brewer"),
        description = S("Learn how to brew beer in the comfort of your own home"),
        icon = "unilib_award_vocation_brewer.png",
        level_list = {
            {title = S("Hopless Beginner"), score = 10},
            {title = S("A Barrel of Laughs"), score = 20},
            {title = S("Foam Alone"), score = 40},
            {title = S("Hoptimist"), score = 60},
            {title = S("How Brewed!"), score = 100},
            {title = S("Lager than Life"), score = 150},
            {title = S("Brewed Awakening"), score = 200},
            {title = S("Critical Drinker"), score = 250},
            {title = S("Barrel Roller"), score = 300},
            {title = S("Running Your Own Pub"), score = 400},
            {title = S("Brewed to Perfection"), score = 500},
            {title = S("Ale's Well That Ends Well"), score = 650},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Selective achievements
    for i, mini_list in ipairs({
        -- Step-by-step achievements
        {"pick_oats", "unilib:plant_oat_brewer_wild", "unilib_break", S("Oastanding Effort"), S("Pick 5 wild brewer's oats"), 10, 5},
        {"pick_hops", "unilib:plant_hops_wild", "unilib_break", S("Hop to It"), S("Pick 5 wild hops"), 20, 5},
        {"frames", "unilib:misc_frame_planting", "unilib_place", S("Frame and Fortune"), S("Place 2 planting frames"), 10, 2},
        {"ropes_1", "unilib:rope_brewer_suspension", "unilib_place", S("Knot Ready"), S("Place 5 brewer's suspension ropes"), 10, 5},
        {"ropes_2", "unilib:rope_brewer_cultivation", "unilib_place", S("Pull Yourself Together"), S("Place 15 brewer's cultivation ropes"), 10, 15},
        {"harvest_hops", "unilib:crop_hops_harvest", "unilib_receive", S("Sow What"), S("Harvest 25 hops"), 20, 25},
        {"dry_hops", "unilib:crop_hops_harvest_dried", "unilib_receive", S("Hopless Case"), S("Dry 25 hops"), 20, 25},
        {"trays_1", "unilib:misc_tray_brewer_empty", "unilib_craft", S("Tray Harder"), S("Craft 3 empty brewer's trays"), 10, 3},
        {"trays_2", "unilib:misc_tray_brewer_wheat", "unilib_craft", S("Wheat a Minute"), S("Craft 3 wheat trays"), 10, 3},
        {"trays_3", "unilib:misc_tray_brewer_malt_normal", "unilib_break", S("Malt-i Tasker"), S("Obtain 3 normal malt trays"), 20, 3},
        {"grains_1", "unilib:ingredient_grain_beer", "unilib_craft", S("Hops and Dreams"), S("Craft mixed beer grains"), 20, 1},
        {"grains_2", "unilib:ingredient_grain_ale", "unilib_craft", S("Ale Be Seeing You"), S("Craft mixed ale grains"), 20, 1},
        {"grains_3", "unilib:ingredient_grain_mead", "unilib_craft", S("Mead Your Maker"), S("Craft mixed apple mead grains"), 20, 1},
        {"barrel", "unilib:misc_barrel_brewer_empty", "unilib_craft", S("That's How I Roll"), S("Craft a brewer's barrel"), 10, 1},
        -- Brewing achievements
        {"beer_light", "unilib:vessel_tankard_beer_light", "brewer_select_fill", S("Lager Enthusiast"), S("Fill 50 tankards with light beer"), 50, 50},
        {"beer_normal", "unilib:vessel_tankard_beer_normal", "brewer_select_fill", S("Light Drinker"), S("Fill 25 tankards with normal beer"), 50, 25},
        {"beer_dark", "unilib:vessel_tankard_beer_dark", "brewer_select_fill", S("Heavy Drinker"), S("Fill 10 tankards with dark beer"), 50, 10},
        {"ale_light", "unilib:vessel_tankard_ale_light", "brewer_select_fill", S("Real Ale Enthusiast"), S("Fill 50 tankards with light ale"), 50, 50},
        {"ale_normal", "unilib:vessel_tankard_ale_normal", "brewer_select_fill", S("Pint Puller"), S("Fill 25 tankards with normal ale"), 50, 25},
        {"ale_dark", "unilib:vessel_tankard_ale_dark", "brewer_select_fill", S("Bitter Veteran"), S("Fill 10 tankards with dark ale"), 50, 10},
        {"mead_light", "unilib:vessel_tankard_mead_light", "brewer_select_fill", S("Mead Enthusiast"), S("Fill 50 tankards with light apple mead"), 50, 50},
        {"mead_normal", "unilib:vessel_tankard_mead_normal", "brewer_select_fill", S("Buzz Seeker"), S("Fill 25 tankards with normal apple mead"), 50, 25},
        {"mead_dark", "unilib:vessel_tankard_mead_dark", "brewer_select_fill", S("Medieval Drinker"), S("Fill 10 tankards with dark apple mead"), 50, 10},
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unidrinks_brewer_select_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_brewer.vocation_name},
            })

        end

    end

end
