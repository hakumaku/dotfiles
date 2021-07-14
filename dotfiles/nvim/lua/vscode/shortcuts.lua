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

nnoremap("]b", ":bn<CR>")
nnoremap("[b", ":bp<CR>")
nnoremap("<BS>", ":lua utils.delete_buffer()<CR>")
nnoremap("]q", ":cnext<CR>")
nnoremap("[q", ":cprevious<CR>")
nnoremap("[g", ":lnext<CR>")
nnoremap("]g", ":lprev<CR>")
nnoremap("]d", ":lua vim.lsp.diagnostic.goto_next()<CR>")
nnoremap("[d", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
