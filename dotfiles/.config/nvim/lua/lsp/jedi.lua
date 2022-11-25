local util = require("lspconfig/util")

return {
  root_dir = function(fname)
    local dir = util.root_pattern(".git", "setup.py", "setup.cfg",
                                  "pyproject.toml", "requirements.txt")(fname) or
                    util.path.dirname(fname)
    print(dir)
    return dir
  end
}
