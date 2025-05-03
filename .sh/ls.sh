# Aliases of LS(1) and EZA(1).

if command -v eza 2>&1 >/dev/null; then
    # https://gist.github.com/AppleBoiy/04a249b6f64fd0fe1744aff759a0563b
    alias _eza='eza --color=always --group-directories-first --icons --classify=always'
    alias l='_eza --git '
    alias ls='_eza --git '
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
