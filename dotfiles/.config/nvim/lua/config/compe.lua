require('compe').setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 2,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 40,
  max_kind_width = 100,
  max_menu_width = 10,
  documentation = true,

  -- priority
  source = {
    ultisnips = true,
    buffer = true,
    path = true,
    nvim_lsp = true,
    nvim_lua = true,
    calc = true,
    vsnip = false,
  }
}
