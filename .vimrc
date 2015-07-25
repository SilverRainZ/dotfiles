source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin        " 还是习惯那些快捷键啊

syntax on 
syntax enable

filetype on
filetype plugin on

set number
set autochdir 

" 距离底部五行时滚屏
set so=5

"高亮当前行列
set cursorline 
set cursorcolumn

"兼容dos & unix 文本
set fileformats=unix,dos

"编码
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,chinese,latin-1
set fileencoding=utf-8
set fenc=gbk
language messages zh_CN.utf-8

"界面
set go=
colorscheme solarized
set background=dark
set guifont=Sayo\ UV\ Console\ HC\ 11
set laststatus=2

"关闭声音
set vb t_vb= 
set novisualbell 

" Tab 与缩进
filetype indent on      " 对不同语言的智能缩进
set autoindent
set expandtab           " Tab 扩展为空格
set tabstop=4           " 编辑时制表符占用空格数
set shiftwidth=4        " 格式化时 Tab 占用 四个空格
set softtabstop=4       " 连续四个空格视为 Tab

" 折叠
set foldmethod=syntax   " 基于语法进行代码折叠
set nofoldenable        " 启动 vim 时关闭折叠代码

" 禁用临时文件(?)
set nobackup
set nowritebackup
set noswapfile
set noundofile

" 特定文件类型
au BufRead,BufNewFile _pentadactylrc set filetype=pentadactyl
au BufNewFile,BufRead *.asm set filetype=fasm
au BufNewFile,BufRead *.md set filetype=markdown

" Normal 模式下禁用输入法(Windows Only?)
set iminsert=0
set imsearch=0
se imd
au InsertEnter * se noimd
au InsertLeave * se imd
au FocusGained * se imd
" ================== 简单键映射 ===========================
map j gj
map k gk

" ==================<F1> - <F12> 功能绑定======================

" <F1> 切换亮暗背景色
map <F1> :call NightMode()<CR>
imap <F1> <ESC>:call NightMode()<CR>
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

" <F9>单个文件编译 
"支持c/c++, python, java, haskell
map <F9> :call Do_OneFileMake()<CR>
imap <F9> <ESC>:call Do_OneFileMake()<CR>
function Do_OneFileMake()
    execute "cclose"
    if expand("%:p:h")!=getcwd()
        echohl WarningMsg | echo "Fail to make! This file is not in the current dir! " | echohl None
        return
    endif
    let sourcefileename=expand("%:t")
    if (sourcefileename=="" || (&filetype!="cpp" && &filetype!="c" && &filetype!="java" && &filetype!="haskell" && &filetype!="python"))
        echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
        return
    endif
    exec "w" 
    echo "file saved."
    "设置make参数
    if &filetype=="c"
        " 默认用32位编译
        set makeprg=gcc\ -m32\ -o\ \"%<\"\ \"%\"
    elseif &filetype=="cpp"
        set makeprg=g++\ -o\ \"%<\"\ \"%\"
    elseif &filetype=="java"
        set makeprg=javac\ \"%\"
    elseif &filetype=="haskell"
        execute "!ghci %"
        return
    elseif &filetype=="python"
        execute "!python -i %"
        return
    endif
    "删除旧文件,对于非编译型的就算了
    if (&filetype=="c" || &filetype=="cpp") 
       let outfilename=expand("%:r")
    elseif &filetype=="java" 
        let outfilename=expand("%:r").".class"
    endif

    if filereadable(outfilename)
        let outdeletedsuccess=delete("./".outfilename) "maybe useable
        if(outdeletedsuccess!=0)
            set makeprg=make
            echohl WarningMsg | echo "Fail to make! I cannot delete the ".outfilename | echohl None
            return
        endif
    endif
    "静默编译
    execute "silent make"
    set makeprg=make   
    "编译成功后执行
    if filereadable(outfilename)
        if &filetype=="java"
            execute "!java %<"
            return
        else
            execute "!./\"%<\"" 
            return 
        endif
    endif 
    "不成功弹出错误信息
    execute "silent copen 6"
endfunction

" <F11> 全屏 依赖 wmctrl
map <silent> <F11> :call ToggleFullscreen()<CR>
function ToggleFullscreen()
    call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf

" ==================== 独立插件配置 =======================
" 依云的 fcitx.vim 
set ttimeoutlen=100 

" =============Vundle https://github.com/gmarik/Vundle.vim================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The ultimate vim statusline utility.
Plugin 'Lokaltog/vim-powerline'
" powerline
set nocompatible
set t_Co=256
set laststatus=2
set encoding=utf8
let g:Powerline_symbols = 'compatible'  " no fancy, too bother

" A code-completion engine for Vim 
" Plugin 'Valloric/YouCompleteMe'

" A tree explorer plugin for vim. 
Plugin 'scrooloose/nerdtree'
" nerdtree 
map <C-n> :NERDTreeToggle<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
