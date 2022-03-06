local wibox = require("wibox")
local awful = require("awful")

-- local mytasklist = require("widgets.mytasklist")
local taglist = require("wibar.widgets.taglist")
local wallpaper = require("wibar.widgets.wallpaper")
local volume = require("wibar.widgets.volume")

local myclock = require("wibar.widgets.clock")
local mypromptbox = require("wibar.widgets.mypromptbox")
local mylauncher = require("wibar.widgets.mylauncher")
local mylayoutbox = require("wibar.widgets.mylayoutbox")

-- awesome-wm-widgets
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')

local M = {}

---@return integer
local function get_height()
    -- TODO: dynamic height
    return 55
end

---@param s screen
---@param wibar_height integer
---@return table
local function left_widget(s, wibar_height)
    return {
        layout = wibox.layout.fixed.horizontal,
        mylauncher.create(),
        taglist.create(s),
        mypromptbox.create()
    }
end

---@param s screen
---@param wibar_height integer
---@return table
local function center_widget(s, wibar_height)
    return {
        myclock.create(),
        valign = "center",
        halign = "center",
        layout = wibox.container.place
    }
end

---@param s screen
---@param wibar_height integer
---@return table
local function right_widget(s, wibar_height)
    -- local size = wibar_height * 0.65
    return {
        layout = wibox.layout.fixed.horizontal,
        expand = true,
        wibox.widget.systray(),
        volume({bar_height = wibar_height}),
        volume_widget({
            step = 5,
            width = 100,
            margins = 15,
            widget_type = "horizontal_bar",
            with_icon = true
        }),
        mylayoutbox.create(s)
    }
end

---@param s screen
---@param height integer
---@return awful.wibar
function M.create(s)
    wallpaper.set(s)

    local height = get_height()
    local wibar = awful.wibar({height = height, position = "top", screen = s})
    wibar:setup({
        layout = wibox.layout.align.horizontal,
        left_widget(s, height),
        center_widget(s, height),
        right_widget(s, height)
    })
    return wibar
end

return M
