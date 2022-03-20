local awful = require("awful")
local beautiful = require("beautiful")
local keys = require("config.keys")

local M = {}

---@param widgets MyWidget
---@return table
local function create(widgets)
    local taglist = widgets.taglist

    -- Rules to apply to new clients (through the "manage" signal).
    local rules = {
        -- All clients will match this rule.
        {
            rule = {},
            properties = {
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = keys.clientkeys,
                buttons = keys.clientbuttons,
                screen = awful.screen.preferred,
                placement = awful.placement.no_overlap +
                    awful.placement.no_offscreen
            }
        }, -- Floating clients.
        {
            rule_any = {
                instance = {
                    "DTA", -- Firefox addon DownThemAll.
                    "copyq", -- Includes session name in class.
                    "pinentry"
                },
                class = {
                    "Arandr",
                    "Blueman-manager",
                    "Gpick",
                    "Kruler",
                    "MessageWin", -- kalarm.
                    "Sxiv",
                    "Nsxiv",
                    "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                    "Wpa_gui",
                    "veromix",
                    "xtightvncviewer"
                },

                -- Note that the name property shown in xprop might be set slightly after creation of the client
                -- and the name shown there might not match defined rules here.
                name = {
                    "Event Tester" -- xev.
                },
                role = {
                    "AlarmWindow", -- Thunderbird's calendar.
                    "ConfigManager", -- Thunderbird's about:config.
                    "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
                }
            },
            properties = {floating = true}
        }, -- Add titlebars to normal clients and dialogs
        {
            rule_any = {type = {"normal", "dialog"}},
            properties = {titlebars_enabled = false}
        },
        { -- Plank
            rule = {class = "Plank"},
            properties = {
                border_width = 0,
                floating = true,
                sticky = true,
                ontop = false,
                focusable = false,
                below = true
            }
        },
        { -- Tag 2: Jetbrains
            rule = {class = "jetbrains-.*"},
            properties = {focus = true, tag = taglist.names[2]}
        },
        { -- Jetbrains loading screen
            rule = {class = "jetbrains-.*", name = " "},
            properties = {
                floating = true,
                placement = awful.placement.centered +
                    awful.placement.no_overlap
            }
        },
        { -- Jetbrains Welcome menu (it must be come AFTER loading screen rule.)
            rule = {class = "jetbrains-.*", name = "Welcome .*"},
            properties = {
                floating = true,
                placement = awful.placement.centered +
                    awful.placement.no_overlap
            }
        },
        { -- Tag 1: Firefox
            rule = {class = "Alacritty"},
            properties = {screen = 1, tag = taglist.names[1]}
        },
        { -- Tag 3: Firefox
            rule = {class = "Firefox"},
            properties = {screen = 1, tag = taglist.names[3]}
        },
        { -- Tag 5: Thunderbird
            rule = {class = "Thunderbird"},
            properties = {screen = 1, tag = taglist.names[5]}
        },
        { -- Tag 6: Twitch
            rule = {class = "streamlink-twitch-gui"},
            properties = {screen = 1, tag = taglist.names[6]}
        },
        { -- Tag 7: Spotify
            rule = {class = "Spotify"},
            properties = {screen = 1, tag = taglist.names[7]}
        },
        { -- Tag 8: Steam
            rule = {class = "Steam"},
            properties = {screen = 1, tag = taglist.names[8], floating = true}
        }
    }

    return rules
end

return setmetatable(M, {
    ---@param widgets MyWidget
    ---@return table
    __call = function(_, widgets)
        return create(widgets)
    end
})
