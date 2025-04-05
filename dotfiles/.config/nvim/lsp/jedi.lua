return {
  filetypes = {'python'},
  cmd = {vim.fn.stdpath('data') .. '/mason/bin/jedi-language-server'},
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json"
  }
}
