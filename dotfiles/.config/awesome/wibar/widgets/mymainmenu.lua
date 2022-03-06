local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

local M = {}

local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor
local menu = {
    {
        "hotkeys",
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end
    },
    {"manual", terminal .. " -e man awesome"},
    {"edit config", editor_cmd .. " " .. awesome.conffile},
    {"restart", awesome.restart},
    {
        "quit",
        function()
            awesome.quit()
        end
    }
}
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

---@return awful.menu
function M.create()
    return awful.menu({
        items = {
            {"awesome", menu, beautiful.awesome_icon},
            {"open terminal", terminal}
        }
    })
end

return M
