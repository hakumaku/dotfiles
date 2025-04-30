local clear_output_panel = function()
  local buf = vim.fn.bufnr("Neotest Output Panel")
  if buf ~= -1 then
    wb.set_options({modifiable = true}, {buf = buf})
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
    wb.set_options({modifiable = false}, {buf = buf})
  end
end

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
        -- require("neotest-python")({
        --   dap = {justMyCode = false},
        --   runner = "pytest",
        --   args = {"--capture=no", "--no-header"}
        -- })
      }
    })
  end,
  -- https://github.com/nvim-neotest/neotest/discussions/455
  keys = {
    {
      "<leader>tn",
      function()
        clear_output_panel()
        require("neotest").run.run()
      end,
      desc = "Run nearest test"
    },
    {
      "<F6>",
      function()
        clear_output_panel()
        require("neotest").run.run()
      end,
      desc = "Run nearest test"
    },
    {
      "<leader>tf",
      function()
        clear_output_panel()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run file tests"
    },
    {
      "<F7>",
      function()
        clear_output_panel()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run file tests"
    },
    {
      "<leader>td",
      function()
        clear_output_panel()
        require("neotest").run.run({strategy = "dap"})
      end,
      desc = "Debug nearest test"
    },
    {
      "<leader>tl",
      function()
        clear_output_panel()
        require("neotest").run.run_last()
      end,
      desc = "Run last test"
    },
    {
      "<leader>ts",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop running tests"
    },
    {
      "<leader>to",
      function()
        -- https://github.com/nvim-neotest/neotest/discussions/197#discussioncomment-4775271
        require("neotest").output_panel.toggle()
        local win = vim.fn.bufwinid("Neotest Output Panel")
        if win > -1 then
          vim.api.nvim_set_current_win(win)
        end
      end,
      desc = "Open test output"
    },
    {
      "<leader>tt",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle test summary"
    }
  }
}
