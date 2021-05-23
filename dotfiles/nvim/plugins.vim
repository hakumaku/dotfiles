" Specify a directory for plugins
call plug#begin(stdpath('data').'/plugged')
	" Vim basic utility
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	Plug 'mbbill/undotree'
	Plug 'raimondi/delimitmate'
	Plug 'scrooloose/nerdtree'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'ryanoasis/vim-devicons'

	" Neovim 5.0+
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-lua/completion-nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
	" Completion for the current buffer
	" Plug 'steelsojka/completion-buffers'
	Plug 'onsails/lspkind-nvim'
	" Telescope
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	" Etc
	Plug 'mhinz/vim-startify'
	Plug 'liuchengxu/vista.vim'
	Plug 'kdav5758/TrueZen.nvim'

	" Git
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

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

" {{{ completion-nvim
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_auto_popup = 1
let g:completion_matching_smart_case = 1
let g:completion_trigger_character = ['.', '::', '->']
let g:completion_trigger_keyword_length = 2 " default = 1
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'snippet']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]
" }}}
