require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "clangd",
    "cmake",
    "cssls",
    "jsonls",
    "html",
    "tssserver",
    "jqls",
    "marksman",
    "yamlls",
    "sqlls",
    "terraformls",
    "dockerls",
    "eslint",
    "lua_ls",
    "pyright",
    "ruff",
    "mypy",
    "rust_analyzer"
  }
})

