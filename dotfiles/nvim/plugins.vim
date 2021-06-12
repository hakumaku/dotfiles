call plug#begin(stdpath('data').'/plugged')
	" Vim basic utility
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-fugitive'
	Plug 'raimondi/delimitmate'
	Plug 'mbbill/undotree'
	" Development Utilities (Neovim 5.0+)
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'hrsh7th/nvim-compe'
	Plug 'lewis6991/gitsigns.nvim'
    Plug 'sbdchd/neoformat'
	Plug 'kyazdani42/nvim-tree.lua'
	Plug 'folke/trouble.nvim'
	Plug 'liuchengxu/vista.vim'
	" Look & Feel
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'folke/lsp-colors.nvim'
	Plug 'onsails/lspkind-nvim'
	Plug 'akinsho/nvim-bufferline.lua'
	Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
	Plug 'monsonjeremy/onedark.nvim'
    Plug 'mhinz/vim-startify'
call plug#end()

silent! colorscheme onedark
hi link GitSignsCurrentLineBlame Comment
