return {
  filetypes = {'python'},
  cmd = {
    vim.fn.stdpath('data') .. '/mason/bin/basedpyright-langserver',
    "--stdio"
  },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json"
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        autoImportCompletions = true,
        diagnosticMode = "workspace",
        venvPath = ".venv",
        diagnosticSeverityOverrides = {
          reportImportCycles = false,
          reportExplicitAny = false,
          reportUnannotatedClassAttribute = false,
          reportUnusedParameter = false,
          reportMissingTypeStubs = false,
          reportInvalidCast = false,
        }
      }
    }
  }
}
