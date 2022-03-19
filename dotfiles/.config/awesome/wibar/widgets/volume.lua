local awful = require("awful")
local wibox = require("wibox")
local beautiful = require('beautiful')
local gears = require("gears")

local svg = require("wibar.widgets.svg")

local M = {}

local list_devices_command = [[sh -c "pacmd list-sinks; pacmd list-sources"]]

---@param device string
local function get_volume_command(device)
    return string.format("amixer -D %s sget Master", device)
end

---@class VolumeArgs
---@field wibar_height integer

---@class VolumeWidget
---@field widget wibox.widget
---@field icons table
---@field device string
VolumeWidget = {}
VolumeWidget.__index = VolumeWidget

---@param args VolumeArgs
---@return VolumeWidget
function VolumeWidget:new(args)
    local height = args.wibar_height
    local size = height * 0.5
    local margin = (height - size) / 2

    -- Draw all icons ahead.
    local icons = {
        high = svg.icon("audio-volume-high-symbolic.svg", size),
        medium = svg.icon("audio-volume-medium-symbolic.svg", size),
        low = svg.icon("audio-volume-low-symbolic.svg", size),
        muted = svg.icon("audio-volume-muted-symbolic.svg", size)
    }

    local o = {
        device = 'pulse',
        icons = icons,
        -- Widget instance
        widget = wibox.widget({
            {
                {id = "icon_role", resize = false, widget = wibox.widget.imagebox},
                layout = wibox.container.place
            },
            {
                id = 'bar_role',
                max_value = 100,
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
            set_volume_level = function(w, value, icon)
                w:get_children_by_id('bar_role')[1]:set_value(value)
                w:get_children_by_id('icon_role')[1]:set_image(icon)
            end
        })
    }

    -- Watch volume level.
    awful.widget.watch(get_volume_command(o.device), 5, o.update_callback, o)

    -- Set initial values for widget.
    local command = string.format("amixer -D %s sget Master", o.device)
    awful.spawn.easy_async(command, function(stdout)
        o:update_callback(stdout)
    end)

    return setmetatable(o, VolumeWidget)
end

---Default callback function
---[ref](https://awesomewm.org/doc/api/classes/awful.widget.watch.html)
---```
---function(widget, stdout, stderr, exitreason, exitcode)
---    widget:set_text(stdout)
---end
---```
function VolumeWidget:update_callback(stdout)
    local volume_level = 0
    local mute = string.match(stdout, "%[(o%D%D?)%]") -- \[(o\D\D?)\] - [on] or [off]
    if mute == 'on' then
        local output = string.match(stdout, "(%d?%d?%d)%%") -- (\d?\d?\d)\%)
        volume_level = tonumber(string.format("% 3d", output))
    end

    local icon = nil
    if volume_level == 0 then
        icon = self.icons.muted
    elseif volume_level < 33 then
        icon = self.icons.low
    elseif volume_level < 66 then
        icon = self.icons.medium
    else
        icon = self.icons.high
    end

    self.widget:set_volume_level(volume_level, icon)
end

---@param step integer
function VolumeWidget:increase(step)
    local command = string.format("amixer -D %s sset Master %d%%+", self.device,
                                  step)
    awful.spawn.easy_async(command, function(stdout)
        self:update_callback(stdout)
    end)
end

---@param step integer
function VolumeWidget:decrease(step)
    local command = string.format("amixer -D %s sset Master %d%%-", self.device,
                                  step)
    awful.spawn.easy_async(command, function(stdout)
        self:update_callback(stdout)
    end)
end

function VolumeWidget:toggle_mute()
    local command =
        string.format("amixer -D %s sset Master toggle", self.device)
    awful.spawn.easy_async(command, function(stdout)
        self:update_callback(stdout)
    end)
end

return setmetatable(M, {
    ---@return VolumeWidget
    __call = function(_, ...)
        return VolumeWidget:new(...)
    end
})
