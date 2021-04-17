" Specify a directory for plugins
call plug#begin(stdpath('data').'/plugged')
	" Vim basic utility
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	Plug 'mbbill/undotree'
	Plug 'raimondi/delimitmate'
	Plug 'scrooloose/nerdtree'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'ryanoasis/vim-devicons'

	" Neovim 5.0+
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
	Plug 'liuchengxu/vista.vim'
	" Telescope
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	" Lua
	Plug 'rafcamlet/coc-nvim-lua'

	" Git
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

	" Startify
	Plug 'mhinz/vim-startify'
	" Status line
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	
	" Colorschemes
	Plug 'lifepillar/vim-solarized8'
	Plug 'morhetz/gruvbox'
	Plug 'joshdick/onedark.vim'
" Initialize plugin system
call plug#end()

" {{{ Tmux
" Tmux true color settings.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" }}}

" {{{ vim-solarized8 (https://github.com/lifepillar/vim-solarized8)
" Options: solarized8_high, solarized8, solarized8_low solarized8_flat
" set background=dark
" silent! colorscheme solarized8
" }}}

" {{{ one dark pro (https://github.com/joshdick/onedark.vim)
silent! colorscheme onedark
" }}}

" {{{ gruvbox (https://github.com/morhetz/gruvbox)
" set background=dark
" let g:gruvbox_contrast = 'hard'
" silent! colorscheme gruvbox
" }}}

" {{{ vim-airline & vim-airline-themes
let g:airline#extensions#tabline#enabled = 1			" turn on buffer list
let g:airline#extensions#tabline#show_tab_nr = 1		" Show tab number
let g:airline#extensions#tabline#tab_nr_type = 1		" Show tab number
let g:airline#extensions#tabline#fnamemod = ':t'		" Display only file name
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1	" Show buffer number
let g:airline#extensions#hunks#enabled = 0
let g:airline_section_y = '%{&fenc} %{WebDevIconsGetFileFormatSymbol()}'
let g:airline_powerline_fonts = 1

" let g:airline_section_b = '%{strftime("%H:%M:%S")}'
" let g:airline_theme='light'
" let g:airline_solarized_bg='dark'
" }}}

" {{{ NERDTree
let g:NERDTreeGlyphReadOnly = "RO"
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
	\ quit | endif
" }}}

" {{{ vim-devicons
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 1
" }}}

" {{{ FZF
" let g:fzf_layout = { 'down': '40%', 'window': '10new' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
" }}}

" {{{ coc
" Highlight the symbol and its references when holding the cursor.
autocmd VimEnter * hi link CocHighlightText Visual
autocmd CursorHold * silent call CocActionAsync('highlight')
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let g:coc_snippet_next = '<tab>'
" }}}
