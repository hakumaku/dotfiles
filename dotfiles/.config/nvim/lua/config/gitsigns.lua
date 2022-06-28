-- https://github.com/lewis6991/gitsigns.nvim
require('gitsigns').setup({
  on_attach = function(bufnr)
    -- local gs = package.loaded.gitsigns
    -- local function map(mode, l, r, opts)
    --   opts = opts or {}
    --   opts.buffer = bufnr
    --   vim.keymap.set(mode, l, r, opts)
    -- end
  end
})
