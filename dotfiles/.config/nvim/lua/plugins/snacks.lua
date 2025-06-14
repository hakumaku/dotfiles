return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            {
              icon = " ",
              key = "n",
              desc = "New File",
              action = ":ene | startinsert",
            },
            {
              icon = " ",
              key = "g",
              desc = "Find Text",
              action = ":lua Snacks.dashboard.pick('live_grep')",
            },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            {
              icon = " ",
              key = "s",
              desc = "Restore Session",
              section = "session",
            },
            {
              icon = "󰒲 ",
              key = "L",
              desc = "Lazy",
              action = ":Lazy",
              enabled = package.loaded.lazy ~= nil,
            },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      lazygit = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            auto_close = true,
            layout = { preset = "sidebar", preview = false },
            win = {
              list = {
                keys = {
                  ["o"] = "confirm",
                  ["O"] = "explorer_open", -- open with system application
                },
              },
            },
          },
          buffers = { layout = { preset = "select", preview = false } },
          files = { layout = { preset = "select", preview = false } },
          lsp_symbols = { layout = { preset = "select", preview = false } },
          marks = { layout = { preset = "ivy", preview = true } },
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
                title_pos = "center",
              },
              { win = "list", border = "none" },
            },
          },
        },
      },
      -- terminal = {enabled = true},
      notifier = { enabled = false },
      quickfile = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = false },
      image = { enabled = false },
      styles = { lazygit = { border = "rounded" } },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      views = {
        notify = {
          replace = true,
          merge = true,
        },
        cmdline_popup = {
          border = {
            style = "none",
            padding = { 2, 3 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
      lsp = {
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          -- throttle = 1000 / 30,
          view = "notify",
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          max_width = 36,
          render = "default",
          stages = "slide",
        },
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<C-w>x",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
    },
  },
}
