return {
  -- DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "igorlfs/nvim-dap-view",
        opts = {
          windows = {
            height = 12,
            terminal = {
              -- 'left'|'right'|'above'|'below': Terminal position in layout
              position = "right",
              -- List of debug adapters for which the terminal should be ALWAYS hidden
              hide = {},
              -- Hide the terminal when starting a new session
              start_hidden = false,
            },
          },
        },
      },
      "theHamsta/nvim-dap-virtual-text",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
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
    "mfussenegger/nvim-dap-python",
    dependencies = { "nvim-dap" },
    config = function()
      local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
      require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
    end,
  },
}
