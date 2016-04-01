awful     = require("awful")
naughty   = require("naughty")
beautiful = require("beautiful")
lain      = require("lain")
markup = lain.util.markup


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

local here = awful.util.getdir("config")

-- Themes define colours, icons, font and wallpapers.
beautiful.init("/usr/share/awesome/themes/default/theme.lua")

dofile( here .. "/" .. "variabels.lua")
dofile( here .. "/" .. "default.lua")
dofile( here .. "/" .. "widgets.lua")
dofile( here .. "/" .. "keys.lua")
dofile( here .. "/" .. "client_rules.lua")
-- Autostart is now handeled directly in xinitrc
-- dofile( here .. "/" .. "autostart.lua")

-- Set keys
root.keys(globalkeys)
-- }}}