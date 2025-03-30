return {
  'sbdchd/neoformat',
  config = function()
    -- Enable alignment
    vim.g.neoformat_basic_format_align = 1

    -- Enable tab to spaces conversion
    vim.g.neoformat_basic_format_retab = 1

    -- Enable trimmming of trailing whitespace
    vim.g.neoformat_basic_format_trim = 1

    vim.g.neoformat_enabled_python = {'black'}

    vim.g.shfmt_opt = "-i 2 -ci -bn"

    -- rustfmt
    vim.g.neoformat_rust_rustfmt = {}
  end
}
