local gears = require("gears")
local awful = require("awful")

local M = {}

local tasklist_buttons = gears.table.join(
                             awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end), awful.button({}, 3, function()
        awful.menu.client_list({theme = {width = 250}})
    end), awful.button({}, 4, function()
        client.focus.byidx(1)
    end), awful.button({}, 5, function()
        client.focus.byidx(-1)
    end))

---@param s screen
---@return awful.widget.tasklist
function M.create(s)
    return awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
    }
end

return M
