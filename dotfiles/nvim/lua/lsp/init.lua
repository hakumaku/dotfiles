local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

local servers = {
  ['clangd'] = require('lsp.clangd'),
  ['cmake'] = require('lsp.cmake'),
  ['bashls'] = require('lsp.bashls'),
  ['pyright'] = require('lsp.pyright'),
  ['sumneko_lua'] = require('lsp.lua')
}
for lsp, setup in pairs(servers) do
  setup.on_attach = on_attach
  lspconfig[lsp].setup(setup)
end

vim.fn.sign_define('LspDiagnosticsSignError', {
  text = '',
  texthl = 'LspDiagnosticsSignError',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('LspDiagnosticsSignWarning', {
  text = '',
  texthl = 'LspDiagnosticsSignWarning',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('LspDiagnosticsSignHint', {
  text = '',
  texthl = 'LspDiagnosticsSignHint',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('LspDiagnosticsSignInformation', {
  text = '',
  texthl = 'LspDiagnosticsSignInformation',
  linehl = '',
  numhl = ''
})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = {severity_limit = "Warning"},
      virtual_text = {prefix = "●", spacing = 2},
      signs = {severity_limit = "Warning"}
    })
