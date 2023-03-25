-- https://github.com/stevearc/aerial.nvim
require('aerial').setup({
  -- When true, aerial will automatically close after jumping to a symbol
  close_on_select = true,
  float = {
    -- Controls border appearance. Passed to nvim_open_win
    border = "rounded",
    -- Determines location of floating window
    --   cursor - Opens float on top of the cursor
    --   editor - Opens float centered in the editor
    --   win    - Opens float centered in the window
    relative = "win",
    -- These control the height of the floating window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a list of mixed types.
    -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
    height = nil,
    max_width = {40, 0.2},
    max_height = 0.9,
    min_width = 10,
    min_height = {8, 0.1},
    override = function(conf, source_winid)
      local padding = 1
      conf.anchor = 'NE'
      conf.row = padding
      conf.col = vim.api.nvim_win_get_width(source_winid) - padding
      return conf
    end
  },
  layout = {
    -- These control the width of the aerial window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a list of mixed types.
    -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
    max_width = {40, 0.2},
    width = nil,
    min_width = 10,

    -- key-value pairs of window-local options for aerial window (e.g. winhl)
    win_opts = {},

    -- Determines the default direction to open the aerial window. The 'prefer'
    -- options will open the window in the other direction *if* there is a
    -- different buffer in the way of the preferred direction
    -- Enum: prefer_right, prefer_left, right, left, float
    default_direction = "prefer_right",

    -- Determines where the aerial window will be opened
    --   edge   - open aerial at the far right/left of the editor
    --   window - open aerial to the right/left of the current window
    placement = "window",

    -- Preserve window size equality with (:help CTRL-W_=)
    preserve_equality = false
  },
  lsp = {
    -- Fetch document symbols when LSP diagnostics update.
    -- If false, will update on buffer changes.
    diagnostics_trigger_update = true,

    -- Set to false to not update the symbols when there are LSP errors
    update_when_errors = true,

    -- How long to wait (in ms) after a buffer change before updating
    -- Only used when diagnostics_trigger_update = false
    update_delay = 300,

    -- Map of LSP client name to priority. Default value is 10.
    -- Clients with higher (larger) priority will be used before those with lower priority.
    -- Set to -1 to never use the client.
    priority = {
      -- pyright = 10,
    }
  }
})

