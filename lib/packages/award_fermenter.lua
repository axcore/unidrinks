---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- From:    unidrinks
-- Code:    LGPL 2.1
-- Media:   CC BY-SA 3.0
---------------------------------------------------------------------------------------------------

unilib.pkg.award_fermenter = {}

local S = unidrinks.intllib
local mode = unilib.global.imported_mod_table.unidrinks.add_mode

---------------------------------------------------------------------------------------------------
-- Shared variables
---------------------------------------------------------------------------------------------------

unilib.pkg.award_fermenter.vocation_name = "unidrinks_fermenter"

---------------------------------------------------------------------------------------------------
-- Shared functions
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_fermenter.on_ferment(player, full_name, multiple)

    if not unilib.setting.awards_enable_flag or
            not unilib.utils.is_player(player) or
            not full_name then
        return
    end

    unilib.awards.handle_complex_trigger(player, "fermenter_select_ferment", full_name, multiple)

end

---------------------------------------------------------------------------------------------------
-- New code
---------------------------------------------------------------------------------------------------

function unilib.pkg.award_fermenter.init()

    return {
        description = "Awards for the \"wine\" remix (\"Home Winemaker\")",
        notes = "Requires the unidrinks expansion pack",
    }

end

function unilib.pkg.award_fermenter.post()

    -- Sanity check -------------------------------------------------------------------------------

    if not unilib.setting.awards_enable_flag then
        return
    end

    -- Trigger prototypes -------------------------------------------------------------------------

    unilib.awards.register_trigger_prototype({
        name = "fermenter_select_ferment",
        trigger_type = "complex",
        hint_list = {"Ferment one glass", "Ferment @1 glasses"},
        progress_list = {"Ferment one glass", "Ferment @1/@2 glasses"},
    })

    -- Vocations ----------------------------------------------------------------------------------

    -- Assumes the "wine" remix with all drinks available, all step-by-step/fermenting/mixed drink
    --      achievements, but only 5 of the multiple-bottle achievements, total score 810
    unilib.awards.register_vocation({
        name = unilib.pkg.award_fermenter.vocation_name,

        title = S("Home Winemaker"),
        description = S("Learn how to ferment drinks in the comfort of your own home"),
        icon = "unilib_award_vocation_fermenter.png",
        level_list = {
            {title = S("Cask Me Another"), score = 10},
            {title = S("Spirit of the Times"), score = 20},
            {title = S("Rum for improvement"), score = 50},
            {title = S("Distill My Beating Heart"), score = 100},
            {title = S("Gin and Bear It"), score = 150},
            {title = S("Proof Positive"), score = 200},
            {title = S("Whiskey Business"), score = 300},
            {title = S("Ferment of the Stars"), score = 400},
            {title = S("Merlot and Behold"), score = 500},
            {title = S("Absinthe Makes the Heart Grow Fonder"), score = 600},
            {title = S("Liver Let Die"), score = 700},
            {title = S("Winecraft Legend"), score = 800},
        },
    })

    -- Achievements -------------------------------------------------------------------------------

    -- Selective achievements
    for i, mini_list in ipairs({
        -- Step-by-step achievements
        {"barrel", "unilib:container_barrel_fermentation", "unilib_break", S("Ferment of Opportunity"), S("Craft a fermenting barrel"), 20, 1},
        -- Fermenting achievements
        {"glass_beer", "unilib:drink_beer_normal_glass", "fermenter_select_ferment", S("The Final Draught I"), S("Ferment 3 glasses of normal beer"), 10, 3},
        {"glass_beer_wheat", "unilib:drink_beer_wheat_glass", "fermenter_select_ferment", S("Wheat Me Halfway I"), S("Ferment 3 glasses of wheat beer"), 10, 3},
        {"glass_champagne", "unilib:drink_champagne_normal_glass", "fermenter_select_ferment", S("Champagne Supernova I"), S("Ferment 3 glasses of normal champagne"), 10, 3},
        {"glass_cider", "unilib:drink_cider_normal_glass", "fermenter_select_ferment", S("Cider Side Quest I"), S("Ferment 3 glasses of normal cider"), 10, 3},
        {"glass_agave", "unilib:drink_juice_agave_sparkling_glass", "fermenter_select_ferment", S("Agave It a Try I"), S("Ferment 3 glasses of sparkling agave juice"), 10, 3},
        {"glass_apple", "unilib:drink_juice_apple_sparkling_glass", "fermenter_select_ferment", S("Core Values I"), S("Ferment 3 glasses of sparkling apple juice"), 10, 3},
        {"glass_blackberry", "unilib:drink_juice_blackberry_sparkling_glass", "fermenter_select_ferment", S("Juiced in Time I"), S("Ferment 3 glasses of sparkling blackberry juice"), 10, 3},
        {"glass_carrot", "unilib:drink_juice_carrot_sparkling_glass", "fermenter_select_ferment", S("Carrot Top I"), S("Ferment 3 glasses of sparkling carrot juice"), 10, 3},
        {"glass_kefir", "unilib:drink_kefir_glass", "fermenter_select_ferment", S("Kefir and Loathing I"), S("Ferment 3 glasses of kefir"), 10, 3},
        {"glass_coffee", "unilib:drink_liqueur_coffee_glass", "fermenter_select_ferment", S("Grounds for Celebration I"), S("Ferment 3 glasses of coffee liqueur"), 10, 3},
        {"glass_mead", "unilib:drink_mead_normal_glass", "fermenter_select_ferment", S("Mead and Greet I"), S("Ferment 3 glasses of normal mead"), 10, 3},
        {"glass_bourbon", "unilib:drink_spirit_bourbon_glass", "fermenter_select_ferment", S("Bourbon to Be Wild I"), S("Ferment 3 glasses of bourbon"), 10, 3},
        {"glass_cointreau", "unilib:drink_spirit_cointreau_glass", "fermenter_select_ferment", S("Cointreau‑versial I"), S("Ferment 3 glasses of cointreau"), 10, 3,},
        {"glass_rum", "unilib:drink_spirit_rum_glass", "fermenter_select_ferment", S("Rum With a View I"), S("Ferment 3 glasses of rum"), 10, 3},
        {"glass_tequila", "unilib:drink_spirit_tequila_glass", "fermenter_select_ferment", S("Tequila Mockingbird I"), S("Ferment 3 glasses of tequila"), 10, 3},
        {"glass_vodka", "unilib:drink_spirit_vodka_glass", "fermenter_select_ferment", S("Skål! I"), S("Ferment 3 glasses of vodka"), 10, 3},
        {"glass_wine", "unilib:drink_wine_normal_glass", "fermenter_select_ferment", S("Grape Expectations I"), S("Ferment 3 glasses of normal wine"), 10, 3},
        {"glass_sake", "unilib:drink_wine_sake_glass", "fermenter_select_ferment", S("For Goodness Sake I"), S("Ferment 3 glasses of sake"), 10, 3},
        -- Bottle achievements
        {"bottle_beer", "unilib:drink_beer_normal_bottle", "unilib_craft", S("The Final Draught II"), S("Craft a bottle of normal beer"), 20, 1},
        {"bottle_beer_wheat", "unilib:drink_beer_wheat_bottle", "unilib_craft", S("Wheat Me Halfway II"), S("Craft a bottle of wheat beer"), 20, 1},
        {"bottle_champagne", "unilib:drink_champagne_normal_bottle", "unilib_craft", S("Champagne Supernova II"), S("Craft a bottle of normal champagne"), 20, 1},
        {"bottle_cider", "unilib:drink_cider_normal_bottle", "unilib_craft", S("Cider Side Quest II"), S("Craft a bottle of normal cider"), 20, 1},
        {"bottle_agave", "unilib:drink_juice_agave_sparkling_bottle", "unilib_craft", S("Agave It a Try II"), S("Craft a bottle of sparkling agave juice"), 20, 1},
        {"bottle_apple", "unilib:drink_juice_apple_sparkling_bottle", "unilib_craft", S("Core Values II"), S("Craft a bottle of sparkling apple juice"), 20, 1},
        {"bottle_blackberry", "unilib:drink_juice_blackberry_sparkling_bottle", "unilib_craft", S("Juiced in Time II"), S("Craft a bottle of sparkling blackberry juice"), 20, 1},
        {"bottle_carrot", "unilib:drink_juice_carrot_sparkling_bottle", "unilib_craft", S("Carrot Top II"), S("Craft a bottle of sparkling carrot juice"), 20, 1},
        {"bottle_kefir", "unilib:drink_kefir_bottle", "unilib_craft", S("Kefir and Loathing II"), S("Craft a bottle of kefir"), 20, 1},
        {"bottle_coffee", "unilib:drink_liqueur_coffee_bottle", "unilib_craft", S("Grounds for Celebration II"), S("Craft a bottle of coffee liqueur"), 20, 1},
        {"bottle_mead", "unilib:drink_mead_normal_bottle", "unilib_craft", S("Mead and Greet II"), S("Craft a bottle of normal mead"), 20, 1},
        {"bottle_bourbon", "unilib:drink_spirit_bourbon_bottle", "unilib_craft", S("Bourbon to Be Wild II"), S("Craft a bottle of bourbon"), 20, 1},
        {"bottle_cointreau", "unilib:drink_spirit_cointreau_bottle", "unilib_craft", S("Cointreau‑versial II"), S("Craft a bottle of cointreau"), 20, 1},
        {"bottle_rum", "unilib:drink_spirit_rum_bottle", "unilib_craft", S("Rum With a View II"), S("Craft a bottle of rum"), 20, 1},
        {"bottle_tequila", "unilib:drink_spirit_tequila_bottle", "unilib_craft", S("Tequila Mockingbird II"), S("Craft a bottle of tequila"), 20, 1},
        {"bottle_vodka", "unilib:drink_spirit_vodka_bottle", "unilib_craft", S("Skål! II"), S("Craft a bottle of vodka"), 20, 1},
        {"bottle_wine", "unilib:drink_wine_normal_bottle", "unilib_craft", S("Grape Expectations II"), S("Craft a bottle of normal wine"), 20, 1},
        {"bottle_sake", "unilib:drink_wine_sake_bottle", "unilib_craft", S("For Goodness Sake II"), S("Craft a bottle of sake"), 20, 1},
        -- Multiple-bottle achievements
        {"case_beer", "unilib:drink_beer_normal_bottle", "unilib_craft", S("The Final Draught III"), S("Craft 12 bottles of normal beer"), 30, 12},
        {"case_beer_wheat", "unilib:drink_beer_wheat_bottle", "unilib_craft", S("Wheat Me Halfway III"), S("Craft 12 bottles of wheat beer"), 30, 12},
        {"case_champagne", "unilib:drink_champagne_normal_bottle", "unilib_craft", S("Champagne Supernova III"), S("Craft 12 bottles of normal champagne"), 30, 12},
        {"case_cider", "unilib:drink_cider_normal_bottle", "unilib_craft", S("Cider Side Quest III"), S("Craft 12 bottles of normal cider"), 30, 12},
        {"case_agave", "unilib:drink_juice_agave_sparkling_bottle", "unilib_craft", S("Agave It a Try III"), S("Craft 12 bottles of sparkling agave juice"), 30, 12},
        {"case_apple", "unilib:drink_juice_apple_sparkling_bottle", "unilib_craft", S("Core Values III"), S("Craft 12 bottles of sparkling apple juice"), 30, 12},
        {"case_blackberry", "unilib:drink_juice_blackberry_sparkling_bottle", "unilib_craft", S("Juiced in Time III"), S("Craft 12 bottles of sparkling blackberry juice"), 30, 12},
        {"case_carrot", "unilib:drink_juice_carrot_sparkling_bottle", "unilib_craft", S("Carrot Top III"), S("Craft 12 bottles of sparkling carrot juice"), 30, 12},
        {"case_kefir", "unilib:drink_kefir_bottle", "unilib_craft", S("Kefir and Loathing III"), S("Craft 12 bottles of kefir"), 30, 12},
        {"case_coffee", "unilib:drink_liqueur_coffee_bottle", "unilib_craft", S("Grounds for Celebration III"), S("Craft 12 bottles of coffee liqueur"), 30, 12},
        {"case_mead", "unilib:drink_mead_normal_bottle", "unilib_craft", S("Mead and Greet III"), S("Craft 12 bottles of normal mead"), 30, 12},
        {"case_bourbon", "unilib:drink_spirit_bourbon_bottle", "unilib_craft", S("Bourbon to Be Wild III"), S("Craft 12 bottles of bourbon"), 30, 12},
        {"case_cointreau", "unilib:drink_spirit_cointreau_bottle", "unilib_craft", S("Cointreau‑versial III"), S("Craft 12 bottles of cointreau"), 30, 12},
        {"case_rum", "unilib:drink_spirit_rum_bottle", "unilib_craft", S("Rum With a View III"), S("Craft 12 bottles of rum"), 30, 12},
        {"case_tequila", "unilib:drink_spirit_tequila_bottle", "unilib_craft", S("Tequila Mockingbird III"), S("Craft 12 bottles of tequila"), 30, 12},
        {"case_vodka", "unilib:drink_spirit_vodka_bottle", "unilib_craft", S("Skål! III"), S("Craft 12 bottles of vodka "), 30, 12},
        {"case_wine", "unilib:drink_wine_normal_bottle", "unilib_craft", S("Grape Expectations III"), S("Craft 12 bottles of normal wine"), 30, 12},
        {"case_sake", "unilib:drink_wine_sake_bottle", "unilib_craft", S("For Goodness Sake III"), S("Craft 12 bottles of sake"), 30, 12},
        -- Mixed drink achievements
        {"glass_brandy", "unilib:drink_spirit_brandy_glass", "unilib_craft", S("Brandy for the Road I"), S("Craft 3 glasses of brandy"), 20, 3},
        {"bottle_brandy", "unilib:drink_spirit_brandy_bottle", "unilib_craft", S("Brandy for the Road II"), S("Craft a bottle of brandy"), 20, 1},
        {"glass_mint", "unilib:drink_cocktail_mint_julep_glass", "unilib_craft", S("Mint Condition I"), S("Craft 3 glasses of mint julep"), 20, 3},
        {"bottle_mint", "unilib:drink_cocktail_mint_julep_bottle", "unilib_craft", S("Mint Condition II"), S("Craft a bottle of mint julep"), 20, 1},
        {"glass_margarita", "unilib:drink_cocktail_margarita_glass", "unilib_craft", S("Salt of the Earth I"), S("Craft 3 glasses of margarita"), 20, 3},
        -- N.B. No margarita bottle exists
    }) do

        if unilib.awards.check_argument(mini_list[2]) then

            unilib.awards.register_achievement({
                name = "unidrinks_fermenter_select_" .. mini_list[1],
                trigger_table = {
                    prototype = mini_list[3],
                    target = mini_list[7],
                    item_list = unilib.utils.convert_to_list(mini_list[2]),
                },

                title = mini_list[4],
                description = mini_list[5],
                score = mini_list[6],
                vocation_list = {unilib.pkg.award_fermenter.vocation_name},
            })

        end

    end

end
