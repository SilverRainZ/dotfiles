# ~/.alias

export LA_ALIAS_LOADED=$(($LA_ALIAS_LOADED+1))

# Commonly used
alias _='sudo ' # keep aliases, https://unix.stackexchange.com/a/349290
alias m='sm'    # smart make, see ~/bin/sm
alias mj8='make -j8'
alias _p='proxychains'
alias py='python3'
alias o='xdg-open'
alias grep='grep --color=auto'
alias g='grep --color=auto -r'
alias rm='trash'    # move to trash, NOTE: DO NOT fallback
alias rrm='/bin/rm' # the real rm

# Freqently used path
alias n='cd ~/documents/bullet'
alias u='cd ~/documents/ronin'

# Workspace manager
alias ws='cd ~/workspace/$(ls ~/workspace | fzf)'
_wsnew() {
    fn="$(date +%Y-%m)_$1_$(pypinyin -f slug -s zhao $1)"
    mkdir -p ~/workspace/$fn
    cd ~/workspace/$fn
}
alias wsnew='_wsnew'

# ls.
if command -v eza 2>&1 >/dev/null; then
    # https://gist.github.com/AppleBoiy/04a249b6f64fd0fe1744aff759a0563b
    alias _eza='eza --color=always --group-directories-first --icons --classify=always'
    alias l='_eza --git '
    alias ll='_eza -l'
    alias la='_eza -la --group'
    alias lx='_eza -la --header --created --accessed --modified --time-style=long-iso --links --extended'
    alias l.="_eza -a | grep -E '^\.'"
    alias tree='_eza --tree --level=2'
else
    alias l='ls --color=auto'
    alias ls='ls --color=auto'
    alias ll='ls -l'
    alias la='ls -a'
fi

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
alias gl='git log --color --graph --decorate -M --pretty=oneline --abbrev-commit -M'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gcm='git commit'
alias gco='git checkout'
alias gst='git stash'
alias grs='git restore --staged'
alias gr='cd $(git rev-parse --show-toplevel)' # cd to git root
alias gg='git grep'

## cd alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# SystemD
_list_systemd_units() {
    # NOTE: The magic number *6* is the lines of "systemctl list-units" legend.
    # After writing this I found github.com/joehillen/sysz :'(
    systemctl $1 list-units --state=running,failed,waiting,dead | \
    head -n -6 | \
    fzf --header-lines 1 \
        --accept-nth=1 \
        --no-hscroll \
        --preview="SYSTEMD_COLORS=1 systemctl $1 status {1}" \
        --preview-window=down
}

## --system
alias s='systemctl'
alias sls="_list_systemd_units"
alias sstart='_ s start $(sls) && s status $_'
alias sstop='_ s stop $(sls) && s status $_'
alias sre='_ s restart $(sls) && s status $_'
alias jour='journalctl --unit $(sls)'

## --user
alias us='systemctl --user' # TODO: conflicts with ronin
alias uls="_list_systemd_units --user"
alias ustart='us start $(uls) && us status $_'
alias ustop='us stop $(uls) && us status $_'
alias ure='us restart  $(uls) && us status $_'
alias ujour='journalctl --user --unit $(uls)'

# Git-delta
alias diff=delta

# vim: set ft=bash:
