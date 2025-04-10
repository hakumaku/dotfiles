return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = {"lua-format"},
      -- Conform will run multiple formatters sequentially
      python = {"black", "ruff"},
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = {"rustfmt", lsp_format = "fallback"},
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
