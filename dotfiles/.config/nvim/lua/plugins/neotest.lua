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
      adapters = {
        require("rustaceanvim.neotest")
        -- https://github.com/LazyVim/LazyVim/issues/3543
        -- require("neotest-python")({
        --   dap = {justMyCode = false},
        --   -- Runner to use. Will use pytest if available by default.
        --   -- Can be a function to return dynamic value.
        --   runner = "pytest",
        --   args = {"--capture=no", "--no-header"},
        --   -- Custom python path for the runner.
        --   -- Can be a string or a list of strings.
        --   -- Can also be a function to return dynamic value.
        --   -- If not provided, the path will be inferred by checking for 
        --   -- virtual envs in the local directory and for Pipenev/Poetry configs
        --   python = ".venv/bin/python"
        -- }),
      }
    })
  end,
  opts = {
    -- https://github.com/nvim-neotest/neotest/discussions/455
    keys = {
      -- Run nearest tests
      vim.keymap.set("n", "<leader>R", function()
        require("neotest").run.run()
      end, {desc = "Run nearest tests"}),
      -- Run tests in file
      vim.keymap.set("n", "<leader>F", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, {desc = "Run tests in file"})
    }
  }
}
