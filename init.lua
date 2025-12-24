---------------------------------------------------------------------------------------------------
-- unidrinks mod by A S Lewis, incorporating materials from many other mods
---------------------------------------------------------------------------------------------------
-- init.lua
--      Initialise the mod
---------------------------------------------------------------------------------------------------

local S = core.get_translator(core.get_current_modname())

---------------------------------------------------------------------------------------------------
-- Create global namespaces
---------------------------------------------------------------------------------------------------

unidrinks = {}

---------------------------------------------------------------------------------------------------
-- Set mod name/version
---------------------------------------------------------------------------------------------------

unidrinks.name = "unidrinks"

unidrinks.ver_max = 0
unidrinks.ver_min = 1
unidrinks.ver_rev = 0

unidrinks.intllib = S

---------------------------------------------------------------------------------------------------
-- Initial setup
---------------------------------------------------------------------------------------------------

-- Tell unilib to use this mod as an expansion pack (in addition to any other expansion packs that
--      have already been loaded)
if not core.global_exists("unilib_expansion") then

    unilib_expansion = {}
    unilib_expansion.ext_pack_list = {"unidrinks"}

else

    table.insert(unilib_expansion.ext_pack_list, "unidrinks")

end

-- Show a warning if unilib's adult content flag is not enabled
if core.settings:get_bool("unidrinks_show_warning_flag", true) then

    core.after(0.1, function()

        if not unilib.setting.enable_adult_content_flag then

            unilib.utils.show_warning(
                S(
                    "unilib's adult content setting is disabled, so most packages from the" ..
                    " unidrinks expansion pack can't be loaded. Either disable this warning in" ..
                    " unidrinks settings, or enable adult content in unilib settings."
                )
            )

        end

    end)

end
