local awful = require("awful")

local M = {}

---@return awful.widget.prompt
function M.create()
    return awful.widget.prompt()
end

return M
