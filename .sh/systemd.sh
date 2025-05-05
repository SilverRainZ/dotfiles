# Set of aliases for SYSTEMCTL(1).

_sysls() {
    # $1: --system or --user
    # $2: list-units or list-unit-files
    # $3: states, see also "systemctl list-units --state=help"
    if [ $1 == 0 ]; then
        WIDE=--system
    else
        WIDE=--user
    fi
    if [ $2 == 0 ]; then
        ACTION=list-units
    else
        ACTION=list-unit-files
    fi
    if [ -z $3 ]; then
        STATE=""
    else
        STATE="--state=$3"
    fi

    # NOTE: The magic number *6* is the lines of "systemctl list-units" legend.
    # After writing this I found github.com/joehillen/sysz :'(
    echo systemctl $WIDE $ACTION $STATE >&2
    systemctl $WIDE $ACTION $STATE | \
    sed 's/●/ /'| \
    head -n -6 | \
    fzf --header-lines 1 \
        --accept-nth=1 \
        --no-hscroll \
        --preview="SYSTEMD_COLORS=1 systemctl $WIDE status {1}" \
        --preview-window=down
}

## --system
alias s='sudo systemctl'
alias sls="_sysls 0 0"
alias slsf="_sysls 0 1"
alias sstart='s start $(slsf static,disabled) && s status $_'
alias sstop='s stop $(sls running,failed) && s status $_'
alias sre='s restart $(sls) && s status $_'
alias jour='journalctl --unit $(sls)'

## --user
alias u='systemctl --user' # TODO: conflicts with ronin
alias uls="_sysls 1 0"
alias ulsf="_sysls 1 1"
alias ustart='u start $(ulsf static,disabled) && u status $_'
alias ustop='u stop $(uls running,failed) && u status $_'
alias ure='u restart $(uls) && u status $_'
alias ujour='journalctl --user --unit $(uls)'
