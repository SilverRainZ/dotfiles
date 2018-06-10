# SilverRainZ's .bashrc
# ~/.bashrc
# date: 2015-7-21

case "$TERM" in
    xterm)
        export TERM=xterm-256color
        ;;
    screen)
        export TERM=screen-256color
        ;;
esac

source $HOME/.profile
source $HOME/.alias

# vim-cn
upimg(){
    curl -F "name=@$1" https://img.vim-cn.com
}
