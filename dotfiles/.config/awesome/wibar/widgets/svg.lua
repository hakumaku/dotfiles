local wibox = require("wibox")
local gears = require("gears")
local cairo = require('lgi').cairo
local Rsvg = require('lgi').Rsvg

local M = {}

local icon_dir = os.getenv("XDG_CONFIG_HOME") .. '/awesome/wibar/icons/'

---@param svg string
---@param size integer
---@return cairo.ImageSurface
function M.icon(svg, size)
    -- https://github.com/awesomeWM/awesome/issues/3038
    -- https://awesomewm.org/apidoc/core_components/client.html#icon

    if not gears.filesystem.file_readable(svg) then
        svg = icon_dir .. svg
    end

    local handle = assert(Rsvg.Handle.new_from_file(svg))
    local dim = handle:get_dimensions()
    local aspect = math.min(size / dim.width, size / dim.height)

    local img = cairo.ImageSurface(cairo.Format.ARGB32, size, size)
    local cr = cairo.Context(img)
    cr:scale(aspect, aspect)
    handle:render_cairo(cr)

    return img
end

---@param svg string
---@param size integer
---@return table
function M.imagebox(svg, size)
    return {
        {
            id = "icon",
            image = M.icon(svg, size),
            resize = false,
            widget = wibox.widget.imagebox
        },
        layout = wibox.container.place
    }
end

return M
