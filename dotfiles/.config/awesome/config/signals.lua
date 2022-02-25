local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
-- local menubar = require("menubar")

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- local icon = menubar.utils.lookup_icon(c.instance)
    -- local lower_icon = menubar.utils.lookup_icon(c.instance:lower())

    -- -- Check if the icon exists
    -- if icon ~= nil then
    --     local new_icon = gears.surface(icon)
    --     c.icon = new_icon._native

    --     -- Check if the icon exists in the lowercase variety
    -- elseif lower_icon ~= nil then
    --     local new_icon = gears.surface(lower_icon)
    --     c.icon = new_icon._native

    --     -- Check if the client already has an icon. If not, give it a default.
    -- elseif c.icon == nil then
    --     local new_icon = gears.surface(menubar.utils.lookup_icon(
    --                                        "application-default-icon"))
    --     c.icon = new_icon._native
    -- end

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup and not c.size_hints.user_position and
        not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end))

    awful.titlebar(c):setup{
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
