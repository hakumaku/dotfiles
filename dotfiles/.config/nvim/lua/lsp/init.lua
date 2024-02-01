-- https://github.com/folke/neodev.nvim
-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

local lspconfig = require('lspconfig')

-- function(client, bufnr)
local on_attach = function(_, bufnr)
end

local servers = {
  -- clangd-extensions invoke this statement automatically.
  -- ['clangd'] = require('lsp.clangd'),
  ['rust_analyzer'] = require('lsp.rust_analyzer'),
  ['cmake'] = require('lsp.cmake'),
  ['bashls'] = require('lsp.bashls'),
  -- python
  ['pyright'] = require('lsp.pyright'),
  ['ruff_lsp'] = require('lsp.ruff-lsp'),
  -- fontend (html, css, js/ts)
  ['tsserver'] = require('lsp.tsserver'),
  ['eslint'] = require('lsp.eslint'),
  ['cssls'] = require('lsp.cssls'),
  ['cssmodules_ls'] = require('lsp.cssmodule-ls'),
  -- etc
  ['lua_ls'] = require('lsp.lua'),
  ['terraformls'] = require('lsp.terraform'),
  ['yamlls'] = require('lsp.yamlls'),
  ['jsonls'] = require('lsp.jsonls')
}
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp
                                                                      .protocol
                                                                      .make_client_capabilities())
for lsp, setup in pairs(servers) do
  setup.on_attach = on_attach
  setup.capabilities = capabilities
  lspconfig[lsp].setup(setup)
end
require('lsp.clangd-extensions')

-- https://github.com/neovim/neovim/blob/master/runtime/plugin/diagnostic.vim
vim.fn.sign_define('DiagnosticSignError', {
  -- TODO: bitmap icon
  text = '',
  texthl = 'LspDiagnosticsDefaultError',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('DiagnosticSignWarn', {
  text = '',
  texthl = 'LspDiagnosticsDefaultWarning',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('DiagnosticSignHint', {
  text = '',
  texthl = 'LspDiagnosticsDefaultHint',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('DiagnosticSignInfo', {
  text = '',
  texthl = 'LspDiagnosticsDefaultInformation',
  linehl = '',
  numhl = ''
})
