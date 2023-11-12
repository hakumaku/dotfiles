require("mason-lspconfig").setup({
  automatic_installation = true,
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
    "ruff-lsp",
    "rust_analyzer"
  }
})

