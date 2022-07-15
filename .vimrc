" Basic vim configuration, should be compatible with both vim & neovim.

" UI {{{1

" 显示行号
set number

set mouse=a

" 高亮当前行列
set cursorline
set cursorcolumn

" 图形界面下不显示任何控件
set guioptions=

set guifont=Iosevka:h16

" 始终显示状态栏
set laststatus=2
" 显示已输入的部分命令
set showcmd
" 显示操作模式
set showmode
" 显示光标位置
set ruler

" 关闭声音
set vb t_vb=
set novisualbell

" Text encoding and style {{{1

" Highlight trailing whitespace
match ErrorMsg "\s\+$"

" 兼容 dos & unix 文本
set fileformats=unix,dos

" 编码
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,chinese,latin-1
set fileencoding=utf-8
set fenc=utf-8
language messages zh_CN.utf-8

" Tab 与缩进
filetype indent on      " 对不同语言的智能缩进
set autoindent
set cindent
set expandtab           " Tab 扩展为空格
set tabstop=4           " 编辑时制表符占用空格数
set shiftwidth=4        " 格式化时 Tab 占用 四个空格
set softtabstop=4       " 连续四个空格视为 Tab

" 距离边缘 n 行时滚屏
set scrolloff=5

" 折行
set wrap
set colorcolumn=80
" set textwidth=80
" set formatoptions+=mM

" 语法折叠
set foldmethod=syntax
set nofoldenable        " 启动 vim 时关闭折叠代码
set foldcolumn=0        " 设置折叠区域的宽度
set foldlevel=100
" 切换折叠状态
nnoremap zz @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 以下类型输入左花括号自动补全
au FileType c,cpp,h,java,css,rust,go inoremap <buffer> {<CR> {<CR>}<Esc>O

" Key binds {{{1

" Set leader key to space
" https://stackoverflow.com/a/446293
let mapleader=" "
nnoremap <SPACE> <Nop>

map j gj
map k gk

" Tabs
nmap tn :tabnew<CR>
nmap tc :tabclose<CR>

nmap vs :vs<CR>
nmap sp :split<CR>

" Copy & Paste {{{2

" Windows-style
map <C-c>  "+y
imap <C-v> <C-r>+
" Always paste from copied content (set :h quote0)
map <C-P> "0p

" F keys {{{2
"
map <F1> :call NightMode()<CR>
imap <F1> <ESC>:call NightMode()<CR>

map <F2> :call RelativeNumber()<CR>
imap <F2> <ESC>:call RelativeNumber()<CR>

" Smart make
map <F9> :!sm<CR>
imap <F9> <ESC>:!sm<CR>

map <silent> <F11> :call ToggleFullscreen()<CR>

" Helper functions  {{{1

" 切换亮暗背景色
let g:isNightMode=1
function NightMode()
    if (g:isNightMode==0)
        set bg=dark
        let g:isNightMode=1
    else
        set bg=light
        let g:isNightMode=0
    endif
endfunction

" 相对行号
let g:isRelativeNumber=0
function RelativeNumber()
    if (g:isRelativeNumber==0)
        set relativenumber
        let g:isRelativeNumber=1
    else
        set norelativenumber
        let g:isRelativeNumber=0
    endif
endfunction

" 全屏 依赖 wmctrl
function ToggleFullscreen()
    call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf

" Misc {{{1

syntax on
syntax enable

filetype on
filetype plugin on

" 打开文件自动切换到该文件目录
set autochdir

" 禁用临时文件(?)
set nobackup
set nowritebackup
set noswapfile
set noundofile

" Normal 模式下禁用输入法(Windows Only?)
set iminsert=0
set imsearch=0
se imd
au InsertEnter * se noimd
au InsertLeave * se imd
au FocusGained * se imd

" reStructuredText
let g:rst_style = 1

" vim modeline {{{1
" vim: set fdm=marker:
