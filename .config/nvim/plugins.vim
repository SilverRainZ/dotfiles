" Plugin related script

let $PLUGIN_CACHE='$HOME/.local/share/nvim/plugged'
let $PLUGIN_CONFIG='$XDG_CONFIG_HOME/nvim/plugins'

" Plugin managed by pacman {{{1

" pacman -S vim-a

" pacman -S vim-airline

" pacman -S vim-doxygentoolkit

" Plugin managed by vim-plug {{{1
" Run `:PlugInstall` to install plugins

call plug#begin($PLUGIN_CACHE)

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'

" Completion manager
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" Completion Sources
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-go'
Plug 'ncm2/ncm2-jedi'

Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }

Plug 'junegunn/fzf'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Initialize plugin system
call plug#end()

" Plugin config {{{1

" source $PLUGIN_CONFIG/solarized.vim
source $PLUGIN_CONFIG/nord.vim
source $PLUGIN_CONFIG/airline.vim
source $PLUGIN_CONFIG/doxygentoolkit.vim
source $PLUGIN_CONFIG/nerdtree.vim
source $PLUGIN_CONFIG/ncm2.vim
source $PLUGIN_CONFIG/languageclient.vim

" vim modeline {{{1
" vim: set fdm=marker:
