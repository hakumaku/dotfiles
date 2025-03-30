return {
  'akinsho/bufferline.nvim',
  config = {
    options = {
      indicator = {icon = '▊ '},
      separator_style = 'thick',
      show_close_icon = false,
      diagnostics = false,
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          highlight = 'Directory',
          text_align = 'center'
        },
        {
          filetype = 'vista',
          text = 'Tags',
          highlight = 'Directory',
          text_align = 'center'
        }
      }
    }
  }
}
