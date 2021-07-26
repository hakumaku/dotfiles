vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Vim basic utility
  use {'tpope/vim-surround'}
  use {'tpope/vim-repeat'}
  use {'tpope/vim-fugitive'}
  use {'raimondi/delimitmate'}
  use {'mbbill/undotree'}
  -- Development Utilities (Neovim 5.0+)
  use {'neovim/nvim-lspconfig'}
  use {'nvim-lua/plenary.nvim'}
  use {'nvim-lua/popup.nvim'}
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = function() require("config/tree-sitter") end
  }
  use {
    'nvim-telescope/telescope.nvim',
    config = function() require("config/telescope") end
  }
  use {'hrsh7th/nvim-compe', config = function() require("config/compe") end}
  use {'SirVer/ultisnips', config = function() require("config/ultisnips") end}
  use {'honza/vim-snippets'}
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require("config/gitsigns") end
  }
  use {'sbdchd/neoformat', config = function() require("config/neoformat") end}
  use {
    'kyazdani42/nvim-tree.lua',
    config = function() require("config/nvim-tree") end
  }
  use {'folke/trouble.nvim', config = function() require("config/trouble") end}
  use {'liuchengxu/vista.vim', config = function() require("config/vista") end}
  use {
    'akinsho/nvim-toggleterm.lua',
    config = function() require("config.toggleterm") end
  }
  -- DAP
  use {'mfussenegger/nvim-dap', config = function() require("config/dap") end}
  use {
    'mfussenegger/nvim-dap-python',
    config = function() require('dap-python').setup('python3') end
  }
  use {'rcarriga/nvim-dap-ui', config = function() require('config.dapui') end}
  use {'nvim-telescope/telescope-dap.nvim'}
  -- Look & Feel
  use {'kyazdani42/nvim-web-devicons'}
  use {'folke/lsp-colors.nvim'}
  use {
    'onsails/lspkind-nvim',
    config = function() require("config/lspkind") end
  }
  use {
    'akinsho/nvim-bufferline.lua',
    config = function() require("config/bufferline") end
  }
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function() require("config/galaxyline") end
  }
  use {
    'monsonjeremy/onedark.nvim',
    config = function() require("config/onedark") end
  }
  -- use {
  --   'projekt0n/github-nvim-theme',
  --   config = function() require("config/github-theme") end
  -- }
  use {'mhinz/vim-startify', config = function() require("config/startify") end}

  -- Post-install/update hook with call of vimscript function with argument
  use {'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end}
end)

