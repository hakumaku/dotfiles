local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim (https://github.com/folke/lazy.nvim)
require("lazy").setup({
  -- Vim basic utility
  "tpope/vim-repeat",
  "mbbill/undotree",
  "Raimondi/delimitMate",
  {
    "kylechui/nvim-surround",
    config = function()
      require("config.nvim-surround")
    end
  },
  -- Development Utilities
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- manage external editor tooling
      {
        "williamboman/mason.nvim",
        opts = {
          ---@since 1.0.0
          -- Where Mason should put its bin location in your PATH. Can be one of:
          -- - "prepend" (default, Mason's bin location is put first in PATH)
          -- - "append" (Mason's bin location is put at the end of PATH)
          -- - "skip" (doesn't modify PATH)
          ---@type '"prepend"' | '"append"' | '"skip"'
          PATH = "append",
        }
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason").setup()
          require("config.mason-lspconfig")
        end
      },
      -- non-LSP sources to hook into its LSP client
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("config.null-ls")
        end
      },
      -- clangd extension
      'p00f/clangd_extensions.nvim',
      -- rust extension
      {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        ft = {'rust'}
      },
      {
        "saecki/crates.nvim",
        version = 'v0.4.0',
        event = {"BufRead Cargo.toml"},
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function()
          require('crates').setup()
        end
      },
      -- typescript extension
      'windwp/nvim-ts-autotag',
      {
        "pmizio/typescript-tools.nvim",
        dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"},
        opts = {
          settings = {
            tsserver_plugins = {
              -- for TypeScript v4.9+
              "@styled/typescript-styled-plugin"
              -- or for older TypeScript versions
              -- "typescript-styled-plugin",
            }
          }
        }
      },
    },
  },
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.tree-sitter")
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      require("config.telescope")
    end
  },
  {
    'sbdchd/neoformat',
    config = function()
      require("config.neoformat")
    end
  },
  -- Git Integration
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require("config.gitsigns")
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim"},
    config = function()
      require("config.neogit")
    end
  },
  -- File Navigation
  {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require("config.nvim-tree")
    end
  },
  -- Symbols Navigation
  {
    'stevearc/aerial.nvim',
    config = function()
      require("config.aerial")
    end
  },

  {
    'akinsho/toggleterm.nvim',
    config = function()
      require("config.toggleterm")
    end
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    -- event = "InsertEnter",
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'rcarriga/cmp-dap'
    },
    config = function()
      require("config.cmp")
    end
  },
  {
    'SirVer/ultisnips',
    lazy = true,
    event = {'InsertEnter'},
    dependencies = {'quangnguyen30192/cmp-nvim-ultisnips'}
  },
  -- json schemas
  "b0o/schemastore.nvim",
  -- database
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      'tpope/vim-dadbod',
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { 'sql', 'mysql', 'plsql' },
        lazy = true
      },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  -- obsidian
  {
    "epwalsh/obsidian.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre " .. vim.fn.expand "~" .. "/Documents/journey/*.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Documents/journey/*.md"
    },
    config = function()
      require("config.obsidian")
    end
  },
  -- inline drawing
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      image = { enabled = true }
    },
  },

  -- test adopter
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "nvim-neotest/nvim-nio"
    },
    lazy = true,
    event = {"BufRead test_*.py"},
    config = function()
      require("config.neotest")
    end
  },

  -- DAP
  {
    'mfussenegger/nvim-dap',
    config = function()
      require("config.dap")
    end
  },
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
      require('dap-python').setup(mason_path ..
                                      "packages/debugpy/venv/bin/python")
    end
  },
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('config.dapui')
    end
  },
  'nvim-telescope/telescope-dap.nvim',

  -- js/css
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('config.nvim-colorizer')
    end
  },

  -- Look & Feel
  {'kyazdani42/nvim-web-devicons', lazy = true},
  'folke/lsp-colors.nvim',
  {
    'folke/zen-mode.nvim',
    opts = {
      width = 120, -- width of the Zen window
    }
  },
  'folke/todo-comments.nvim',
  {
    'onsails/lspkind-nvim',
    config = function()
      require("config.lspkind")
    end
  },
  {
    'akinsho/bufferline.nvim',
    config = function()
      require("config.bufferline")
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {'kyazdani42/nvim-web-devicons'},
    config = function()
      require("config.lualine")
    end
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    config = function()
      require("config.nightfox")
    end
  },
  {
    'mhinz/vim-startify',
    config = function()
      require("config.startify")
    end
  }
})

