local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache') ..
                              '/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name ..
                           "/lua-language-server"

local path = {"?.lua", "?/init.lua", "?/?.lua"}
for _, v in ipairs(vim.split(package.path, ';')) do path[#path + 1] = v end

local plugins = vim.fn.stdpath('data') .. '/plugged/'
local library = {
  [plugins .. 'plenary.nvim'] = true,
  [plugins .. 'popup.nvim'] = true,
  -- [vim.fn.expand('$VIMRUNTIME/lua')] = true,
  -- [vim.fn.expand('$VIMRUNTIME/lua/vim')] = true,
  [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
  [vim.fn.expand('$VIMRUNTIME/lua/vim/treesitter')] = true
}

return {
  cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT', path = path},
      diagnostics = {globals = {'vim', 'describe', 'it'}},
      workspace = {library = library},
      telemetry = {enable = false}
    }
  }
}
