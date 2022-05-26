DOTFILES_PATH="$XDG_DATA_HOME/dotfiles"

df_pull() {
    git -C $DOTFILES_PATH pull
}

df_zsh() {
    make --directory $DOTFILES_PATH zsh
}

