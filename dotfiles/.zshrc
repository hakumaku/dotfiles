# zsh basic settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
autoload -Uz compinit promptinit
zmodload zsh/complist
compinit
promptinit

# Disable pressing <C-s> to freeze.
stty -ixon

# Environment variables & aliases
export LESS="--ignore-case --window=-4 -R"
export PAGER="less"
if command -v bat &>/dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi
export EDITOR=nvim
export VISUAL="$EDITOR"

alias python='/usr/bin/python3'
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
alias zshrc='nvim ~/.zshrc'
alias bashrc="nvim ~/.bashrc -c 'normal zt'"
alias vimrc="nvim $HOME/.vimrc"
alias nvimrc="nvim $HOME/.config/nvim/init.vim"
alias sxiv='sxiv -a -f'
alias mocp='mocp --theme green_theme --sound-driver pulseaudio --set-option Keymap=keymap'
# Move to the directory when exiting.
# alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR";'
# alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias nvimg="nvim -c 'Git | wincmd o' ."

# Tmux
if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# powerline10k settings
source $HOME/.packages/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# FZF (https://github.com/junegunn/fzf)
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# zsh-syntax-highlighting
source $HOME/.packages/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh-autosuggestions
source $HOME/.packages/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-vi-mode
source $HOME/.packages/zsh-vi-mode/zsh-vi-mode.plugin.zsh

function zsh_vi_mode_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    # Key bindings
    bindkey -v
    bindkey "^j" history-beginning-search-forward
    bindkey "^k" history-beginning-search-backward
    bindkey -M menuselect 'h' vi-backward-char
    bindkey -M menuselect 'k' vi-up-line-or-history
    bindkey -M menuselect 'l' vi-forward-char
    bindkey -M menuselect 'j' vi-down-line-or-history
}
zvm_after_init_commands+=(zsh_vi_mode_init)

alias luamake=/home/haku/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/3rd/luamake/luamake
