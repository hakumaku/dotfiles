return {
  -- rust extension
  {
    "mrcjkb/rustaceanvim",
    lazy = false,
    version = "^6", -- Recommended
    config = function()
      vim.g.rustaceanvim = {
        server = {
          cmd = function(host_or_path, port)
            return vim.lsp.rpc.connect("/run/user/1000/ra-mux/ra-mux.sock")
          end,
          -- ra_multiplex = {
          --   enable = true,
          --   host = "127.0.0.1",
          --   host = "27631",
          -- },
          default_settings = {
            --- options to send to rust-analyzer
            --- See: https://rust-analyzer.github.io/book/configuration
            --- @type table
            ["rust-analyzer"] = {
              workspace = {
                symbol = {
                  search = {
                    excludeImports = true,
                  },
                },
              },
              lspMux = {
                version = "1",
                method = "connect",
                server = vim.fn.exepath("rust-analyzer"),
              },
            },
          },
        },
        tools = { enable_nextest = true, enable_clippy = true },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    version = "v0.4.0",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },
}
