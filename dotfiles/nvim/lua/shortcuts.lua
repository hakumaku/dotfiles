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

-- Move cursor by virtual lines.
-- nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
-- nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap("Y", "y$")
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
-- Move the current line one down.
nnoremap("<C-j>", ":m+1<Bar>echo 'Move line down'<CR>")
-- Move the current line one up.
nnoremap("<C-k>", ":m-2<Bar>echo 'Move line up'<CR>")

-- Toggle displaying whitespaces. Mapped to 'ctrl + /'
nnoremap("<C-_>", ":set nolist!<Bar>echo 'Show whitespaces'<CR>")

-- Removes any search highlighting.
nnoremap("<C-l>",
         ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>")
-- Insert space in normal mode
nnoremap("<Space>", "i<space><ESC>")
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
nnoremap("<BS>", ":lua utils.delete_buffer()<CR>")
nnoremap("]q", ":cnext<CR>")
nnoremap("[q", ":cprevious<CR>")
nnoremap("[g", ":lnext<CR>")
nnoremap("]g", ":lprev<CR>")
nnoremap("]d", ":lua vim.lsp.diagnostic.goto_next()<CR>")
nnoremap("[d", ":lua vim.lsp.diagnostic.goto_prev()<CR>")

-- LSP config
nnoremap("<C-]>", ":lua utils.lsp_goto_definition()<CR>")
nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
nnoremap("<C-Space>", ":lua utils.lsp_code_action()<CR>")
nnoremap("<leader>s", ":ClangdSwitchSourceHeader<CR>")
nnoremap("<leader>r", ":lua vim.lsp.buf.references()<CR>")
nnoremap("<leader>c", ":lua vim.lsp.buf.rename()<CR>")

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
nnoremap("gd", ":Gvdiffsplit!<CR>")
nnoremap("gs", ":vertical Git<CR>")
nnoremap("gb", ":Gitsigns toggle_current_line_blame<CR>")

-- nvim-compe
inoremap("<C-Space>", "compe#complete()", {expr = true})
inoremap("<CR>", "compe#confirm('<CR>')", {expr = true})
inoremap("<C-e>", "compe#close('<C-e>')", {expr = true})
inoremap("<C-f>", "compe#scroll({ 'delta': +4 })", {expr = true})
inoremap("<C-d>", "compe#scroll({ 'delta': -4 })", {expr = true})

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
