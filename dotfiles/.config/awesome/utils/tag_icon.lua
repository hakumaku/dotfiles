local awful = require("awful")

local lgi = require("lgi")
local gtk = lgi.require("Gtk", "3.0")
local gtk_theme = gtk.IconTheme.get_default()

local M = {}

-- TODO: change '22' value
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

local function do_attach(c)
    -- Keep track on the new tag which is used during handling 'untagged' signal.
    save_tag(c)

    local icon = gtk_icon(c)
    if icon ~= nil then
        c.first_tag.icon = icon
    end
end

function M.attach(c)
    if c.class == nil then
        -- This is a special case such as 'spotify' where it sets properties at runtime.
        -- It is definitely an abnormal behavior.
        -- It seems it is setting 'class', 'instance' in order,
        -- so we will connect signal to 'instance', not 'class'.
        c:connect_signal("property::instance", function()
            do_attach(c)
        end)
    else
        do_attach(c)
    end
end

function M.detach(c)
    local tag = load_tag(c)
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
        local new_tag = awful.tag.add(tag.name, {
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

return M
