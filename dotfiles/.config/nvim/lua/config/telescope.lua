local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous
      }
    }
  },
  pickers = {
    find_files = {theme = "dropdown", previewer = false},
    buffers = {theme = "dropdown", previewer = false},
    live_grep = {theme = "ivy"},
    current_buffer_fuzzy_find = {theme = "dropdown", previewer = false},
    grep_string = {theme = "ivy"},
    git_branches = {theme = "dropdown", previewer = false},
    lsp_workspace_symbols = {theme = "dropdown", previewer = false},
    lsp_references = {theme = "ivy"}
  }
}

require('telescope').load_extension('dap')
