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
  Typeparameter = "",
  Copilot = "🤖",
  Boolean = ""
}

local utils = require("telescope.utils")
local make_entry = require("telescope.make_entry")
local entry_display = require("telescope.pickers.entry_display")
local plenary = require('plenary.strings')
local devicons = require('nvim-web-devicons')
local icon_width = plenary.strdisplaywidth(
                       devicons.get_icon('fname', {default = true}))

local create_get_path_and_tail = function()
  local project_path = require("plenary.job"):new({
    command = "git",
    args = {"rev-parse", "--show-toplevel"}
  }):sync()[1]

  if project_path == nil then
    return function(path)
      local tail = vim.fs.basename(path)
      local parent = vim.fs.dirname(path)
      if parent == "." then
        return tail, nil
      end
      return tail, parent
    end
  else
    return function(path)
      local tail = utils.path_tail(path)

      if path:sub(1, 1) == "/" then
        local parent = string.sub(path, #project_path + 2, -#tail - 2)
        if #parent == 0 then
          return tail, nil
        end
        return tail, parent
      else
        local parent = string.sub(path, 1, -#tail - 2)
        if parent == "." then
          return tail, nil
        end
        return tail, parent
      end

    end
  end
end

local format_tail_and_path = function(tail, path)
  if path == nil then
    return string.format("%s", tail)
  else
    return string.format("%s\t(%s)", tail, path)
  end
end

function M.pretty_find_files(opts)
  opts = opts or {}
  local gen_from_files = make_entry.gen_from_file(opts)
  local get_tail_and_path = create_get_path_and_tail()

  opts.entry_maker = function(line)
    local entry_table = gen_from_files(line)
    local displayer = entry_display.create({
      separator = ' ',
      items = {{width = icon_width}, {width = nil}, {remaining = true}}
    })

    entry_table.display = function(entry)
      local tail, path = get_tail_and_path(entry.value)
      local icon, icon_hl = utils.get_devicons(tail)
      return displayer {
        {icon, icon_hl},
        tail,
        {path, 'TelescopeResultsComment'}
      }
    end

    return entry_table
  end

  require('telescope.builtin').find_files(opts)
end

function M.pretty_lsp_dynamic_workspace_symbols(opts)
  opts = opts or {}
  local gen_from_lsp_symbols = make_entry.gen_from_lsp_symbols(opts)
  local get_tail_and_path = create_get_path_and_tail()

  opts.entry_maker = function(line)
    local entry_table = gen_from_lsp_symbols(line)
    local displayer = entry_display.create({
      separator = ' ',
      items = {
        {width = icon_width},
        {width = 20},
        {width = nil},
        {remaining = true}
      }
    })

    entry_table.display = function(entry)
      local tail, path = get_tail_and_path(entry.filename)
      local location = format_tail_and_path(tail, path)

      local symbol = entry.symbol_type:lower():gsub("^%l", string.upper)
      local icon = kind_icons[symbol]
      return displayer {
        string.format("%s", icon),
        {entry.symbol_name, 'TelescopeResultsConstant'},
        {location, 'TelescopeResultsComment'}
      }
    end

    return entry_table
  end

  require('telescope.builtin').lsp_dynamic_workspace_symbols(opts)
end

function M.pretty_lsp_workspace_symbols(opts)
  opts = opts or {}
  local gen_from_lsp_symbols = make_entry.gen_from_lsp_symbols(opts)
  local get_tail_and_path = create_get_path_and_tail()

  opts.entry_maker = function(line)
    local entry_table = gen_from_lsp_symbols(line)
    local displayer = entry_display.create({
      separator = ' ',
      items = {
        {width = icon_width},
        {width = 20},
        {width = nil},
        {remaining = true}
      }
    })

    entry_table.display = function(entry)
      local tail, path = get_tail_and_path(entry.filename)
      local location = format_tail_and_path(tail, path)

      local symbol = entry.symbol_type:lower():gsub("^%l", string.upper)
      local icon = kind_icons[symbol]
      return displayer {
        string.format("%s", icon),
        {entry.symbol_name, 'TelescopeResultsConstant'},
        {location, 'TelescopeResultsComment'}
      }
    end

    return entry_table
  end

  require('telescope.builtin').lsp_workspace_symbols(opts)
end

function M.pretty_lsp_document_symbols(opts)
  opts = opts or {}
  local gen_from_lsp_symbols = make_entry.gen_from_lsp_symbols(opts)

  opts.entry_maker = function(line)
    local entry_table = gen_from_lsp_symbols(line)
    local displayer = entry_display.create({
      separator = ' ',
      items = {{width = icon_width}, {width = 20}, {remaining = true}}
    })

    entry_table.display = function(entry)
      local symbol = entry.symbol_type:lower():gsub("^%l", string.upper)
      local icon = kind_icons[symbol]
      return displayer {
        string.format("%s", icon),
        {entry.symbol_name, 'TelescopeResultsConstant'}
      }
    end

    return entry_table
  end

  require('telescope.builtin').lsp_document_symbols(opts)
end

return M
