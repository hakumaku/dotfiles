#!/usr/bin/env bash

dotfile="$HOME/workspace/ubuntu-fresh/dotfiles"

install_vundle() {
	local url="https://github.com/VundleVim/Vundle.vim.git"
	git clone -q "$url" ~/.vim/bundle/Vundle.vim &&
		(cd && ln -s "$dotfile/vim/.vimrc") && vim +PluginInstall +qall
}

install_ycm() {
	# YouCompleteMe dependencies
	local dependencies=(
	"build-essential" "cmake" "python3-dev" "exuberant-ctags" "cscope" "clang-format")

	# Install latest clang
	sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

	local ycm="$HOME/.vim/bundle/YouCompleteMe"
	sudo apt install ${dependencies[@]} &&
		# (cd && mkdir ycm_build && cd ycm_build &&
		# cmake -G "Unix Makefiles" . $ycm/third_party/ycmd/cpp &&
		# cmake --build . --target ycm_core) &&
		# watchdog installation
		pip3 install setuptools &&
		(cd $ycm/third_party/ycmd/third_party/watchdog_deps/watchdog &&
		rm -rf build/lib3 &&
		python setup.py build --build-base=build/3 --build-lib=build/lib3)
}

sudo apt install vim vim-gtk3 &&
	install_vundle && install_ycm
