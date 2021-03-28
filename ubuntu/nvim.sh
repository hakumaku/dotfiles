#!/usr/bin/env bash

workspace="$HOME/workspace"
dotfile="$HOME/workspace/ubuntu-fresh/dotfiles"
# TODO: auto version detection
version="12"

install_clang() {
	local packages=(
		"clang-${version}" "libclang-${version}-dev" "libclang-cpp${version}-dev"
		"clang-tools-${version}" "clang-format-${version}" "clang-tidy-${version}")
	# Install latest clang
	sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" &&
		sudo apt install ${packages[@]} &&
		sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-${version} 100 &&
		sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${version} 100 &&
		sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${version} 100
}

install_plug() {
	local config="$HOME/.config"
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' &&
		(mkdir -p $config && cd $config && ln -s "$dotfile/nvim") && nvim +PlugInstall +qall &&
		(nvim +"CocInstall coc-highlight coc-clangd coc-cmake coc-snippets" +qall) &&
		(mkdir -p $config/coc && cd $config/coc && ln -s "$dotfile/ultisnips")
}

install_nodejs() {
	sh -c 'curl -sL install-node.now.sh/lts | sudo bash'
}

sudo apt install neovim curl &&
	install_clang &&
	install_nodejs &&
	install_plug

