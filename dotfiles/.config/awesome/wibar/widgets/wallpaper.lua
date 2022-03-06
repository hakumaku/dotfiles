local beautiful = require("beautiful")
local gears = require("gears")

local themes = require("themes.mytheme")

local M = {}

function M.set(s)
    local wallpaper = themes.wallpaper or beautiful.wallpaper
    if wallpaper then
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

return M
