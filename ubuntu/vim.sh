#!/usr/bin/env bash

workspace="$HOME/workspace"
dotfile="$HOME/workspace/ubuntu-fresh/dotfiles"
version="11"

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

install_vundle() {
	local url="https://github.com/VundleVim/Vundle.vim.git"
	git clone -q "$url" ~/.vim/bundle/Vundle.vim &&
		(cd && ln -s "$dotfile/vim/.vimrc") && vim +PluginInstall +qall
}

install_cclc() {
	git clone --depth=1 --recursive https://github.com/MaskRay/ccls $workspace &&
		(cd "${workspace}/ccls" &&
			cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
				-DCMAKE_PREFIX_PATH=/usr/lib/llvm-${version} \
				-DLLVM_INCLUDE_DIR=/usr/lib/llvm-${version}/include \
				-DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-${version}/ &&
			sudo cmake --build Release --target install)
}

install_ycm() {
	# YouCompleteMe dependencies
	local dependencies=("build-essential" "python3-dev" "exuberant-ctags" "cscope")
	local ycm="$HOME/.vim/bundle/YouCompleteMe"
	sudo apt install ${dependencies[@]} &&
		(cd $ycm && ./install.py --clangd-completer)
}

install_coc() {
	curl -sL install-node.now.sh/lts | bash
}

sudo apt install cmake vim vim-gtk3 &&
	install_clang &&
	install_vundle &&
	install_ycm
