# History settings
HISTFILE=$HOME/.cache/.zsh_histfile
HISTSIZE=500
SAVEHIST=500
# Auto completions path
fpath+=${XDG_DATA_HOME}/zsh/site-functions
[[ -d $XDG_DATA_HOME/repositories/zsh-completions ]] && fpath+=$XDG_DATA_HOME/repositories/zsh-completions/src
# zsh basic settings
# compinit: advanced tab-completion
# promptinit: advanced prompt support
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
autoload -Uz compinit promptinit
zmodload zsh/complist
autoload bashcompinit
compinit
promptinit
bashcompinit
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
# nvm (https://github.com/nvm-sh/nvm)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# pyenv (https://github.com/pyenv/pyenv)
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
if command -v pyenv >/dev/null; then
  eval "$(pyenv init -)"
fi

source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/dotfiles.zsh"
source "$ZDOTDIR/completions.zsh"

# powerline10k settings
source $XDG_DATA_HOME/repositories/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh

# zsh-autosuggestions
source $XDG_DATA_HOME/repositories/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-vi-mode
source $XDG_DATA_HOME/repositories/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# zsh-syntax-highlighting
source $XDG_DATA_HOME/repositories/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# fzf-tab
source $XDG_DATA_HOME/repositories/fzf-tab/fzf-tab.plugin.zsh

function _zsh_vi_mode_init() {
  if [[ -f $XDG_CONFIG_HOME/fzf/fzf.zsh ]]; then
    source $XDG_CONFIG_HOME/fzf/fzf.zsh
    # FZF (https://github.com/junegunn/fzf)
    # Use ~~ as the trigger sequence instead of the default **
    export FZF_COMPLETION_TRIGGER='~~'
    # Options to fzf command
    export FZF_COMPLETION_OPTS='+c -x'
    # Setting fd as the default source for fzf
    export FZF_DEFAULT_COMMAND='fd --type f'
    # To apply the command to CTRL-T as well
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi

  # Key bindings
  bindkey -v
  bindkey "^j" history-beginning-search-forward
  bindkey "^k" history-beginning-search-backward
  bindkey -M menuselect 'h' vi-backward-char
  bindkey -M menuselect 'k' vi-up-line-or-history
  bindkey -M menuselect 'l' vi-forward-char
  bindkey -M menuselect 'j' vi-down-line-or-history
}
zvm_after_init_commands+=(_zsh_vi_mode_init)

# Tmux
if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  if command -v neofetch &>/dev/null; then
    exec tmux new 'sleep 0.1; neofetch; $SHELL'
  else
    exec tmux
  fi
fi

bindkey -s '^w9' "cd $XDG_DATA_HOME/dotfiles^M"
bindkey -s '^w0' "cd $XDG_DATA_HOME/repositories^M"

bindkey -s '^wa' "^Ulazygit^M"
bindkey -s '^wb' "^Ulazydocker^M"
bindkey -s '^wc' "^Ubtm^M"
bindkey -s '^o' "^Uranger^M"
