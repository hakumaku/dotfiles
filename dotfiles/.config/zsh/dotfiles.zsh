DOTFILES_PATH="$XDG_DATA_HOME/dotfiles"

_dotfiles_pull() {
    git -C $DOTFILES_PATH pull
}

