-- Example config in Lua
vim.g.onedark_italic_comments = true
vim.g.onedark_italic_keywords = true
vim.g.onedark_italic_functions = true
vim.g.onedark_italic_variables = true
vim.g.onedark_transparent = false
vim.g.onedark_hide_inactive_statusline = true
vim.g.onedark_sidebars = {"qf", "vista_kind", "terminal", "packer"}
vim.g.onedark_dark_sidebar = true
vim.g.onedark_dark_float = true

vim.g.onedark_colors = {}

vim.cmd [[colorscheme onedark]]
vim.cmd([[hi link GitSignsCurrentLineBlame Comment]])
