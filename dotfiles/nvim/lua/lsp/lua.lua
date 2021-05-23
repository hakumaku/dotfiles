local system_name = 'Linux'
local sumneko_root_path = vim.loop.os_homedir() .. '/workspace/lua-language-server'
local sumneko_binary = sumneko_root_path..'/bin/'..system_name..'/lua-language-server'
return {
	cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'};
	settings = {
		Lua = {
			runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
			diagnostics = {globals = {'vim', 'describe'}},
			workspace = {
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
				}
			}
		},
	},
}
