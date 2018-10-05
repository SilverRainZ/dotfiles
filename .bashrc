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
