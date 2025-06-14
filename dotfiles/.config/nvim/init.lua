if vim.g.neovide then
  -- normal = ["MesloLGS Nerd Font", "Source Han Sans KR", "Noto Color Emoji"]
  vim.g.neovide_normal_opacity = 0.75
  vim.g.neovide_cursor_vfx_mode = "sonicboom"
  vim.keymap.set(
    { "n", "v" },
    "<C-+>",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>"
  )
  vim.keymap.set(
    { "n", "v" },
    "<C-->",
    ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>"
  )
  vim.keymap.set({ "n", "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
end
vim.opt.syntax = "on"
vim.opt.termguicolors = true
vim.opt.cursorline = false
-- vim.opt.wrap linebreak nolist

-- When a file has been changed outside of Vim, automatically read it againautoread
vim.opt.autoread = true

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "101"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- :help conceal
vim.opt.conceallevel = 2

-- Replace - with ' '
vim.opt.fillchars = { fold = " " }

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

vim.opt.listchars = { tab = "» ", eol = "↲", space = "·" }

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
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
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
vim.g.python3_host_prog = "/usr/bin/python"

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
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
  pattern = "*",
  desc = "Highlight yank",
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
    local buf = args.buf

    vim.api.nvim_create_autocmd({
      "BufEnter",
      "BufWritePost",
      "CursorHold",
      "InsertLeave",
    }, {
      buffer = buf,
      callback = function(ev)
        vim.lsp.codelens.refresh({ bufnr = 0 })
      end,
    })

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
    if client:supports_method("textDocument/documentHighlight") then
      vim.api.nvim_create_autocmd("cursorhold", {
        callback = vim.lsp.buf.document_highlight,
        buffer = buf,
        desc = "Highlight lsp references on CursorHold",
      })
      vim.api.nvim_create_autocmd("CursorHoldI", {
        callback = vim.lsp.buf.document_highlight,
        buffer = buf,
        desc = "Highlight lsp references on CursorHoldI",
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        callback = vim.lsp.buf.clear_references,
        buffer = buf,
        desc = "Clear highlighted lsp references on CursorMoved",
      })
    end
  end,
})
-- https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
-- local progress = vim.defaulttable()
-- vim.api.nvim_create_autocmd("LspProgress", {
--   ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
--     if not client or type(value) ~= "table" then
--       return
--     end
--     local p = progress[client.id]
--
--     for i = 1, #p + 1 do
--       if i == #p + 1 or p[i].token == ev.data.params.token then
--         p[i] = {
--           token = ev.data.params.token,
--           msg = ("[%3d%%] %s%s"):format(
--             value.kind == "end" and 100 or value.percentage or 100,
--             value.title or "",
--             value.message and (" **%s**"):format(value.message) or ""
--           ),
--           done = value.kind == "end",
--         }
--         break
--       end
--     end
--
--     local msg = {} ---@type string[]
--     progress[client.id] = vim.tbl_filter(function(v)
--       return table.insert(msg, v.msg) or not v.done
--     end, p)
--
--     local spinner = {
--       "⠋",
--       "⠙",
--       "⠹",
--       "⠸",
--       "⠼",
--       "⠴",
--       "⠦",
--       "⠧",
--       "⠇",
--       "⠏",
--     }
--     vim.notify(table.concat(msg, "\n"), "info", {
--       id = "lsp_progress",
--       title = client.name,
--       opts = function(notif)
--         notif.icon = #progress[client.id] == 0 and " "
--           or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
--       end,
--     })
--   end,
-- })

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
  -- do NOT call 'rust-analyzer' lsp server
  -- since 'mrcjkb/rustaceanvim' automatically does
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
  "docker",
}, {
  -- global lsp config
})
vim.filetype.add({ extension = { jinja = "jinja", jinja2 = "jinja", j2 = "jinja" } })
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  virtual_lines = false,
  float = { border = "rounded", focusable = false },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
    texthl = {
      [vim.diagnostic.severity.ERROR] = "LspDiagnosticsDefaultError",
      [vim.diagnostic.severity.WARN] = "LspDiagnosticsDefaultWarning",
      [vim.diagnostic.severity.HINT] = "LspDiagnosticsDefaultHint",
      [vim.diagnostic.severity.INFO] = "LspDiagnosticsDefaultInformation",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
})

vim.fn.sign_define("DapBreakpoint", {
  text = "🔴",
  texthl = "DapBreakpoint",
  linehl = "DapBreakpoint",
  numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapStopped", {
  text = "👉",
  texthl = "DapStopped",
  linehl = "Visual",
  numhl = "DapStopped",
})
