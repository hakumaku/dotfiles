local M = {}

local kind_icons = {
  Text = "",
  String = "",
  Array = "",
  Object = "󰅩",
  Namespace = "",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰫧",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
  Copilot = "🤖",
  Boolean = ""
}

local make_entry = require("telescope.make_entry")
local entry_display = require("telescope.pickers.entry_display")
local plenary = require('plenary.strings')
local devicons = require('nvim-web-devicons')
local icon_with = plenary.strdisplaywidth(
                      devicons.get_icon('fname', {default = true}))

function M.pretty_lsp_dynamic_workspace_symbols(opts)
  opts = opts or {}
  local gen_from_lsp_symbols = make_entry.gen_from_lsp_symbols(opts)

  opts.entry_maker = function(line)
    local entry_table = gen_from_lsp_symbols(line)
    local displayer = entry_display.create({
      separator = ' ',
      items = {{width = icon_with}, {width = 20}, {remaining = true}}
    })

    entry_table.display = function(entry)
      return displayer {
        string.format("%s", kind_icons[(entry.symbol_type:lower()
                          :gsub("^%l", string.upper))]),
        {entry.symbol_type:lower(), 'TelescopeResultsVariable'},
        {entry.symbol_name, 'TelescopeResultsConstant'}
      }
    end

    return gen_from_lsp_symbols
  end

  require('telescope.builtin').lsp_dynamic_workspace_symbols(opts)
end

return M
