return {
  'stevearc/conform.nvim',
  event = {"BufWritePre"},
  cmd = {"ConformInfo"},
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({async = true})
      end,
      mode = "",
      desc = "Format buffer"
    }
  },
  opts = {
    formatters = {
      rustfmt = {prepend_args = {"+nightly"}},
      sqlfluff = {
        command = "sqlfluff",
        args = {
          "fix",
          "--config",
          vim.fn.stdpath("config") .. "/.sqlfluff",
          "--disable-progress-bar",
          "-"
        },
        stdin = true
      }
    },
    formatters_by_ft = {
      lua = {"lua-format"},
      python = {"black", "ruff"},
      rust = {"rustfmt"},
      sql = {"sqlfluff"},
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ["_"] = {"trim_whitespace"}
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback"
    }
  }
}
