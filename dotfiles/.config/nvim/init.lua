if vim.g.vscode then
  vim.opt.incsearch = true
  vim.opt.ignorecase = true
  require("vscode.shortcuts")
elseif vim.g.started_by_firenvim then
else
  vim.opt.syntax = "on"
  vim.opt.termguicolors = true
  vim.opt.cursorline = true
  -- vim.opt.wrap linebreak nolist

  -- When a file has been changed outside of Vim, automatically read it againautoread
  vim.opt.autoread = true

  vim.opt.backspace = {"indent", "eol", "start"}
  vim.opt.cmdheight = 1
  vim.opt.colorcolumn = "101"
  vim.opt.encoding = "utf-8"
  vim.opt.fileencoding = "utf-8"

  -- Replace - with ' '
  vim.opt.fillchars = {fold = " "}

  vim.opt.foldlevel = 5
  vim.opt.foldmethod = "syntax"
  vim.opt.foldnestmax = 5

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
]])

  -- autocmd
  vim.cmd([[
au FocusGained,BufEnter * checktime

augroup project
	au!
	au BufRead,BufNewFile *.h,*.c set filetype=cpp
augroup END

augroup file_py
	au!
	au FileType python noremap <buffer> <C-e> :exec '!python3' shellescape(@%, 1) g:argv<CR>
augroup END

augroup file_bash
	au!
	au FileType sh noremap <buffer> <C-e> :exec '!bash' shellescape(@%, 1)<CR>
augroup END

augroup file_vim
	au!
	au FileType vim setlocal foldmethod=marker
	au FileType vim setlocal foldmarker={{{,}}}
augroup END
]])

  -- Terraform
  vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = {"*.tf", "*.tfvars"},
    callback = vim.lsp.buf.format
  })

  utils = require("utils.functions")
  require("plugins")
  require("shortcuts")
  require("lsp")
end
