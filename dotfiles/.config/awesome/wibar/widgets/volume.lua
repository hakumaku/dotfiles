local wibox = require("wibox")
local beautiful = require('beautiful')
local gears = require("gears")

local svg = require("wibar.widgets.svg")

local volume = {}

---@class VolumeArgs
---@field bar_height integer

---@param args VolumeArgs
local function create_widget(args)
    local height = args.bar_height
    local size = height * 0.5
    local margin = (height - size) / 2

    local widget = wibox.widget({
        {
            {
                id = "icon",
                image = svg.icon("audio-volume-high-symbolic.svg", size),
                resize = false,
                widget = wibox.widget.imagebox
            },
            layout = wibox.container.place
        },
        {
            id = 'bar',
            max_value = 100,
            value = 50,
            forced_width = 100,
            color = beautiful.fg_normal,
            background_color = beautiful.bg_normal,
            ticks = true,
            ticks_gap = 2,
            ticks_size = 4,
            margins = {top = margin, bottom = margin},
            shape = gears.shape["bar"],
            widget = wibox.widget.progressbar
        },
        spacing = 8,
        layout = wibox.layout.fixed.horizontal,
        set_volume_level = function(self, new_value)
            self:get_children_by_id('bar')[1]:set_value(tonumber(new_value))
        end,
        mute = function(self)
            self:get_children_by_id('bar')[1]:set_color(beautiful.fg_urgent)
        end,
        unmute = function(self)
            self:get_children_by_id('bar')[1]:set_color(beautiful.fg_normal)
        end
    })

    return widget
end

---@param args VolumeArgs
local function worker(args)
    return create_widget(args)
end

return setmetatable(volume, {
    __call = function(_, ...)
        return worker(...)
    end
})
