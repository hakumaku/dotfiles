-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache') ..
                              '/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local path = {"?.lua", "?/init.lua", "?/?.lua"}
table.insert(path, "lua/?.lua")
table.insert(path, "lua/?/init.lua")

return {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          -- vim
          'vim',
          'describe',
          'it',
          -- awesomewm
          'awesome',
          'client',
          'root'
        }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          vim.api.nvim_get_runtime_file("", true),
          "/usr/share/awesome/lib"
        }
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {enable = false}
    }
  }
}
