# SilverRainZ's .bashrc
# ~/.bashrc
# date: 2015-7-21

export LA_BASHRC_LOADED=$(($LA_BASHRC_LOADED+1))

case "$TERM" in
    xterm)
        export TERM=xterm-256color
        ;;
    screen)
        export TERM=screen-256color
        ;;
esac

source $HOME/.alias

# vim-cn
upimg(){
    curl -F "name=@$1" https://img.vim-cn.com
}

# Init pyenv if it is installed
# if command -v pyenv 1>/dev/null 2>&1; then
#     eval "$(pyenv init -)"
#     # Init pyenv-virtualenv if it is installed
#     if command -v pyenv-virtualenv 1>/dev/null 2>&1; then
#         eval "$(pyenv virtualenv-init -)"
#     fi
# fi

# Fix tilix VTE configuration Issue
# Ref: https://github.com/gnunn1/tilix/wiki/VTE-Configuration-Issue
if [[ $TILIX_ID ]]; then
    source /etc/profile.d/vte.sh
fi

# Source for TTY
if [ "$TERM" = "linux" ]; then
    source .tty
fi

# sphinxnotes-snippet
eval "$(snippet integration --sh --sh-binding)"
