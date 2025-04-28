return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim"
  },
  lazy = true,
  event = {"BufRead test_*.py", "BufRead test_*.rs"},
  config = function()
    require("neotest").setup({
      -- https://github.com/nvim-neotest/neotest/issues/319
      output_panel = {open = "botright vsplit | vertical resize 80"},
      adapters = {
        require("rustaceanvim.neotest")({args = {"--color=always"}})
        require("neotest-python")({
          dap = {justMyCode = false},
          runner = "pytest",
          args = {"--capture=no", "--no-header"},
        }),
      }
    })
  end,
  opts = {
    -- https://github.com/nvim-neotest/neotest/discussions/455
    keys = {
      vim.keymap.set("n", "<leader>tn", function()
        require("neotest").run.run()
      end, {desc = "Run nearest test"}),
      vim.keymap.set("n", "<F5>", function()
        require("neotest").run.run()
      end, {desc = "Run nearest test"}),
      vim.keymap.set("n", "<leader>tf", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, {desc = "Run file tests"}),
      vim.keymap.set("n", "<F6>", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, {desc = "Run file tests"}),
      vim.keymap.set("n", "<leader>tl", function()
        require("neotest").run.run_last()
      end, {desc = "Run last test"}),
      vim.keymap.set("n", "<leader>ts", function()
        require("neotest").run.stop()
      end, {desc = "Stop running tests"}),
      vim.keymap.set("n", "<leader>to", function()
        require("neotest").output_panel.toggle()
      end, {desc = "Open test output"}),
      vim.keymap.set("n", "<leader>tt", function()
        require("neotest").summary.toggle()
      end, {desc = "Toggle test summary"})
    }
  }
}
