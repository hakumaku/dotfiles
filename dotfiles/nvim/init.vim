let $NVIM_CONFIG_DIR = expand('$HOME/.config/nvim')

set guioptions-=m		"remove menu bar
set guioptions-=T		"remove toolbar
set guioptions-=r		"remove right-hand scroll bar
set guioptions-=L		"remove left-hand scroll bar
if has("gui_running")
	if has("gui_gtk3") || has("gui_gtk2")
		" set guifont=SauceCodePro\ Nerd\ Font\ 16
		set guifont=UbuntuMono\ Nerd\ Font\ Bold\ 16
	elseif has("gui_win32")
		set guifont=UbuntuMono\ NF\ Bold:h16
	end
endif

syntax on
if (has("termguicolors"))
	set termguicolors
endif

" Enable folding
" Soft wrapping text
" set cursorline		" Show cursor line
" set spell
" set wrap linebreak nolist
" set signcolumn=number
set autoindent
set autoread            " When a file has been changed outside of Vim, automatically read it againautoread
set backspace=indent,eol,start
set cmdheight=2
set colorcolumn=101
set encoding=utf-8		" Encoding
set fileencoding=utf-8  " Encoding
set fillchars=fold:\	" Replace - with ' '
set foldlevel=5
set foldmethod=syntax
set foldnestmax=5
set hidden				" Hide buffers when abandoned
set history=500
set hlsearch			" Highlight search
set ignorecase			" Case insensitive search
set incsearch			" Dynamic search
set laststatus=2
set lazyredraw			" Do not redraw screen in the middle of a macro
set listchars=tab:»\ ,eol:↲,trail:·
set mouse=a				" Enable mouse scrolling
set nobackup			" No backup files
set noexpandtab			" No spaces when tab
set nofoldenable        " Disable all folds to be open
set noswapfile          " No .swp
set nowrap
set nowritebackup       " No backup
set nrformats-=octal    " No octal format when using CTRL-A and CTRL-X. E,g. 007 -> 010
set number				" Show line number
set relativenumber		" Relative numbers instead of absolute
set ruler               " Show the line and column number of the cursor position, separated by a comma
set scrolloff=8			" Show 8 lines above or below cursor when scrolling
set sessionoptions-=options
set shiftwidth=4		" Size of the indent
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
set shortmess+=c        " Don't give ins-completion-menu messages
set showcmd				" Show command in last line
set showmode			" Show insert, replace, or visual mode in last line
set signcolumn=yes:1
set smartcase			" Case sensitive if contains at least one capital letter
set smarttab
set softtabstop=0		" Insert a combination of spaces when set to non-zero
set splitbelow			" When opening h splits, place cursor in the new split
set splitright			" When opening v splits, place cursor in the new split
set tabpagemax=50
set tabstop=4			" Tab size = 4
set ttimeout			" Time waited for key press to complete
set ttimeoutlen=50
set undodir=~/.vim/undo-dir
set undofile
set updatetime=300
set viewoptions-=options
set wildmenu			" On pressing 'wildchar' to invoke completion
let g:termdebug_wide=1

" au CmdLineEnter * if !exists('b:NERDTree') | set norelativenumber | redraw
" au CmdlineLeave * if !exists('b:NERDTree') | set relativenumber

iabbrev sturct struct
iabbrev wrod word
iabbrev wrods words
iabbrev teh the
iabbrev mian main
iabbrev lenght length

" {{{ Autocommand
augroup project
	au!
	au BufRead,BufNewFile *.h,*.c set filetype=cpp
augroup END

augroup file_c
	au!
	" Insert comment
	au FileType c call Iab('icom', '/*	*/<esc>2<Left>i')
	au FileType c call Iab('com', '/*<CR> <CR>/<Up>')
	" Compile and Run C file
	" au FileType c noremap <F2> :call CompileAssem()<CR>
	au FileType c noremap <C-e> :call CompileRun()<CR>
	" au FileType c noremap <F3> :call CompileDebug()<CR>
augroup END

augroup file_py
	au!
	" Execute python file
	au FileType python noremap <buffer> <C-e> :exec '!python3' shellescape(@%, 1) g:argv<CR>
augroup END

augroup file_bash
	au!
	" Execute bash file
	au FileType sh noremap <buffer> <C-e> :exec '!bash' shellescape(@%, 1)<CR>
augroup END

augroup file_vim
	au!
	au FileType vim setlocal foldmethod=marker
	au FileType vim setlocal foldmarker={{{,}}}
augroup END
" }}}

source $NVIM_CONFIG_DIR/functions.vim
source $NVIM_CONFIG_DIR/plugins.vim
source $NVIM_CONFIG_DIR/shortcuts.vim

lua require('config')
lua require('lsp')
lua utils = require('utils.functions')
" Jump to the next tab ')'
inoremap <C-l> <esc>:lua utils.jump_right()<CR>a
