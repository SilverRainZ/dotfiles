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

# alias
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias felix='pacman -Syu'
alias qtox='XDG_CURRENT_DESKTOP= qtox'
alias wiznote='XDG_CURRENT_DESKTOP= WizNote'
alias cutegram='XDG_CURRENT_DESKTOP= cutegram'
alias vin='vim --noplugin'

# custome gitalias
alias gitl='git log --color --graph --decorate -M --pretty=oneline --abbrev-commit -M'
alias gits='git status'

# vim-cn
upimg(){
    curl -F "name=@$1" https://img.vim-cn.com
}
