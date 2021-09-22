local function nnoremap(combo, mapping, opts)
  if not opts then
    vim.api.nvim_set_keymap("n", combo, mapping, {noremap = true})
  else
    opts.noremap = true
    vim.api.nvim_set_keymap("n", combo, mapping, opts)
  end
end

local function inoremap(combo, mapping, opts)
  if not opts then
    vim.api.nvim_set_keymap("i", combo, mapping, {noremap = true})
  else
    opts.noremap = true
    vim.api.nvim_set_keymap("i", combo, mapping, opts)
  end
end

local function vnoremap(combo, mapping)
  vim.api.nvim_set_keymap("v", combo, mapping, {noremap = true})
end

local function cnoremap(combo, mapping)
  vim.api.nvim_set_keymap("c", combo, mapping, {noremap = true})
end

local function tnoremap(combo, mapping)
  vim.api.nvim_set_keymap("t", combo, mapping, {noremap = true})
end

local function snoremap(combo, mapping, opts)
  if not opts then
    vim.api.nvim_set_keymap("s", combo, mapping, {noremap = true})
  else
    opts.noremap = true
    vim.api.nvim_set_keymap("s", combo, mapping, opts)
  end
end

-- Move cursor by virtual lines.
-- nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
-- nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap("Y", "y$")
nnoremap("n", "nzz")
nnoremap("N", "Nzz")
nnoremap("J", "mzJ`z")
nnoremap("k", "(v:count > 5 ? \"m'\".v:count : \"\").'k'", {expr = true})
nnoremap("j", "(v:count > 5 ? \"m'\".v:count : \"\").'j'", {expr = true})

inoremap("<C-u>", "<C-g>u<C-u>")
inoremap("<C-w> ", "<C-g>u<C-w>")

-- cmdline-editing
cnoremap("<C-a>", "<Home>")
cnoremap("<C-e>", "<End>")
cnoremap("<C-j>", "<Left>")
cnoremap("<C-k>", "<Right>")
cnoremap("<C-l>", "<Delete>")
cnoremap("<C-d>", "<S-Left>")
cnoremap("<C-f>", "<S-Right>")

-- Insert a newline in normal mode.
-- nnoremap("<CR>", "o<ESC>k")
-- Insert space in normal mode
nnoremap("<Space>", "i<space><ESC>")
-- Move the current line one down.
nnoremap("<C-j>", ":m+1<Bar>echo 'Move line down'<CR>")
vnoremap("<C-j>", ":m '>+1<CR>gv=gv")
-- Move the current line one up.
nnoremap("<C-k>", ":m-2<Bar>echo 'Move line up'<CR>")
vnoremap("<C-k>", ":m '<-2<CR>gv=gv")

-- Toggle displaying whitespaces. Mapped to 'ctrl + /'
nnoremap("<C-_>", ":set nolist!<Bar>echo 'Show whitespaces'<CR>")

