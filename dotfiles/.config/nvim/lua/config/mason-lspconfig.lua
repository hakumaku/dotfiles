require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = {
    "bashls",
    "clangd",
    "cmake",
    "cssls",
    "jsonls",
    "html",
    "jqls",
    "marksman",
    "yamlls",
    "sqlls",
    "terraformls",
    "dockerls",
    "eslint",
    "lua_ls",
    "pyright",
    "ruff_lsp",
    "rust_analyzer"
  }
})

