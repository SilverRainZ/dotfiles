" Plugin related script

let $PLUGIN_CACHE='$HOME/.local/share/nvim/plugged'
let $PLUGIN_CONFIG='$XDG_CONFIG_HOME/nvim/plugins'

" Plugin managed by vim-plug {{{1
" Run `:PlugInstall` to install plugins

call plug#begin($PLUGIN_CACHE)

" Themes
Plug 'shaunsingh/nord.nvim'
Plug 'ishan9299/nvim-solarized-lua'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Completion manager
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" Completion Sources
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-pyclang'
" Plug 'ncm2/ncm2-go'
" Plug 'ncm2/ncm2-jedi'

" Multi-entry selection UI.
if has('mac')
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'junegunn/fzf.vim'

Plug 'fatih/vim-go'

" Change and enhance features of * (highlight and search)
" ref: https://stackoverflow.com/a/13682379
Plug 'vim-scripts/star-search'

Plug 'Vimjas/vim-python-pep8-indent'

Plug 'vim-voom/VOoM'

Plug 'junegunn/goyo.vim'

Plug 'arrufat/vala.vim'

if has('mac')
    Plug 'CodeFalling/fcitx-vim-osx'
endif

" Initialize plugin system
call plug#end()

" Plugin managed by others {{{1

" Plugin config {{{1

source $PLUGIN_CONFIG/nord.vim
source $PLUGIN_CONFIG/airline.vim
source $PLUGIN_CONFIG/ncm2.vim
source $PLUGIN_CONFIG/voom.vim
source $PLUGIN_CONFIG/goyo.vim
source $PLUGIN_CONFIG/sphinxnotes-snippet.vim
source $PLUGIN_CONFIG/go.vim

" vim modeline {{{1
" vim: set fdm=marker:
