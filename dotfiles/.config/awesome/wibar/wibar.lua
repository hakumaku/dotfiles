local wibox = require("wibox")
local awful = require("awful")

-- local mytasklist = require("widgets.mytasklist")
local taglist = require("wibar.widgets.taglist")
local wallpaper = require("wibar.widgets.wallpaper")
local MyVolume = require("wibar.widgets.volume")

local myclock = require("wibar.widgets.clock")
local mylayoutbox = require("wibar.widgets.mylayoutbox")

local M = {}

---@return integer
local function get_height()
    -- TODO: dynamic height
    return 55
end

---@class MyWibar
---@field widgets table
---@field wibar awful.wibar
MyWibar = {}
MyWibar.__index = MyWibar

---@param s screen
---@return MyWibar
function MyWibar:new(s)
    -- wallpaper has memory leak?
    -- wallpaper.set(s)
    local height = get_height()

    local o = {
        -- Create widgets
        widgets = {
            taglist = taglist.create(s),
            clock = myclock.create(),
            volume = MyVolume({bar_height = height}),
            layoutbox = mylayoutbox.create(s)
        },
        -- Create wibar
        wibar = awful.wibar({height = height, position = "top", screen = s})
    }

    -- Draw wibar
    o.wibar:setup({
        layout = wibox.layout.align.horizontal,
        { -- left widget
            layout = wibox.layout.fixed.horizontal,
            o.widgets.taglist
        },
        { -- center widget
            o.widgets.clock,
            layout = wibox.container.place
        },
        { -- right widget
            layout = wibox.layout.fixed.horizontal,
            expand = true,
            wibox.widget.systray(),
            o.widgets.volume.widget,
            o.widgets.layoutbox
        }
    })

    return setmetatable(o, MyWibar)
end

function MyWibar:get_taglist_widget()
    return self.widgets.taglist
end

function MyWibar:get_clock_widget()
    return self.widgets.clock
end

function MyWibar:get_layoutbox_widget()
    return self.widgets.layoutbox
end

function MyWibar:get_volume_widget()
    return self.widgets.volume
end

return setmetatable(M, {
    __call = function(_, ...)
        return MyWibar:new(...)
    end
})
