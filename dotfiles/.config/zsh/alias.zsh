#alias python='/usr/bin/python3'
if command -v exa &>/dev/null; then
  alias ls="exa --group-directories-first -s extension"
  alias l.="exa -d .*"
  alias la="exa -lahF"
else
  alias ls='ls --color -h --group-directories-first'
  alias l.='ls -d .* --color=auto'
  alias la="ls -lahF"
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
alias vimrc="nvim $HOME/.vimrc"
alias nvimrc="nvim $HOME/.config/nvim/init.vim"
alias sxiv='sxiv -a -f'
alias mocp='mocp --theme green_theme --sound-driver pulseaudio --set-option Keymap=keymap'
# Move to the directory when exiting.
# alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR";'
# alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias nvimg="nvim -c 'Git | wincmd o' ."
alias luamake=$XDG_CACHE_HOME/nvim/lspconfig/sumneko_lua/lua-language-server/3rd/luamake/luamake

