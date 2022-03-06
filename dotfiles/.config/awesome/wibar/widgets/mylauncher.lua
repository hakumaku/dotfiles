local awful = require("awful")
local beautiful = require("beautiful")
local mymainmenu = require("wibar.widgets.mymainmenu")

local M = {}

---@return awful.widget.launcher
function M.create()
    local launcher = awful.widget.launcher({
        image = beautiful.awesome_icon,
        menu = mymainmenu.create()
    })
    return launcher
end

return M
