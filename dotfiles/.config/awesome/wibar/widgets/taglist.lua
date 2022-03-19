local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local lgi = require("lgi")
local gtk = lgi.require("Gtk", "3.0")
local gtk_theme = gtk.IconTheme.get_default()

local var = require("config.var")

local modkey = var.modkey

local M = {}

local function gtk_icon(c)
    local icon = gtk_theme:choose_icon({
        c.class,
        c.class:lower(),
        c.instance,
        c.instance:lower()
    }, 22, {})

    if icon then
        return icon:get_filename()
    end

    return nil
end

local function save_tag(c)
    c.previous_tag = c.first_tag
end

---@return table
local function load_tag(c)
    local state = c.previous_tag
    c.previous_tag = nil
    return state
end

local function do_set_icon(c)
    -- Keep track on the new tag which is used during handling 'untagged' signal.
    save_tag(c)

    local icon = gtk_icon(c)
    if icon ~= nil then
        c.first_tag.icon = icon
        c.first_tag.name = ""
    end
end

local taglist_buttons = {
    awful.button({}, 1, function(t)
        t:view_only()
    end),

    awful.button({modkey}, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),

    awful.button({}, 3, awful.tag.viewtoggle),

    awful.button({modkey}, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),

    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),

    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
}

---@class TaglistWidget
---@field widget wibox.widget
---@field names string[]
TaglistWidget = {}
TaglistWidget.__index = TaglistWidget

---@param s screen
---@return TaglistWidget
function TaglistWidget:new(s)
    local names = {
        "\u{2160}",
        "\u{2161}",
        "\u{2162}",
        "\u{2163}",
        "\u{2164}",
        "\u{2165}",
        "\u{2166}",
        "\u{2167}"
    }

    awful.tag(names, s, awful.layout.layouts[1])
    -- TODO: these two values could be calculated from the height of wibar.
    local width = 60
    local margins = 6
    local widget = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = gears.table.join(table.unpack(taglist_buttons)),
        layout = {layout = wibox.layout.fixed.horizontal},
        widget_template = {
            {
                {
                    {
                        {
                            id = 'text_role',
                            align = 'center',
                            valign = 'center',
                            forced_width = width,
                            widget = wibox.widget.textbox
                        },
                        -- text margins should be larger than that of icon.
                        widget = wibox.container.margin
                    },
                    {
                        {id = 'icon_role', widget = wibox.widget.imagebox},
                        -- adjust margins to resize icon.
                        margins = margins,
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.stack
                },
                forced_width = width,
                layout = wibox.layout.fixed.horizontal,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background
            -- create_callback
            -- update_callback
        }
    })

    local o = {widget = widget, names = names}

    return setmetatable(o, TaglistWidget)
end

function TaglistWidget:set_icon(c)
    if c.class == nil then
        -- This is a special case such as 'spotify' where it sets properties at runtime.
        -- It is definitely an abnormal behavior.
        -- It seems it is setting 'class' and 'instance' in order,
        -- so we will connect signal to 'instance', not 'class'.
        c:connect_signal("property::instance", function()
            do_set_icon(c)
        end)
    else
        do_set_icon(c)
    end
end

function TaglistWidget:reset_icon(c)
    local tag = load_tag(c)

    -- There are some clients not having tags.
    -- e.g, steam loading screen.
    if not tag then
        return
    end

    local clients = tag:clients()

    if #clients > 0 then
        local icon = gtk_icon(clients[1])
        if icon ~= nil then
            tag.icon = icon
        end
    else
        -- Icon does not get re-rendered by setting its value to nil.
        -- Create a new tag and swap that with the current tag.
        -- See a full list of properties:
        -- https://awesomewm.org/doc/api/classes/tag.html#Object_properties
        local tag_name = self.names[tag.index]
        local new_tag = awful.tag.add(tag_name, {
            layout = tag.layout,
            selected = tag.selected,
            activated = tag.activated,
            index = tag.index,
            screen = tag.screen,
            master_width_factor = tag.master_width_factor,
            gap = tag.gap,
            gap_single_client = tag.gap_single_client,
            master_fill_policy = tag.master_fill_policy
        })
        new_tag:clients(clients)
        new_tag:swap(tag)
        tag:delete()
    end
end

return setmetatable(M, {
    ---@return TaglistWidget
    __call = function(_, ...)
        return TaglistWidget:new(...)
    end
})
