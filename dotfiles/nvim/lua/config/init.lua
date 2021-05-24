require('config.telescope')
require('config.tree-sitter')
require('config.lspkind')
require('config.trouble')

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
