# SilverRainZ's .bashrc
# ~/.bashrc
# date: 2015-7-21

export PATH=$PATH:$HOME/bin

case "$TERM" in
    xterm)
        export TERM=xterm-256color
        ;;
    screen)
        export TERM=screen-256color
        ;;
esac

# vim-cn
upimg(){
    curl -F "name=@$1" http://img.vim-cn.com
}

# Envirnment varible

## Wechall scoreboard
export WECHALLUSER="LastAvengers"
export WECHALLTOKEN="ED8E2-83FF7-4AD9B-4CF7B-FF06B-80DCF"

## Less colorful output
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

export CHROOT=$HOME/chroot

source $HOME/.alias
