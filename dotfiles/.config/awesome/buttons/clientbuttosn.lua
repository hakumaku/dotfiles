local awful = require("awful")
local gears = require("gears")

local M = {}
function M.get()
    local clientbuttons = {
        awful.button({}, 1, function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end),
        awful.button({modkey}, 1, function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({modkey}, 3, function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end)
    }

    return gears.table.join(table.unpack(clientbuttons))
end

return M
