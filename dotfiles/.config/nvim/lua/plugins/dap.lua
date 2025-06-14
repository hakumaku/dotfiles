return {
  -- DAP
  {
    -- TODO: https://github.com/miroshQa/debugmaster.nvim
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      {
        "igorlfs/nvim-dap-view",
        opts = {
          winbar = {
            show = true,
            -- You can add a "console" section to merge the terminal with the other views
            sections = {
              "watches",
              "scopes",
              "exceptions",
              "breakpoints",
              "threads",
              "repl",
              "console",
            },
            -- Must be one of the sections declared above
            default_section = "scopes",
            headers = {
              breakpoints = "Breakpoints [B]",
              scopes = "Scopes [S]",
              exceptions = "Exceptions [E]",
              watches = "Watches [W]",
              threads = "Threads [T]",
              repl = "REPL [R]",
              console = "Console [C]",
            },
            controls = {
              enabled = false,
              position = "right",
              buttons = {
                "play",
                "step_into",
                "step_over",
                "step_out",
                "step_back",
                "run_last",
                "terminate",
                "disconnect",
              },
              custom_buttons = {},
              icons = {
                pause = "",
                play = "",
                step_into = "",
                step_over = "",
                step_out = "",
                step_back = "",
                run_last = "",
                terminate = "",
                disconnect = "",
              },
            },
          },
          windows = {
            height = 8,
            position = "below",
            terminal = {
              position = "left",
              width = 0.3,
              -- List of debug adapters for which the terminal should be ALWAYS hidden
              hide = {},
              -- Hide the terminal when starting a new session
              start_hidden = true,
            },
          },
          help = {
            border = nil,
          },
          -- Controls how to jump when selecting a breakpoint or navigating the stack
          switchbuf = "usetab,newtab",
        },
      },
    },
    keys = {
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>h",
        function()
          require("dap").continue()
        end,
        desc = "DAP continue",
      },
      {
        "<leader>j",
        function()
          require("dap").step_into()
        end,
        desc = "DAP Step Into",
      },
      {
        "<leader>k",
        function()
          require("dap").step_out()
        end,
        desc = "DAP Step Out",
      },
      {
        "<leader>l",
        function()
          require("dap").step_over()
        end,
        desc = "DAP Step Over",
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = true,
      virt_text_pos = "inline",
      all_references = true,
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "nvim-dap" },
    config = function()
      local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
      require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
    end,
  },
}
