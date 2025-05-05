# ~/.alias

export LA_ALIAS_LOADED=$(($LA_ALIAS_LOADED+1))

# Commonly used
alias _='sudo ' # keep aliases, https://unix.stackexchange.com/a/349290
alias m='make'
alias mj8='make -j8'
alias py='python3'
alias o='xdg-open'
alias grep='grep --color=auto'
alias g='grep --color=auto -r'
alias rm='trash'    # move to trash, NOTE: DO NOT fallback
alias rrm='/bin/rm' # the real rm

# Freqently used path
alias n='cd ~/documents/bullet'
alias nn='cd ~/documents/ronin'

# Workspace manager
alias ws='cd ~/workspace/$('/bin/ls' ~/workspace | fzf)'
_wsnew() {
    fn="$(date +%Y-%m)_$1_$(pypinyin -f slug -s zhao $1)"
    mkdir -p ~/workspace/$fn
    cd ~/workspace/$fn
}
alias wsnew='_wsnew'

# Neovim.
if command -v nvim 2>&1 >/dev/null; then
    alias v='nvim'
    alias vim='nvim'
    alias vin='nvim --noplugin'
else
    alias v='vim'
    alias vin='vim --noplugin'
fi

# Tmux.
alias t='tmux new-session -A'
alias ta='t'
alias ts='tmux-select-sessions'
alias reset='reset; tmux clear-history'

# File manager.
alias f='yazi'

# Package manager
alias felix='sudo pacman -Syu'

## git alias
## cd alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Git-delta
alias diff=delta

# and more..
source ~/.sh/ls.sh
source ~/.sh/git.sh
source ~/.sh/systemd.sh

# vim: set ft=bash:
