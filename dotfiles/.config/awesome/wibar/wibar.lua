local wibox = require("wibox")
local awful = require("awful")

-- local mytasklist = require("widgets.mytasklist")
local wallpaper = require("wibar.widgets.wallpaper")
local MyTaglist = require("wibar.widgets.taglist")
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

---@class MyWidget
---@field taglist TaglistWidget
---@field volume VolumeWidget
MyWidget = {}
MyWidget.__index = MyWidget

---@param args table
---@return MyWidget
function MyWidget:new(args)
    local o = args
    return setmetatable(o, MyWidget)
end

---@param s screen
---@return MyWibar
function MyWibar:new(s)
    -- wallpaper has memory leak?
    -- wallpaper.set(s)
    local height = get_height()

    local o = {
        -- Create widgets
        widgets = MyWidget:new({
            taglist = MyTaglist({
                screen = s,
                wibar_height = height,
                names = {
                    "\u{2160}",
                    "\u{2161}",
                    "\u{2162}",
                    "\u{2163}",
                    "\u{2164}",
                    "\u{2165}",
                    "\u{2166}",
                    "\u{2167}"
                }
            }),
            clock = myclock.create(),
            volume = MyVolume({wibar_height = height}),
            layoutbox = mylayoutbox.create(s)
        }),
        -- Create wibar
        wibar = awful.wibar({height = height, position = "top", screen = s})
    }

    -- Draw wibar
    o.wibar:setup({
        layout = wibox.layout.align.horizontal,
        { -- left widget
            layout = wibox.layout.fixed.horizontal,
            o.widgets.taglist.widget
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
    ---@return MyWibar
    __call = function(_, ...)
        return MyWibar:new(...)
    end
})
