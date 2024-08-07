if command -v exa &>/dev/null; then
  alias ls="exa --group-directories-first -s extension"
  alias ll="exa -alF"
  alias la="exa -lahF"
  alias l.="exa -d .*"
else
  alias ls="ls --color -h --group-directories-first"
  alias ll="ls -alF"
  alias la="ls -lahF"
  alias l.="ls -d .* --color=auto"
fi
alias grep='grep --color=auto'
alias mnt='udisksctl mount -b'
alias umnt='udisksctl unmount -b'
alias rm='rm -i'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias gm='cd $HOME/Music'
alias gd='cd $HOME/Downloads'
alias gv='cd $HOME/Videos'
alias zshrc='nvim $ZDOTDIR/.zshrc'
alias bashrc="nvim ~/.bashrc -c 'normal zt'"
alias dotfiles="cd $HOME/.local/share/dotfiles"
alias kitty_ssh="kitty +kitten ssh"

[ "$TERM" = "xterm-kitty" ] && alias terminfo="echo kitty +kitten ssh"
[ "$TERM" = "alacritty" ] && alias terminfo="echo curl -sSL https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info | tic -x -"
