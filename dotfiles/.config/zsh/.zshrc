# History settings
HISTFILE=$HOME/.cache/.zsh_histfile
HISTSIZE=500
SAVEHIST=500
# zsh basic settings
# compinit: advanced tab-completion
# promptinit: advanced prompt support
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
autoload -Uz compinit promptinit
zmodload zsh/complist
compinit
promptinit
# Enable the auto-correction of the commands typed.
setopt correctall

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
alias zshrc='nvim $ZDOTDIR/.zshrc'
alias bashrc="nvim ~/.bashrc -c 'normal zt'"
alias vimrc="nvim $HOME/.vimrc"
alias nvimrc="nvim $HOME/.config/nvim/init.vim"
alias sxiv='sxiv -a -f'
alias mocp='mocp --theme green_theme --sound-driver pulseaudio --set-option Keymap=keymap'
# Move to the directory when exiting.
# alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR";'
# alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias nvimg="nvim -c 'Git | wincmd o' ."
alias luamake=/home/haku/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/3rd/luamake/luamake

# Tmux
if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# powerline10k settings
source $XDG_DATA_HOME/ubuntu-fresh-sites/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh

# zsh-syntax-highlighting
source $XDG_DATA_HOME/ubuntu-fresh-sites/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh-autosuggestions
source $XDG_DATA_HOME/ubuntu-fresh-sites/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-vi-mode
source $XDG_DATA_HOME/ubuntu-fresh-sites/zsh-vi-mode/zsh-vi-mode.plugin.zsh

function zsh_vi_mode_init() {
  # Setup fzf
  if [[ ! "$PATH" == */$XDG_DATA_HOME/ubuntu-fresh-sites/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}$XDG_DATA_HOME/ubuntu-fresh-sites/fzf/bin"
  fi
  # Auto-completion
  [[ $- == *i* ]] && source "$XDG_DATA_HOME/ubuntu-fresh-sites/fzf/shell/completion.zsh" 2>/dev/null
  # Key bindings
  source "$XDG_DATA_HOME/ubuntu-fresh-sites/fzf/shell/key-bindings.zsh"

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

fzf_commit() {
  local filter
  if [ -n $@ ] && [ -e $@ ]; then
    filter="-- $@"
  fi
  export LESS='-R'
  export BAT_PAGER='less -S -R -M -i'
  git log \
    --graph --color=always --abbrev=7 \
    --format=format:"%C(bold blue)%h%C(reset) %C(dim white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(white)%s%C(reset) %C(bold green)(%ar)%C(reset)" $@ \
    | fzf --ansi --no-sort --layout=reverse --tiebreak=index \
      --preview="f() { set -- \$(echo -- \$@ | rg -o '\\b[a-f0-9]{7,}\\b'); [ \$# -eq 0 ] || git show --color=always \$1 \$filter | delta --line-numbers; }; f {}" \
      --preview-window=right:60%
}

if command -v neofetch &>/dev/null; then
  neofetch
fi
