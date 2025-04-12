return {
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
