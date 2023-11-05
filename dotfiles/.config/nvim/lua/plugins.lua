local install_path = vim.fn.stdpath('data') ..
                         '/site/pack/packer/start/packer.nvim'
local is_packer_not_installed = vim.fn.empty(vim.fn.glob(install_path)) > 0
if is_packer_not_installed then
  vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer = require('packer')
packer.init({max_jobs = 4})

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  -- Vim basic utility
  use {"tpope/vim-repeat"}
  use {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("config.nvim-surround")
    end
  }
  -- Development Utilities (Neovim 5.0+)
  -- manage external editor tooling
  use {
    "williamboman/mason.nvim",
    config = function()
      require("config.mason")
    end
  }
  use {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("config.mason")
    end
  }
  use {"neovim/nvim-lspconfig"}
  -- non-LSP sources to hook into its LSP client
  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("config.null-ls")
    end
  }
  use {"nvim-lua/plenary.nvim"}
  use {"nvim-lua/popup.nvim"}
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("config.tree-sitter")
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
    config = function()
      require("config.telescope")
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require("config.gitsigns")
    end
  }
  use {
    'sbdchd/neoformat',
    config = function()
      require("config.neoformat")
    end
  }
  -- File Navigation
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require("config.nvim-tree")
    end
  }
  -- Symbols Navigation
  use {
    'stevearc/aerial.nvim',
    config = function()
      require("config.aerial")
    end
  }

  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require("config.toggleterm")
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require("Comment").setup()
    end
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'rcarriga/cmp-dap'
    },
    config = function()
      require("config.cmp")
    end
  }
  use {
    'SirVer/ultisnips',
    requires = {'quangnguyen30192/cmp-nvim-ultisnips'},
    config = function()
      require("config.ultisnips")
    end
  }

  -- clangd extension
  use {'p00f/clangd_extensions.nvim'}

  -- rust extension
  use {'simrat39/rust-tools.nvim'}
  use {
    tag = 'v0.3.0',
    event = {"BufRead Cargo.toml"},
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
      require('crates').setup()
    end
  }

  -- python extension
  use {'numirias/semshi'}

  -- json schemas
  use {"b0o/schemastore.nvim"}

  -- database
  use {'tpope/vim-dadbod'}
  use {
    "kndndrj/nvim-dbee",
    requires = {"MunifTanjim/nui.nvim"},
    run = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      -- require("dbee").setup( --[[optional config]] )
    end
  }

  -- nvim api
  use {"folke/neodev.nvim"}

  -- obsidian
  use({
    "epwalsh/obsidian.nvim",
    requires = {"nvim-lua/plenary.nvim"},
    config = function()
      require("obsidian").setup({dir = "~/workspace/github/obsidian/diary"})
    end
  })

  -- test adopter
  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python"
      -- "antoinemadec/FixCursorHold.nvim"
    },
    config = function()
      require("config.neotest")
    end
  }

  -- DAP
  use {
    'mfussenegger/nvim-dap',
    config = function()
      require("config.dap")
    end
  }
  use {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('python')
      -- require('dap-python').resolve_python = function()
      --   return '/absolute/path/to/python'
      -- end
    end
  }
  use {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('config.dapui')
    end
  }
  use {'nvim-telescope/telescope-dap.nvim'}

  -- js/css
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('config.nvim-colorizer')
    end
  }

  -- Look & Feel
  use {'kyazdani42/nvim-web-devicons'}
  use {'folke/lsp-colors.nvim'}
  use {
    'folke/todo-comments.nvim',
    config = function()
      require("config.todo")
    end
  }
  use {
    'onsails/lspkind-nvim',
    config = function()
      require("config.lspkind")
    end
  }
  use {
    'akinsho/bufferline.nvim',
    config = function()
      require("config.bufferline")
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require("config.lualine")
    end
  }
  -- use {
  --   'olimorris/onedarkpro.nvim',
  --   config = function()
  --     require("config.onedarkpro")
  --   end
  -- }
  use {
    'EdenEast/nightfox.nvim',
    config = function()
      require("config.nightfox")
    end
  }
  use {
    'mhinz/vim-startify',
    config = function()
      require("config.startify")
    end
  }

  -- Post-install/update hook with call of vimscript function with argument
  use {
    'glacambre/firenvim',
    run = function()
      vim.fn['firenvim#install'](0)
    end
  }

  if is_packer_not_installed then
    require('packer').sync()
  end
end)

