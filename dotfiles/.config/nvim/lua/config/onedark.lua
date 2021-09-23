require("onedark").setup({
  commentStyle = "italic",
  keywordStyle = "italic",
  functionStyle = "italic",
  variableStyle = "italic",
  transparent = false,
  hideInactiveStatusline = true,
  sidebars = {"qf", "vista_kind", "terminal", "packer"},
  darkSidebar = true,
  darkFloat = true,
  colors = {}
})

vim.cmd [[colorscheme onedark]]
-- nvim 0.6 version
vim.cmd([[
hi link GitSignsCurrentLineBlame Comment

hi link DiagnosticError LspDiagnosticsDefaultError
hi link DiagnosticWarn LspDiagnosticsDefaultWarning
hi link DiagnosticHint LspDiagnosticsDefaultHint
hi link DiagnosticInfo LspDiagnosticsDefaultInformation
]])
