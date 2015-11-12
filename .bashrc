# LastAvengers' .bashrc
# ~/.bashrc
# date: 2015-7-21

# env var
PATH=$PATH:~/.gem/ruby/2.2.0/bin 

case "$TERM" in
    xterm)
        export TERM=xterm-256color
        ;;
    screen)
        export TERM=screen-256color
        ;;
esac

# less colorful output
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# alias
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias felix='pacman -Syu'
alias qtox='XDG_CURRENT_DESKTOP= qtox'
alias wiznote='XDG_CURRENT_DESKTOP= WizNote'
alias cutegram='XDG_CURRENT_DESKTOP= cutegram'
alias wps='wps -style=gtk'

# vim-cn
upimg(){
    curl -F "name=@$1" https://img.vim-cn.com
}

# wechall scoreboard
export WECHALLUSER="LastAvengers"
export WECHALLTOKEN="ED8E2-83FF7-4AD9B-4CF7B-FF06B-80DCF"

