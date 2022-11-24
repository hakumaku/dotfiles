local null_ls = require("null-ls")
local sources = {
  null_ls.builtins.diagnostics.flake8.with({prefer_local = ".venv/bin"}),
  null_ls.builtins.diagnostics.mypy.with({prefer_local = ".venv/bin"}),
null_ls.builtins.code_actions.gitsigns,
}

null_ls.setup({sources = sources})

