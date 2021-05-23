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