-- Removes any search highlighting.
nnoremap("<C-l>",
         ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>")
-- Copy & Paste
vnoremap("<C-c>", '"+y:echo ' .. "'Yanked to clipboard'<CR>")
inoremap("<C-v>", '<ESC>"+pa')

-- Escape terminal mode
vim.g.termdebug_useFloatingHover = 0
vim.g.termdebug_use_prompt = 1
tnoremap("<Esc>", "<C-\\><C-n>")
nnoremap("<RightMouse>", ":Break<CR>")

-- Reverse selected lines.
vnoremap("<leader>r", "y:lua utils.reverse_lines()<CR>")
-- Jump to the next tab ')'
inoremap("<C-l>", "<esc>:lua utils.jump_right()<CR>a")
-- External Utilities
nnoremap("<leader>1", ":.!toilet -w 200 -f term -F border<CR>")

-- Cycle through buffers
nnoremap("]b", ":bn<CR>")
nnoremap("[b", ":bp<CR>")
nnoremap("<BS>", ":lua utils.delete_buffer()<CR>", {silent = true})
nnoremap("]q", ":cnext<CR>")
nnoremap("[q", ":cprevious<CR>")
nnoremap("[g", ":lnext<CR>")
nnoremap("]g", ":lprev<CR>")
nnoremap("]d", ":lua vim.lsp.diagnostic.goto_next()<CR>", {silent = true})
nnoremap("[d", ":lua vim.lsp.diagnostic.goto_prev()<CR>", {silent = true})

-- LSP config
nnoremap("<C-]>", ":lua vim.lsp.buf.definition()<CR>", {silent = true})
nnoremap("K", ":lua vim.lsp.buf.hover()<CR>", {silent = true})
nnoremap("<C-Space>", ":lua vim.lsp.buf.code_action()<CR>", {silent = true})
nnoremap("<leader>s", ":ClangdSwitchSourceHeader<CR>", {silent = true})
nnoremap("<leader>r", ":lua vim.lsp.buf.references()<CR>", {silent = true})
nnoremap("<leader>c", ":lua vim.lsp.buf.rename()<CR>", {silent = true})

-- DAP
nnoremap("<leader>dc", ":lua require('dap').continue()<CR>", {silent = true})
nnoremap("<leader>db", ":lua require('dap').toggle_breakpoint()<CR>",
         {silent = true})
nnoremap("<leader>di", ":lua require('dap').step_into()<CR>", {silent = true})
nnoremap("<leader>do", ":lua require('dap').step_out()<CR>", {silent = true})
nnoremap("<leader>dn", ":lua require('dap').step_over()<CR>", {silent = true})
nnoremap("<leader>dq", ":lua utils.dap_quit()<CR>", {silent = true})
nnoremap("<A-h>", ":lua require('dap').toggle_breakpoint()<CR>", {silent = true})
nnoremap("<A-j>", ":lua require('dap').step_into()<CR>", {silent = true})
nnoremap("<A-k>", ":lua require('dap').step_out()<CR>", {silent = true})
nnoremap("<A-l>", ":lua require('dap').step_over()<CR>", {silent = true})
-- DAP Telescope
nnoremap("<leader>df", ":Telescope dap frames<CR>", {silent = true})

-- neoformat
nnoremap("<leader>f", ":Neoformat<CR>")

-- Telescope
nnoremap("<C-s>f", ":Telescope find_files<CR>")
nnoremap("<C-s>s", ":Telescope live_grep<CR>")
nnoremap("<C-s>b", ":Telescope buffers<CR>")
nnoremap("<C-s>u", ":Telescope git_status<CR>")
nnoremap("<C-s>g", ":lua utils.grep_prompt()<CR>")
nnoremap("<C-s>/", ":Telescope current_buffer_fuzzy_find<CR>")

-- NvimTree
nnoremap("<C-w>o", ":NvimTreeToggle<CR>")

-- Vista
nnoremap("<C-w>t", ":Vista!!<CR>")

-- trouble.nvim
nnoremap("<C-w>T", ":TroubleToggle<CR>")

-- vim-fugitive
nnoremap("<leader>gd", ":Gvdiffsplit!<CR>")
nnoremap("<leader>gs", ":vertical Git<CR>")
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<CR>")
-- nvim-toggleterm.lua
LazyGit = {}
function LazyGit:toggle()
  if not self.__term then
    local Terminal = require('toggleterm.terminal').Terminal
    self.__term = Terminal:new({cmd = "lazygit", hidden = true})
  end
  self.__term:toggle()
end
nnoremap("<leader>gg", ":lua LazyGit:toggle()<CR>")

-- nvim-compe
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local check_next_char_is_bracket = function ()
  local col = vim.fn.col('.')
  return vim.fn.getline('.'):sub(col, col):match('[%)%]}>]')
end
local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
    return t "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"
  elseif check_next_char_is_bracket() then
    return t "<esc>:lua utils.jump_right()<CR>a"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
    return t "<C-R>=UltiSnips#JumpBackwards()<CR>"
  else
    return t "<S-Tab>"
  end
end

inoremap("<C-Space>", "compe#complete()", {expr = true})
inoremap("<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", {expr = true})
inoremap("<C-e>", "compe#close('<C-e>')", {expr = true})
inoremap("<C-f>", "compe#scroll({ 'delta': +4 })", {expr = true})
inoremap("<C-d>", "compe#scroll({ 'delta': -4 })", {expr = true})
inoremap("<Tab>", "v:lua.tab_complete()", {expr = true})
snoremap("<Tab>", "v:lua.tab_complete()", {expr = true})
inoremap("<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
snoremap("<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

nnoremap("<A-1>", ":echo 'alt-1'<CR>")
nnoremap("<A-2>", ":echo 'alt-2'<CR>")
nnoremap("<A-3>", ":echo 'alt-3'<CR>")
nnoremap("<A-4>", ":echo 'alt-4'<CR>")
nnoremap("<A-5>", ":echo 'alt-5'<CR>")
nnoremap("<A-6>", ":echo 'alt-6'<CR>")
nnoremap("<A-7>", ":echo 'alt-7'<CR>")
nnoremap("<A-8>", ":echo 'alt-8'<CR>")
nnoremap("<A-9>", ":echo 'alt-9'<CR>")
nnoremap("<A-0>", ":echo 'alt-0'<CR>")

nnoremap("<C-w>1", ":lua utils.select_buffer(1)<CR>", {silent = true})
nnoremap("<C-w>2", ":lua utils.select_buffer(2)<CR>", {silent = true})
nnoremap("<C-w>3", ":lua utils.select_buffer(3)<CR>", {silent = true})
nnoremap("<C-w>4", ":lua utils.select_buffer(4)<CR>", {silent = true})
nnoremap("<C-w>5", ":lua utils.select_buffer(5)<CR>", {silent = true})
nnoremap("<C-w>6", ":lua utils.select_buffer(6)<CR>", {silent = true})
nnoremap("<C-w>7", ":lua utils.select_buffer(7)<CR>", {silent = true})
nnoremap("<C-w>8", ":lua utils.select_buffer(8)<CR>", {silent = true})
nnoremap("<C-w>9", ":lua utils.select_buffer(9)<CR>", {silent = true})
nnoremap("<C-w>0", ":lua utils.select_buffer(10)<CR>", {silent = true})
