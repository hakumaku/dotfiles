#!/usr/bin/env bash

workspace="$HOME/workspace"

install_lua_lsp() {
	local output="${workspace}/lua-language-server"
	if [ ! -d "$output" ]; then
		local url="https://github.com/sumneko/lua-language-server"
		git clone --recurse-submodules $url $output
	fi
	(cd $output/3rd/luamake && ./compile/install.sh &&
		cd $output && ./3rd/luamake/luamake rebuild)
}

install_lua_formatter() {
	local output="${workspace}/LuaFormatter"
	if [ ! -d "$output" ]; then
		local url="https://github.com/Koihik/LuaFormatter.git"
		git clone --recurse-submodules $url $output
	fi
	cmake -S "$output" -B "$output/build" &&
		(cd "$output/build" && make -j8 && sudo make install)
}

# install_lua_formatter
install_lua_lsp
