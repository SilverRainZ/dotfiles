# SilverRainZ's .bashrc
# ~/.bashrc
# date: 2015-7-21

export LA_BASHRC_LOADED=$(($LA_BASHRC_LOADED+1))

if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    OSID=$ID
fi

case "$TERM" in
    xterm)
        export TERM=xterm-256color
        ;;
    screen)
        export TERM=screen-256color
        ;;
esac

source $HOME/.alias

# tilix
if [[ $TILIX_ID ]]; then
    # Fix tilix VTE configuration Issue
    # Ref: https://github.com/gnunn1/tilix/wiki/VTE-Configuration-Issue
    source /etc/profile.d/vte.sh
fi

# TTY
if [ "$TERM" = "linux" ]; then
    source .tty
fi

# iterm2
if [[ "$ITERM_SESSION_ID" ]]; then
    source "${HOME}/.iterm2_shell_integration.zsh"
fi

# sphinxnotes-snippet, only enabled when not sourced by zsh.
if [[ -z "$ZSH_VERSION" ]]; then
    eval "$(snippet integration --sh --sh-binding)"
fi

# autojump, :require:`bin:autojump`.
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    case $OSID in
        arch)
            source /etc/profile.d/autojump.sh;;
        debian)
            source /usr/share/autojump/autojump.zsh;;
    esac
elif [[ "$OSTYPE" == "darwin"* ]]; then
    source /usr/local/etc/profile.d/autojump.sh
fi

# vim: se fdm=marker:
