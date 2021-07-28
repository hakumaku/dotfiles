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
vim.cmd([[hi link GitSignsCurrentLineBlame Comment]])
