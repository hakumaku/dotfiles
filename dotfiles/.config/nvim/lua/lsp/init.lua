-- https://github.com/folke/neodev.nvim
-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

local util = require("vim.lsp.util")
local find_root_dir = function(fname)
  local dir = util.root_pattern(".git", "setup.py", "setup.cfg",
                                "pyproject.toml", "requirements.txt")(fname) or
                  util.path.dirname(fname)
  return dir
end

local lspconfig = require('lspconfig')

-- https://www.reddit.com/r/neovim/comments/vfc7hc/lsp_definition_in_tsserver/
local tsserver_handler = {
  ["textDocument/definition"] = function(_, result, params)
    if result == nil or vim.tbl_isempty(result) then
      -- local _ = vim.lsp.log.info() and vim.lsp.log.info(params.method, "No location found")
      return nil
    end

    if vim.tbl_islist(result) then
      -- this is opens a buffer to that result
      -- you could loop the result and choose what you want
      util.jump_to_location(result[1])

      if #result > 1 then
        local isReactDTs = false
        ---@diagnostic disable-next-line: unused-local
        for key, value in pairs(result) do
          if string.match(value.uri, "react/index.d.ts") then
            isReactDTs = true
            break
          elseif string.match(value.uri, "next/types/global.d.ts") then
            isReactDTs = true
            break
          end
        end
        if not isReactDTs then
          -- this sets the value for the quickfix list
          util.set_qflist(util.locations_to_items(result))
          -- this opens the quickfix window
          vim.api.nvim_command("copen")
          vim.api.nvim_command("wincmd p")
        end
      end
    else
      util.jump_to_location(result)
    end
  end
}

local lspconfig = require('lspconfig')
-- Bash
lspconfig.bashls.setup {}
-- Typescript
lspconfig.tsserver.setup {handlers = tsserver_handler}
lspconfig.eslint.setup {}
lspconfig.cssls.setup {}
lspconfig.cssmodules_ls.setup {
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "css",
    "scss"
  },
  on_attach = function(client)
    -- avoid accepting `definitionProvider` responses from this LSP
    client.server_capabilities.definitionProvider = false
    -- custom_on_attach(client)
  end
}
-- Python
lspconfig.pyright.setup {}
lspconfig.ruff_lsp.setup {}
-- C/C++
lspconfig.cmake.setup {}
lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--header-insertion=iwyu",
    "--inlay-hints",
    "--clang-tidy"
  },
  filetypes = {"c", "cpp", "h", "hpp", "cxx", "tpp", "objc", "objcpp"},
  init_option = {fallbackFlags = {"--std=c++20"}}
}
-- Rust
-- lspconfig.rust_analyzer.setup {
--   -- Server-specific settings. See `:help lspconfig-setup`
--   settings = {['rust-analyzer'] = {}}
-- }
lspconfig.terraformls.setup {}
-- Misc
lspconfig.jsonls.setup {}
lspconfig.yamlls.setup {}
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
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

require('lsp.clangd-extensions')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = {buffer = ev.buf}
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', '<space>f', function()
    --   vim.lsp.buf.format {async = true}
    -- end, opts)
  end
})

-- https://github.com/neovim/neovim/blob/master/runtime/plugin/diagnostic.vim
vim.fn.sign_define('DiagnosticSignError', {
  -- TODO: bitmap icon
  text = '',
  texthl = 'LspDiagnosticsDefaultError',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('DiagnosticSignWarn', {
  text = '',
  texthl = 'LspDiagnosticsDefaultWarning',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('DiagnosticSignHint', {
  text = '',
  texthl = 'LspDiagnosticsDefaultHint',
  linehl = '',
  numhl = ''
})
vim.fn.sign_define('DiagnosticSignInfo', {
  text = '',
  texthl = 'LspDiagnosticsDefaultInformation',
  linehl = '',
  numhl = ''
})
