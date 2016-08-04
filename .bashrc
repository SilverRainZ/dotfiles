# LastAvengers' .bashrc
# ~/.bashrc
# date: 2015-7-21

# env var
PATH=$PATH:~/.gem/ruby/2.3.0/bin

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
    curl -F "name=@$1" http://img.tjm.moe
}

# alias
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias felix='pacman -Syu'
alias qtox='XDG_CURRENT_DESKTOP= qtox'
alias wiznote='XDG_CURRENT_DESKTOP= WizNote'
alias cutegram='XDG_CURRENT_DESKTOP= cutegram'
alias goldendict='XDG_CURRENT_DESKTOP= goldendict'
alias vin='vim --noplugin'
alias _p='proxychains'

# custome gitalias
alias gl='git log --color --graph --decorate -M --pretty=oneline --abbrev-commit -M'
alias gs='git status'
alias ga='git add'
alias gd='git diff'

source ~/.workalias
