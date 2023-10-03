if [ "${TERM}" = "linux" ] || [ -n "${SSH_CLIENT}" ] || [ -n "${SSH_TTY}" ]; then
  if [ -d "${HOME}/.config/environment.d" ]; then
    env_configs=($(ls "$HOME/.config/environment.d"))
    for env_config in ${env_configs[@]}; do
      source "$HOME/.config/environment.d/${env_config}"
    done
  else
    export PATH=${HOME}/.local/bin:${XDG_DATA_HOME}/cargo/bin:$PATH
  fi
fi

# Environment variables
export HISTFILE=$HOME/.cache/.zsh_histfile
export HISTSIZE=1000
export SAVEHIST=1000
export LESS="--ignore-case --window=-4 -R"
export PAGER="less"
if command -v bat &>/dev/null; then
  export MANROFFOPT="-c"
  export MANPAGER="sh -c 'col -bx | bat -pl man'"
fi
export EDITOR=nvim
export VISUAL="$EDITOR"

# Auto completions path
fpath+=${XDG_DATA_HOME}/zsh/site-functions
[[ -d $XDG_DATA_HOME/repositories/zsh-completions ]] && fpath+=$XDG_DATA_HOME/repositories/zsh-completions/src

# Disable pressing <C-s> to freeze.
stty -ixon

# zsh basic settings
# compinit: advanced tab-completion
# promptinit: advanced prompt support
autoload -Uz compinit promptinit
zmodload zsh/complist
autoload bashcompinit
compinit
promptinit
bashcompinit
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

# zsh-vi-mode
local dir="$XDG_DATA_HOME/repositories"
local plugins=(
  "powerlevel10k/powerlevel10k.zsh-theme"
  "zsh-autosuggestions/zsh-autosuggestions.zsh"
  "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  "fzf-tab/fzf-tab.plugin.zsh"
  "zsh-vi-mode/zsh-vi-mode.plugin.zsh"
)
for plugin in "${plugins[@]}"; do
  source "$dir/$plugin"
done
# powerlevel10k: to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]]; then
  source $XDG_CONFIG_HOME/zsh/.p10k.zsh
fi

function _zsh_vi_mode_init() {
  # fzf
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

  # Key bindings for zsh-vi-mode
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
# if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

# Bindings
zle -N _fzf_cd_gitlab
bindkey '^]' _fzf_cd_gitlab

zle -N _fg_bg
bindkey '^z' _fg_bg

alias pubip="curl 'https://api.ipify.org?format=txt'"

bindkey -s '^w9' "cd $XDG_DATA_HOME/dotfiles^M"
bindkey -s '^w0' "cd $XDG_DATA_HOME/repositories^M"

bindkey -s '^wa' "^Ulazygit^M"
bindkey -s '^wb' "^Ulazydocker^M"
bindkey -s '^wc' "^Ubtm^M"
bindkey -s '^o' "^Uranger^M"

# source some files
source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/dotfiles.zsh"
source "$ZDOTDIR/completions.zsh"

# broot (https://github.com/Canop/broot)
if [[ -f $XDG_CONFIG_HOME/broot/launcher/bash/br ]]; then
  source $XDG_CONFIG_HOME/broot/launcher/bash/br
fi

# nvm (https://github.com/nvm-sh/nvm)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# pyenv (https://github.com/pyenv/pyenv)
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null; then
  eval "$(pyenv init -)"
fi
