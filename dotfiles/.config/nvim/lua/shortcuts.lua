local function nnoremap(combo, mapping, opts)
  opts = opts or { noremap = true }
  opts.noremap = true
  vim.keymap.set({ "n" }, combo, mapping, opts)
end

local function inoremap(combo, mapping, opts)
  opts = opts or { noremap = true }
  opts.noremap = true
  vim.keymap.set("i", combo, mapping, { noremap = true })
end

local function vnoremap(combo, mapping)
  vim.keymap.set("v", combo, mapping, { noremap = true })
end

local function cnoremap(combo, mapping)
  vim.keymap.set("c", combo, mapping, { noremap = true })
end

local function tnoremap(combo, mapping)
  vim.keymap.set("t", combo, mapping, { noremap = true })
end

local function snoremap(combo, mapping, opts)
  opts = opts or { noremap = true }
  opts.noremap = true
  vim.keymap.set("s", combo, mapping, { noremap = true })
end

-- Move cursor by virtual lines.
-- nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
-- nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap("n", "nzz")
nnoremap("N", "Nzz")
nnoremap("J", "mzJ`z")
nnoremap("k", '(v:count > 5 ? "m\'".v:count : "").\'k\'', { expr = true })
nnoremap("j", '(v:count > 5 ? "m\'".v:count : "").\'j\'', { expr = true })

inoremap("<C-u>", "<C-g>u<C-u>")
inoremap("<C-w>", "<C-g>u<C-w>")

nnoremap("gh", "0")
nnoremap("gl", "$")
nnoremap("gs", "^")
-- Copy & Paste
vnoremap("<C-c>", '"+y:echo ' .. "'Yanked to clipboard'<CR>")
inoremap("<C-v>", '<ESC>"+pa')
vnoremap("<leader>v", '"_dP')

-- Insert space in normal mode
nnoremap("<Space>", "i<space><ESC>")
-- Move the current line one down.
nnoremap("<C-j>", ":m+1<Bar>echo 'Move line down'<CR>")
vnoremap("<C-j>", ":m '>+1<CR>gv=gv")
-- Move the current line one up.
nnoremap("<C-k>", ":m-2<Bar>echo 'Move line up'<CR>")
vnoremap("<C-k>", ":m '<-2<CR>gv=gv")

-- buffers
-- nnoremap("", ":b#<CR>")
nnoremap("<TAB>", function()
  local buf = vim.fn.expand("#")
  if #buf > 0 then
    vim.cmd.edit(buf)
    Snacks.notify.info(vim.fn.expand("#:t"), { timeout = 500 })
  end
end, { silent = true })
nnoremap("<BS>", ":bd<CR>", { silent = true })
nnoremap("]B", ":BufferLineMoveNext<CR>")
nnoremap("[B", ":BufferLineMovePrev<CR>")
tnoremap("<C-,>", "<C-\\><C-n>", { silent = true })
tnoremap("<C-.>", "<C-\\><C-n>:ToggleTerm<CR>", { silent = true })

-- cmdline-editing
cnoremap("<C-a>", "<Home>")
cnoremap("<C-e>", "<End>")
cnoremap("<C-j>", "<Left>")
cnoremap("<C-k>", "<Right>")
cnoremap("<C-l>", "<Delete>")
cnoremap("<C-d>", "<S-Left>")
cnoremap("<C-f>", "<S-Right>")
-- Reverse selected lines.
vnoremap("<leader>r", "y:lua utils.reverse_lines()<CR>")
-- Jump to the next tab ')'
-- <C-,> = <C-q>a
-- <C-.> = <C-q>b
-- <C-/> = <C-q>c
-- <C-;> = <C-q>d
inoremap("<C-l>", "<C-o>:lua utils.jump_right()<CR>")
inoremap("<C-q>b", "<C-o>:lua utils.toggle_eol_await()<CR>")
inoremap("<C-q>c", "<C-o>:lua utils.toggle_eol_option()<CR>")
inoremap("<C-q>d", "<C-o>:lua utils.append_semi_colon()<CR>")

-- LSP config
nnoremap("grn", vim.lsp.buf.rename, { silent = true })
nnoremap("grr", vim.lsp.buf.references, { silent = true })
nnoremap("gra", vim.lsp.buf.code_action, { silent = true })
nnoremap("gd", vim.lsp.buf.definition, { silent = true })
nnoremap("gD", vim.lsp.buf.declaration, { silent = true })
nnoremap("gi", vim.lsp.buf.implementation, { silent = true })
nnoremap("gI", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
end, { silent = true })
nnoremap("K", function()
  vim.lsp.buf.hover({ border = "rounded", focusable = false })
end, { silent = true })
nnoremap("<C-Space>", vim.lsp.buf.code_action, { silent = true })
vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.rs",
  callback = function(ev)
    nnoremap("gp", function()
      vim.cmd.RustLsp("parentModule")
    end)
    nnoremap("gO", function()
      vim.cmd.RustLsp("renderDiagnostic")
    end)
    nnoremap("go", function()
      vim.cmd.RustLsp("relatedDiagnostics")
    end)
    nnoremap("gi", function()
      Snacks.picker.lsp_implementations({
        filter = {
          filter = function(item, self)
            return string.sub(item["line"], 1, 1) ~= "#"
          end,
        },
      })
      -- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
    end, { silent = true })
  end,
})

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://toggleterm* lua set_terminal_keymaps()")

nnoremap("<C-s>f", ":lua Snacks.picker.smart()<CR>")
nnoremap("<C-s>b", ":lua Snacks.picker.buffers()<CR>")
nnoremap("<C-s>s", ":lua Snacks.picker.grep()<CR>")
nnoremap("'", ":lua Snacks.picker.marks()<CR>")
nnoremap("dm", ":delm! | delm A-Z0-9<CR>")
nnoremap("<C-s>/", ":lua Snacks.picker.lines()<CR>")
nnoremap("<C-t>", function()
  Snacks.picker.lsp_symbols({
    filter = {
      rust = {
        "Class",
        "Constructor",
        "Enum",
        -- "Field",
        "Object",
        "Function",
        "Interface",
        "Method",
        -- "Module",
        "Namespace",
        "Package",
        "Property",
        "Struct",
        "Trait",
      },
    },
  })
end)
nnoremap("<C-s>t", ":lua Snacks.picker.lsp_workspace_symbols()<CR>")
nnoremap("<C-s>u", ":lua Snacks.picker.lsp_references()<CR>")
nnoremap("<C-s>c", ":lua Snacks.picker.git_branches()<CR>")

-- neogit & diffview & gitsigns
nnoremap("<leader>gd", ":Gvdiffsplit!<CR>")
nnoremap("<leader>gj", ":diffget //2<CR>")
nnoremap("<leader>gk", ":diffget //3<CR>")
nnoremap("<leader>gl", ":lua require('neogit').open({'log'})<CR>")
nnoremap("<leader>gg", ":lua Snacks.lazygit()<CR>")
nnoremap("<leader>gh", ":DiffviewFileHistory %<CR>")
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<CR>")
nnoremap("<leader>gr", ":Gitsigns reset_hunk<CR>")
nnoremap("<leader>gp", ":Gitsigns preview_hunk<CR>")

nnoremap("<leader>q", ":lua utils.dap_quit()<CR>", { silent = true })

nnoremap("<C-w>d", ":lua require('dap-view').toggle()<CR>", { silent = true })
nnoremap("<C-w>r", ":lua require('dap').repl.toggle({}, 'vsplit')<CR>", { silent = true })
nnoremap("<C-w>.", ":only<CR>")
nnoremap("<C-w>o", ":lua Snacks.explorer()<CR>")
nnoremap("<C-w>f", ":ToggleTerm<CR>")
nnoremap("<C-w>g", ":Neogit<CR>")
nnoremap("<C-w>b", ":DiffviewOpen<CR>")
nnoremap("<C-w>z", ":ZenMode<CR>")

nnoremap("]c", ":Gitsigns next_hunk<CR>")
nnoremap("[c", ":Gitsigns prev_hunk<CR>")
nnoremap("]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { silent = true })
nnoremap("[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { silent = true })
