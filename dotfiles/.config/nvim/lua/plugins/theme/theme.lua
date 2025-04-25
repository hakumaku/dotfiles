return {
  "folke/todo-comments.nvim",
  {
    "sphamba/smear-cursor.nvim",
    config = function()
      if not vim.g.neovide then
        require("smear_cursor").toggle()
      end
    end,
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,
      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,
      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,
      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,
      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.

      smear_insert_mode = true,
      stiffness = 0.8, -- 0.6      [0, 1]
      trailing_stiffness = 0.5, -- 0.4      [0, 1]
      stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
      distance_stop_animating = 0.5 -- 0.1      > 0
    }
  },
  {"folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}},
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        }
      }
    },
    plugins = {gitsigns = {enabled = false}}
  }
}
