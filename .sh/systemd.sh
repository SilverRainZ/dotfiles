# Set of aliases/helpers for SYSTEMCTL(1).

# Simple aliases.
alias s='sudo systemctl'
alias sj='journalctl'
alias u='systemctl --user'
alias uj='journalctl --user'

# SystemD unit selector.
_sysls() {
    # $1: --system or --user
    # $2: states, see also "systemctl list-units --state=help"
    WIDE=$1
    [ -n "$2" ] && STATE="--state=$2"
    cat \
        <(echo 'UNIT/FILE LOAD/STATE ACTIVE/PRESET SUB DESCRIPTION') \
        <(systemctl $WIDE list-units --legend=false $STATE) \
        <(systemctl $WIDE list-unit-files --legend=false $STATE) \
    | sed 's/●/ /' \
    | grep . \
    | column --table --table-columns-limit=5 \
    | fzf --header-lines=1 \
          --accept-nth=1 \
          --no-hscroll \
          --preview="SYSTEMD_COLORS=1 systemctl $WIDE status {1}" \
          --preview-window=down
}

# Aliases for unit selector.
alias sls='_sysls --system'
alias uls='_sysls --user'
alias sjf='sj --unit $(uls) --all --follow'
alias ujf='uj --unit $(uls) --all --follow'

_SYS_ALIASES=(
    sstart sstop sre
    ustart ustop ure
)
_SYS_CMDS=(
    's start $(sls static,disabled,failed)'
    's stop $(sls running,failed)'
    's restart $(sls)'
    'u start $(uls static,disabled,failed)'
    'u stop $(uls running,failed)'
    'u restart $(uls)'
)

_sysexec() {
    for ((j=0; j < ${#_SYS_ALIASES[@]}; j++)); do
        if [ "$1" == "${_SYS_ALIASES[$j]}" ]; then
            cmd=$(eval echo "${_SYS_CMDS[$j]}") # expand service name
            wide=${cmd:0:1}
            cmd="$cmd && ${wide} status \$_ || ${wide}j -xeu \$_"
            eval $cmd

            # Push to history.
            [ -n "$BASH_VERSION" ] && history -s $cmd
            [ -n "$ZSH_VERSION" ] && print -s $cmd 
            return
        fi
    done
}

# Generate bash function/zsh widgets.
for i in ${_SYS_ALIASES[@]}; do
    source /dev/stdin <<EOF
$i() {
    _sysexec $i
}
EOF
done
