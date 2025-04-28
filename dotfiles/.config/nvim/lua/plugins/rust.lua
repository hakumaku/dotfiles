return {
  -- rust extension
  {
    'mrcjkb/rustaceanvim',
    lazy = false,
    version = '^6', -- Recommended
    config = function()
      vim.g.rustaceanvim = {
        tools = {enable_nextest = true, enable_clippy = true}
      }
    end
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
