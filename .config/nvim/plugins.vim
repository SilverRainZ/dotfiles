" Plugin related script

let $PLUGIN_CACHE='$HOME/.local/share/nvim/plugged'
let $PLUGIN_CONFIG='$XDG_CONFIG_HOME/nvim/plugins'

" Plugin managed by vim-plug {{{1
" Run `:PlugInstall` to install plugins

call plug#begin($PLUGIN_CACHE)

" Themes
Plug 'shaunsingh/nord.nvim'
Plug 'ishan9299/nvim-solarized-lua'
" Plug 'vim-airline/vim-airline' " FIXME: seems conflicts with xkbswitch
" Plug 'vim-airline/vim-airline-themes'

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
    " https://zhuanlan.zhihu.com/p/49411224
    Plug 'lyokha/vim-xkbswitch', {'as': 'xkbswitch'}
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchIMappings = ['cn']
    let g:XkbSwitchIMappingsTr = {'cn': {'<': '', '>': ''}}
endif

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Initialize plugin system
call plug#end()

" Plugin managed by others {{{1

" Plugin config {{{1

source $PLUGIN_CONFIG/nord.vim
" source $PLUGIN_CONFIG/airline.vim
source $PLUGIN_CONFIG/voom.vim
source $PLUGIN_CONFIG/goyo.vim
source $PLUGIN_CONFIG/sphinxnotes-snippet.vim
source $PLUGIN_CONFIG/go.vim
source $PLUGIN_CONFIG/ultisnips.vim

" vim modeline {{{1
" vim: set fdm=marker:
