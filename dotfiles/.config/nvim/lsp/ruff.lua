return {
  filetypes = {'python'},
  cmd = {vim.fn.stdpath('data') .. '/mason/bin/ruff', "server"},
  root_markers = {'pyproject.toml'}
}

