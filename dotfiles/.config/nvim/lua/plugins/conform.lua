return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters = {
      rustfmt = { prepend_args = { "+nightly" } },
      stylua = {
        prepend_args = {
          "--column-width",
          100,
          "--indent-type",
          "spaces",
          "--indent-width",
          "2",
        },
      },
      sqlfluff = {
        command = "sqlfluff",
        args = {
          "fix",
          "--config",
          vim.fn.stdpath("config") .. "/.sqlfluff",
          "--disable-progress-bar",
          "-",
        },
        stdin = true,
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black", "ruff" },
      rust = { "rustfmt" },
      sql = { "sqlfluff" },
      json = { "jq" },
      sh = { "shfmt" },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
