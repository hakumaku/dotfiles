local wibox = require("wibox")

local M = {}

function M.create()
    return wibox.widget.textclock()
end

return M

