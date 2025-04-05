return {
  {
    'saghen/blink.cmp',
    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
      version = "v2.*"
    },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {preset = 'default'},
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },
      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = {auto_show = false},
        menu = {
          auto_show = true,
          draw = {
            columns = {
              {"kind_icon", gap = 1},
              {"label", "label_description", gap = 1}
            },
            components = {
              label = {width = {fill = true, max = 32}},
              label_description = {
                width = {max = 28},
                text = function(ctx)
                  return ctx.label_description
                end,
                highlight = 'BlinkCmpLabelDescription'
              },
              source_name = {
                width = {max = 16},
                text = function(ctx)
                  return ctx.source_name
                end,
                highlight = 'BlinkCmpSource'
              }
            }
          }
        },
        ghost_text = {show_with_menu = true}
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {default = {'lsp', 'path', 'snippets', 'buffer', 'cmdline'}},
      snippets = {preset = 'luasnip'},
      fuzzy = {implementation = "prefer_rust_with_warning"}
      -- pts_extend = { "sources.default" }
    }
  },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        ui = {border = 'rounded'},
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry'
        }
      })
    end
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function(_, opts)
      if opts then
        require("luasnip").config.setup(opts)
      end
      vim.tbl_map(function(type)
        require("luasnip.loaders.from_" .. type).lazy_load()
      end, {"vscode", "snipmate", "lua"})
      -- friendly-snippets - enable standardized comments snippets
      require("luasnip").filetype_extend("typescript", {"tsdoc"})
      require("luasnip").filetype_extend("javascript", {"jsdoc"})
      require("luasnip").filetype_extend("lua", {"luadoc"})
      require("luasnip").filetype_extend("python", {"pydoc"})
      require("luasnip").filetype_extend("rust", {"rustdoc"})
      require("luasnip").filetype_extend("c", {"cdoc"})
      require("luasnip").filetype_extend("cpp", {"cppdoc"})
      require("luasnip").filetype_extend("kotlin", {"kdoc"})
      require("luasnip").filetype_extend("sh", {"shelldoc"})
    end
  },
  -- rust extension
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
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
  }
}
