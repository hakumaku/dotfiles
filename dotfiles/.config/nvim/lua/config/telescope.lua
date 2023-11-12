local telescope = require("telescope")
local actions = require("telescope.actions")
local fzf_options = {
  fuzzy = true, -- false will only do exact matching
  override_generic_sorter = true, -- override the generic sorter
  override_file_sorter = true, -- override the file sorter
  case_mode = "ignore_case" -- or "ignore_case" or "respect_case"
  -- the default case_mode is "smart_case"
}

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
    find_files = {theme = "dropdown", previewer = false, hidden = true},
    buffers = {theme = "dropdown", previewer = false},
    live_grep = {theme = "ivy"},
    current_buffer_fuzzy_find = {theme = "dropdown", previewer = false},
    grep_string = {theme = "ivy"},
    git_branches = {theme = "dropdown", previewer = false},
    lsp_workspace_symbols = {
      path_display = "hidden",
      theme = "dropdown",
      previewer = false,
      sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_options)
    },
    -- Manually set sorter, for some reason not picked up automatically
    lsp_dynamic_workspace_symbols = {
      path_display = "hidden",
      theme = "dropdown",
      previewer = false,
      sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_options)
    },
    lsp_references = {theme = "ivy"}
  }
}
