return {
  cmd = {vim.fn.stdpath('data') .. '/mason/bin/docker-langserver', '--stdio'},
  filetypes = {'dockerfile'},
  single_file_support = true,
  settings = {
    docker = {
      languageserver = {formatter = {ignoreMultilineInstructions = true}}
    }
  }
}

