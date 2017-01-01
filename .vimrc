source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin        " 还是习惯那些快捷键啊

syntax on
syntax enable

filetype on
filetype plugin on

" 显示行号
set number

" 打开文件自动切换到该文件目录
set autochdir

" 距离底部五行时滚屏
set so=5

"高亮当前行列
set cursorline
if has("gui_running")
    set cursorcolumn
endif

match ErrorMsg "\s\+$"
"兼容dos & unix 文本
set fileformats=unix,dos

"编码
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,chinese,latin-1
set fileencoding=utf-8
set fenc=utf-8
language messages zh_CN.utf-8

"界面
set go=

if has("gui_running")
    colorscheme solarized
endif

set background=dark
set guifont=Iosevka\ 14
set laststatus=2

"关闭声音
set vb t_vb=
set novisualbell

" Tab 与缩进
filetype indent on      " 对不同语言的智能缩进
set autoindent
set cindent
set expandtab           " Tab 扩展为空格
set tabstop=4           " 编辑时制表符占用空格数
set shiftwidth=4        " 格式化时 Tab 占用 四个空格
set softtabstop=4       " 连续四个空格视为 Tab

" 折行
set wrap
set colorcolumn=80
" set textwidth=80
" set formatoptions+=mM

" 折叠
set foldmethod=syntax   " 基于语法进行代码折叠
set nofoldenable        " 启动 vim 时关闭折叠代码

" 禁用临时文件(?)
set nobackup
set nowritebackup
set noswapfile
set noundofile

"语法折叠
set foldmethod=syntax
set foldcolumn=0        " 设置折叠区域的宽度
set foldlevel=100
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 特定文件类型
au BufRead,BufNewFile _pentadactylrc set filetype=pentadactyl
au BufNewFile,BufRead *.asm set filetype=fasm
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.wiki set filetype=wikipedia
au BufRead *.defs set filetype=c

" 以下类型输入左花括号自动补全
au FileType c,cpp,h,java,css,rust inoremap <buffer> {<CR> {<CR>}<Esc>O

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
nunmap <c-v>

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

map <F2> :call RelativeNumber()<CR>
imap <F2> <ESC>:call RelativeNumber()<CR>
let g:isRelativeNumber=1
function RelativeNumber()
    if (g:isRelativeNumber==0)
        set relativenumber
        let g:isRelativeNumber=1
    else
        set norelativenumber
        let g:isRelativeNumber=0
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
    if (sourcefileename=="" || (&filetype!="cpp" && &filetype!="c" && &filetype!="java" && &filetype!="haskell" && &filetype!="python" && &filetype!="rust"))
        echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
        return
    endif
    exec "w"
    echo "file saved."
    "设置make参数
    if &filetype=="c"
        set makeprg=gcc\ -lm\ -o\ \"/tmp/%<\"\ \"%\"
    elseif &filetype=="cpp"
        set makeprg=g++\ -std=c++11\ -o\ \"/tmp/%<\"\ \"%\"
    elseif &filetype=="java"
        set makeprg=javac\ \"%\"
    elseif &filetype=="haskell"
        execute "!ghci %"
        return
    elseif &filetype=="python"
        execute "!python -i %"
        return
    elseif &filetype=="rust"
        execute "!cargo run"
        return
    endif
    "删除旧文件,对于非编译型的就算了
    if (&filetype=="c" || &filetype=="cpp")
       let outfilename="/tmp/".expand("%:r")
    elseif &filetype=="java"
        let outfilename="/tmp/".expand("%:r").".class"
    endif

    if filereadable(outfilename)
        let outdeletedsuccess=delete(outfilename) "maybe useable
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
            execute "!\"/tmp/%<\""
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


" ===================================================
" ==================== Plugin =======================
" ===================================================
" all plugins are managed by pacman
" community/vim-nerdtree
" community/powerline-vim
" community/vim-doxygentoolkit
" archlinuxcn/vim-fcitx
" archlinuxcn/vim-youcompleteme-git

" -------------------- fcitx -----------------------
set ttimeoutlen=100

" -------------------- powerline -----------------------
set nocompatible
set t_Co=256
set laststatus=2
set encoding=utf8
let g:powerline_pycmd = "py3"
let g:powerline_symbols = 'compatible'  " no fancy, too bother

" -------------------- nerdtree -----------------------
map <C-n> :NERDTreeToggle<CR>

" -------------------- YCM -----------------------
nnoremap <C-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <C-k> :YcmForceCompileAndDiagnostics<CR>

let g:ycm_global_ycm_extra_conf = ''
autocmd FileType c let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf/c.py'
autocmd FileType cpp let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf/cpp.py'

let g:ycm_confirm_extra_conf = 0
let g:syntastic_always_populate_loc_list = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'
" set tags+=./.tags

" -------------------- doxygen -----------------------
let g:DoxygenToolkit_authorName = "Shengyu Zhang <silverrainz@outlook.com>"
let g:DoxygenToolkit_briefTag_funcName = "yes"

map <F3>a :DoxAuthor
map <F3>f :Dox
map <F3>b :DoxBlock
map <F3>c O/** */<Left><Left>

" -------------------- hurd -----------------------
" let g:loaded_youcompleteme = 1
" set noexpandtab         " Tab 扩展为空格
" set tabstop=8           " 编辑时制表符占用空格数
" set shiftwidth=8        " 格式化时 Tab 占用 四个空格
" set softtabstop=0       " 连续四个空格视为 Tab
