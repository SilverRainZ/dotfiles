if empty($XDG_CONFIG_HOME)
    let $XDG_CONFIG_HOME =expand('~/.config')
endif

" Say goodbye to vi
set nocompatible

source $HOME/.vimrc

lua require('plugins')

" vim modeline {{{1
" vim: set fdm=marker:
