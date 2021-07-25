" Plugin related script

let $PLUGIN_CACHE='$HOME/.local/share/nvim/plugged'
let $PLUGIN_CONFIG='$XDG_CONFIG_HOME/nvim/plugins'

" Plugin managed by pacman {{{1

" pacman -S vim-a

" pacman -S vim-doxygentoolkit

" Plugin managed by vim-plug {{{1
" Run `:PlugInstall` to install plugins

call plug#begin($PLUGIN_CACHE)

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'shaunsingh/nord.nvim'

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

Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }

" Multi-entry selection UI.
Plug 'junegunn/fzf.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Change and enhance features of * (highlight and search)
" ref: https://stackoverflow.com/a/13682379
Plug 'vim-scripts/star-search'

Plug 'Vimjas/vim-python-pep8-indent'

Plug 'Chiel92/vim-autoformat'

Plug 'stsewd/sphinx.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'cespare/vim-toml'

Plug 'vim-voom/VOoM'

Plug 'airblade/vim-rooter'

Plug 'junegunn/goyo.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()

" Plugin managed by others {{{1

let snippet_nvim = tempname()
call system('snippet integration --vim --vim-binding>' . snippet_nvim)
execute 'source ' . snippet_nvim
call delete(snippet_nvim)

" Plugin config {{{1

" source $PLUGIN_CONFIG/solarized.vim
source $PLUGIN_CONFIG/nord.vim
source $PLUGIN_CONFIG/airline.vim
source $PLUGIN_CONFIG/doxygentoolkit.vim
source $PLUGIN_CONFIG/nerdtree.vim
source $PLUGIN_CONFIG/ncm2.vim
source $PLUGIN_CONFIG/languageclient.vim
source $PLUGIN_CONFIG/autoformat.vim
source $PLUGIN_CONFIG/voom.vim
source $PLUGIN_CONFIG/goyo.vim
source $PLUGIN_CONFIG/treesitter.vim

" vim modeline {{{1
" vim: set fdm=marker:
