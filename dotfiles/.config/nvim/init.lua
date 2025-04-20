vim.opt.syntax = "on"
vim.opt.termguicolors = true
vim.opt.cursorline = false
-- vim.opt.wrap linebreak nolist

-- When a file has been changed outside of Vim, automatically read it againautoread
vim.opt.autoread = true

vim.opt.backspace = {"indent", "eol", "start"}
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "101"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- :help conceal
vim.opt.conceallevel = 2

-- Replace - with ' '
vim.opt.fillchars = {fold = " "}

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 4

-- Hide buffers when abandoned
vim.opt.hidden = true
vim.opt.history = 500

-- Highlight search
vim.opt.hlsearch = true
-- Case insensitive search
vim.opt.ignorecase = true
-- Dynamic search
vim.opt.incsearch = true
-- Case sensitive if contains at least one capital letter
vim.opt.smartcase = true

vim.opt.laststatus = 2
-- Do not redraw screen in the middle of a macro
vim.opt.lazyredraw = true

vim.opt.listchars = {tab = "» ", eol = "↲", space = "·"}

-- Enable mouse scrolling
vim.opt.mouse = "a"

-- Enable spelling
vim.opt.spell = true

-- No backup files
vim.opt.backup = false
-- No backup
vim.opt.writebackup = false
-- No .swp
vim.opt.swapfile = false

-- No spaces when tab
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smarttab = true
-- Insert a combination of spaces when set to non-zero
vim.opt.softtabstop = 0
vim.opt.tabpagemax = 50
-- Tab size = 4
vim.opt.tabstop = 4
-- Disable all folds to be open
vim.opt.foldenable = false

vim.opt.wrap = false
-- No octal format when using CTRL-A and CTRL-X. E,g. 007 -> 010
vim.opt.nrformats:remove("octal")
-- Show line number
vim.opt.number = true
-- Relative numbers instead of absolute
vim.opt.relativenumber = true

-- Show the line and column number of the cursor position, separated by a comma
vim.opt.ruler = true
-- Show 8 lines above or below cursor when scrolling
vim.opt.scrolloff = 8
vim.opt.sessionoptions:remove("options")
-- Size of the indent
vim.opt.shiftwidth = 4
-- Set completeopt to have a better completion experience
vim.opt.completeopt = {"menuone", "noinsert", "noselect"}
-- Don't give ins-completion-menu messages
vim.opt.shortmess:append("c")
-- Show command in last line
vim.opt.showcmd = true
-- Show insert, replace, or visual mode in last line
vim.opt.showmode = true
vim.opt.signcolumn = "yes:1"
-- When opening h splits, place cursor in the new split
vim.opt.splitbelow = true
-- When opening v splits, place cursor in the new split
vim.opt.splitright = true
-- Time waited for key press to complete
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 50
if not vim.env.XDG_DATA_HOME then
  vim.opt.undodir = vim.env.HOME .. "/.config/vim-undo"
else
  vim.opt.undodir = vim.env.XDG_DATA_HOME .. "/vim-undo"
end
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.viewoptions:remove("options")
-- On pressing 'wildchar' to invoke completion
vim.opt.wildmenu = true
vim.opt.pumblend = 15
vim.g.termdebug_wide = 1

-- One status line only.
vim.opt.laststatus = 3

-- python3 on Arch Linux
vim.g.python3_host_prog = '/usr/bin/python'

-- Common typos
vim.cmd([[
iabbrev sturct struct
iabbrev wrod word
iabbrev wrods words
iabbrev teh the
iabbrev mian main
iabbrev lenght length
iabbrev wheil while
iabbrev whiel while
iabbrev todo TODO:
iabbrev fixme FIXME:
]])

-- Load plugins using "lazy.nvim"
require("config.lazy")
utils = require("config.functions")
require("shortcuts")

-- Show highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", {clear = true}),
  callback = function()
    vim.highlight.on_yank()
  end,
  pattern = "*",
  desc = "Highlight yank"
})

-- Callback when LSP is attached
-- GLOBAL DEFAULTS
-- grr gra grn gri i_CTRL-S These GLOBAL keymaps are created unconditionally when Nvim starts:
-- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
-- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
-- "grr" is mapped in Normal mode to vim.lsp.buf.references()
-- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
-- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
-- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    -- :help lsp-cofnig
    -- args: {
    --   event: "LspAttach"
    --   match: <matching string>
    --   group: <group number>
    --   file: "/path/to/your/file.txt"
    --   buf: <buffer number>
    --   id: <id number>
    -- }
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/documentHighlight') then
      local buf = args.buf
      vim.api.nvim_create_autocmd("cursorhold", {
        callback = vim.lsp.buf.document_highlight,
        buffer = buf,
        desc = "Highlight lsp references on CursorHold"
      })
      vim.api.nvim_create_autocmd("CursorHoldI", {
        callback = vim.lsp.buf.document_highlight,
        buffer = buf,
        desc = "Highlight lsp references on CursorHoldI"
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        callback = vim.lsp.buf.clear_references,
        buffer = buf,
        desc = "Clear highlighted lsp references on CursorMoved"
      })
    end
  end
})

vim.cmd([[
colorscheme tokyonight-storm

au FocusGained,BufEnter * checktime

augroup file_vim
	au!
	au FileType vim setlocal foldmethod=marker
	au FileType vim setlocal foldmarker={{{,}}}
augroup END
]])

-- LSP
vim.lsp.enable({
  -- lua
  "luals",
  -- rust
  "rust-analyzer",
  -- python
  "basedpyright",
  "ruff",
  -- terraform
  "terraformls",
  -- HTML
  "html",
  "css",
  "htmx",
  "jinja",
  "tailwindcss",
  -- etc
  "marksman",
  "yamlls",
  "jsonls",
  "bashls",
  "docker"
}, {
  -- global lsp config
})
vim.filetype
    .add({extension = {jinja = 'jinja', jinja2 = 'jinja', j2 = 'jinja'}})
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  virtual_lines = false,
  float = {border = 'rounded', focusable = false},
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵"
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "LspDiagnosticsDefaultError",
      [vim.diagnostic.severity.WARN] = "LspDiagnosticsDefaultWarning",
      [vim.diagnostic.severity.HINT] = "LspDiagnosticsDefaultHint",
      [vim.diagnostic.severity.INFO] = "LspDiagnosticsDefaultInformation"
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = ""
    }
  }
})
