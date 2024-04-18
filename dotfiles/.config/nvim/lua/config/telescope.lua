local telescope = require("telescope")
local actions = require("telescope.actions")
local fzf_options = {
  fuzzy = true, -- false will only do exact matching
  override_generic_sorter = true, -- override the generic sorter
  override_file_sorter = true, -- override the file sorter
  case_mode = "ignore_case" -- or "ignore_case" or "respect_case"
  -- the default case_mode is "smart_case"
}
local utils = require("telescope.utils")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd("TelescopeParent", "\t(.*)$")
      vim.api.nvim_set_hl(0, "TelescopeParent", {link = "Comment"})
    end)
  end
})

local filename_first = function()
  local project_path = require("plenary.job"):new({
    command = "git",
    args = {"rev-parse", "--show-toplevel"}
  }):sync()[1]

  if project_path == nil then
    return function(_, path)
      local tail = vim.fs.basename(path)
      local parent = vim.fs.dirname(path)
      if parent == "." then
        return tail
      end
      return string.format("%s\t(%s)", tail, parent)
    end
  end

  return function(_, path)
    if string.sub(path, 1, 1) == '/' then
      local tail = utils.path_tail(path)
      local parent = string.sub(path, #project_path + 2, -#tail - 2)
      if #parent == 0 then
        return tail
      end
      return string.format("%s\t(%s)", tail, parent)
    else
      local tail = vim.fs.basename(path)
      local parent = vim.fs.dirname(path)
      if parent == "." then
        return tail
      end
      return string.format("%s\t(%s)", tail, parent)
    end
  end
end

telescope.load_extension('dap')
telescope.load_extension('fzf')
telescope.load_extension("aerial")

telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules/",
      ".yarn/",
      "yarn.lock",
      "build/",
      ".git/",
      "venv/",
      ".venv/",
      "poetry.lock"
    },
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous
      }
    }
  },
  extensions = {
    fzf = fzf_options,
    aerial = {
      -- Display symbols as <root>.<parent>.<symbol>
      show_nesting = {
        ["_"] = false, -- This key will be the default
        json = true, -- You can set the option for specific filetypes
        yaml = true
      }
    }
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
      hidden = true,
      path_display = filename_first()
    },
    buffers = {theme = "dropdown", previewer = false},
    live_grep = {theme = "ivy"},
    current_buffer_fuzzy_find = {theme = "dropdown", previewer = false},
    grep_string = {theme = "ivy"},
    git_branches = {theme = "dropdown", previewer = false},
    lsp_workspace_symbols = {
      path_display = filename_first(),
      theme = "dropdown",
      previewer = false,
      sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_options),
      color_devicons = true,
      disable_devicons = false,
      case_mode = "smart_case"
    },
    -- Manually set sorter, for some reason not picked up automatically
    lsp_dynamic_workspace_symbols = {
      path_display = filename_first(),
      theme = "dropdown",
      previewer = false,
      sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_options),
      color_devicons = true,
      disable_devicons = false,
      case_mode = "smart_case"
    },
    lsp_references = {theme = "ivy"}
  }
}
