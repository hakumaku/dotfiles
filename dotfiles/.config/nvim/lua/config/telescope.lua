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
    git_status = {theme = "dropdown", previewer = false},
    current_buffer_fuzzy_find = {theme = "dropdown", previewer = false},
    buffers = {theme = "dropdown", previewer = false},
    lsp_workspace_symbols = {theme = "dropdown", previewer = false}
  }
}

require('telescope').load_extension('dap')
