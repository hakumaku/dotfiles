-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

-- ##################
-- Customized configs
-- ##################

-- Set basic configs
local keys = require("config.keys")
local MyWibar = require("wibar.wibar")
local mymainmenu = require("wibar.widgets.mymainmenu")
local MyRules = require("config.rules")
local MySignals = require("wibar.signals")

beautiful.init(string.format("%s/awesome/themes/%s",
                             os.getenv("XDG_CONFIG_HOME"), "mytheme.lua"))
awful.layout.layouts = {awful.layout.suit.spiral, awful.layout.suit.floating}

local invoked = false
-- Draw wibar on each screen
awful.screen.connect_for_each_screen(function(s)
    -- Create the wibox
    local mywibar = MyWibar(s)
    s.mywibar = mywibar

    -- Because some shortcuts depend on widget instances,
    -- it has to set keymaps after wibar is created.
    if not invoked then
        invoked = true
        root.keys(keys.globalkeys(mywibar))
        awful.rules.rules = MyRules(mywibar.widgets)
        local mysignals = MySignals(mywibar.widgets)

        -- Set signals
        for event, callback in pairs(mysignals.client) do
            client.connect_signal(event, callback)
        end
        for event, callback in pairs(mysignals.screen) do
            screen.connect_signal(event, callback)
        end
    end
end)

root.buttons(gears.table.join(awful.button({}, 3, function()
    mymainmenu.create():toggle()
end)))

-- Miscellaneous settings
awful.screen.set_auto_dpi_enabled(true)
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
-- Run garbage collector regularly to prevent memory leaks
gears.timer {
    timeout = 100,
    autostart = true,
    callback = function()
        collectgarbage()
    end
}
