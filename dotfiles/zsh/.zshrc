# zsh basic settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
zstyle :compinstall filename '/home/haku/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
autoload -Uz compinit promptinit
zmodload zsh/complist
compinit
promptinit

# Key bindings
bindkey -v
bindkey "^j" history-beginning-search-forward
bindkey "^k" history-beginning-search-backward
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# powerline10k settings
source $HOME/workspace/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Customize
wm () {
	xprop | awk '
		/^WM_CLASS/{sub(/.* =/, "instance:"); sub(/,/, "\nclass:"); print}
		/^WM_NAME/{sub(/.* =/, "title:"); print}'
}
twitch () {
	youtube-dl --quiet -o - "https://www.twitch.tv/""$1" | vlc -f - &!
	# firefox "https://www.twitch.tv/popout/$1/chat?popout=" &!
}
icons () {
	local app=$1
	local path="/var/lib/snapd/desktop/applications"
	local icon=""

	if [ "$app" = "lol" ] || [ "$app" = "leagueoflegends" ]; then
		icon="leagueoflegends"
		app="leagueoflegends_leagueoflegends.desktop"

	elif [ "$app" = "discord" ]; then
		icon="discord"
		app="discord_discord.desktop"

	elif [ "$app" = "system" ]; then
		icon="system"
		app="gnome-system-monitor_gnome-system-monitor.desktop"

	else
		return 1
	fi

	echo $PATH
	sudo sed -ri 's/(Icon=)(.*)/\1'$icon'/' "$path/$app"
}

# Environment variables & aliases
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export LESS="--ignore-case --window=-4 -R"
export PAGER="less"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR=/usr/bin/vim
# Disable pressing <C-s> to freeze.
stty -ixon
alias ls="exa --group-directories-first -s extension"
alias l.="exa -d .*"
alias la="exa -lahF"
# alias ls='ls --color -h --group-directories-first'
# alias l.='ls -d .* --color=auto'
alias diff="diff-so-fancy"
alias cat="bat"
alias find="fd"
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
alias zshrc='vim ~/.zshrc'
# Move to the directory when exiting.
# alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR";'
alias bashrc="vim ${BASH_SOURCE[0]} -c 'normal zt'"
alias vimrc="vim $HOME/.vimrc"
alias sxiv='sxiv -a -f'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# Tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	exec tmux
fi

# zsh-syntax-highlighting
source $HOME/workspace/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-dircolors-solarized
source $HOME/workspace/zsh-dircolors-solarized/zsh-dircolors-solarized.zsh
