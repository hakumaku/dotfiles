-- local util = require("lspconfig/util")
-- local dir = util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml",
--                               "requirements.txt")
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = {justMyCode = false},
      -- Runner to use. Will use pytest if available by default.
      -- Can be a function to return dynamic value.
      runner = "pytest",
      args = {"--capture=no", "--no-header"},
      -- Custom python path for the runner.
      -- Can be a string or a list of strings.
      -- Can also be a function to return dynamic value.
      -- If not provided, the path will be inferred by checking for 
      -- virtual envs in the local directory and for Pipenev/Poetry configs
      python = ".venv/bin/python"
    })
  }
})
