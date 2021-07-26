require("github-theme").setup({
  themeStyle = "dark",
  commentStyle = "italic",
  keywordStyle = "italic",
  functionStyle = "italic",
  variableStyle = "italic",
  transparent = false
})

vim.cmd([[hi link GitSignsCurrentLineBlame Comment]])
