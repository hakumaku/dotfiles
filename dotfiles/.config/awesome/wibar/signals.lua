local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local wallpaper = require("wibar.widgets.wallpaper")

local M = {}

---@param widgets MyWidget
---@return table
local function create(widgets)
    local taglist = widgets.taglist

    local rules = {
        screen = {},
        client = {
            tagged = function(c)
                -- Replace tag name with an app icon.
                taglist:set_icon(c)
            end,
            untagged = function(c)
                -- Set tag name back to the previous state.
                taglist:reset_icon(c)
            end,
            manage = function(c)
                -- Set the windows at the slave,
                -- i.e. put it at the end of others instead of setting it master.
                -- if not awesome.startup then awful.client.setslave(c) end
                if awesome.startup and not c.size_hints.user_position and
                    not c.size_hints.program_position then
                    -- Prevent clients from being unreachable after screen count changes.
                    awful.placement.no_offscreen(c)
                end
            end,
            focus = function(c)
                c.border_color = beautiful.border_focus
            end,
            unfocus = function(c)
                c.border_color = beautiful.border_normal
            end
        }
    }

    rules.client["request::titlebars"] = function(c)
        -- buttons for the titlebar
        local buttons = gears.table.join(
                            awful.button({}, 1, function()
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
    end

    rules.client["mouse::enter"] = function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end

    rules.screen["property::geometry"] = function(s)
        wallpaper.set(s)
    end

    return rules
end

return setmetatable(M, {
    ---@param widgets MyWidget
    ---@return table
    __call = function(_, widgets)
        return create(widgets)
    end
})
