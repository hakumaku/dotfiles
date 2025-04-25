return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = {enabled = true},
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          {
            icon = " ",
            key = "f",
            desc = "Find File",
            action = ":lua Snacks.dashboard.pick('files')"
          },
          {
            icon = " ",
            key = "n",
            desc = "New File",
            action = ":ene | startinsert"
          },
          {
            icon = " ",
            key = "g",
            desc = "Find Text",
            action = ":lua Snacks.dashboard.pick('live_grep')"
          },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')"
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})"
          },
          {
            icon = " ",
            key = "s",
            desc = "Restore Session",
            section = "session"
          },
          {
            icon = "󰒲 ",
            key = "L",
            desc = "Lazy",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil
          },
          {icon = " ", key = "q", desc = "Quit", action = ":qa"}
        }
      }
    },
    explorer = {enabled = true},
    indent = {enabled = true},
    input = {enabled = true},
    lazygit = {enabled = true},
    picker = {
      enabled = true,
      sources = {
        explorer = {
          auto_close = true,
          layout = {preset = "sidebar", preview = false},
          win = {
            list = {
              keys = {
                ["o"] = "confirm",
                ["O"] = "explorer_open" -- open with system application
              }
            }
          }
        },
        buffers = {layout = {preset = "select", preview = false}},
        files = {layout = {preset = "select", preview = false}},
        lsp_symbols = {layout = {preset = "select", preview = false}}
      },
      layouts = {
        sidebar = {
          preview = false,
          layout = {
            backdrop = false,
            width = 32,
            max_width = 32,
            height = 0,
            position = "left",
            border = "none",
            box = "vertical",
            {
              win = "input",
              height = 1,
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center"
            },
            {win = "list", border = "none"}
          }
        }
      }
    },
    -- terminal = {enabled = true},
    notifier = {
      enabled = true
      -- your notifier configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    quickfile = {enabled = true},
    scope = {enabled = true},
    statuscolumn = {enabled = true},
    words = {enabled = false},
    image = {enabled = false}
  }
}
