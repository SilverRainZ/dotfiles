map <C-n> :NERDTreeToggle<CR>

let NERDTreeShowBookmarks=1

" https://stackoverflow.com/a/5800087/4799273
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call StartUp()

" Close tab if the only window left open is a NERDTree?
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "?",
    \ "Renamed"   : ">",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "x",
    \ "Dirty"     : "*",
    \ "Clean"     : "",
    \ 'Ignored'   : '-',
    \ "Unknown"   : "?"
    \ }

let NERDTreeIgnore = [
            \ '\.pyc$',
            \ '__pycache__'
            \ ]
